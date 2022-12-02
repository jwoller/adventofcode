use Data::Dumper;


open IN, "< day02-input0.txt";
open IN, "< day02-input1.txt";

my %response_values = ( 'X' => 1, 'Y' => 2, 'Z' => 3 );
my %outcome_values  = (
   'A X' => 3,
   'A Y' => 6,
   'A Z' => 0,
   'B X' => 0,
   'B Y' => 3,
   'B Z' => 6,
   'C X' => 6,
   'C Y' => 0,
   'C Z' => 3
   );

my $running_score = int 0;
LINE: while (<IN>) {
   chomp;
   my $play = $_;
   my ( $opp_play, $response ) = split /\s*/, $play;
   my $round_score = $outcome_values{$play} + $response_values{$response};
   $running_score = $running_score + $round_score;
   print "Running score: $running_score\n";
}
close IN;

