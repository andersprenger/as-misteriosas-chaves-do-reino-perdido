import Foundation

var matrix: [[Character]] = loadMatrix(from: "caso00")
var checkMatrix: [[Character]] = loadMatrix(from: "caso00")
var markedNodes: Set<Node> = []
var keys: Set<Character> = []
var lockedDoors: Set<Door> = []
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
    
    var count = 1
    
    while !list.isEmpty {
        let visited = list.removeFirst()
        
        for x in visited.x - 1 ... visited.x + 1 where x >= 0 && x < matrix.count {
            for y in visited.y - 1 ... visited.y + 1 where y >= 0 && y < matrix[x].count {
                let isMarked = markedNodes.contains(Node(x, y))
                
                guard Node(x, y) != visited && !isMarked else {
                    continue
                }
                
//                list = [Node(x, y)] + list
                markedNodes.insert(Node(x, y))
//                checkMatrix[x][y] = "&"
                
                let char = matrix[x][y]
                
                switch char {
                case ".","1","2","3","4","5","6","7","8","9":
                    count += 1
                    checkMatrix[x][y] = "&"
                    
                    list = [Node(x, y)] + list
                    
                case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z":
                    count += 1
                    checkMatrix[x][y] = "&"
                    
                    keys.insert(char)
                    
                    for door in lockedDoors where door.char == char.uppercased().first {
                        list = [Node(x, y)] + list
                        lockedDoors.remove(door)
                    }
                    
                case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
                    count += 1
                    checkMatrix[x][y] = "&"
                    
                    if keys.contains(char.lowercased().first!) {
                        list = [Node(x, y)] + list
                    } else {
                        lockedDoors.insert(Door(char, Node(x, y)))
                    }
                default:
                    break
                }
            }
        }
    }
    
    print(count, "\n")
}

func check() {
    var str = ""
    for line in checkMatrix {
        for char in line {
            str += "\(char)"
        }
        
        str += "\n"
    }
    
    print(str)
}

searchForPlayers()
dfs(from: Node(15, 16))
check()
