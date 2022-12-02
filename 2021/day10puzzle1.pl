use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day10input1.txt', { chomp => 1 });
#my @input = read_file('day10sampleinput.txt', { chomp => 1 });

my $count = 0;
my %tracker;
foreach my $line ( @input ) {
   while (  $line =~ /((\[\])|(\(\))|({})|(<>))/  ) { 
      my $pattern = $1;
      $line =~ s/\Q$pattern\E//g;
      #print "$count: $line $pattern\n";
   }
   $count++;
   # Corrupted line: Find first close character & count
   if ( $line =~ /^[\[\({<]+([>}\)\]])/ ) {
      my $last_open = quotemeta($1);
      my $char_count = $tracker{$last_open} + 1;
      $tracker{$last_open} = $char_count;
   }
}

my $score = ( $tracker{'\)'} * 3 ) + ( $tracker{'\]'} * 57 ) + ( $tracker{'\}'} * 1197 ) + ( $tracker{'\>'} * 25137 );
print "Score: $score\n";

#print Dumper(\%tracker);

