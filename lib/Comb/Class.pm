package Comb::Class;
# ABSTRACT: Base Class for all Comb object classes

use strict;
use warnings;
use MooX ();
use Moo::Role ();
use Carp ();

sub import {
  my $target = caller;
  MooX->import::into($target, '+Path::Tiny', '+Carp' => [qw( croak )]);
  Moo::Role->apply_roles_to_package($target,qw( Comb::Role::Class ));
}

1;
