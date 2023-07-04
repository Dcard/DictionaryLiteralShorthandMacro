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

import SwiftDiagnostics

enum DictionaryLiteralShorthandMacroError: Int {
    case acceptsOnlyIdentifierExpressionSyntax
    case emptyInput
    case duplicateIdentifiers
}

extension DictionaryLiteralShorthandMacroError: DiagnosticMessage {
    var message: String {
        switch self {
        case .acceptsOnlyIdentifierExpressionSyntax:
            return "#dictionaryLiteralShorthand accepts only 'variable names', do not input literals such as String literal, Integer literal."
            
        case .emptyInput:
            return "The input of #dictionaryLiteralShorthand is empty."
            
        case .duplicateIdentifiers:
            return "There are duplicate identifiers in the input, this makes no difference to the expanded code."
        }
    }
    var diagnosticID: SwiftDiagnostics.MessageID {
        MessageID(domain: "tw.dcard.dcardMacro", id: "\(rawValue)")
    }
    var severity: SwiftDiagnostics.DiagnosticSeverity { .error }
}
