ThreadedArray
=============

ThreadedArray - Perl extension for quickly threading out work executed
on an array of items, where the array is returned after work has been executed

== USEAGE ==

  use ThreadedArray;
  ThreadedArray::set_work_list(@some_array);
  ThreadedArray::set_items_per_thread(3);
  ThreadedArray::set_working_function(\&your_function,@your_arguments);
  my @result_array = ThreadedArray::get_result();

== DESCRIPTION ==

  This module threads out work that needs to be executed on an array of items.
  It then returns the resulting array.

== AUTHOR ==

  Pablo Karlsson, epabkar, Pablo.Karlsson@gmail.com
