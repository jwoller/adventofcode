use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day8input1.txt', { chomp => 1 });
#my @input = read_file('day8sampleinput.txt', { chomp => 1 });

my ($count1, $count4, $count7, $count8);
foreach my $line ( @input ) {
   my ( $x, $y ) = split / \| /, $line;
   my @patterns = split /\s+/, $x;
   my @tests = split /\s+/, $y;
   #print Dumper(\@patterns);
   #print Dumper(\@tests);
   foreach my $test ( @tests ) {
      my $length = length($test);
      if ( $length == 2 ) { $count1++; }
      elsif ( $length == 3 ) { $count7++; }
      elsif ( $length == 4 ) { $count4++; }
      elsif ( $length == 7 ) { $count8++; }
   }
}

print "Number of 1s: $count1\n";
print "Number of 4s: $count4\n";
print "Number of 7s: $count7\n";
print "Number of 8s: $count8\n";
print "Total: ".($count1 + $count4 + $count7 + $count8)."\n";

sub numerically { $a <=> $b; }
