use Data::Dumper;

open IN, "< day02-input0.txt";
open IN, "< day02-input1.txt";

my %outcome_target  = ( 'X' => 0, 'Y' => 3, 'Z' => 6 );
my %response_values = ( 'A' => 1, 'B' => 2, 'C' => 3 );
my %response_matrix = (
   'A X' => 'C', # goal: loss
   'A Y' => 'A', # goal: draw
   'A Z' => 'B', # goal: win
   'B X' => 'A', # goal: loss
   'B Y' => 'B', # goal: draw
   'B Z' => 'C', # goal: win
   'C X' => 'B', # goal: loss
   'C Y' => 'C', # goal: draw
   'C Z' => 'A'  # goal: win
   );

my $running_score = int 0;
LINE: while (<IN>) {
   chomp;
   my $play = $_;
   my ( $opp_play, $outcome ) = split /\s*/, $play;

   my $response = $response_matrix{$play};
   my $response_score = $response_values{$response};

   my $outcome_score = $outcome_target{$outcome};
   my $round_score = $response_score + $outcome_score;

   $running_score = $running_score + $round_score;
   print "Round score: $round_score  Running score: $running_score\n";
}
close IN;
