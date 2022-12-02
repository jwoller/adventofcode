use File::Slurp;
use Data::Dumper;

my @lines = read_file('day3input1.txt', { chomp => 1 });
#my @lines = read_file('day3sampleinput.txt', { chomp => 1 });

my %tracker; # keys: position, bit (0/1) value: count

foreach my $value ( @lines ) {
   my $length = length($value);
   for ( $i = 0; $i < $length; $i++ ) {
      my $bit = substr( $value, $i, 1 );
      my $count = int($tracker{$i}{$bit} + 1);
      $tracker{$i}{$bit} = $count;
   }
}

my ($gamma, $epsilon);
foreach my $position ( sort numeric keys %tracker ) {
   if ( $tracker{$position}{0} > $tracker{$position}{1} ) {
      $gamma .= '0';
      $epsilon .= '1';
   }
   else {
      $gamma .= '1';
      $epsilon .= '0';
   }
}

my $gamma10 = oct("0b".$gamma);
my $epsilon10 = oct("0b".$epsilon);
my $power = ( $gamma10 * $epsilon10 );

print "\n";
print "Gamma: $gamma $gamma10\n";
print "Epsilon: $epsilon $epsilon10\n";
print "Power: $power\n";

sub numeric { $a <=> $b };
