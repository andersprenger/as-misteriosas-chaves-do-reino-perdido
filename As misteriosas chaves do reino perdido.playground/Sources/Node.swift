import Foundation

public struct Node: Hashable {
    public let x: Int
    public let y: Int
    
    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}
