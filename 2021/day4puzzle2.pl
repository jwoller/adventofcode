use File::Slurp;
use Data::Dumper;
use strict;

my @lines = read_file('day4input1.txt', { chomp => 1 });
#my @lines = read_file('day4sampleinput.txt', { chomp => 1 });

my @draw = split /,/, shift @lines;
#print Dumper(\@draw);

my $cardnum = int 0;
my $cardrowcount = int 0;
my %cards; # keys: cardnum, row on card

foreach my $line ( @lines ) {
   if ( $line !~ /\d/ ) {
      $cardnum++;
      $cardrowcount = 0;
      #print "Card $cardnum\n";
   }
   elsif ( $cardrowcount <= 4 ) {
      my $cardrow = $line;
         $cardrow =~ s/^\s*//;
      my @digits = split /\s+/, $cardrow;
      @{$cards{$cardnum}{'row'}{$cardrowcount}} = @digits;
      push (@{$cards{$cardnum}{'all'}}, @digits);
      $cardrowcount++;
   }
}

foreach my $cardnum ( keys %cards ) {
   for ( my $colnum = 0; $colnum <= 4; $colnum++ ) {
      my @digits;
      for ( my $rownum = 0; $rownum <= 4; $rownum++ ) {
         push @digits, ${$cards{$cardnum}{'row'}{$rownum}}[$colnum];
      }
      @{$cards{$cardnum}{'col'}{$colnum}} = @digits;
   }
}

my @nums_drawn;
my @cards_completed;
my ( $lastnum, $done );
my $numcards = keys %cards;

foreach my $lastnum_drawn ( @draw ) {
   if ( not defined $done ) {
      push @nums_drawn, $lastnum_drawn;
      $lastnum = $lastnum_drawn;
      print "Draw: $lastnum\n";

      foreach my $cardnum ( sort numeric keys %cards ) {
         unless ( grep($cardnum == $_, @cards_completed) ) {
            foreach my $row ( sort numeric keys %{$cards{$cardnum}{'row'}} ) {
               my $match_count = int 0;
               foreach my $num ( @nums_drawn ) {
                  if ( grep( $_ == $num, @{$cards{$cardnum}{'row'}{$row}}) ) { $match_count++; }
               }
               if ( $match_count == 5 ) {
                  print "Bingo card $cardnum in row $row\n";
                  push @cards_completed, $cardnum unless ( grep($cardnum == $_, @cards_completed) );
                  my $numcards_completed = @cards_completed;
                  $done = $cardnum if ( $numcards_completed == $numcards );
               }
            }
            foreach my $col ( sort numeric keys %{$cards{$cardnum}{'col'}} ) {
               my $match_count = int 0;
               foreach my $num ( @nums_drawn ) {
                  if ( grep( $_ == $num, @{$cards{$cardnum}{'col'}{$col}}) ) { $match_count++; }
               }
               if ( $match_count == 5 ) {
                  print "Bingo card $cardnum in col $col\n";
                  push @cards_completed, $cardnum unless ( grep($cardnum == $_, @cards_completed) );
                  my $numcards_completed = @cards_completed;
                  $done = $cardnum if ( $numcards_completed == $numcards );
               }
            }
         }
      }
   }
}
#print Dumper(\@cards_completed);

my $last_board = pop @cards_completed;
print "Last board to win: $last_board\n";

#print Dumper(\@nums_drawn);

   my @remaining_nums;
   foreach my $gridnum ( @{$cards{$last_board}{'all'}} ) {
      if ( grep( $gridnum == $_, @nums_drawn ) ) {
         #print "$gridnum drawn - exclude\n";
      }
      else {
         push @remaining_nums, $gridnum;
         print "$gridnum not drawn\n";
      }
   }
   my $sum = int 0;
   foreach ( @remaining_nums ) {
      $sum = $sum + $_;
   }
   print "Sum of remaining numbers on winning card: $sum\n";
   print "Last number drawn: $lastnum\n";
   print "Product of sum and last drawn number: ". ($sum * $lastnum)."\n";





#print Dumper(\%cards);

sub numeric { $a <=> $b };
