use File::Slurp;
use Data::Dumper;
use strict;


my @input = read_file('day14input.txt', { chomp => 1 });
#my @input = read_file('day14sampleinput.txt', { chomp => 1 });

my $iterations = 40;

my %map;
my %pairs;
my %letters;
foreach my $line ( @input ) {
   if ( $line =~ /^(\w+) -> (\w+)$/ ) {
      $map{$1} =  $2;
   }
   elsif ( $line =~ /^(\w+)$/ ) {
      my $string = $1;
      my $ref = splitPairs($string);
      foreach my $pair ( @$ref ) {
         $pairs{0}{$pair} = $pairs{0}{$pair} + 1;
      }
      my @letterList = split //, $string;
      foreach my $letter ( @letterList ) { $letters{$letter} = $letters{$letter} + 1; }
   }
}

for ( my $i = 1; $i <= $iterations; $i++ ) {
   print "Iteration $i\n";
   my $prior = $i - 1; # prior iteration, source of letter pairs
   foreach my $pair ( keys %{$pairs{$prior}} ) {
      my $new = $map{$pair};
      my $num_pairs = $pairs{$prior}{$pair};
         $letters{$new} = $letters{$new} + $num_pairs;
      my $p1 = substr($pair,0,1).$new;
      my $p2 = $new.substr($pair,1,1);
         $pairs{$i}{$p1} = $pairs{$i}{$p1} + $num_pairs;
         $pairs{$i}{$p2} = $pairs{$i}{$p2} + $num_pairs;
   }
}

my $sum = int 0;
my %count;
foreach my $letter ( keys %letters ) {
   my $this_num = $letters{$letter};
   $count{$this_num} = $letter;
   $sum = $sum + $this_num;
}
print "Number letters: $sum\n";

my @counts = sort num keys %count;

my $high = pop @counts;
my $low = shift @counts;
print "High: ".$count{$high}." $high\n";
print "Low: ".$count{$low}." $low\n";
print "Difference: ".($high - $low)."\n";


sub num { $a <=> $b; }

sub splitPairs {
   my @polymer = split //, $_[0];
   my $size = @polymer;
   my @pairs;
   for ( my $i = 0; $i < ($size-1); $i++ ) {
      push @pairs, $polymer[$i].$polymer[$i+1];
   }
   return(\@pairs);
}






