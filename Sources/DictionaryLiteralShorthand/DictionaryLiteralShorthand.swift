// MIT License

// Copyright (c) 2023 Dcard Taiwan Ltd.

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

/// A macro that creates a Swift dictionary literal wherein the keys are string representations of the corresponding values’ variable names.
/// For example:
/// let a = 1
/// let b = "Foo"
/// let dict = #dictionaryLiteralShorthand([a, b])
///
/// produces a dictionary literal with type: [AnyHashable: Any]
///
/// ["a": a, "b": b]
///
/// Basically the same as: https://developer.apple.com/documentation/uikit/nsdictionaryofvariablebindings , but in Swift.
@freestanding(expression)
public macro dictionaryLiteralShorthand(_ value: Any...) -> [AnyHashable: Any] = #externalMacro(module: "DictionaryLiteralShorthandMacros", type: "DictionaryLiteralShorthandMacro")
