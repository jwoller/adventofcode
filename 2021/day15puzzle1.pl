use File::Slurp;
use Data::Dumper;
use strict;


my @input = read_file('day15input.txt', { chomp => 1 });
my @input = read_file('day15sampleinput.txt', { chomp => 1 });

my %grid; # $grid{row}{col} = cell value
my $num_cols;
my $num_rows = @input;
for ( my $row = 0; $row < $num_rows; $row++ ) {
   my (@values) = split //, $input[$row];
      $num_cols = @values;
   for ( my $col = 0; $col < $num_cols; $col++ ) {
      $grid{$row}{$col} = $values[$col];
   }
}

my $max_cost = ( $num_rows * $num_cols * 100);

# possible moves
my @dx = [ 1, -1, 0,  0 ];
my @dy = [ 0,  0, 1, -1 ];

my ( %visited, %minCost, %dp );

for ( my $row = 0; $row < $num_rows; $row++ ) {
   for ( my $col = 0; $col < $num_cols; $col++ ) {
      $dp{$row}{$col} = $max_cost;
   }
}
