# EnumIdentifiable

`EnumIdentifiable` is an attached Swift macro for `enum` that provides automatic conformance to the `Identifiable` protocol and returns `self` as the `id` value.

## Usage

```swift
import EnumIdentifiable

@EnumIdentifiable
enum Fruit {
    case apple, banana
    case mango
}
```

This will automatically generate the following code:

```swift
extension Fruit: Identifiable {
    var id: Fruit {
        return self
    }
}
```

## Installation

The package can be installed using [Swift Package Manager](https://swift.org/package-manager/). To add EnumIdentifiable to your Xcode project, select *File > Add Package Dependancies...* and search for the repository URL: `https://github.com/davidsteppenbeck/EnumIdentifiable.git`.

## License

EnumIdentifiable is available under the MIT license. See the LICENSE file for more info.
