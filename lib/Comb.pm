package Comb;
# ABSTRACT: Comb Base Environment Class

use Comb::Class;
use Comb::Project;
use Config;
use Import::Into;

has os => (
  is => 'lazy',
);

sub _build_os { $Config{osname} }

has arch => (
  is => 'lazy',
);

sub _build_arch { $Config{archname} }

has_path root => (
  is => 'ro',
  required => 1,
);

has files => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_files {
  my ( $self ) = @_;
  my @files;
  my @ignoredir;
  $self->root->visit(sub {
    my ( $path, $state ) = @_;
    for (@ignoredir) {
      return if $_->realpath->subsumes($path->realpath);
    }
    for (@{$self->ignores}) {
      if ($path->relative($self->root)->stringify =~ $_) {
        push @ignoredir, $path if $path->is_dir;
        return;
      }
    }
    push @files, $path if $path->is_file;
  },{
    recurse => 1,
  });
  return [ @files ];
}

has project_files => (
  is => 'lazy',
  init_arg => undef,
);

sub has_project_files {
  my ( $self ) = @_;
  return scalar @{$self->project_files};
}

sub _build_project_files {
  my ( $self ) = @_;
  my @project_files;
  for my $path (@{$self->files}) {
    my $p = $path->relative($self->root);
    push @project_files, $path if $p->stringify =~ qr/^(combprj|[^\/]+\.cbprj)$/;
  }
  return [ @project_files ];
}

has custom_ignores => (
  is => 'ro',
  init_arg => 'ignores',
  predicate => 1,
);

has ignores => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_ignores {
  my ( $self ) = @_;
  my @ignores = (
    qr!^\.git$!, qr!^\.gitignore$!,
    qr!^(.+/|)\.DS_Store$!,
    qr!^(.+/|)\.svn!
  );
  my $gitignore = $self->root->child('.gitignore');
  if (-f $gitignore) {
    push @ignores, map { s!/$!!g; s!\*\*!.+!g; s!\*![^/]+!g; qr/^$_$/ } $gitignore->lines({ chomp => 1 });
  }
  if ($self->has_custom_ignores) {
    push @ignores, map { qr/^$_$/ } @{$self->custom_ignores};
  }
  return [ @ignores ];
}

sub load_project {
  my ( $self, $name ) = @_;
  my $prjfile = defined $name ? $name.'.cbprj' : 'combprj';
  if ($self->has_project_files) {
    for my $prj (@{$self->project_files}) {
      if ($prj->relative($self->root)->stringify eq $prjfile) {
        my $content = scalar $prj->slurp;
        return Comb::Project->new( comb => $self, code => $content );
      }
    }
  }
  return undef;
}

1;
