import EncryptedModel
import SwiftData

let a = 17
let b = 25

print("The value \(a + b) was produced by adding \(a) and \(b)")

@available(macOS 10.15, iOS 17.0, tvOS 13.0, watchOS 6.0, *)
@EncryptedModel
class Dog {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

if #available(iOS 17.0, *) {
    let dog = Dog(name: "Fido")
    print("The name of \(dog) is \(dog.name)")
} else {
    // Fallback on earlier versions
}
