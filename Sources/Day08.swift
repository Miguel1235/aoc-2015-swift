import Foundation

struct Day08: AdventDay {
  var data: String
  

  
  func part1() -> Any {
    let lines = data.split(separator: "\n")
    
    var total = 0
    for line in lines {
      total += line.count - String(line).obtainRealLen()
    }
    return total
  }
}

extension String {
    func obtainRealLen() -> Int {
        return self.replacingOccurrences(of: "\\\"", with: "*")
            .replacingOccurrences(of: "\\\\", with: "*")
            .replacingOccurrences(of: "\\\\x[a-f0-9]{2}", with: "_", options: .regularExpression)
            .count - 2
    }
}
