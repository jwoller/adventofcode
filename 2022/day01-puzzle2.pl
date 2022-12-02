use Data::Dumper;


open IN, "< day01-input0.txt";
open IN, "< day01-input1.txt";
my $elfnum = 1;
my %caltrack;
LINE: while (<IN>) {
   chomp;
   if ( $_ ) {
      push @{$caltrack{$elfnum}{'list'}}, $_;
   }
   else {
      $elfnum++;
   }
}
close IN;

my %bycal;
foreach my $elfnum ( keys %caltrack ) {
   my $total;
   foreach my $entry ( @{$caltrack{$elfnum}{'list'}} ) {
      $total = $total + $entry;
   }
   $caltrack{$elfnum}{'total'} = $total;
   push @{$bycal{$total}}, $elfnum;
}

my @order;
foreach my $total ( sort reverse_num keys %bycal ) {
   push @order, $total;
}

#print Dumper(\@order);
my $high = $order[0];
my $top3 = $order[0] + $order[1] + $order[2];

print "Top 3 calories total: $top3\n";

sub reverse_num { $b <=> $a }
