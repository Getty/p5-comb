package Comb::Command;
# ABSTRACT: Base Class for all Comb object classes

use strict;
use warnings;
use MooX ();
use Moo::Role ();

sub import {
  my $target = caller;
  MooX->import::into($target,qw(
    +Comb::Class Options Cmd
  ));
  Moo::Role->apply_roles_to_package($target,qw( Comb::Role::Command ));
}

1;
