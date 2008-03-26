#!/usr/bin/env perl

use Test::More tests => 12;

my $URI = 'http://pastie.caboo.se/170666/';
my $ID  = '170666';
my $DUMP = "#foos {\n    position: relative;\n}\n\n#foos bars {\n    position: absolute;\n}\n\n#content { display: block; }\n#content { display: inline-block; }";

BEGIN {
    use_ok('WWW::Pastebin::Base::Retrieve');
	use_ok( 'WWW::Pastebin::PastieCabooSe::Retrieve' );
}

diag( "Testing WWW::Pastebin::PastieCabooSe::Retrieve $WWW::Pastebin::PastieCabooSe::Retrieve::VERSION, Perl $], $^X" );

my $o = WWW::Pastebin::PastieCabooSe::Retrieve->new(timeout=>10);
isa_ok($o,'WWW::Pastebin::PastieCabooSe::Retrieve');
can_ok($o, qw(retrieve new error content results uri id));
isa_ok($o->ua, 'LWP::UserAgent');
SKIP:{
    my $content = $o->retrieve($URI);
    isa_ok($o->uri, 'URI::http', 'uri() method');
    is($o->id,$ID,'id() method');
    
    unless (defined $content) {
        diag "\nGot error: " . $o->error . "\n\n";
        ok( (defined $o->error and length $o->error), 'error() method');
        skip 'Got error', 4;
    }

    is($content,$DUMP,'content matches dump');
    is( $content, "$o", 'overloads');
    is($content, $o->content, 'content()');
    is($content, $o->results,'results()');
    is($o->uri,$URI,'uri() method contents');
}


