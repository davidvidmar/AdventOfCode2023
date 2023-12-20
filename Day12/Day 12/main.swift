import Foundation

let day = "12"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

var result1 = 0

for line in lines {
    
    let s = line.components(separatedBy: " ")
    let springs = s[0]
    let indexes = s[1].components(separatedBy: ",").map { Int($0)! }
    
    print("\(springs) | \(indexes)")
    result1 += checkIndex(springs: springs, indexes: indexes)
    
}

print("Part 1: \(result1)")

// part 2

var result2 = 0

for line in lines {
    
    let s = line.components(separatedBy: " ")
    let springs = s[0]
    let indexes = s[1]
    
    print("\(springs) | \(indexes)")
    result1 += checkIndex(
        springs: String.init(repeating: springs, count: 5),
        indexes: String.init(repeating: indexes, count: 5).components(separatedBy: ",").map { Int($0)! }
    )
    
}

print("Part 2: \(result2)")

//var cache: [(String, [Int]): Int]()

func checkIndex(springs: String, indexes: [Int]) -> (Int) {
 
//    let key = (springs, indexes)
//    if cache.keys.contains(key) {
//        return cache[key]
//    }
    
    if (springs.count == 0) {
        return 0
    }
    if (indexes.count == 0) {
        return 1
    }
    
    
    var s = Array(springs)
    
//    if (cache.contains(where: (s, indexes)))
    
    if let i = s.firstIndex(of: "?") {
        s[i] = "#"
        var s1 = checkIndex(springs: String(s), indexes: indexes)
        s[i] = "."
        var s2 = checkIndex(springs: String(s), indexes: indexes)
        return s1 + s2
    } else {
        let x = springs.components(separatedBy: ".").filter({ !$0.isEmpty }).map { $0.count }
//        print("\(springs) == \(x): \(indexes == x)")
        return x == indexes ? 1 : 0
    }
    
}
    
//    
//    
//    var r = 0
//    
//    for (i, c) in springs.enumerated() {
//        if c == "?" {
//            var sO = Array(springs)
//            sO[i] = "."
//            //            print(sO)
//            let r2 = checkIndex(springs: String(sO), indexes: indexes)
//            if (r2.0) {
////                print("\(sO), \(r2.1)")
//                r += r2.1
//            }
//        }
//    }
//
//    if (!springs.contains("?")) {
//        
//    } else {
//        return (false, 0)
//    }
    
    
//}
