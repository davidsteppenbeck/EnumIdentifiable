import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct EnumIdentifiableMacro: ExtensionMacro {
    
    public static func expansion(
        of node: AttributeSyntax,
        attachedTo declaration: some DeclGroupSyntax,
        providingExtensionsOf type: some TypeSyntaxProtocol,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [ExtensionDeclSyntax] {
        guard declaration.is(EnumDeclSyntax.self) else {
            throw EnumIdentifiableError.notAnEnum
        }
        
        let ext: DeclSyntax = """
        extension \(type.trimmed): Identifiable {
            var id: \(type.trimmed) {
                return self
            }
        }
        """
        
        return [ext.cast(ExtensionDeclSyntax.self)]
    }
    
}

enum EnumIdentifiableError: Error, CustomStringConvertible {
    case notAnEnum
    
    var description: String {
        switch self {
        case .notAnEnum:
            return "'@EnumIdentifiable' can only be applied to an 'enum'"
        }
    }
}

@main
struct EnumIdentifiablePlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        EnumIdentifiableMacro.self,
    ]
}
