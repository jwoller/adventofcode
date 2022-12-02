use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day6input1.txt', { chomp => 1 });
#my @input = read_file('day6sampleinput.txt', { chomp => 1 });

my @fish = split /,/, $input[0];

my %tracker;
foreach my $age ( @fish ) {
   $tracker{$age} = $tracker{$age} + 1;
}
#print Dumper(\%tracker);

for ( my $day = 1; $day <= 256; $day++ ) {
   my %this_day;
   foreach my $age ( keys %tracker ) {
      my $num_fish = $tracker{$age};
      #print "$age $num_fish\n";
      if ( $age == 0 ) {
         $age = 6;
         $this_day{$age} = $this_day{$age} + $num_fish;
         $this_day{8} = $this_day{8} + $num_fish; # new fish added
      }
      else {
         $age = $age - 1;
         $this_day{$age} = $this_day{$age} + $num_fish;
      }
   }
   #print "Day $day\n";
   #print Dumper(\%tracker);
   #print Dumper(\%this_day);
   %tracker = %this_day;
}

my $count = 0;
foreach my $age ( keys %tracker ) {
   $count = $count + $tracker{$age};
}
print "There are $count fish\n";
