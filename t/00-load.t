#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'VOIP::VOIPBuster' );
}

diag( "Testing VOIP::VOIPBuster $VOIP::VOIPBuster::VERSION, Perl $], $^X" );
