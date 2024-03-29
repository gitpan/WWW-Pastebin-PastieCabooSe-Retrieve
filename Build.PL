use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'WWW::Pastebin::PastieCabooSe::Retrieve',
    license             => 'perl',
    dist_author         => 'Zoffix Znet <zoffix@cpan.org>',
    dist_version_from   => 'lib/WWW/Pastebin/PastieCabooSe/Retrieve.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'WWW::Pastebin::Base::Retrieve' => 0.001,
    },
    add_to_cleanup      => [ 'WWW-Pastebin-PastieCabooSe-Retrieve-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
