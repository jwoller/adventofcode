use Data::Dumper;
use File::Slurp;
use strict;

my $input_file = "day06-input0.txt";
my $input_file = "day06-input1.txt";

my $input = read_file( $input_file );

my @letters = split( '', $input );
my $num_letters = @letters;

my $unique_chars = 14; 

my $done;
for ( my $index = 0; $index < $num_letters; $index++ ) {
   unless ( $done ) {
      my %tracker;
      for ( my $j = $index; $j < ($index + $unique_chars) ; $j++ ) {
         $tracker{$letters[$j]} = $tracker{$letters[$j]} + 1;
      }

      #print Dumper(\%tracker);

      my @counts;
      foreach my $letter ( keys %tracker ) {
         push @counts, int($tracker{$letter});
      }

      #print Dumper(\@counts);

      my $hit = 0;
      unless ( grep( $_ > 1, @counts ) ) {
         $hit = 1;
      }
      print "Testing ".($index + $unique_chars)."\n";
      if ( $hit ) {
         print "\nFirst hit: ".($index + $unique_chars)."\n";
         $done = 1;
      }
   }
}
