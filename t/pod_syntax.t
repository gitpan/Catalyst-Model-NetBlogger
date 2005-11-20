#!perl -wT
# $Id: pod_syntax.t 943 2005-11-19 03:45:12Z claco $
use strict;
use warnings;
use Test::More;

eval 'use Test::Pod 1.00';
plan skip_all => 'Test::Pod 1.00 not installed' if $@;

all_pod_files_ok();
