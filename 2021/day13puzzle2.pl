use File::Slurp;
use Data::Dumper;
use strict;


my @input = read_file('day13input.txt', { chomp => 1 });
#my @input = read_file('day13sampleinput.txt', { chomp => 1 });
#my @input = read_file('day13bonusinput.txt', { chomp => 1 });

my %tracker;
my $num_folds = int 0;
foreach my $line ( @input ) {
   if ( $line =~ /^(\d+,\d+)$/ ) {
      push @{$tracker{'dots'}}, $1;
   }
   elsif ( $line =~ /fold along ([xy])=(\d+)$/ ) {
      $tracker{'fold'}{$num_folds}{'axis'} = $1;
      $tracker{'fold'}{$num_folds}{'position'} = $2;
      $num_folds++;
   }
}

print "\nPoints visible: ".@{$tracker{'dots'}}."\n";

foreach my $fold_num ( sort num keys %{$tracker{'fold'}} ) {
   my %positions_after_fold;
   my $axis = $tracker{'fold'}{$fold_num}{'axis'};
   my $fold_position = $tracker{'fold'}{$fold_num}{'position'};
   foreach my $xy ( @{$tracker{'dots'}} ) {
      my ($x,$y) = split /,/, $xy;
      if ( ( $axis eq 'x' ) && ( $x > $fold_position ) ) {
         my $diff = $x - $fold_position;
         $x = $fold_position - $diff;
      }
      elsif ( ( $axis eq 'y' ) && ( $y > $fold_position ) ) {
         my $diff = $y - $fold_position;
         $y = $fold_position - $diff;
      }
      $xy = $x.",".$y;
      $positions_after_fold{$xy} = 1;
   }
   print "Fold #".($fold_num+1)." ($axis = $fold_position)\n";
   my $num_points = keys (%positions_after_fold);
   print "Points visible: $num_points\n";
   @{$tracker{'dots'}} = ( );
   foreach my $xy ( keys %positions_after_fold ) {
      push @{$tracker{'dots'}}, $xy;
   }
}

my %printable;
my $max_x;
foreach my $dot ( @{$tracker{'dots'}} ) {
   my ($x,$y) = split /,/, $dot;
   $printable{$y}{$x} = 1;
   if ( $x > $max_x ) { $max_x = $x; }
}

my $num_rows = keys %printable;

for ( my $y = 0; $y < $num_rows; $y++ ) {
   for ( my $x = 0; $x <= $max_x; $x++ ) {
      if ( $printable{$y}{$x} ) {
         print "#";
      }
      else {
         print " ";
      }
   }
   print "\n";
}


sub num { $a <=> $b; }


