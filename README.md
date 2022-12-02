 ## AoC 2022 (in Jakt)

 This feels more like a compiler stability test, so I'll report the bugs encountered here as a nice massive list of TODOs and FIXMEs :^)

 - [day 1](day1)
     - `String::split(sep, keep_empty)` is missing its `keep_empty` parameter - defaults to `false`.
     - Implementing traits as extension methods would be _really_ nice
     - Allow me to declare traits on String, damnit
     - Don't crash on this
     ```jakt
     function reduce<T, Acc>(self: &Array<T>, accumulator: Acc, anon f: &function(accumulator: Acc, value: &T) -> Acc) -> Acc {
         mut acc = accumulator
         // Right here on this for, crash on typecheck_for()
         for i in 0..(.size()) {
             acc = f(accumulator: acc, value: &self[i])
         }
         return acc
     }
     ```
- [day 2](day2)
    - Functions overloading imported functions clash when the overloading modules are imported into the same module (without importing the functions themselves)
    - `try expr` does not work anymore?
