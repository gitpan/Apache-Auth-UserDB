#
# Apache::Auth::User
# An abstract Apache authentication user class.
#
# (C) 2003-2004 Julian Mehnle <julian@mehnle.net>
# $Id: User.pm,v 1.2 2004/09/20 23:44:37 julian Exp $
#
##############################################################################

package Apache::Auth::User;

our $VERSION = 0.11;

use v5.6;

use warnings;
use strict;

use overload
    '""'        => 'signature',
    fallback    => 1;

# Constants:
##############################################################################

use constant TRUE   => (0 == 0);
use constant FALSE  => not TRUE;

# Interface:
##############################################################################

sub new;

sub name;
sub password;
sub password_digest;

# Implementation:
##############################################################################

sub new {
    my ($class, %fields) = @_;
    my $self = bless(\%fields, $class);
    return $self;
}

sub name {
    my ($self, @value) = @_;
    $self->{name} = $value[0] if @value;
    return $self->{name};
}

sub password {
    my ($self, @value) = @_;
    if (@value) {
        $self->{password} = $value[0];
        $self->{password_digest} = undef;
    }
    return $self->{password};
}

sub password_digest {
    my ($self, @value) = @_;
    if (@value) {
	$self->{password_digest} = $value[0];
    }
    elsif (not defined($self->{password_digest})) {
        $self->{password_digest} = $self->_build_password_digest();
    }
    return $self->{password_digest};
}

TRUE;

# vim:tw=79
