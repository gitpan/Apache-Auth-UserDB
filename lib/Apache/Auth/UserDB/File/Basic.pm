#
# Apache::Auth::UserDB::File::Basic
# A Apache basic authentication file user database manager class.
#
# (C) 2003-2004 Julian Mehnle <julian@mehnle.net>
# $Id: Basic.pm,v 1.1 2004/09/09 21:57:26 julian Exp $
#
##############################################################################

package Apache::Auth::UserDB::File::Basic;

our $VERSION = 0.10;

use v5.6;

use warnings;
use strict;

use base qw(Apache::Auth::UserDB::File);

use Carp;

use Apache::Auth::User::Basic;

# Constants:
##############################################################################

use constant TRUE   => (0 == 0);
use constant FALSE  => not TRUE;

# Interface:
##############################################################################

# Implementation:
##############################################################################

sub _parse_entry {
    my ($self, $entry) = @_;
    
    $entry =~ /^([^:]*):([^:]*)$/
        or croak('Malformed userdb entry encountered: "' . $entry . '"');
    
    return Apache::Auth::User::Basic->new(
        name            => $1,
        password_digest => $2
    );
}

sub _build_entry {
    my ($self, $user) = @_;
    
    return join(':',
        $user->name,
        $user->password_digest
    );
}

TRUE;

# vim:tw=79
