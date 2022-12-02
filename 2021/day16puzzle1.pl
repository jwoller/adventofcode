use Data::Dumper;
use strict;


my $hex = "D2FE28"; # hexadecimal sample 1
my $hex = "38006F45291200"; # hexadecimal sample 2

my $bin = sprintf ( "%b", hex( $hex ) );

my $version = sprintf ( oct("0b0".substr($bin,0,3) ) );
my $typeId  = sprintf ( oct("0b0".substr($bin,3,3) ) );

my $message_in = $bin;
   $message_in =~ s/^\d{6}//;
my ( $message );

print "Input: $hex\n";
print "Binary: $bin\n";
print "Version: $version\n";
print "Type ID: $typeId\n";


if ( $typeId == 4 ) { # literal
   my @characters;
   my ( $type, $done );
   while ( ( $message_in =~ /^((\d)(\d{4}))/ ) && ( $done != 1 ) ) {
      my $word = $1;
      $type = $2;
      push @characters, $3;
      $message_in =~ s/^$word//;
      if ( $type == 0 ) {
         $done = 1;
      }
   }
   $message = join "", @characters;
   $message = oct("0b".$message);
   print "$message\n";
}
else { # operator packet
   my $lengthId = substr( $message_in, 0, 1 );
      $message_in =~ s/^$lengthId//;

   print "Length ID: $lengthId\n";
   print "Binary remaining: $message_in\n";

   my ( $total_length, $num_subpackets );
   if ( $lengthId == 0 ) {
      $total_length = substr( $message_in, 0, 15 );
      print "Total length: $total_length\n";
   }
   else { # lengthId = 1
      $num_subpackets = oct("0b".substr( $message_in, 0, 11 ));
      print "Subpackets: $num_subpackets\n";
   }

}


