#! /usr/bin/perl
# Author: Daniel Amsel - daniel.amsel@ime.fraunhofer.de
# parse a FASTA file to a perl hash
use strict;
use warnings;
use Storable;



my $fasta_file	= $ARGV[0];
# if no file was specified
if (not $fasta_file){
	print STDERR "No file!\n";
	exit;
}

my $fa_hash_file= "$fasta_file.hash";
my %fa_hash;
my $fa_header;
open(FA,"<",$fasta_file) or die "$fasta_file not found!\n";
print "Start parsing the FASTA file...";
while(<FA>){
	chomp;
	my $fa_line	= $_;
	if(/^>/){
		$fa_header	= $fa_line;
		$fa_hash{$fa_header}="";
	}
	else{
		$fa_hash{$fa_header}.=$fa_line;
	}
}
close(FA);
print "done!\n";
print "Saving...";
store \%fa_hash, $fa_hash_file;
print "done!\n";
print "Save file : $fa_hash_file\n";
