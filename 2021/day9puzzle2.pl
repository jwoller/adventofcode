use File::Slurp;
use Data::Dumper;
use strict;


# this is ugly

my @input = read_file('day9input1.txt', { chomp => 1 });
#my @input = read_file('day9sampleinput.txt', { chomp => 1 });

my $num_rows = @input;
my $num_cols = length($input[0]);

#print "$num_rows $num_cols\n";

my %tracker; # Load up coordinates of 9 vs. not-9 (basin)
for ( my $row = 0; $row < $num_rows; $row++ ) {
   my $string = $input[$row];
      $string =~ s/[0-8]/0/g;
   #print "$string\n";
   my @nums = split //, $string;
   #print Dumper(\@nums);
   for ( my $col = 0; $col < $num_cols; $col++ ) {
      $tracker{$col}{$row}{'value'} = $nums[$col];
   }
}
close OUT;

#print Dumper(\%tracker);

my %basins;
my @checked;
my $risk = int 0;
foreach my $col ( sort num keys %tracker ) {
   foreach my $row ( sort num keys %{$tracker{$col}} ) {
      my $is_basin;
      my $this_value = $tracker{$col}{$row}{'value'};
      my $xy = "$col,$row";
      if ( ($this_value == 0) && not(grep( $xy eq $_, @checked) ) ) { # this is a basin index
         my $basin_index = $xy;
         push @{$basins{$xy}}, $xy;
         push @checked, $xy;
         my $ref = checkNeighbors($xy, $basin_index);
         my @basin_neighbors = @$ref;
         while ( $basin_neighbors[0] ) {
            my $next = shift @basin_neighbors;
            unless ( grep( $next eq $_, @checked ) ) {
               push @checked, $next;
               my $ref = checkNeighbors($next, $basin_index);
               my @more = @$ref;
               push (@basin_neighbors, @more);
            }
         }
      }
   }
}

my @basin_size;
foreach my $basin_index ( keys %basins ) {
   my $count = @{$basins{$basin_index}};
   print "$basin_index: $count\n";
   push @basin_size, $count;
}
my @sorted = sort revnum @basin_size;
my $product = ($sorted[0] * $sorted[1] * $sorted[2]);
print "Product of 3 largest basin sizes: $product\n";


sub checkNeighbors {
   my $xy = shift @_;
   my $basin_index = shift @_;
   my ($col,$row) = split /,/, $xy;
   my @basin_coords;
   if ( $row > 0 ) { # up
      my $y = $row - 1;
      my $x = $col;
      if ($tracker{$x}{$y}{'value'} == 0 ) { 
         push @basin_coords, "$x,$y";
         push @{$basins{$basin_index}}, "$x,$y" unless ( grep ( "$x,$y" eq $_, @{$basins{$basin_index}}) );
      }
   }
   if ( $row < ( $num_rows - 1 ) ) { # down
      my $y = $row + 1;
      my $x = $col;
      if ($tracker{$x}{$y}{'value'} == 0 ) { 
         push @basin_coords, "$x,$y";
         push @{$basins{$basin_index}}, "$x,$y" unless ( grep ( "$x,$y" eq $_, @{$basins{$basin_index}}) );
      }
   }
   if ( $col > 0 ) { # left
      my $y = $row;
      my $x = $col - 1;
      if ($tracker{$x}{$y}{'value'} == 0 ) { 
         push @basin_coords, "$x,$y";
         push @{$basins{$basin_index}}, "$x,$y" unless ( grep ( "$x,$y" eq $_, @{$basins{$basin_index}}) );
      }
   }
   if ( $col < ( $num_cols - 1 ) ) { #right
      my $y = $row;
      my $x = $col + 1;
      if ($tracker{$x}{$y}{'value'} == 0 ) { 
         push @basin_coords, "$x,$y";
         push @{$basins{$basin_index}}, "$x,$y" unless ( grep ( "$x,$y" eq $_, @{$basins{$basin_index}}) );
      }
   }
   return(\@basin_coords);
}

sub num { $a <=> $b; }
sub revnum { $b <=> $a; }
