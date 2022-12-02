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
      $lines{$linecount}{'x1'} = $x1;
      $lines{$linecount}{'x2'} = $x2;
      $lines{$linecount}{'y1'} = $y1;
      $lines{$linecount}{'y2'} = $y2;
      $linecount++;
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
            #print "$x1,$point\n";
         }
      }
      elsif ( $y1 == $y2 ) { # vertical line
         my ( $points ) = expand_points( $x1,$x2 );
         foreach my $point ( @$points ) {
            my $count = $coordinates{$point.",".$y1} + 1;
            $coordinates{$point.",".$y1} = $count;
            #print "$point,$y1\n";
         }
      }
      else {
         my ( $points ) = expand_diagonal ( $x1, $y1, $x2, $y2 );
         foreach my $point ( @$points ) {
            my $count = $coordinates{$point} + 1;
            $coordinates{$point} = $count;
            #print "$count\n";
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


sub expand_diagonal {
   my ( $x1, $y1, $x2, $y2 ) = @_;
   my $rise = $y2 - $y1;
   my $run  = $x2 - $x1;
   my $slope = $rise/$run;
   #print "$x1 $y1 $x2 $y2 slope: $slope\n";
   my @points;
   if ( $x1 < $x2 ) {
      my $y = $y1;
      my $ydelta = $slope;
      for ( my $i = $x1; $i <= $x2; $i++ ) {
         push @points, $i.",".$y;
         $y = $y+$slope;
      }
   }
   if ( $x1 > $x2 ) {
      my $y = $y2;
      my $ydelta = $slope;
      for ( my $i = $x2; $i <= $x1; $i++ ) {
         push @points, $i.",".$y;
         $y = $y+$slope;
      }
   }
   #print Dumper(\@points);
   return(\@points);
}


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
