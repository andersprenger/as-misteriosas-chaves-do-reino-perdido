import Foundation

class LostKingdom {
    var matrix: [[Character]]
    var list: [Node]
    var markedNodes: Set<Node>
    var visitedNodes: Set<Node>
    var keys: Set<Character>
    var lockedDoors: Set<Door>
    var players: [Player]
    var caso: String
    
    init(_ arquivoCaso: String = "caso00") {
        print(arquivoCaso)
        
        matrix = loadMatrix(from: arquivoCaso)
        markedNodes = []
        visitedNodes = []
        keys = []
        lockedDoors = []
        players = []
        caso = arquivoCaso
        list = []
        
        
        searchForPlayers()
        
        for player in players {
            dfs(from: player)
        }
        
        //        dfs(from: Player("3", in: Node(22, 55)))
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
        
        //        print("\n")
        //        print(players)
        //        print("\n")
    }
    
    func dfs(from player: Player) {
        markedNodes = []
        visitedNodes = []
        
        list = [player.node]
        
        markedNodes.insert(player.node)
        visitedNodes.insert(player.node)
        
        while !list.isEmpty {
            let visited = list.removeFirst()
            
            move(from: Node(visited.x - 1, visited.y))
            move(from: Node(visited.x + 1, visited.y))
            move(from: Node(visited.x, visited.y - 1))
            move(from: Node(visited.x, visited.y + 1))
        }
        
        //        check()
        
        print("Player \(player.char):", visitedNodes.count)
    }
    
    func move(from node: Node) {
        let isMarked = markedNodes.contains(node)
        
        guard !isMarked else {
            return
        }
        markedNodes.insert(node)
        
        let char = matrix[node.x][node.y]
        
        switch char {
        case ".","1","2","3","4","5","6","7","8","9":
            list = [node] + list
            
            visitedNodes.insert(node)
            
        case "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z":
            list = [node] + list
            
            visitedNodes.insert(node)
            
            keys.insert(char)
            
            for door in lockedDoors where door.char == char.uppercased().first {
                list = [node] + list
                
                lockedDoors.remove(door)
                markedNodes.remove(door.node)
                
                visitedNodes.insert(door.node)
            }
            
        case "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z":
            if keys.contains(char.lowercased().first!) {
                list = [node] + list
                
                visitedNodes.insert(node)
            } else {
                lockedDoors.insert(Door(char, node))
            }
            
        default:
            break
        }
    }
    
    func check() {
        var checkMatrix: [[Character]] = loadMatrix(from: caso)
        
        for node in visitedNodes {
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

//LostKingdom("caso00")
LostKingdom("caso05")
//LostKingdom("caso06")
//LostKingdom("caso07")
//LostKingdom("caso08")
//LostKingdom("caso09")
//LostKingdom("caso10")
