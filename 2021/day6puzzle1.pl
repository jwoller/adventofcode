use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day6input1.txt', { chomp => 1 });
#my @input = read_file('day6sampleinput.txt', { chomp => 1 });

my @fish = split /,/, $input[0];

#print Dumper(\@fish);

for ( my $day = 1; $day <= 80; $day++ ) {
   my @this_day;
   foreach my $fishy ( @fish ) {
      if ( $fishy == 0 ) {
         $fishy = 6;
         push @this_day, $fishy;
         push @this_day, 8;
      }
      else {
         $fishy = $fishy - 1;
         push @this_day, $fishy;
      }
   }
   @fish = @this_day;
   #print "=====\n$day\n";
   #print Dumper(\@fish);
}

#print Dumper(\@fish);
my $count = @fish;
print "There are $count fish\n";

