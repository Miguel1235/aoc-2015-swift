//
//  File.swift
//  AdventOfCode
//
//  Created by Miguel Del Corso on 06/05/2025.
//

import Foundation

struct Day06: AdventDay {
  var data: String
  
  enum Action {
    case TURN_ON
    case TURN_OFF
    case TOGGLE
    
    init (_ string: String) {
      switch string {
      case "toggle":
        self = .TOGGLE
      case "turn on":
        self = .TURN_ON
      default:
        self = .TURN_OFF
      }
    }
  }
  
  struct Instruction {
    let action: Action
    let col: (Int, Int)
    let row: (Int, Int)
  }
  
  func parseInput() -> Array<Instruction> {
    let lines = data.split(separator: "\n")
    let pattern = /(?<action>toggle|turn on|turn off) (?<x1>\d+),(?<y1>\d+) through (?<x2>\d+),(?<y2>\d+)/
    
    return lines.map {
      let match = try! pattern.wholeMatch(in: $0)!
      
      let action = Action(String(match.action))
      let colS = Int(match.x1)!
      let rowS = Int(match.y1)!
      let colE = Int(match.x2)!
      let rowE = Int(match.y2)!
      
      return Instruction(action: action, col: (colS, colE), row: (rowS, rowE))
    }
  }
  
  func updateGrid(grid: [[Int]], instruction: Instruction, isPart2: Bool = false) -> [[Int]] {
    let (rs, re) = instruction.row
    let (cs, ce) = instruction.col
    
    var newGrid = grid
    
    for r in rs...re {
      for c in cs...ce {
        if isPart2 {
          switch instruction.action {
          case .TOGGLE:
            newGrid[r][c] += 2
          case .TURN_OFF:
            newGrid[r][c] = max(0, newGrid[r][c] - 1)
          case .TURN_ON:
            newGrid[r][c] += 1
          }
          continue
        }
        switch instruction.action {
        case .TOGGLE:
          newGrid[r][c] = grid[r][c] == 0 ? 1 : 0
        case .TURN_OFF:
          newGrid[r][c] = 0
        case .TURN_ON:
          newGrid[r][c] = 1
        }
      }
    }
    
    return newGrid
  }
  
  func part1() -> Int {
    var grid = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
    
    let instructions = parseInput()
    
    for instruction in instructions {
      grid = updateGrid(grid: grid, instruction: instruction)
    }
    
    return grid.flatMap { $0 }.count { $0 == 1 }
  }
  
  func part2() -> Int {
    var grid = Array(repeating: Array(repeating: 0, count: 1000), count: 1000)
    let instructions = parseInput()
    
    instructions.forEach {
      grid = updateGrid(grid: grid, instruction: $0, isPart2: true)
    }
    
    return grid.flatMap { $0 }.reduce(0, +)
  }
}
