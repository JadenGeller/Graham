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
Unlike an `Int` though, `BigInt` does not overflow!
```swift
let y: BigInt = 9999999 * 9999999 * 9999999 * 9999999 * 9999999 * 9999999
print(y) // -> 
```
It can be used to represent HUGE computations, which is pretty cool.

If you want to declare a `BigInt` literal that's bigger than the biggest `Int` value, use a string literal.
```swift
let z: BigInt = "1234567898765432123456789876543212345678987654321"
```
