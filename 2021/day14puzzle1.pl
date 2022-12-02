use File::Slurp;
use Data::Dumper;
use strict;


my @input = read_file('day14input.txt', { chomp => 1 });
my @input = read_file('day14sampleinput.txt', { chomp => 1 });

my %tracker;
my $pairsList;
foreach my $line ( @input ) {
   if ( $line =~ /^(\w+) -> (\w+)$/ ) {
      $tracker{$1} = $2;
   }
   elsif ( $line =~ /^(\w+)$/ ) {
      $pairsList = splitPairs($1);
      print "$line\n\n";
   }
}

my $new_string;
for ( my $i = 1; $i <= 10; $i++ ) {
   my @new_polymer;
   foreach my $pair ( @$pairsList ) {
      my $new = substr($pair,0,1).$tracker{$pair}; # Only first 2 characters
      push @new_polymer, $new;
   }
   my $last_pair = pop @$pairsList;
   push @new_polymer, substr($last_pair,1,1);
   $new_string = join( "", @new_polymer );
   print "$i Length ".length($new_string)."\n";
   print "$i $new_string\n\n";
   $pairsList = splitPairs($new_string);
}

my @chars = split //, $new_string;
my %characters;
foreach my $char ( @chars ) {
   $characters{$char} = $characters{$char} + 1;
}
my ($high, $low);
foreach my $char ( keys %characters ) {
   if ( $characters{$char} > $high ) { $high = $characters{$char}; }
   if  ( defined($low) ) {
      if ( $characters{$char} < $low ) { $low = $characters{$char}; }
   }
   else { $low = $characters{$char}; }
}

print "$high - $low = ".($high - $low)."\n";

sub splitPairs {
   my @polymer = split //, $_[0];
   my $size = @polymer;
   my @pairs;
   for ( my $i = 0; $i < ($size-1); $i++ ) {
      push @pairs, $polymer[$i].$polymer[$i+1];
   }
   return(\@pairs);
}




