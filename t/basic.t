#!perl -wT
# $Id: basic.t 943 2005-11-19 03:45:12Z claco $
use strict;
use warnings;
use Test::More tests => 2;

BEGIN {
    use_ok('Catalyst::Model::SVN');
    use_ok('Catalyst::Helper::Model::SVN');
};
