use Data::Dumper;
use strict;


open IN, "< day04-input0.txt";
open IN, "< day04-input1.txt";

my $count = int 0;
LINE: while (<IN>) {
   chomp;
   my $string = $_;
   my ($elf1_range,$elf2_range) = split ( ',', $string );
   my ($elf1_low,$elf1_high) = split ( '-', $elf1_range );
   my ($elf2_low,$elf2_high) = split ( '-', $elf2_range );

   if ( ( ( $elf1_low >= $elf2_low )  && ( $elf1_low <= $elf2_high ) ) ||
        ( ( $elf1_high >= $elf2_low ) && ( $elf1_high <= $elf2_high ) ) ||
        ( ( $elf2_low >= $elf1_low )  && ( $elf2_low <= $elf1_high ) ) ||
        ( ( $elf2_high >= $elf1_low ) && ( $elf2_high <= $elf1_high ) ) ) {
        $count++;
   }
}
close IN;

print "\nPairs where one range fully encompasses the other: ".$count."\n\n";
