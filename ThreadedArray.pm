package ThreadedArray;

use strict;
use threads;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter);
@EXPORT = qw();
$VERSION = '1.0.0';

my @work_list = [];
my $working_function;
my $items_per_thread = 3;
my @argument_list = ();

sub set_work_list {
  @work_list = @_;
}
# Subroutine to set the items that will be handled by each thread
sub set_items_per_thread {
  $items_per_thread = $_[0];
}
# Set the function and argument list 
# to be parrallelly executed on each item of the worklist.
sub set_working_function {
  $working_function = shift;
  @argument_list    = @_;
}
# Thread out the work and retrive the resulting array.
# It is not necessary to expect a resulting array but it will
# still be returned.
sub get_result {
  # Threading out
  my @worked_array;
  my $i = 0;
  my @threads;
  while ($i < scalar(@work_list)){
    my $j = $i + $items_per_thread -1;
    if(defined($work_list[$j])){
      my @work_list_sub = @work_list[$i..$j];
      push(@threads, threads->new($working_function,\@work_list_sub,@argument_list));
    }else{
      my @work_list_sub = @work_list[$i..scalar(@work_list)-1];
      push(@threads, threads->new($working_function,\@work_list_sub,@argument_list));
    }
    $i = $j+1;
  }
  # Synchronizing threads
  foreach my $thread (@threads){
    push(@worked_array, $thread->join);
  }
  return @worked_array;
}

1;
__END__

=head1 NAME

ThreadedArray - Perl extension for quickly threading out work executed
on an array of items, where the array is returned after work has been executed

=head1 SYNOPSIS

  use ThreadedArray;
  ThreadedArray::set_work_list(@some_array);
  ThreadedArray::set_items_per_thread(3);
  ThreadedArray::set_working_function(\&your_function,@your_arguments);
  my @result_array = ThreadedArray::get_result();

=head1 DESCRIPTION

  This module threads out work that needs to be executed on an array of items.
  It then returns the resulting array.

=head1 AUTHOR

  Pablo Karlsson, epabkar, Pablo.Karlsson@gmail.com

=cut
