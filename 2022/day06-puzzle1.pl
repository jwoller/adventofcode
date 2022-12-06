use Data::Dumper;
use File::Slurp;
use strict;

my $input_file = "day06-input0.txt";
my $input_file = "day06-input1.txt";

my $input = read_file( $input_file );

my @letters = split( '', $input );
my $num_letters = @letters;

my $done;
for ( my $index = 0; $index < $num_letters; $index++ ) {
   unless ( $done ) {
      my %tracker;
      $tracker{$letters[$index]} = $tracker{$letters[$index]} + 1;
      $tracker{$letters[$index + 1]} = $tracker{$letters[$index + 1]} + 1;
      $tracker{$letters[$index + 2]} = $tracker{$letters[$index + 2]} + 1;
      $tracker{$letters[$index + 3]} = $tracker{$letters[$index + 3]} + 1;

      my @counts;
      foreach my $letter ( keys %tracker ) {
         push @counts, int($tracker{$letter});
      }

      #print Dumper(\@counts);

      my $hit = 0;
      unless ( grep( $_ > 1, @counts ) ) {
         $hit = 1;
      }
      if ( $hit ) {
         print "\nFirst hit: ".($index + 4)."\n";
         $done = 1;
      }
   }
}
