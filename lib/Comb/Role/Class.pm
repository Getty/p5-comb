package Comb::Role::Class;

use Moo::Role;
use Package::Stash;
use Path::Tiny;

sub has_path {
  my ( $name, @args ) = @_;
  my $caller = caller;
  $caller->can('has')->($name, coerce => sub { ref $_[0] eq 'Path::Tiny' ? $_[0]->absolute : path($_[0])->absolute }, @args);
}

1;
