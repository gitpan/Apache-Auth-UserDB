#
# Apache::Auth::UserDB::File
# An abstract Apache file user database manager class.
#
# (C) 2003-2004 Julian Mehnle <julian@mehnle.net>
# $Id: File.pm,v 1.8 2004/09/20 23:44:44 julian Exp $
#
##############################################################################

package Apache::Auth::UserDB::File;

our $VERSION = 0.11;

use v5.6;

use warnings;
use strict;

use base qw(Apache::Auth::UserDB);

use Carp;
# TODO: We are not multi-user-safe yet!
#use IPC::SysV;
#use IPC::Semaphore;
use IO::File;
use File::Copy;

# Constants:
##############################################################################

use constant TRUE   => (0 == 0);
use constant FALSE  => not TRUE;

# Interface:
##############################################################################

sub open;

# Implementation:
##############################################################################

sub open {
    my ($class, %options) = @_;
    
    my $self = $class->new(%options);
    if (defined($self) and $self->_read()) {
	return $self;
    }
    else {
	return undef;
    }
}

sub _read {
    my ($self) = @_;
    
    my $file = IO::File->new($self->{file_name}, '<');
    return undef if not $file;
    #croak("Unable to open file for reading: $self->{file_name}")
    #	if not $file;
    
    $self->clear();
    
    while (my $line = <$file>) {
	chomp($line);
        my $user = $self->_parse_entry($line);
	push(@{$self->{users}}, $user);
    }
    
    $file->close();
    
    return TRUE;
}

sub _write {
    my ($self) = @_;
    
    my $temp_file_name = $self->{file_name} . sprintf('.%d:%d', $$, time());
    my $temp_file = IO::File->new($temp_file_name, '>');
    return undef if not $temp_file;
    #croak("Unable to open file for writing: $temp_file_name")
    #	if not $temp_file;
    
    foreach my $user (@{$self->{users}}) {
	$temp_file->print($self->_build_entry($user), "\n");
    }
    
    $temp_file->close();
    
    move($temp_file_name, $self->{file_name})
        or return undef;
	#or croak("Unable to replace $self->{file_name} with $temp_file_name");
    
    return TRUE;
}

TRUE;

# vim:tw=79
