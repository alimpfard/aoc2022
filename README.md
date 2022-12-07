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
- [day 3](day3)
    - Generic functions are just broken, basically all attempts at implementing `map<T, U>` as either a free generic function or a trait lead to crashes
    - `range.inclusive()` in match does not work ("expected u8, found u8..u8")
    - Really need some niceties for sets, `Set::from_array()`, `Set::intersection()`, etc etc.
    - `for foo in some_reference` does not work, it should auto-dereference the reference.
    - I want `String::bytes()` to give me a nice iterable object, kthxbye.
- [day 4](day4)
    - Would be nice to get diagnostics on `println()` format/args mismatches
    - that's it really
- [day 5](day5)
    Absolute trainwreck, most notable:
    - `String::replace()` just crashed, no idea why (called: `input.replace(replace: "    ", with: "--- ")`)
    - No way to reverse an array, so I had to implement it myself
        - `function reverse<T>(anon xs: &mut Array<T>)` -> gave me a typecheck error on `reverse(&mut some_array)` with `expected T, found u8` (missing reference support somewhere probs)
    - `String::split()` still needs either a `keep_empty` parameter or support for splitting by a string
    - `for (i, x) in foo.enumerate()` would be nice, getting tired of `defer i += 1`
- [day 6](day6)
    - Inference based on struct members _requires_ a member exactly with the generic type, it fails if...say, `w: [T]` exists, but not `x: T`.
    - `struct Foo<T, U requires(Iterable<T>)> { x: T, y: U }` passes inference, but infers the wrong type when trying to iterate: `for a in .y { ... }` infers `[T]?` for the type of `a`.
    - `for x in it` assigns `it` to an immutable variable, so the `.next()` method can't be called unless `it` itself is mutable.
- [day 7](day7)
    - Generic functions still very buggy (writing `walk<T>` just crashed the compiler)
    - `[String:SomeClassType]` is broken, I patched it locally to allow `.get()`, but the design of HashMap means we will _never_ be able to hand out `NNRP<T>&` as we don't even have an NNRP object to hand out - this used to be (still is?) an AK limitation too, we just avoided `operator[]` in there mostly - should `operator[]` in Jakt just invoke `.get().value()` instead?
    - Mutable captures in lambdas
    - Captures in lambdas in general, lambdas shouldn't inherit their parent block scope (they should inherit the immediate parent of the deepest _function_ scope)
    - `x ?? y` should pass `type_hint: x.type()` (or `unwrap_optional(x.type())`) to `typecheck(y)` - maybe we need a way to specify multiple type hints?
    - Some nice functional-style stuff is really in demand right now, you can't possibly expect me to implement `reduce` a million times!
    - There's some confusion between `&mut foo`, `&foo` and `foo` - the compiler just blindly allows them through...?
