import Algorithms
import CryptoKit

struct Day05: AdventDay {
  var data: String
  var words: [String.SubSequence] {
    data.split(separator: "\n")
  }
  
  func generateNonOverlappingPairs(from input: String.SubSequence) -> [(String, String)] {
      let chars = Array(input)
      var substrings: [(String, Int, Int)] = []

      for i in 0..<chars.count - 1 {
          let substring = String(chars[i...i+1])
          substrings.append((substring, i, i+1))
      }

      var result: [(String, String)] = []
      for i in 0..<substrings.count {
          for j in i+1..<substrings.count {
              let (w1, _, endA) = substrings[i]
              let (w2, startB, _) = substrings[j]
              if endA < startB {
                  result.append((w1, w2))
              }
          }
      }

      return result
  }
  
  func threeEqual(_ input: String.SubSequence) -> Bool {
      let characters = Array(input)
      
      for i in 0..<characters.count {
          let f = i > 0 ? characters[i - 1] : nil
          let s = i < characters.count - 1 ? characters[i + 1] : nil
          
          if f != nil && s != nil && f == s {
              return true
          }
      }
      
      return false
  }


  func isTheWordNice(_ word: String.SubSequence, isPart2: Bool = false) -> Bool {
    if isPart2 {
      return threeEqual(word) && generateNonOverlappingPairs(from: word).count(where: { $0 == $1 }) > 0
    }
    
    let vowels: Set<Character> = ["a", "e", "i", "o", "u"]
    let bannedWords = /ab|cd|pq|xy/
    
    let appearsTwice = zip(word, word.dropFirst()).contains { $0 == $1 }
    let numberOfVowels = word.filter { vowels.contains($0) }.count >= 3
    let notBannedWords = !word.contains(bannedWords)
    
    return appearsTwice && numberOfVowels && notBannedWords
  }
  
  func part1() -> Int {
    return words.count { isTheWordNice($0) }
  }
  
  func part2() -> Int {
    return words.count { isTheWordNice($0, isPart2: true) }
  }
}
