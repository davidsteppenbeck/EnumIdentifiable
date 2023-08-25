/// An attached macro for `enum` that provides automatic conformance to the `Identifiable` protocol and returns `self` as the `id` value.
/// Applying the macro to anything other than an `enum` will result in a compile time error.
///
/// Applying `@EnumIdentifiable` to an `enum`
///
///     @EnumIdentifiable
///     enum Fruit {
///         case apple
///         case banana
///     }
///
/// injects the following code automatically
///
///     extension Fruit {
///         var id: Fruit {
///             return self
///         }
///     }
@attached(extension)
public macro EnumIdentifiable() = #externalMacro(module: "EnumIdentifiableMacros", type: "EnumIdentifiableMacro")
