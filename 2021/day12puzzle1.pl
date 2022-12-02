use File::Slurp;
use Data::Dumper;
use strict;


my @input = read_file('day12input.txt', { chomp => 1 });
#my @input = read_file('day12sampleinput2.txt', { chomp => 1 });
#my @input = read_file('day12sampleinput1.txt', { chomp => 1 });

my %tracker;
foreach my $line ( @input ) {
   my ($c1, $c2) = split /-/, $line;
   push @{$tracker{$c1}}, $c2;
   push @{$tracker{$c2}}, $c1;
}

my ( @valid_next, @complete );
foreach my $step1 ( @{$tracker{'start'}} ) {
   my $this_step = "start,$step1";
   push @valid_next, $this_step;
   while ( $valid_next[0] ) {
      my $this_path = shift @valid_next;
      my $ref = expandSteps($this_path);
      push @valid_next, @$ref;
   }
}

my $count = @complete;
print "There are $count valid paths\n";

sub expandSteps {
   my $this_path = shift @_;

   my @current_strings;
   my $this_step = $this_path;
      $this_step =~ s/.*,//;

   foreach my $next ( @{$tracker{$this_step}} ) {
      if ( $next ne 'start' ) { # no going back to start
         if ( $next eq 'end' ) {
            push @complete, "$this_path,$next";
            print "Complete: $this_path,$next\n";
         }
         elsif ( $next =~ /[a-z]/ ) {
            if ( $this_path !~ /$next/ ) {
               push @current_strings, "$this_path,$next";
               print "Valid: $this_path,$next\n";
            }
         }
         elsif ( $next =~ /[A-Z]/ ) {
            push @current_strings, "$this_path,$next";
               print "Valid: $this_path,$next\n";
         }
         else { # this string doesn't have any valid next move; it won't be returned as valid
            print "Abandoned: $this_path\n";
         }
      }
   }
   return(\@current_strings);
}


