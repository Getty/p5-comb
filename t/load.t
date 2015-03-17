#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;

for (qw(
  App::Comb
  App::Comb::Cmd::Build
  Comb
  Comb::Class
  Comb::Command
  Comb::File
  Comb::Project
  Comb::Role::Command
  Comb::Role::Class
)) {
  use_ok($_);
}

done_testing;

