# DictionaryLiteralShorthand

`DictionaryLiteralShorthand` is a Swift compiler plugin that provides a [macro](https://developer.apple.com/videos/play/wwdc2023/10166/) for creating dictionary literals with keys as string representations of corresponding variable names.

It simplifies the process of creating dictionaries by automatically generating the keys based on variable names.

This macro is inspired by the [shorthand syntax](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Object_initializer) for object initializers in JavaScript.

UIKit also offers a similar macro called [NSDictionaryOfVariableBindings](https://developer.apple.com/documentation/uikit/nsdictionaryofvariablebindings) for NSDictionary.

# Usage

In the past, if you want to define a dictionary with the key is the same as the variable name, you write:

```
let a = 99
let b = "foo"
let dictionary: [AnyHashable: Any] = ["a": a, "b": b]
```

With this macro, you simply write

```
import DictionaryLiteralShorthand

let a = 99
let b = "foo"
let dictionary: [AnyHashable: Any] = #dict(a, b)

// This is the equalivant code generated by the compiler:
// let dictionary: [AnyHashable: Any] = ["a": a, "b": b]
```

The compiler magically "exapnds" the macro for you, saving your time from writing boilerplate code.

Note:

- The shorthand accepts only "variable names", do not input "literals" such as a String literal, or an Integer literal

```
/// ❌ This raises a compiler error, as we don't have a "variable name" to input to dictionary
let dictionary: [AnyHashable: Any] = #dict(["Foo", 999])
```

# Installation

### Swift Package manager

Open your project with Xcode, go

- File > Add Package Dependencies
- Enter url `https://github.com/Dcard/DictionaryLiteralShorthandMacro.git`
- Select the `main` branch

After installation, Xcode might ask you if you want to enable `DictionaryLiteralShorthandMacros`, select `Trust & Enable`

# Requirements

- Swift 5.9 or later
- Xcode 15 or later

# Resources

- [https://developer.apple.com/videos/play/wwdc2023/10166/](https://developer.apple.com/videos/play/wwdc2023/10166/)
- [https://developer.apple.com/videos/play/wwdc2023/10167](https://developer.apple.com/videos/play/wwdc2023/10167)

# ToDo

- Setup CI/CD to automate tests for pull requests

# License

DictionaryLiteralShorthand is released under the MIT license. See [LICENSE](https://github.com/Dcard/DictionaryLiteralShorthandMacro) for details.
