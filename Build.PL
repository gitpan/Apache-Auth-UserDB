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
        Carp                => 0,   # in Perl 5.8
        IO::File            => 0,   # in Perl 5.8
        File::Copy          => 0    # in Perl 5.8
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

# $Id: Build.PL,v 1.1 2004/09/09 21:53:03 julian Exp $
# vim:tw=79
