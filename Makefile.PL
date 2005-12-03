# $Id: Makefile.PL 1000 2005-12-03 01:57:23Z claco $
use ExtUtils::MakeMaker;
use 5.008;
use strict;
use warnings FATAL => 'all';

WriteMakefile(
    NAME         => 'Catalyst::Model::NetBlogger',
    VERSION_FROM => 'lib/Catalyst/Model/NetBlogger.pm',
    AUTHOR       => 'Christopher H. Laco <claco@chrislaco.com>',
    ABSTRACT     => 'Catalyst Model to post and retrieve blog entries using Net::Blogger',
    PREREQ_PM    => {
        'Catalyst'     => 5.33,
        'Net::Blogger' => 1.01
    },
    (ExtUtils::MakeMaker->VERSION >= 6.11) ?
    (NO_META => 1) : (),
    dist => {
        PREOP => 'pod2text lib/Catalyst/Model/NetBlogger.pm > $(DISTVNAME)/README',
    },
    clean => { FILES => 't/TestApp'},
);
