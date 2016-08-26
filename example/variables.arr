# Proto does not support globals.
# However, variables are scoped.

? myFunc(name)
  # Easily declare a local variable with 'def'
  def foo := 4
  cat:"Hello, ":name:"!"

? main
  # 'foo' in this scope will not refer to the one within myFunc
  def foo := 2
  def baz := myFunc:"bar"
  0
  
