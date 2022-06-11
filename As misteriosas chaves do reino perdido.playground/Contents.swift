import Foundation

typealias Node = (x: Int, y: Int)
typealias Door = (char: Character, node: Node)

var matrix: [[Character]] = loadMatrix(from: "caso00")
var markedNodes: [Node] = []
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

func dfs(node: Node) {
    markedNodes = []
    markedNodes += [node]
    var list: [Node] = [node]
    
    while !list.isEmpty {
        let visited = list.removeFirst()
        
        for x in visited.x - 1 ..< visited.x + 1 where x >= 0 && x < matrix.count {
            for y in visited.y - 1 ..< visited.y + 1 where y >= 0 && y < matrix[x].count {
                let isMarked = markedNodes.contains { $0 == (x, y) }
                
                guard (x, y) != visited && !isMarked else {
                    continue
                }
                
                list = [(x, y)] + list
                markedNodes += [(x, y)]
            }
        }
    }
    
    print(markedNodes.count)
}

//searchForPlayers()
dfs(node: (20, 6))
