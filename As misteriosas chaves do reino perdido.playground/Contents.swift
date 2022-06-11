import Foundation

typealias Node = (x: Int, y: Int)
typealias Door = (char: Character, node: Node)

var matrix: [[Character]] = loadMatrix(from: "caso00")
var visitedNodes: [Node] = []
var keys: [Character] = []
var lockedDoors: [Door] = []
var players: [Node] = []

func searchForPlayers() {
    for x in 0 ..< matrix.count {
        for y in 0 ..< matrix[x].count {
            let char = matrix[x][y]
            
            switch char {
            case "1", "2","3", "4", "5", "6", "7", "8", "9":
                players.append((x, y))
                print("Player \(char) encontrado.")
                
            default:
                break
            }
        }
    }
    
    print(players)
}

func bfs(node first: Node) {
    var queue: [Node] = []
    var count = 0
    
    queue.append(first)
    visitedNodes.append(first)

    
    while !queue.isEmpty {
        let node = queue.removeFirst()
        visitedNodes.append(node)
        
        print(queue.count)
        
        for x in node.x - 1 ... node.x + 1 {
            guard x >= 0 && x < matrix.count else {
                print(node)
                continue
            }
            
            for y in node.y - 1 ... node.y + 1 {
                guard (x, y) != node && y >= 0 && x < matrix[x].count else {
                    print(node)
                    continue
                }
                
                let char = matrix[node.x][node.y]
                count += 1
                
                switch char { // TODO: -- refazer com REGEX...
                case ".":
                    if (!visitedNodes.contains { $0.x == x && $0.y == y }) {
                        queue.append((x, y))
                    }
                    
                case "1", "2","3", "4", "5", "6", "7", "8", "9":
                    if (!visitedNodes.contains { $0.x == x && $0.y == y }) {
                        queue.append((x, y))
                    }
                    // print(node, "1-9")
                    
                case "a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                     "k", "l", "m", "n", "o", "p", "q", "r", "s", "t",
                     "u", "v", "w", "x", "y", "z":
                    if (!visitedNodes.contains { $0.x == x && $0.y == y }) {
                        queue.append((x, y))
                        keys.append(char)
                    }
                    
                    for i in 0 ..< lockedDoors.count where lockedDoors[i].char == char {
                        if (!visitedNodes.contains { $0.x == x && $0.y == y }) {
                            queue.append(lockedDoors[i].node)
                            lockedDoors.remove(at: i)
                        }
                    }
                    
//                    print(node, "a-z")
                    
                case "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
                     "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
                     "U", "V", "W", "X", "Y", "Z":
                    
                    if (!visitedNodes.contains { $0.x == x && $0.y == y }) {
                        if keys.contains(char) {
                            queue.append((x, y))
                        }
                        
                        else {
                            lockedDoors.append((char: char, node: (x, y)))
                        }
                    }
//                    print(node, "A-Z")
                    
                default:
                    break
                }
            }
        }
    }
    
    print("Pecorreu:", count)
}

searchForPlayers()

bfs(node: (x: 20, y: 6))
