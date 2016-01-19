#!/usr/bin/perl
use File::Spec;

my $sslcert = shift or die "Usage: $0 sslcertificate.crt\n"

if (-e $sslcert) {
	my $sslexpiry = `/usr/bin/openssl x509 -enddate -noout -in $sslcert |awk -F= '{print $2}'`;
	print $sslexpiry;
} else {
	print "$sslcert does not exist.\n"
}