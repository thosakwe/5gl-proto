# All Proto files are considered to be 'modules'. A module is a group of functions.
# When a module is imported, all of its functions are accessible without restriction.
# This state of accessibility is described as being "public."
# However, functions within a module can be "private," and not be accessible from the outside when imported.

# This is a public function.
? square(x)
  *:x:x
  
# To make a function private, simply prefix it with an underscore ('_').
? _cube(x)
  *:x:(square:x)
