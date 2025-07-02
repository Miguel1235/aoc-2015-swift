import Foundation

struct Day10: AdventDay {
  var data: String
  
  func generateLookAndSay(_ input: String) -> String {
    var result = ""
    var currentChar = input.first!
    var count = 0
    
    for char in input {
      if char == currentChar {
        count += 1
        continue
      }
      result.append("\(count)")
      result.append(currentChar)
      currentChar = char
      count = 1
    }
    
    return result
  }
  
  func part1() -> Any {
    var result = data
    for _ in 0..<40 {
      result = generateLookAndSay(result)
    }
    return result.count
  }
  
  func part2() -> Any {
    var result = data
    for _ in 0..<50 {
      result = generateLookAndSay(result)
    }
    return result.count
  }
}
