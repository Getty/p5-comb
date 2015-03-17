package App::Comb;
# ABSTRACT: Comb Application

use Comb::Class;
use MooX::Options;
use MooX::Cmd;
use Comb;

option build => (
  is => 'lazy',
);

sub _build_build {
  my ( $self ) = @_;
  return path(".build")->absolute;
}

option root => (
  is => 'lazy',
);

sub _build_root {
  my ( $self ) = @_;
  return path(".")->absolute;
}

has comb => (
  is => 'lazy',
);

sub _build_comb {
  my ( $self ) = @_;
  return Comb->new( root => $self->root );
}

sub execute {
  my ( $self, $args_ref, $chain_ref ) = @_;

}

1;
