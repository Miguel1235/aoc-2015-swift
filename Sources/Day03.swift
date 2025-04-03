import Algorithms

struct Day03: AdventDay {
  var data: String
  var directions: [Character] {
      Array(data.trimmingCharacters(in: .whitespacesAndNewlines))
  }
  struct House: Hashable {
    var r: Int
    var c: Int
  }
  
  private let directionVectors: [Character: (Int, Int)] = [
    "^": (-1, 0),
    "v": (1, 0),
    "<": (0, -1),
    ">": (0, 1)
  ]
  
  func countHouses(houses: [Character]) -> Set<House> {
    var currentHouse = House(r: 0, c: 0)
    var visited: Set<House> = [currentHouse]
    
    for direction in houses {
      guard let vector = directionVectors[direction] else { continue }
        currentHouse.r += vector.0
        currentHouse.c += vector.1
        visited.insert(currentHouse)
    }
    
    return visited
  }
  
  func part1() -> Int {
    return countHouses(houses: directions).count
  }
  
  func part2() -> Int {
    let h1 = directions.enumerated().filter { i, e in i % 2 == 1 }.map { $0.element }
    let h2 = directions.enumerated().filter { i, e in return i % 2 == 0 }.map { $0.element }
    
    return  countHouses(houses: h1).union(countHouses(houses: h2)).count
  }
}
