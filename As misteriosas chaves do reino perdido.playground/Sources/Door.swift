import Foundation

public struct Door: Hashable {
    public let char: Character
    public let node: Node
    
    public init(_ c: Character, _ n: Node) {
        char = c
        node = n
    }
}
