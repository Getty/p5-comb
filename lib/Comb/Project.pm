package Comb::Project;
# ABSTRACT: Comb Project Class

use Comb::Class;

has comb => (
  is => 'ro',
  required => 1,
);

has package => (
  is => 'lazy',
  init_arg => undef,
);

sub _build_package {
  my ( $self ) = @_;
  my $suffix = $self->has_name ? '::'.$self->name : '';

}

sub _run_combcode {
  my ( $self ) = @_;

}

1;
