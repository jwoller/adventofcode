use File::Slurp;
use Data::Dumper;
use strict;

my %patterns; # Key = number of segments in common with 1, 4, 7, 8, in order; see Excel file
   $patterns{'2336'} = 0;
   $patterns{'1225'} = 2;
   $patterns{'2335'} = 3;
   $patterns{'1325'} = 5;
   $patterns{'1326'} = 6;
   $patterns{'2436'} = 9;

my @input = read_file('day8input1.txt', { chomp => 1 });
#my @input = read_file('day8sampleinput.txt', { chomp => 1 });

my $sum;
foreach my $line ( @input ) {
   my %tracker;
   my ( $x, $y ) = split / \| /, $line;
   my @patterns = split /\s+/, $x;
   my @tests = split /\s+/, $y;
   my ( $alpha1, $alpha7, $alpha4, $alpha8 );
   foreach my $pattern ( @patterns ) {
      my @arr = split //, $pattern;
      my @word = sort alpha @arr;
      my $alpha = join "", @word;
      my $length = length($pattern);
      push @{$tracker{'num characters'}{$length}}, $alpha;
      foreach ( @word ) {
         $tracker{'info'}{$alpha}{'letters'}{$_} = 1;
      }
      if ( $length == 2 ) { 
         $tracker{'info'}{$alpha}{'value'} = 1; 
         $tracker{'knowns'}{1} = $alpha;
      }
      elsif ( $length == 3 ) { 
         $tracker{'info'}{$alpha}{'value'} = 7; 
         $tracker{'knowns'}{7} = $alpha;
      }
      elsif ( $length == 4 ) { 
         $tracker{'info'}{$alpha}{'value'} = 4; 
         $tracker{'knowns'}{4} = $alpha;
      }
      elsif ( $length == 7 ) { 
         $tracker{'info'}{$alpha}{'value'} = 8; 
         $tracker{'knowns'}{8} = $alpha;
      }
   }

   foreach my $word ( keys %{$tracker{'info'}} ) {
      unless ( $tracker{'info'}{$word}{'value'} ) {
      #print "$word\n";
         my $tracker_ref = check(\%tracker,$word);
            %tracker = %$tracker_ref;
      }
   }

   my $answer;
   foreach my $test ( @tests ) {
      my @arr = split //, $test;
      my @word = sort alpha @arr;
         $test = join "", @word;
         $answer .= $tracker{'info'}{$test}{'value'};
   }
   print "$answer\n";

   $sum = $sum + $answer;
}

print "\n\nSum of all digits: $sum\n";


#print "Total: ".($count1 + $count4 + $count7 + $count8)."\n";

sub check {
   my $tracker_ref = shift @_;
   my %tracker = %$tracker_ref;
   my $checkstr = shift @_;

   my $segment_matches;
   foreach my $value ( sort num keys %{$tracker{'knowns'}} ) {
      my $known_alpha = $tracker{'knowns'}{$value};
      my $count_matches = int 0;
      foreach my $letter ( keys %{$tracker{'info'}{$known_alpha}{'letters'}} ) {
         if ( $checkstr =~ /$letter/i ) { $count_matches++; }
      }
      $segment_matches .= $count_matches;
   }

   my $unknown_value = $patterns{$segment_matches};
   #print "$checkstr $segment_matches $unknown_value\n";
   $tracker{'info'}{$checkstr}{'value'} = $unknown_value;

   return(\%tracker);
}

sub alpha { lc($a) cmp lc($b); }
sub num { $a <=> $b; }
