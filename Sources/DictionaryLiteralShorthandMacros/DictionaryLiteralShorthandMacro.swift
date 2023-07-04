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

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftDiagnostics

public struct DictionaryLiteralShorthandMacro: ExpressionMacro {
    
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard !node.argumentList.isEmpty else {
            let diagnose: Diagnostic = Diagnostic(
                node: node._syntaxNode,
                message: DictionaryLiteralShorthandMacroError.emptyInput
            )
            context.diagnose(diagnose)
            throw DiagnosticsError(diagnostics: [diagnose])
        }
        
        print("Node: \(node)")
        var usedExpressions: Set<String> = []
        var elements = [DictionaryElementSyntax]()
        let enumerated = node.argumentList.enumerated()
        
        // a, b, c
        for (index, element) in enumerated {
            /// We accept only `IdentifierExprSyntax` in order to take the identifier as "key name" of the dictionary
            /// Example:
            /// let a = "Foo"
            ///     ^ this is an identifier
            ///
            ///     #dictionaryLiteralShorthand("Foo")
            guard element.expression.is(IdentifierExprSyntax.self) else {
                let diagnose: Diagnostic = Diagnostic(
                    node: element._syntaxNode,
                    message: DictionaryLiteralShorthandMacroError.acceptsOnlyIdentifierExpressionSyntax
                )
                context.diagnose(diagnose)
                throw DiagnosticsError(diagnostics: [diagnose])
            }
            let idSyntanx = element.expression.cast(IdentifierExprSyntax.self)
            let identifierText: String = idSyntanx.identifier.text
            
            guard !usedExpressions.contains(identifierText) else {
                let diagnose: Diagnostic = Diagnostic(
                    node: element._syntaxNode,
                    message: DictionaryLiteralShorthandMacroError.duplicateIdentifiers
                )
                context.diagnose(diagnose)
                throw DiagnosticsError(diagnostics: [diagnose])
            }
            
            let trailingComma: TokenSyntax? = index == node.argumentList.count - 1 ? nil : .commaToken()
            elements.append(
              DictionaryElementSyntax(
                keyExpression: StringLiteralExprSyntax(content: identifierText),
                valueExpression: idSyntanx,
                trailingComma: trailingComma
              )
            )
            
            usedExpressions.insert(identifierText)
        }
        
        let dictionaryLiteral = DictionaryExprSyntax(
          content: .elements(DictionaryElementListSyntax(elements))
        )
        
        return ExprSyntax(dictionaryLiteral)
    }
}

@main
struct DcardMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DictionaryLiteralShorthandMacro.self
    ]
}

