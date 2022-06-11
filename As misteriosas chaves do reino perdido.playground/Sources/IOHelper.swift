import Foundation

public func loadFile(named fileName: String) -> [String] {
    guard let path = Bundle.main.path(forResource: fileName, ofType: ""), let content = try? String(contentsOfFile: path) else {
        fatalError("IO Error")
    }
    
    return content.components(separatedBy: .newlines)
}

public func loadMatrix(from fileName: String) -> [[Character]] {
    let data = loadFile(named: fileName)

    return data.compactMap { line in
        Array(line)
    }
}
