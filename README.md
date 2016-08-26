# 5gl-proto
Loose prototype of a 5th-gen language with terse syntax.

This will probably just be written in Java and generate some sort of bytecode, probably JVM.

# Example
 Proto code:
 
 ```
import <math> as Math

? myFunc(a, b assume 2)
  +:a:b

# Comment
? main
  cond1
    def one := 1
    def three := +:one:2
    print:"Three is %0":three
    Math.pow:three:2
  cond2
    print:"cond2 was true"
  else
    print:"Default course of action"
    1
 ```
 
 Equivalent C code:
 
 ```c
 int main() {
    if (cond) {
        int one = 1;
        int three = one + 2;
        printf("Three is %d\n", three);
        return three ^ 2;
    } else if (cond2) {
        return printf("cond2 was true\n");
    } else {
        printf("Default course of action\n");
        return 1;
    }
}
 ```
