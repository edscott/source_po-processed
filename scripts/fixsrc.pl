#!/usr/bin/perl
# cat xx |sed s/\r/
use strict;
$_ = `ls *.po`;
my $po;
my @linguas = split;
    &fixR("ast.po");

foreach $po (@linguas) {
#    &fixR($po);
}
exit(1);

sub fixR {
    my ($file) = @_;
    open IN, $file or die "cannot open $file\n";
    my $content = "";
    my $lines = 0;
    my $ko=0;
    while (<IN>) { 
	$lines++;
	if (/\\\\r/) {$ko=1; s/\\\\r/\\r/g;}
	if (/\\\\n/) {$ko=1; s/\\\\n/\\n/g;}
	if (/\\r/) {
	    $ko=1; 
#	    print;
	    s/\\r//g;
#	    print "fix: $_";
	}
	$content .= $_; 
    }
    close IN;
    print "read $file, $lines lines.\n";
    if ($ko){
	print "$file is dirty... \n";
	print `cp -v $file $file.bak`;
	open OUT, ">$file" or die "cannot open $file for write\n";
	print OUT $content;
	close $content;
	print "fixed $file\n";
    } else {
	print "$file is clean\n";
    }
}
