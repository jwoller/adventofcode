use File::Slurp;
use Data::Dumper;
use strict;

my @lines = read_file('day3input1.txt', { chomp => 1 });
#my @lines = read_file('day3sampleinput.txt', { chomp => 1 });

my %tracker; 
# keys: position, bit (0/1); count = occurrences of bit in that position; value = list of values with matching bit

foreach my $value ( @lines ) {
   my $length = length($value);
   for ( my $i = 0; $i < $length; $i++ ) {
      my $bit = substr( $value, $i, 1 );
      my $count = int($tracker{$i}{$bit}{'count'} + 1);
      $tracker{$i}{$bit}{'count'} = $count;
      push @{$tracker{$i}{$bit}{'values'}}, $value;
   }
}
my $num_positions = keys %tracker;

# Oxygen generator rating
my (@oxygen_values);
my ($ox_gen_rating);
if ( $tracker{0}{0}{'count'} > $tracker{0}{1}{'count'} ) {
   @oxygen_values = @{$tracker{0}{0}{'values'}};
}
elsif ( $tracker{0}{0}{'count'} < $tracker{0}{1}{'count'} ) {
   @oxygen_values = @{$tracker{0}{1}{'values'}};
}
for ( my $i = 1; $i < $num_positions; $i++ ) {
   my (@oxtemp1, @oxtemp0);
   foreach my $value ( @oxygen_values ) {
      my $bit = substr( $value, $i, 1 );
      if ( $bit == 1 ) {
         push @oxtemp1, $value;
      } 
      elsif ( $bit == 0 ) {
         push @oxtemp0, $value;
      } 
   }
   my $num0 = @oxtemp0;
   my $num1 = @oxtemp1;
   if ( $num0 <= $num1 ) {
      @oxygen_values = @oxtemp1;
   }
   elsif ( $num0 > $num1 ) {
      @oxygen_values = @oxtemp0;
   }

   my $num_ox_values = @oxygen_values;
   if ( $num_ox_values == 1 ) {
      $ox_gen_rating = $oxygen_values[0];
   }

}

my $ox10 = oct("0b".$ox_gen_rating);

print "\n";
print "Oxygen rating: $ox_gen_rating ($ox10)\n";

# CO2 scrubber rating
my (@co2_values);
my ($co2_rating);
if ( $tracker{0}{0}{'count'} < $tracker{0}{1}{'count'} ) {
   @co2_values = @{$tracker{0}{0}{'values'}};
}
elsif ( $tracker{0}{0}{'count'} > $tracker{0}{1}{'count'} ) {
   @co2_values = @{$tracker{0}{1}{'values'}};
}

for ( my $i = 1; $i < $num_positions; $i++ ) {
   my (@co2temp1, @co2temp0);
   foreach my $value ( @co2_values ) {
      my $bit = substr( $value, $i, 1 );
      if ( $bit == 1 ) {
         push @co2temp1, $value;
      } 
      elsif ( $bit == 0 ) {
         push @co2temp0, $value;
      } 
   }
   my $num0 = @co2temp0;
   my $num1 = @co2temp1;
   if ( $num0 <= $num1 ) {
      @co2_values = @co2temp0;
   }
   elsif ( $num1 < $num0 ) {
      @co2_values = @co2temp1;
   }

   my $num_co2_values = @co2_values;
   if ( $num_co2_values == 1 ) {
      $co2_rating = $co2_values[0];
   }

}

my $co210 = oct("0b".$co2_rating);

print "CO2 rating: $co2_rating ($co210)\n";

print "Life support rating: ".($co210*$ox10)."\n";

sub numeric { $a <=> $b };
