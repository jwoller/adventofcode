use File::Slurp;
use Data::Dumper;

my @lines = read_file('day1input1.txt', { chomp => 1 });

my $numlines = @lines;
my @sums;

for ( $i = 2; $i <= $numlines; $i++ ) {
   my $i1 = $i-1;
   my $i2 = $i-2;
   my $this_sum = $lines[$i] + $lines[$i1] + $lines[$i2];
   push @sums, $this_sum;
}

my $numsums = @sums;
my $increased_num = 0;
for ( $i = 1; $i <= $numsums; $i++ ) {
   my $lastsum = $sums[$i-1];
   my $diff = $sums[$i] - $lastsum;
   if ( $diff > 0 ) {
      print "$lastsum => ".$sums[$i]." (increased)\n";
      $increased_num++;
   }
}

print "\n\nNumber of increased rolling sums: ".$increased_num."\n";
