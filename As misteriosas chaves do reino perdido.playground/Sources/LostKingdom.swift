import Foundation

public class LostKingdom {
    var matrix: [[Character]]
    var list: [Node]
    var markedNodes: Set<Node>
    
    var keys: Set<Character>
    var lockedDoors: Set<Door>
    var players: [Player]
    
    var fileName: String
    
    public init(_ fileName: String = "caso00") {
        print(fileName)
        
        matrix = loadMatrix(from: fileName)
        markedNodes = []
        
        keys = []
        lockedDoors = []
        players = []
        self.fileName = fileName
        list = []
        
        searchForPlayers()
        
        for player in players {
            dfs(from: player)
        }
    }
    
    func searchForPlayers() {
        for x in 0 ..< matrix.count {
            for y in 0 ..< matrix[x].count {
                let char = matrix[x][y]
                
                switch char {
                case "1", "2","3", "4", "5", "6", "7", "8", "9":
                    players.append(Player(char, in: Node(x, y)))
                    
                default:
                    break
                }
            }
        }
        
        players.sort()
        
        //        print("\n")
        //        print(players)
        //        print("\n")
    }
    
    func dfs(from player: Player) {
        markedNodes = []
        
        list = [player.node]
        
        markedNodes.insert(player.node)
        
        while !list.isEmpty {
            let visited = list.removeFirst()
            
            move(from: Node(visited.x - 1, visited.y))
            move(from: Node(visited.x + 1, visited.y))
            move(from: Node(visited.x, visited.y - 1))
            move(from: Node(visited.x, visited.y + 1))
        }
        
//        check()
        
        print(markedNodes.count)
    }
    
    func move(from node: Node) {
        let isMarked = markedNodes.contains(node)
        
        guard !isMarked else {
            return
        }
        
        guard node.x >= 0 && node.x < matrix.count else {
            return
        }
        
        guard node.y >= 0 && node.y < matrix[node.x].count else {
            return
        }
        
        let char = matrix[node.x][node.y]

        guard char != "#" else {
            return
        }
        
        markedNodes.insert(node)
        
        
        switch char {
        case ".","1","2","3","4","5","6","7","8","9":
            list = [node] + list
            
        case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z":
            list = [node] + list
            keys.insert(char)
            
            for door in lockedDoors where door.char == char.uppercased().first {
                list = [door.node] + list
                
                lockedDoors.remove(door)
                markedNodes.remove(door.node)
            }
            
        case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
            if keys.contains(char.lowercased().first!) {
                list = [node] + list
            } else {
                lockedDoors.insert(Door(char, node))
            }
            
        default:
            break
        }
    }
    
    func check() {
        var checkMatrix: [[Character]] = loadMatrix(from: fileName)
        
        for node in markedNodes {
            checkMatrix[node.x][node.y] = "^"
        }
        
        printMatrix(checkMatrix)
    }
    
    func printMatrix(_ matrix: [[Character]]) {
        var str = ""
        for line in matrix {
            for char in line {
                str += "\(char)"
            }
            
            str += "\n"
        }
        
        print(str)
    }
}
