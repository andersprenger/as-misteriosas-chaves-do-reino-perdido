import Foundation

typealias Door = (char: Character, node: Node)

var matrix: [[Character]] = loadMatrix(from: "caso00")
var markedNodes: Set<Node> = []
var keys: Set<Character> = []
var lockedDoors: Set<Node> = []
var players: [Node] = []

func searchForPlayers() {
    for x in 0 ..< matrix.count {
        for y in 0 ..< matrix[x].count {
            let char = matrix[x][y]
            
            switch char {
            case "1", "2","3", "4", "5", "6", "7", "8", "9":
                players.append(Node(x, y))
                print("Player \(char) encontrado.")
                
            default:
                break
            }
        }
    }
    
    print(players)
}

func dfs(from node: Node) {
    markedNodes = []
    markedNodes.insert(node)
    var list: [Node] = [node]
    
    while !list.isEmpty {
        let visited = list.removeFirst()
        
        for x in visited.x - 1 ... visited.x + 1 where x >= 0 && x < matrix.count {
            for y in visited.y - 1 ... visited.y + 1 where y >= 0 && y < matrix[x].count {
                let isMarked = markedNodes.contains(Node(x, y))
                
                guard Node(x, y) != visited && !isMarked else {
                    continue
                }
                
                list = [Node(x, y)] + list
                markedNodes.insert(Node(x, y))
                
//                let char = matrix[x][y]
//                print(x,y)
                
            }
        }
    }
    
    print(markedNodes.count)
}

//searchForPlayers()
dfs(from: Node(20, 6))
