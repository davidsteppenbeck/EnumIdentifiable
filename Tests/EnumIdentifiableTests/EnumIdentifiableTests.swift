import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(EnumIdentifiableMacros)
import EnumIdentifiableMacros

let testMacros: [String: Macro.Type] = [
    "EnumIdentifiable" : EnumIdentifiableMacro.self,
]
#endif

final class EnumIdentifiableTests: XCTestCase {
    func testEnumIdentifiable() throws {
        #if canImport(EnumIdentifiableMacros)
        assertMacroExpansion(
            """
            @EnumIdentifiable
            enum Fruit {
                case apple, banana
                case orange(Int)
                case mango
            }
            """,
            expandedSource:
            """
            enum Fruit {
                case apple, banana
                case orange(Int)
                case mango
            }
            
            extension Fruit: Identifiable {
                var id: Fruit {
                    return self
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testEnumIdentifiableOnStruct() throws {
        #if canImport(EnumIdentifiableMacros)
        assertMacroExpansion(
            """
            @EnumIdentifiable
            struct Fruit {
            }
            """,
            expandedSource:
            """
            struct Fruit {
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "'@EnumIdentifiable' can only be applied to an 'enum'", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
