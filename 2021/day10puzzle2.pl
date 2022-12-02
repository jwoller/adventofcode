use File::Slurp;
use strict;

my @input = read_file('day10input1.txt', { chomp => 1 });
#my @input = read_file('day10sampleinput.txt', { chomp => 1 });

my %scoring = ( '(' => 1, '[' => 2, '{' => 3, '<' => 4 );
my @scores;
foreach my $line ( @input ) {
   # replace all matched pairs with no intervening characters
   while (  $line =~ /((\[\])|(\(\))|({})|(<>))/  ) { 
      $line =~ s/\Q$1\E//g;
   }
   # unless a corrupted line (closing char immediately following opening char)
   unless ( $line =~ /^[\[\({<]+([>}\)\]])/ ) {
      my $score = 0;
      my $high_index = length($line) - 1;
      for ( my $i = $high_index; $i >= 0; $i-- ) { # iterate backward thru string
         my $char = substr( $line, $i, 1 );
         $score = ( 5 * $score ) + $scoring{$char};
      }
      push @scores, $score;
   }
}
my @sorted_scores = sort num @scores;
my $num_scores = @scores;
print "Number of scores = $num_scores\n"; # hopefully odd
my $midpoint = int($num_scores/2);
print "Middle score: ".$sorted_scores[$midpoint]."\n";

sub num { $a <=> $b; }
