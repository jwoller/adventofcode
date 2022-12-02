use File::Slurp;
use Data::Dumper;
use strict;


my @input = read_file('day11input.txt', { chomp => 1 });
#my @input = read_file('day11sampleinput.txt', { chomp => 1 });

my $num_rows = @input;
my $num_cols = length($input[0]);

my $num_flashes = int 0;

my %tracker; # Load up coordinates and values
for ( my $row = 0; $row < $num_rows; $row++ ) {
   my $string = $input[$row];
   print "$string\n";
   my @nums = split //, $string;
   #print Dumper(\@nums);
   for ( my $col = 0; $col < $num_cols; $col++ ) {
      $tracker{$row}{$col} = $nums[$col];
   }
}

my @flashers;
for ( my $step = 1; $step <= 100; $step++ ) {
   print "\n\nStep $step";
   # step  - increase each by one
   foreach my $row ( sort num keys %tracker ) {
      foreach my $col ( sort num keys %{$tracker{$row}} ) {
         my $this_value = $tracker{$row}{$col} + 1;
         if ( $this_value > 9 ) {
            push @flashers, "$col,$row";
            $this_value = 'F';
            $tracker{$row}{$col} = $this_value;
            $num_flashes++;
         }
         else {
            $tracker{$row}{$col} = $this_value;
         }
      }
   }
   # Now that 1 has been added to all coords, loop through to find 
   while (@flashers ) {
      my $xy = shift @flashers;
      addAdjacent($xy);
   }
   # Clean up flashers (reset F values to 0)
   foreach my $row ( sort num keys %tracker ) {
      print "\n";
      foreach my $col ( sort num keys %{$tracker{$row}} ) {
         if ( $tracker{$row}{$col} eq 'F' ) {
            $tracker{$row}{$col} = 0;
         }
         print $tracker{$row}{$col};
      }
   }
}

print "\n\nNumber of flashes: $num_flashes\n";


sub addAdjacent {
   my $xy = shift @_;

   my ($col,$row) = split /,/, $xy;

   my %adj; # label adjacent coords with compass directions
   if ( $row > 0 ) {
      $adj{'nw'} = ( $col - 1 ).",".( $row -1 ) if ( $col > 0 );
      $adj{'n'} = ( $col ).",".( $row -1 );
      $adj{'ne'} = ( $col + 1 ).",".( $row -1 ) if ( $col < ( $num_cols - 1 ) );
   }
   if ( $col > 0 ) {
      $adj{'w'} = ( $col - 1 ).",".( $row );
   }
   if ( $col < ( $num_cols - 1 ) ) {
      $adj{'e'} = ( $col + 1 ).",".( $row );
   }
   if ( $row < ( $num_rows - 1 ) ) {
      $adj{'sw'} = ( $col - 1 ).",".( $row + 1 ) if ( $col > 0 );
      $adj{'s'} = ( $col ).",".( $row + 1 );
      $adj{'se'} = ( $col + 1 ).",".( $row + 1 ) if ( $col < ( $num_cols - 1 ) );
   }

   foreach my $neighbor ( keys %adj ) {
      my $xy = $adj{$neighbor};
      my ($col,$row) = split /,/, $xy;
      my $this_value = $tracker{$row}{$col};
      if ( $this_value ne 'F' ) {
         if ( $this_value == 9 ) {
            $num_flashes++;
            $tracker{$row}{$col} = 'F';
            push @flashers, $xy unless ( grep( $xy eq $_, @flashers ));
         }
         else {
            $tracker{$row}{$col} = $this_value + 1;
         }
      }
   }

}

sub num { $a <=> $b; }
sub revnum { $b <=> $a; }
