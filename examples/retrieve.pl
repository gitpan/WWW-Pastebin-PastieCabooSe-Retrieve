#!/usr/bin/env perl

use strict;
use warnings;

use lib '../lib';
use WWW::Pastebin::PastieCabooSe::Retrieve;

die "Usage: perl retrieve.pl <paste_ID_or_URI>\n"
    unless @ARGV;

my $Paste = shift;

my $paster = WWW::Pastebin::PastieCabooSe::Retrieve->new;

my $ret = $paster->retrieve( $Paste )
    or die 'Error: ' . $paster->error;

print "Paste content:\n$paster\n";
