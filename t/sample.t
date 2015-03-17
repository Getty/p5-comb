#!/usr/bin/env perl
use strict;
use warnings;
use Test::More;
use Comb;

use FindBin qw($Bin);

my $comb = Comb->new( root => $Bin.'/sample' );
my $prj  = $comb->load_project;

use DDP; p($prj);

done_testing;
