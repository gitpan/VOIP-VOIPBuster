=head1 NAME

VOIP::VOIPBuster - Makes (limited) calls using
L<VOIPBuster|http://www.voipbuster.com/>.

=cut

package VOIP::VOIPBuster;

use strict;
use warnings;

use Carp qw(croak);
use WWW::Mechanize;

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

	use VOIP::VOIPBuster;
	my ($me, $you) = qw(some international phone numbers);
	my $v = VOIP::VOIPBuster->new(from => $me, to => $you);
	## OR ##
	VOIP::VOIPBuster::call(
		from	=> $me,
		to		=> $you
	);

=head1 METHODS

=over 4

=item new

Creates a new VOIP::VOIPBuster object. Called automatically by call() if
necessary.

=cut

sub new {
	my $class = shift;
	bless {
		@_,
		mech	=> WWW::Mechanize->new,
		url		=> 'http://www.voipbuster.com/en/callpanel.php',
	}, $class;
}

=item call

Places a call, taking either no arguments (called on an object) or two (called
as a function, with "from" and "to" number strings) or four (called as a
function, with new()-style arguments. See C<SYNOPSIS>.

=cut

sub call {
	my $self = (ref $_[0])
		? shift
		: @_ == 4
			? __PACKAGE__->new(@_)
			: __PACKAGE__->new(
				from	=> shift,
				to		=> shift
			);
	
	defined $self->{from}
		or croak "No 'from' specified";
	defined $self->{to}
		or croak "No 'to' specified";

	$self->{mech}->get($self->{url});
	
	$self->{mech}->submit_form(
		form_number => 1,
		fields      => {
			anrphonenr	=> $self->{from},
			bnrphonenr	=> $self->{to},
		}
	);
	$self
}

=back

=head1 AUTHOR

Darren Kulp, C<< <darren at kulp.ch> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-voip-voipbuster at rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=VOIP-VOIPBuster>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc VOIP::VOIPBuster

You can also look for information at:

=over 4

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/VOIP-VOIPBuster>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/VOIP-VOIPBuster>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=VOIP-VOIPBuster>

=item * Search CPAN

L<http://search.cpan.org/dist/VOIP-VOIPBuster>

=back

=head1 ACKNOWLEDGEMENTS

The VOIPBuster service at L<http://www.voipbuster.com/>

=head1 COPYRIGHT & LICENSE

Copyright 2006 Darren Kulp, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1; # End of VOIP::VOIPBuster
