import Foundation

struct Day09: AdventDay {
  var data: String

  var cityGraph: CityGraph {
    CityGraph(routes: data.split(separator: "\n"))
  }
  
  var paths: [HamiltonianPath] {
    return cityGraph.findHamiltonianPaths()
  }
  
  
  struct HamiltonianPath {
    let cities: [String]
    let totalDistance: Int
    
    func printPath() {
      let pathString = cities.joined(separator: " -> ")
      print("\(pathString) - Total distance: \(totalDistance) km")
    }
  }
  
  class CityGraph {
    private var adjacencyList: [String: [(city: String, distance: Int)]] = [:]
    
    init(routes: [String.SubSequence]) {
      let routeRegex = /(\w+) to (\w+) = (\d+)/
      for route in routes {
        guard let match = try? routeRegex.wholeMatch(in: route) else { continue }
        let (_, city1, city2, distance) = match.output
        addConnection(from: String(city1), to: String(city2), withDistance: Int(distance)!)
      }
    }
    
    func addCity(withName city: String) {
      if adjacencyList[city] == nil {
        adjacencyList[city] = []
      }
    }
    
    func addConnection(from startCity: String, to endCity: String, withDistance distance: Int) {
      addCity(withName: startCity)
      addCity(withName: endCity)
      adjacencyList[startCity]?.append((city: endCity, distance: distance))
      adjacencyList[endCity]?.append((city: startCity, distance: distance))
    }
    
    func printGraph() {
      for (city, connections) in adjacencyList {
        print("\(city):")
        for connection in connections {
          print("  -> \(connection.city): \(connection.distance) km")
        }
      }
    }
    
    func getAllCities() -> [String] {
      return Array(adjacencyList.keys)
    }
    
    func findHamiltonianPaths() -> [HamiltonianPath] {
      let cities = getAllCities()
      var allPaths: [HamiltonianPath] = []
      
      // Try starting from each city
      for startCity in cities {
        var visited = Set<String>()
        var currentPath: [String] = []
        
        findHamiltonianPathsRecursive(
          currentCity: startCity,
          visited: &visited,
          currentPath: &currentPath,
          allCities: cities,
          result: &allPaths
        )
      }
      
      return allPaths
    }
    
    private func findHamiltonianPathsRecursive(
      currentCity: String,
      visited: inout Set<String>,
      currentPath: inout [String],
      allCities: [String],
      result: inout [HamiltonianPath]
    ) {
      visited.insert(currentCity)
      currentPath.append(currentCity)
      
      if visited.count == allCities.count {
        let totalDistance = calculatePathDistance(path: currentPath)
        let hamiltonianPath = HamiltonianPath(cities: currentPath, totalDistance: totalDistance)
        result.append(hamiltonianPath)
      } else {
        let connections = getConnections(for: currentCity)
        for connection in connections {
          if !visited.contains(connection.city) {
            findHamiltonianPathsRecursive(
              currentCity: connection.city,
              visited: &visited,
              currentPath: &currentPath,
              allCities: allCities,
              result: &result
            )
          }
        }
      }
      
      visited.remove(currentCity)
      currentPath.removeLast()
    }
    
    
    func getConnections(for city: String) -> [(city: String, distance: Int)] {
      return adjacencyList[city] ?? []
    }
    
    func calculatePathDistance(path: [String]) -> Int {
      var totalDistance = 0
      
      for i in 0..<(path.count - 1) {
        if let distance = getDistance(from: path[i], to: path[i + 1]) {
          totalDistance += distance
        }
      }
      
      return totalDistance
    }
    
    func getDistance(from city1: String, to city2: String) -> Int? {
      guard let connections = adjacencyList[city1] else { return nil }
      
      for connection in connections {
        if connection.city == city2 {
          return connection.distance
        }
      }
      return nil
    }
  }
  
  
  func part1() -> Any {
    return paths.min { $0.totalDistance < $1.totalDistance }!.totalDistance
  }
  
  func part2() -> Any {
    return paths.max { $0.totalDistance < $1.totalDistance }!.totalDistance
  }
}
