use File::Slurp;
use Data::Dumper;

my @lines = read_file('day2input1.txt', { chomp => 1 });
#my @lines = read_file('day2sampleinput.txt', { chomp => 1 });

my $x = int 0;
my $depth = int 0;
my $aim = int 0;
foreach ( @lines ) {
   if ($_ =~ /(\w+) (\d+)/) {
      my $direction = $1;
      my $distance = $2;
      if ( $direction eq 'forward' ) {
         $x = $x + $distance;
         $depth = $depth + ($aim * $distance);
      }
      elsif ( $direction eq 'up' ) {
         $aim = $aim - $distance;
      }
      elsif ( $direction eq 'down' ) {
         $aim = $aim + $distance;
      }
      print "$direction $distance | $x $aim $depth\n";
   }
}

print "\nProduct of x and depth: ".($x * $depth)."\n\n\n";
