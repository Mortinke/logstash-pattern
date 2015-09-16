#!/usr/bin/perl
use POSIX qw/strftime/;

while (<>) {
  my $now = time();
  print strftime('%Y-%m-%dT%H:%M:%SZ', gmtime($now)) . " $_";
}