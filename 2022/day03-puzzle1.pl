use Data::Dumper;


open IN, "< day03-input0.txt";
open IN, "< day03-input1.txt";

my %letter_map;
my $number = 1;
foreach('a'..'z') {
   $map{$_} = $number;
   $number++;
}
foreach('A'..'Z') {
   $map{$_} = $number;
   $number++;
}

my @dupes;
LINE: while (<IN>) {
   chomp;
   my $string = $_;
   my $length = length($string);
   my $compartment_size = int($length / 2);
   my @comp1 = split( '', substr( $string, 0, $compartment_size ) );
   my $comp2 = substr( $string, $compartment_size, $compartment_size );
   my $this_dupe;
   foreach my $letter ( @comp1 ) {
      if ( $comp2 =~ /$letter/ ) {
         $this_dupe = $letter;
      }
   }
   push @dupes, $this_dupe;
}
close IN;

my $sum = 0;
foreach my $dupe ( @dupes ) {
   $sum = $sum + $map{$dupe};
}
print "Sum of priorities: ".$sum;
