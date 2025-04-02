import Algorithms

struct Day02: AdventDay {
  var data: String
  var input: [String.SubSequence] {
    data.split(separator: "\n")
  }
  
  func getPresents() -> [Present] {
    var presents: [Present] = []
    let dimensionsRegex = /(\d+)x(\d+)x(\d+)/
    
    for present in input {
      guard let match = try? dimensionsRegex.wholeMatch(in: present) else {
        continue
      }
      
      let (_, l, w, h) = match.output
      presents.append(Present(l: Int(l)!, w: Int(w)!, h: Int(h)!))
    }
    return presents
  }
  
  class Present {
    let l: Int
    let w: Int
    let h: Int
    var base: Int {
      l * w
    }
    var side: Int {
      w * h
    }
    var front: Int {
      h * l
    }
    var minSide: Int {
      [base, side, front].min()!
    }
    
    var peremiter: Int {
      let sideP = 2 * w + 2 * h
      let frontP = 2 * l + 2 * h
      let baseP = 2 * w + 2 * l
      
      return [sideP, frontP, baseP].min()!
    }
    
    var volume: Int {
      return l * w * h
    }
    
    var area: Int {
      return 2 * base + 2 * side + 2 * front
    }
    
    
    init(l: Int, w: Int, h: Int) {
      self.l = l
      self.w = w
      self.h = h
    }
  }
  
  func part1() -> Int {
    let presents = getPresents()
    return presents.reduce(0) { acc, present in
      acc + present.area + present.minSide
    }
  }
  
  func part2() -> Int {
    let presents = getPresents()
    return presents.reduce(0) { acc, present in
      acc + present.volume + present.peremiter
    }
  }
}
