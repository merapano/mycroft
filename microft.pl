#!/usr/bin/perl

open(TMPFILE, "> tmp.tmp")
    or die "Cannot open tmp.tmp\n";

my @tags = ();
my $head="<HTML><HEAD>\n";
my $tail="</UL></BODY></HTML>\n";


print $head;
while(<>) {
    chomp;
    if (/^#conf/) { 
        ($conf, $category, $path, $title)= split(/:/, $_);
        printf "<TITLE>$title</TITLE></HEAD><BODY><UL>";
        next;
    } 
    if (/^#|^$/) { next }
    ($fname,$expl,$date,$kywds) =
        split(/::/, $_);
    print "<LI> <p> <a href=\"$path$fname\">$expl</a>
	($date) \n";
    @keywords = split (/,\s*/, $kywds);
    for ($i=0;$i<@keywords;$i++){
        print " <a href=\"$keywords[$i].html\">$keywords[$i]</a>\n";
        for ($k=0;$k<@tags;$k++) {
            if($tags[$k] eq $keywords[$i]) {
                $eureka=1; }
        }
        push @tags, $keywords[$i] if !$eureka;
        $eureka=0;
        
        print TMPFILE "$keywords[$i].md::[$expl]($path$fname) ($date)\n" ;
    }
    print "</p></li>\n";
}

print $tail;

close(TMPFILE);
open(TMPFILE, "tmp.tmp") or die;

while (<TMPFILE>){

    ($tagname,$contents) = split(/::/, $_);
    open(TAG,">> $tagname") or die "Cannot open $tagname";
    print TAG "- $contents\n";
    close(TAG);
}

        
    
