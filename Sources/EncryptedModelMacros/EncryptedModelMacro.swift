import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct EncryptedModelMacro: MemberAttributeMacro, MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Return any additional members needed
        return []
    }
    
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclSyntaxProtocol,
        providingAttributesFor member: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [AttributeSyntax] {
        // Only process stored properties (variables and constants)
        guard let varDecl = member.as(VariableDeclSyntax.self) else {
            return []
        }
        
        // Add @Attribute(.allowsCloudEncryption) to all properties
        return [
            AttributeSyntax(
                atSign: .atSignToken(),
                attributeName: IdentifierTypeSyntax(name: .identifier("Attribute")),
                leftParen: .leftParenToken(),
                arguments: .argumentList([
                    LabeledExprSyntax(
                        expression: DeclReferenceExprSyntax(
                            leadingTrivia: .none,
                            baseName: .identifier(".allowsCloudEncryption"),
                            argumentNames: .none,
                            trailingTrivia: .none
                        )
                    )
                ]),
                rightParen: .rightParenToken()
            )
        ]
    }
}

@main
struct EncryptedModelPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EncryptedModelMacro.self,
    ]
}
