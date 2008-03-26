package WWW::Pastebin::PastieCabooSe::Retrieve;

use warnings;
use strict;

our $VERSION = '0.001';

use base 'WWW::Pastebin::Base::Retrieve';

sub _make_uri_and_id {

    my ( $self, $what ) = @_;

    my ( $id ) = $what =~ m{
        (?:http://)? (?:www\.)?
        \Qpastie.caboo.se/\E
        (\d+)
        /?
    }xi;

    $id = $what
        unless defined $id and length $id;

    $self->{_human_uri} = URI->new("http://pastie.caboo.se/$id/");

    return ( URI->new("http://pastie.caboo.se/$id.txt"), $id );
}

sub _get_was_successful {
    my ( $self, $content ) = @_;
    $self->uri( delete $self->{_human_uri} );

    return $self->results( $self->content( $content ) );
}

1;
__END__

=head1 NAME

WWW::Pastebin::PastieCabooSe::Retrieve - retrieve pastes from http://pastie.caboo.se/

=head1 SYNOPSIS

    use strict;
    use warnings;

    use WWW::Pastebin::PastieCabooSe::Retrieve;

    my $paster = WWW::Pastebin::PastieCabooSe::Retrieve->new;

    $paster->retrieve('http://pastie.caboo.se/170666')
        or die 'Error: ' . $paster->error;

    print "Paste content:\n$paster\n";

=head1 DESCRIPTION

The module provides interface to retrieve pastes from
L<http://pastie.caboo.se/> website via Perl.

=head1 CONSTRUCTOR

=head2 C<new>

    my $paster = WWW::Pastebin::PastieCabooSe::Retrieve->new;

    my $paster = WWW::Pastebin::PastieCabooSe::Retrieve->new(
        timeout => 10,
    );

    my $paster = WWW::Pastebin::PastieCabooSe::Retrieve->new(
        ua => LWP::UserAgent->new(
            timeout => 10,
            agent   => 'PasterUA',
        ),
    );

Constructs and returns a brand new juicy WWW::Pastebin::PastieCabooSe::Retrieve
object. Takes two arguments, both are I<optional>. Possible arguments are
as follows:

=head3 C<timeout>

    ->new( timeout => 10 );

B<Optional>. Specifies the C<timeout> argument of L<LWP::UserAgent>'s
constructor, which is used for retrieving. B<Defaults to:> C<30> seconds.

=head3 C<ua>

    ->new( ua => LWP::UserAgent->new( agent => 'Foos!' ) );

B<Optional>. If the C<timeout> argument is not enough for your needs
of mutilating the L<LWP::UserAgent> object used for retrieving, feel free
to specify the C<ua> argument which takes an L<LWP::UserAgent> object
as a value. B<Note:> the C<timeout> argument to the constructor will
not do anything if you specify the C<ua> argument as well. B<Defaults to:>
plain boring default L<LWP::UserAgent> object with C<timeout> argument
set to whatever C<WWW::Pastebin::PastieCabooSe::Retrieve>'s C<timeout> argument is
set to as well as C<agent> argument is set to mimic Firefox.

=head1 METHODS

=head2 C<retrieve>

    my $content = $paster->retrieve('http://pastie.caboo.se/170666')
        or die $paster->error;

    my $content = $paster->retrieve('170666')
        or die $paster->error;

Instructs the object to retrieve a paste specified in the argument. Takes
one mandatory argument which can be either a full URI to the paste you
want to retrieve or just its ID.
On failure returns either C<undef> or an empty list depending on the context
and the reason for the error will be available via C<error()> method.
On success returns the content of the paste.

=head2 C<error>

    $paster->retrieve('170666')
        or die $paster->error;

On failure C<retrieve()> returns either C<undef> or an empty list depending
on the context and the reason for the error will be available via C<error()>
method. Takes no arguments, returns an error message explaining the failure.

=head2 C<id>

    my $paste_id = $paster->id;

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns a paste ID number of the last retrieved paste irrelevant of whether
an ID or a URI was given to C<retrieve()>

=head2 C<uri>

    my $paste_uri = $paster->uri;

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns a L<URI> object with the URI pointing to the last retrieved paste
irrelevant of whether an ID or a URI was given to C<retrieve()>

=head2 C<results>

    my $last_content = $paster->results;

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns the exact return value the last call to C<retrieve()> returned.
B<Note:> the overloaded C<content()> method which is an alias for
C<results()> method (if you are wondering "why?" see
L<WWW::Pastebin::Base::Retrieve>; the http://pastie.caboo.se/ pastebin
is sucky enough to make C<retrieve()> method return just content)

=head2 C<content>

    my $paste_content = $paster->content;

    print "Paste content is:\n$paster\n";

Must be called after a successful call to C<retrieve()>. Takes no arguments,
returns the actual content of the paste. B<Note:> this method is overloaded
for this module for interpolation. Thus you can simply interpolate the
object in a string to get the contents of the paste.

=head2 C<ua>

    my $old_LWP_UA_obj = $paster->ua;

    $paster->ua( LWP::UserAgent->new( timeout => 10, agent => 'foos' );

Returns a currently used L<LWP::UserAgent> object used for retrieving
pastes. Takes one optional argument which must be an L<LWP::UserAgent>
object, and the object you specify will be used in any subsequent calls
to C<retrieve()>.

=head1 SEE ALSO

L<LWP::UserAgent>, L<URI>

=head1 AUTHOR

Zoffix Znet, C<< <zoffix at cpan.org> >>
(L<http://zoffix.com>, L<http://haslayout.net>)

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-pastebin-pastiecaboose-retrieve at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Pastebin-PastieCabooSe-Retrieve>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Pastebin::PastieCabooSe::Retrieve

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Pastebin-PastieCabooSe-Retrieve>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Pastebin-PastieCabooSe-Retrieve>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Pastebin-PastieCabooSe-Retrieve>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Pastebin-PastieCabooSe-Retrieve>

=back

=head1 COPYRIGHT & LICENSE

Copyright 2008 Zoffix Znet, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

