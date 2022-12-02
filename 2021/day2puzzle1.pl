use File::Slurp;
use Data::Dumper;

my @lines = read_file('day2input1.txt', { chomp => 1 });
#my @lines = read_file('day2sampleinput.txt', { chomp => 1 });

my $x = int 0;
my $y = int 0;
foreach ( @lines ) {
   if ($_ =~ /(\w+) (\d+)/) {
      my $direction = $1;
      my $distance = $2;
      if ( $direction eq 'forward' ) {
         $x = $x + $distance;
      }
      elsif ( $direction eq 'up' ) {
         $y = $y + $distance;
      }
      elsif ( $direction eq 'down' ) {
         $y = $y - $distance;
      }
      print "$direction $distance | $x $y\n";
   }
}

print "\nProduct of x and y: ".($x * $y)."\n";
print "Depth is negative, so answer is: ".($x * $y * -1)."\n\n\n";
