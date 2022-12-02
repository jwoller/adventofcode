use File::Slurp;
use Data::Dumper;

my @lines = read_file('day1input1.txt', { chomp => 1 });

my $lastnum = 'start';
my $increased_num = 0;
while ( @lines ) {
   print $lines[0];
   if ( $lastnum eq 'start' ) {
      print " (N/A - no previous measurement)\n";
   }
   else {
      if ( $lines[0] > $lastnum ) {
         print " (increased)\n";
         $increased_num++;
      }
      elsif ( $lines[0] < $lastnum ) {
         print " (decreased)\n";
      }
      else {
         print " (no change)\n";
      }
   }
   $lastnum = shift @lines;
}

print "Number of increased measurements: ".$increased_num."\n";
