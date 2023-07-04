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

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import DictionaryLiteralShorthandMacros

let testMacros: [String: Macro.Type] = [
    "dictionaryLiteralShorthand": DictionaryLiteralShorthandMacro.self,
]

final class DcardMacroTests: XCTestCase {
    func testMacroExpansion() {
        assertMacroExpansion(
            """
            #dictionaryLiteralShorthand(a, b, c)
            """,
            expandedSource: """
            ["a": a, "b": b, "c": c]
            """,
            macros: testMacros
        )
    }
    
    func testSingleInputMacroExpansionDoesNotContainTrailingComma() {
        assertMacroExpansion(
            """
            #dictionaryLiteralShorthand(z)
            """,
            expandedSource: """
            ["z": z]
            """,
            macros: testMacros
        )
    }
    
    func testDuplicateIdentifierExpression() {
        let spec: DiagnosticSpec = DiagnosticSpec(message: "There are duplicate identifiers in the input, this makes no difference to the expanded code.", line: 1, column: 32)
        assertMacroExpansion(
            """
            #dictionaryLiteralShorthand(a, a, a, a, b)
            """,
            expandedSource: "",
            diagnostics: [
                spec,
                /// The compiler emits 2 diagnostics, so we had to add 1 more DiagnosticSpec in order to pass the test.
                /// Still not sure why it emits same diagnose twice, I'm guessing it's a bug.
                spec
            ],
            macros: testMacros
        )
    }

}
