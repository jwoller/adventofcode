use Data::Dumper;
use File::Slurp;
use strict;

my $input_file = "day05-input0.txt";
my $input_file = "day05-input1.txt";

my @lines = read_file( $input_file );

my @procedure;
my %stacks;
my $num_stacks;
foreach my $line ( @lines ) { # get number of stacks
   if ( $line =~ /^[ \d]*(\d)\s*$/ ) {
      $num_stacks = $1;
   }
}
print "\n";
print "Number of stacks: $num_stacks\n";

foreach my $line ( @lines ) {
   if ( $line =~ /move (\d+) from (\d+) to (\d+)/ ) { # procedure
      push @procedure, "$1,$2,$3";
   }
   elsif ( $line =~ /\[/ ) { # starting stack configuration
      for ( my $stack = 1; $stack <= $num_stacks; $stack++ ) {
         my $column = 1;
         if ( $stack > 1 ) {
            $column = ( ( $stack - 1 ) * 4 ) + 1;
         }
         my $crate_contents = substr( $line, $column, 1 );
         if ( $crate_contents =~ /[A-Z]/ ) {
            push @{$stacks{$stack}}, $crate_contents;
         }
      }
   }
}
#print Dumper(\%stacks);
#print Dumper(\@procedure);

foreach my $step ( @procedure ) {
   my ($num,$source,$target) = split(',',$step);
   my @move_stack;
   for ( my $i = 1; $i <= $num; $i++ ) {
      my $crate = shift( @{$stacks{$source}} );
      unshift ( @move_stack, $crate );
   }
   foreach my $crate ( @move_stack ) {
      unshift ( @{$stacks{$target}}, $crate );
   }
   #print Dumper(\%stacks);
}

my $top_crates;
foreach my $stack ( sort keys %stacks ) {
   $top_crates .= ${$stacks{$stack}}[0];
}

print "\nTop crates: $top_crates\n";
