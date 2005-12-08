#!perl -wT
# $Id: basic.t 1010 2005-12-08 23:40:44Z claco $
use strict;
use warnings;
use Test::More tests => 2;

BEGIN {
    use_ok('Catalyst::Model::NetBlogger');
    use_ok('Catalyst::Helper::Model::NetBlogger');
};
