import Foundation

struct Day11: AdventDay {
  var data: String
  
  
  func consecutiveOnes(_ pwd: String) -> Bool {
    let abecedary = "abcdefghijklmnopqrsutvwxyz"
    let straightLetters = abecedary.windows(ofCount: 3)
    
    
    let includesStraight = straightLetters.contains { pwd.contains($0) }
    let bannedWords = ["i", "o", "l"]
    let includesBannedWord = bannedWords.contains(where: pwd.contains)
    
    
    return includesStraight
  }
  
  func part1() -> Any {
    let result = consecutiveOnes(data)
    print(result)
    return 123
  }
  
  func part2() -> Any {
    return 456
  }
}
