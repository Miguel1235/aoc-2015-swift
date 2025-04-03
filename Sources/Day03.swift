import Algorithms

struct Day03: AdventDay {
  var data: String
  var input: [Substring] {
    data.split(separator: "").dropLast()
  }
  struct House: Hashable {
    var r: Int
    var c: Int
  }
  
  func countHouses(houses: [Substring]) -> Set<House> {
    var currentHouse = House(r: 0, c: 0)
    var visited: Set<House> = [currentHouse]
    
    for direction in houses {
      switch direction {
      case "v":
        currentHouse.r -= 1
      case "^":
        currentHouse.r += 1
      case "<":
        currentHouse.c -= 1
      case ">":
        currentHouse.c += 1
      default:
        print("wtf bro")
      }
      visited.insert(currentHouse)
    }
    
    return visited
  }
  
  func part1() -> Int {
    return countHouses(houses: input).count
  }
  
  func part2() -> Int {
    let h1 = input.enumerated().filter { i, e in i % 2 == 1 }.map { $0.element }
    let h2 = input.enumerated().filter { i, e in return i % 2 == 0 }.map { $0.element }
    
    return  countHouses(houses: h1).union(countHouses(houses: h2)).count
  }
}
