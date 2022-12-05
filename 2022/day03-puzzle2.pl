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

my %groups;
my $group_num = int 0;
my $line_count = int 0;

LINE: while (<IN>) {
   chomp;
   my $string = $_;

   push @{$groups{$group_num}}, $string;
   $line_count++;

   # iterate next group if line # is divisible by 3
   my $remainder = remainder( $line_count, 3 );
   if ( $remainder == 0 ) {
      $group_num++;
   }
}
close IN;


foreach my $group_num ( keys %groups ) {
   my $elf1 = shift @{$groups{$group_num}};
   my $elf2 = shift @{$groups{$group_num}};
   my $elf3 = shift @{$groups{$group_num}};

   my @dupes1;

   my @elf1_letters = split ( '', $elf1 );

   my $this_dupe;
   foreach my $letter ( @elf1_letters ) {
      if ( $elf2 =~ /$letter/ ) {
         if ( $elf3 =~ /$letter/ ) {
            $this_dupe = $letter;
         }
      }
   }
   push @dupes, $this_dupe;
}

my $sum = 0;
foreach my $dupe ( @dupes ) {
   $sum = $sum + $map{$dupe};
}
print "Sum of priorities: ".$sum;

sub remainder {
    my ($a, $b) = @_;
    return 0 unless $b && $a;
    return $a / $b - int($a / $b);
}   
