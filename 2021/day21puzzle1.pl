use Data::Dumper;
use strict;

my %tracker;

$tracker{'player1'}{'position'} = 10;
$tracker{'player1'}{'score'} = 0;
$tracker{'player2'}{'position'} = 3;
$tracker{'player2'}{'score'} = 0;

my $roll_ref = rollDice();
my @roll = @$roll_ref;;

my $num_rolls = int 0;
while ( ( $tracker{'player1'}{'score'} < 1000 ) && ( $tracker{'player2'}{'score'} < 1000 ) ) {
   my $who = int ( $num_rolls % 2 );
   my $player;
   if ( $who == 1 ) {
      $player = 'player2';
   }
   else {
      $player = 'player1';
   }
   my $position;
   my $roll_total = int 0;
   for ( my $turn = 1; $turn <= 3; $turn++ ) {
      $num_rolls++;
      $roll_total = $roll_total + $roll[$num_rolls-1];
      print "$num_rolls $roll[$num_rolls]\n";
   }
   my $new_position =  (( $tracker{$player}{'position'} + $roll_total ) % 10 ); 
      if ( $new_position == 0 ) { $new_position = '10'; }
      $tracker{$player}{'position'} = $new_position;
   my $new_score = $tracker{$player}{'score'} + $new_position;
      $tracker{$player}{'score'} = $new_score;
   print "roll $num_rolls $player rolls $roll_total ends on $new_position with score $new_score\n";
}

print "Die rolled $num_rolls times\n";
print "Player 1 score = $tracker{'player1'}{'score'} (x$num_rolls = ".($tracker{'player1'}{'score'} * $num_rolls).")\n";
print "Player 2 score = $tracker{'player2'}{'score'} (x$num_rolls = ".($tracker{'player2'}{'score'} * $num_rolls).")\n";



sub rollDice {
   my @roll;
   for ( my $i = 1; $i <= 1000; $i++ ) {
      push @roll, $i;
   }
   return(\@roll);
}
