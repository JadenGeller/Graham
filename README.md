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

Now, let me let you in a secret: `BigInt` is just a typealias. That's right.
```swift
typealias BigInt = Integer<Decimal>
```
That's right, you can represent integers of any whole number base with Graham! Graham comes built in with support for `Decimal`, `Binary`, and `Hexadecimal`, but it's really easy to add more! We'll make a new base `Monkey` that has three symbols—🙈, 🙉, and 🙊.
```swift
public struct Monkey: Base {
    public static let symbols: SymbolSet = "🙈🙉🙊"
}
```
Ta-da! Really simple, right!? Obviously you probably won't want to make such bizzare numbers, but you could imagine how easy it is to create a octal base or something of that sort.
