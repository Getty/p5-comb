package Comb::Role::Command;

use Moo::Role;

requires qw( run );

has app => (
  is => 'lazy',
  handles => [qw(
    comb
  )],
);

sub _build_app {
  my ( $self ) = @_;
  return $self->command_chain->[0];
}

sub execute {
  my ( $self, $args_ref ) = @_;
  $self->run(@{$args_ref});
}

1;
