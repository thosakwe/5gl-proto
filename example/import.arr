# Use the 'import' keyword to import a module.
# By default, all of a module's members will be loaded into the current scope.

import <std> # All members of <std> are now available

? foo
  cat:"Hello, ":"world!"

# To prevent naming conflicts, you can assign a "namespace" to an import to define its members within a custom context.

import <std> as std

? bar
  std.cat:"Hello, ":"world"
  
# You can also choose to import only a specific set of functions from a module.

import <math> only pow

? e(m, c) # Einstein reference
  *m:(pow:c:2)
  
# Of course, you can combine these options to import a limited subset of a module into a namespace.

import <math> as Math only sqrt

? fubar(n)
  def root := Math.sqrt:n
  *3:root
  
