use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day7input1.txt', { chomp => 1 });
#my @input = read_file('day7sampleinput.txt', { chomp => 1 });

my @crabs = split /,/, $input[0];

my @sorted_crabs;
foreach my $crab ( sort numerically @crabs ) {
   push @sorted_crabs, $crab;
}

my $low_position = $sorted_crabs[0];
my $high_position = $sorted_crabs[@sorted_crabs - 1];

my %tracker;
for ( my $i = $low_position; $i <= $high_position; $i++ ) {
   foreach my $crab ( sort numerically @crabs ) {
      my $distance = abs( $crab - $i );
      if ( $distance > 0 ) {
         my $cost;
         # Looping over each step is slow (~65 sec)
#         for ( my $j = 0; $j <= $distance; $j++ ) {
#            $cost = $cost + $j;
#         }
         # Much faster (~2 sec)
         if ( $distance % 2 == 0 ) { # distance is even number
            $cost = ( ($distance / 2) * $distance ) + ( $distance / 2 );
         }
         else { # distance is odd
            $cost = ( (($distance - 1) / 2) * $distance ) + $distance ;
         }
         #print "Move from $crab to $i: $cost (distance = $distance)\n";
         $cost = $cost + $tracker{$i};
         $tracker{$i} = $cost;
      }
   }
}

my ( $cheapest_position, $cheapest_fuel );
foreach my $position ( keys %tracker ) {
   if ( ($tracker{$position} < $cheapest_fuel ) || ( $cheapest_fuel == 0 ) ) {
      $cheapest_position = $position;
      $cheapest_fuel = $tracker{$position};
   }
}

#print Dumper(\%tracker);

print "Low crab position:  ".$low_position."\n";
print "High crab position: ".$high_position."\n";
print "Cheapest position:  ".$cheapest_position."\n";
print "Cheapest fuel:      ".$cheapest_fuel."\n";

sub numerically { $a <=> $b; }
