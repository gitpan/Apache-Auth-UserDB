#
# Apache::Auth::User::Digest
# An Apache digest authentication user class.
#
# (C) 2003-2004 Julian Mehnle <julian@mehnle.net>
# $Id: Digest.pm,v 1.5 2004/09/20 23:44:44 julian Exp $
#
##############################################################################

package Apache::Auth::User::Digest;

our $VERSION = 0.11;

use v5.6;

use warnings;
use strict;

use base qw(Apache::Auth::User);

use Carp;
use Digest::MD5;

# Constants:
##############################################################################

use constant TRUE   => (0 == 0);
use constant FALSE  => not TRUE;

# Interface:
##############################################################################

sub signature;
sub realm;

# Implementation:
##############################################################################

sub signature {
    my ($self) = @_;
    return
        (defined($self->name) and defined($self->realm)) ?
            $self->name . ':' . $self->realm
        :   undef;
}

sub realm {
    my ($self, @value) = @_;
    $self->{realm} = $value[0] if @value;
    return $self->{realm};
}

sub _build_password_digest {
    my ($self) = @_;
    
    croak("Unable to build password digest from incomplete data")
        if not defined($self->{realm}) or
           not defined($self->{name}) or
           not defined($self->{password});
    
    my $text = join(':', $self->{name}, $self->{realm}, $self->{password});
    return Digest::MD5::md5_hex($text);
}

TRUE;

# vim:tw=79
