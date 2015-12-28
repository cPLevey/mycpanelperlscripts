#!/usr/bin/perl  
use strict;
use warnings;

use File::Find qw(find);
use List::MoreUtils qw(uniq);

my $userdatadir = '/var/cpanel/userdata';

find( \&search_all, $userdatadir );

sub search_all {
    chomp $_;
    return if $_ eq '.' or $_ eq '..';
    read_files($_) if (-f);
}

my @docroots;

sub read_files {
    my ($userdatafile) = @_;

    if (open(my $fh, $userdatafile)){    
    	while (my $row = <$fh>) {
    		chomp $row;
    		if ($row =~ /^documentroot/){
    			my @docroot = split ' ', $row;
    			push @docroots, "$docroot[1]";
    		}
    	}
    } else {
    	warn "Unable to open: '$userdatafile' $!";
    }
}

my @uniqdocroots = uniq @docroots;

foreach(@uniqdocroots){
	print "$_\n";
}
