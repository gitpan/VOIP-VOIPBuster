use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'VOIP::VOIPBuster',
    AUTHOR              => 'Darren Kulp <darren@kulp.ch>',
    VERSION_FROM        => 'lib/VOIP/VOIPBuster.pm',
    ABSTRACT_FROM       => 'lib/VOIP/VOIPBuster.pm',
	EXE_FILES           => [ 'bin/vbcall' ],
    PL_FILES            => {},
    PREREQ_PM => {
        'Carp' => 0,
        'Test::More' => 0,
        'WWW::Mechanize' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'VOIP-VOIPBuster-*' },
);
