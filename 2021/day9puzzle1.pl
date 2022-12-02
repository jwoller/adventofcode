use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day9input1.txt', { chomp => 1 });
#my @input = read_file('day9sampleinput.txt', { chomp => 1 });

my $num_rows = @input;
my $num_cols = length($input[0]);

#print "$num_rows $num_cols\n";

my %tracker;
for ( my $row = 0; $row < $num_rows; $row++ ) {
   my @nums = split //, $input[$row];
   #print Dumper(\@nums);
   for ( my $col = 0; $col < $num_cols; $col++ ) {
      $tracker{$col}{$row}{'value'} = $nums[$col];
   }
}

#print Dumper(\%tracker);

my $risk = int 0;
foreach my $col ( sort num keys %tracker ) {
   foreach my $row ( sort num keys %{$tracker{$col}} ) {
      my %map;
         if ( $row > 0 ) {
            $map{'up'}{'y'} = $row - 1;
            $map{'up'}{'x'} = $col;
         }
         if ( $row < ( $num_rows - 1 ) ) {
            $map{'down'}{'y'} = $row + 1;
            $map{'down'}{'x'} = $col;
         }
         if ( $col > 0 ) {
            $map{'left'}{'y'} = $row;
            $map{'left'}{'x'} = $col - 1;
         }
         if ( $col < ( $num_cols - 1 ) ) {
            $map{'right'}{'y'} = $row;
            $map{'right'}{'x'} = $col + 1;
         }
      my $this_value = $tracker{$col}{$row}{'value'};
      my $adjacent_pts = ( keys %map );
      #print "$this_value $col $row\n";
      #print Dumper(\%map);
      #print "$this_value adjacent points: $adjacent_pts\n";
      my $is_lower_count = int 0;
      foreach my $direction ( keys %map ) {
         my $check_value_x = $map{$direction}{'x'};
         my $check_value_y = $map{$direction}{'y'};
         my $check_value = $tracker{$check_value_x}{$check_value_y}{'value'};
         #print "   $this_value $direction $check_value\n";
         #print "$col $row <$this_value> $direction $check_value_x $check_value_y <$check_value>\n";
         if ( $this_value < $check_value ) {
            $is_lower_count++;
         }
         #print "     count: $is_lower_count\n";
      }
      if ( $is_lower_count == $adjacent_pts ) {
         $risk = $risk + $this_value + 1;
      }
   }
}

print "Risk: $risk\n";

#print Dumper(\%tracker);

sub num { $a <=> $b; }
