use Module::Build;

my $build = Module::Build->new(
    module_name     => 'Apache::Auth::UserDB',
    dist_author     => 'Julian Mehnle <julian@mehnle.net>',
    license         => 'perl',
    build_requires  => {
        # Build requirements:
        Test::More          => 0,
    },
    requires        => {
        # General requirements:
        perl                => '5.6',
        Carp                => 0,   # in Perl 5.6
        IO::File            => 0,   # in Perl 5.6
        File::Copy          => 0    # in Perl 5.6
    },
    recommends      => {
        # Digest requirements:
        Digest::MD5         => 0
    },
    create_makefile_pl
                    => 'passthrough',
    sign            => 1
);

$build->create_build_script();

# $Id: Build.PL,v 1.2 2004/09/20 23:23:55 julian Exp $
