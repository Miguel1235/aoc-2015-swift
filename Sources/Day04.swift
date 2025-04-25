import Algorithms
import CryptoKit

struct Day04: AdventDay {
  var data: String
  
  var secretKey: String {
    data.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  func md5Hash(_ source: String) -> String {
    Insecure.MD5.hash(data: source.data(using: .utf8)!).map { String(format: "%02hhx", $0) }.joined()
  }
  
  func obtainKey(secretKey: String, repeats: Int) -> Int {
    var counter = 0
    while md5Hash("\(secretKey)\(counter)").prefix(repeats) != String(repeating: "0", count: repeats) {
      counter += 1
    }
    return counter
  }
  
  func part1() -> Int {
    return obtainKey(secretKey: secretKey, repeats: 5)
  }
  
  func part2() -> Int {
    return obtainKey(secretKey: secretKey, repeats: 6)
  }
}
