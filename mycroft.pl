#!/usr/bin/perl

# use strict;
use Getopt::Long;

open(TMPFILE, "> tmp.tmp")
    or die "Cannot open tmp.tmp\n";

my @tags = ();
my $output;

GetOptions('output=s' => \$output);
if ( $output ) {
    $output = $output . "-tagcloud" ;
} else {
    $output = "tagcloud";
}

while(<>) {
    chomp;
    my $info="";
    if (/^#conf/) { 
        ($conf, $category, $path, $title)= split(/:/, $_);
        print "\n# $title\n\n";
        next;
    } 
    if (/^#|^$/) { next }
    ($fname,$expl,$date,$kywds, $info) =
        split(/::/, $_);
    print "\n- [$expl]($path$fname) ";

    if($info){
        ($basename, $ext)=split(/\./,$fname);
        $sname = "INF-$basename.md";
        unless( -e $sname ) {
            open(SFILE, "> $sname") or die "Cannot open $sname";
            print SFILE << "EOF";
<!-- -*- coding: utf-8 -*- -->

# $expl

[Here]($path$fname)

EOF
        }
        print " [ [ +++++ ] ](INF-$basename.html) ";        
    }

    print "  ($date) ";
    
    @keywords = split (/,\s*/, $kywds);
    for ($i=0;$i<@keywords;$i++){
        print " [$keywords[$i]](TAG-$keywords[$i].html)";
        for ($k=0;$k<@tags;$k++) {
            if($tags[$k] eq $keywords[$i]) {
                $eureka=1; }
        }
        push @tags, $keywords[$i] if !$eureka;
        $eureka=0;
        
        print TMPFILE "$keywords[$i]::[$expl]($path$fname) ($date)\n" ;
    }
    print "\n";
}

# print $tail;

close(TMPFILE);
open(TMPFILE, "tmp.tmp") or die "Cannot open tmp.tmp";

while (<TMPFILE>){

    ($tagname,$contents) = split(/::/, $_);
    # if( -e "TAG-$tagname") {
    #     open (TAG, ">> TAG-$tagname") or die "Cannot open TAG-$tagname";
    # } else { 
    #     open (TAG, "> TAG-$tagname") or die "Cannot open TAG-$tagname";
    # }
    open (TAG, ">> TAG-$tagname.md") or die "Cannot open TAG-$tagname.md";
    print TAG "- $contents\n";
    close(TAG);
}
