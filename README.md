# Graham

Graham is a library for representing arbitrarily large integers in Swift.

A `BigInt`—an integer of limitless size—can be created just like an `Int`.
```swift
let x: BigInt = 1000
```
Since `BigInt` conforms to `IntegerType`, we can use it nearly anywhere we'd use an `Int`.
```swift
for i in 0...x {
   // Such loop. Very wow.
}
```
