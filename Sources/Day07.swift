import Foundation

struct Day07: AdventDay {
  var data: String
  
  var instructions: [String: String] {
    Dictionary(
        uniqueKeysWithValues: data.split(separator: "\n").compactMap { instruction in
            let parts = instruction.split(separator: " -> ")
            guard parts.count == 2 else { return nil }
            
            let (op, wire) = (parts[0], parts[1])
            return (String(wire), String(op))
        }
    )
  }
  
  func getWireValue(wire: String, results: inout [String: Int], instructions: [String: String]) -> Int {
       if let existingResult = results[wire] { return existingResult }
      
      if let numberValue = Int(wire) { return numberValue }
      
      guard let instruction = instructions[wire] else {
          fatalError("No instruction found for wire: \(wire)")
      }
      
      let result: Int
      
      let simplePattern = "^(\\d+|\\w+)$"
      if instruction.range(of: simplePattern, options: .regularExpression) != nil {
          result = getWireValue(wire: instruction, results: &results, instructions: instructions)
      }
      else if instruction.hasPrefix("NOT ") {
          let operand = String(instruction.dropFirst(4)).trimmingCharacters(in: .whitespaces)
          result = ~getWireValue(wire: operand, results: &results, instructions: instructions) & 0xFFFF
      }
      else {
          let parts = instruction.components(separatedBy: " ")
          let left = getWireValue(wire: parts[0], results: &results, instructions: instructions)
          let right = getWireValue(wire: parts[2], results: &results, instructions: instructions)
          
          switch parts[1] {
          case "AND":
              result = left & right
          case "OR":
              result = left | right
          case "LSHIFT":
              result = (left << right) & 0xFFFF
          default: // RSHIFT
              result = left >> right
          }
      }
      
      results[wire] = result
      return result
  }

  func part1() -> Any {
    var results : [String: Int] = [:]
    let result = getWireValue(wire: "a", results: &results, instructions: instructions)
    return result
  }
  
  func part2() -> Any {
    var results : [String: Int] = [:]
    let firstPart = part1()
    
    var newInstructions = instructions
    newInstructions["b"] = "\(firstPart)"
    
    return getWireValue(wire: "a", results: &results, instructions: newInstructions)
  }
}
