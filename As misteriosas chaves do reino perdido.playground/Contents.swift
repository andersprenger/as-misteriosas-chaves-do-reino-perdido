import Foundation

class LostKingdom {
    var matrix: [[Character]]
    var markedNodes: Set<Node>
    var keys: Set<Character>
    var lockedDoors: Set<Door>
    var players: [Node]
    
    init(_ arquivoCaso: String = "caso00") {
        print(arquivoCaso)
        
        matrix = loadMatrix(from: arquivoCaso)
        markedNodes = []
        keys = []
        lockedDoors = []
        players = []
        
        searchForPlayers()
        
//        for player in players {
//            dfs(from: player)
//        }
    }
    
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
        
        print("\n")
        print(players)
        print("\n")
    }
    
    func dfs(from node: Node) {
        markedNodes = []
        markedNodes.insert(node)
        var list: [Node] = [node]
        
        var wallCounter = 0
        
        while !list.isEmpty {
            let visited = list.removeFirst()
            
            for x in visited.x - 1 ... visited.x + 1 where x >= 0 && x < matrix.count {
                for y in visited.y - 1 ... visited.y + 1 where y >= 0 && y < matrix[x].count {
                    let isMarked = markedNodes.contains(Node(x, y))
                    
                    guard Node(x, y) != visited && !isMarked else {
                        continue
                    }
                    
                    markedNodes.insert(Node(x, y))
                    
                    let char = matrix[x][y]
                    
                    switch char {
                    case ".":
                        list = [Node(x, y)] + list
                        
                    case "1","2","3","4","5","6","7","8","9":
                        list = [Node(x, y)] + list
                        
                    case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z":
                        
                        list = [Node(x, y)] + list
                        
                        keys.insert(char)
                        
                        for door in lockedDoors where door.char == char.uppercased().first {
                            list = [Node(x, y)] + list
                            lockedDoors.remove(door)
                            markedNodes.remove(door.node)
                        }
                        
                    case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
                        if keys.contains(char.lowercased().first!) {
                            list = [Node(x, y)] + list
                        } else {
                            lockedDoors.insert(Door(char, Node(x, y)))
                        }
                        
                    case "#":
                        wallCounter += 1
                        
                    default:
                        break
                    }
                }
            }
        }
        
//        check()
        
        print(markedNodes.count - wallCounter - lockedDoors.count, "\n")
    }
    
    func check() {
        var checkMatrix: [[Character]] = loadMatrix(from: "caso00")
        
        for node in markedNodes where checkMatrix[node.x][node.y] != "#" {
            checkMatrix[node.x][node.y] = "^"
        }
        
        var str = ""
        for line in checkMatrix {
            for char in line {
                str += "\(char)"
            }
            
            str += "\n"
        }
        
        print(str)
    }
}

LostKingdom("caso00")
LostKingdom("caso05")
LostKingdom("caso06")
LostKingdom("caso07")
LostKingdom("caso08")
LostKingdom("caso09")
LostKingdom("caso10")
