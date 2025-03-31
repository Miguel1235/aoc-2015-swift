import Algorithms

struct Day01: AdventDay {
  var data: String
  var input: [Substring] {
    data.split(separator: "")
  }
  
  func part1() -> Int {
    return input.reduce(0) { floor, char in
      floor + (char == "(" ? 1 : -1)
    }
  }
  
  func part2() -> Int {
    var currentFloor = 0
    for (position, char) in input.enumerated() {
      currentFloor += char == "(" ? 1 : -1
      if currentFloor == -1 {
        return position + 1
      }
    }
    fatalError(#function + ": Failed to find the basement!")
  }
}
