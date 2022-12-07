use Data::Dumper;
use File::Slurp;
use strict;

my $input_file = "day07-input0.txt";
my $input_file = "day07-input1.txt";

my @input = read_file( $input_file, { chomp => 1 } );

#print Dumper(\@input);

my @current_location;
my %info;
my @files;
while ( @input ) {
   my $line = shift @input;
   #print "\n\n$line\n";
   if ( $line =~ /\$ cd \/$/ ) {
      undef @current_location;
   }
   elsif ( $line =~ /\$ cd \.\.$/ ) {
      pop @current_location;
   }
   elsif ( $line =~ /\$ cd (\w+)$/ ) {
      my $dirname = $1;
      push @current_location, $dirname;
   }
   elsif ( $line =~ /\$ ls$/ ) {
      my $path = '/';
         $path .= join( '/', @current_location);
         #print "   Current location: $path\n";
      while ( $input[0] =~ /^((dir)|\d)/ ) {
         my $line = shift @input;
         if ( $line =~ /^dir (\w+)$/ ) {
            my $dirname = $1;
            push @{$info{$path}{'dirs'}}, $dirname;
         }
         elsif ( $line =~ /^(\d+) ([\w\.]+)$/ ) {
            my $filesize = $1;
            my $filename = $2;
            push @{$info{$path}{'files'}}, $filename;
            #print "     File: $path/$filename\n";
            unless ( grep ( $_ eq "$path/$filename", @files )) {
               my $parents = $path;
               while ( $parents =~ /\/\w+/ ) {
                  if ( $parents =~ /[a-z]$/i ) {
                     $info{$parents}{'size'} = $info{$parents}{'size'} + $filesize;
                     $parents =~ s/(\/\w+)$//;
                  }
               }
               $info{'/'}{'size'} = $info{'/'}{'size'} + $filesize;
               push @files, "$path/$filename";
            }
         }
      }
   }
}

my @largedirs;
foreach my $dir ( keys %info ) {
   if ( $dir =~ /\w$/ ) {
      my $dirsize = $info{$dir}{'size'};
      if ( $dirsize < 100000 ) {
         push @largedirs, $dirsize;
      }
   }
}

my $sum;
foreach ( @largedirs ) {
   $sum = $sum + $_;
}

print "Sum of directories <100000: $sum\n";

