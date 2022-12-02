use File::Slurp;
use Data::Dumper;
use strict;

my @input = read_file('day5input1.txt', { chomp => 1 });
#my @input = read_file('day5sampleinput.txt', { chomp => 1 });

my %lines;
my $linecount = int 1;

foreach my $line ( @input ) {
   if ( $line =~ /(\d+),(\d+) -> (\d+),(\d+)/ ) {
      my $x1 = int $1;
      my $y1 = int $2;
      my $x2 = int $3;
      my $y2 = int $4;
      if ( ( $x1 == $x2 ) || ( $y1 == $y2 ) ) { # Only horizontal / vertical lines
         $lines{$linecount}{'x1'} = $x1;
         $lines{$linecount}{'x2'} = $x2;
         $lines{$linecount}{'y1'} = $y1;
         $lines{$linecount}{'y2'} = $y2;
         $linecount++;
      }
   }
}

#print Dumper(\%lines);

my %coordinates;

foreach my $linecount ( keys %lines ) {
      my $x1 = $lines{$linecount}{'x1'};
      my $y1 = $lines{$linecount}{'y1'};
      my $x2 = $lines{$linecount}{'x2'};
      my $y2 = $lines{$linecount}{'y2'};
      if ( $x1 == $x2 ) { # horizontal line
         my ( $points ) = expand_points( $y1,$y2 );
         foreach my $point ( @$points ) {
            my $count = $coordinates{$x1.",".$point} + 1;
            $coordinates{$x1.",".$point} = $count;
         }
      }
      elsif ( $y1 == $y2 ) { # vertical line
         my ( $points ) = expand_points( $x1,$x2 );
         foreach my $point ( @$points ) {
            my $count = $coordinates{$point.",".$y1} + 1;
            $coordinates{$point.",".$y1} = $count;
         }
      }
}

#print Dumper(\%coordinates);

my $intersection_count = int 0;
foreach my $coordinate ( keys %coordinates ) {
   if ( $coordinates{$coordinate} > 1 ) {
      $intersection_count++;
   }
}

print "Number of intersection points: $intersection_count\n";

sub expand_points {
   my ( $p1, $p2 ) = @_;

   my @points;
   if ( $p1 == $p2 ) {
      push @points, $p1;
   }
   elsif ( $p1 < $p2 ) {
      for ( my $i = $p1; $i <= $p2; $i++ ) {
         push @points, $i;
      }
   }
   elsif ( $p1 > $p2 ) {
      for ( my $i = $p2; $i <= $p1; $i++ ) {
         push @points, $i;
      }
   }
   return ( \@points );
}

sub numeric { $a <=> $b };
