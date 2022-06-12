import Foundation

public struct Player: Hashable {
    
    public let char: Character
    public let node: Node
    
    public init(_ c: Character, in n: Node) {
        char = c
        node = n
    }
}

extension Player: Comparable {
    public static func < (lhs: Player, rhs: Player) -> Bool {
        lhs.char.wholeNumberValue! < rhs.char.wholeNumberValue!
    }
}
