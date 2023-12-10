import Foundation

let day = "08"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
//let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input-sample-part2.txt", encoding: String.Encoding.utf8)
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

let commands = Array(lines[0])
let nodes = lines[1...].map { Node(string: $0) }

// part 1

var end = false
var step = 0
var ci = 0
var current = "AAA"

//while (!end) {
//    
//    let command = commands[i]
//    
////    print("\(step): \(command) \(current)", terminator: "")
//
//    let next = nodes.filter { $0.start == current }.first!
//    current = command == "L" ? next.left : next.right
//        
////    print(" -> \(current)")
//    
//    if current == "ZZZ" {
//        end = true
//    } else {
//        step += 1
//        i += 1
//        if i >= commands.count { i = 0 }
//    }
//}

print("Part 1: \(step + 1)")

// part 2

end = false
step = 0
ci = 0

var currents = nodes.filter { $0.start.last == "A" }

while (!end) {

    let command = commands[ci]
    
    //    let next = nodes.filter { $0.start == curr }.first!
    //    curr = command == "L" ? next.left : next.right
    
    for i in 0..<currents.count {
        
        let c = currents[i]
        
        currents[i] = nodes.filter { $0.start == (command == "L" ? c.left : c.right) }.first!
        
        currents[i].path = c.path
        currents[i].loopLen = c.loopLen
        currents[i].loopStart = c.loopStart
        
//        if (currents[i].loopLen == 0 && currents[i].path.contains(c.start))
//        {
//            currents[i].loopStart = currents[i].path.firstIndex{ $0 == c.start }!
//            currents[i].loopLen = currents[i].path.count - currents[i].path.firstIndex{ $0 == c.start }!
//        }
        
        if currents[i].loopLen == 0 && currents[i].start.last == "Z" {
            currents[i].loopLen = currents[i].path.count + 1
        }
        
        currents[i].path.append(c.start)
    }
    
    step += 1
    ci += 1
    if ci >= commands.count { ci = 0 }
    
//    print("\(step): \(command) | \(currents)")
    
//    if currents.allSatisfy({ $0.start.last == "Z" }) {
    if currents.allSatisfy({ $0.loopLen != 0 }) {
        end = true
        print("\(step): \(command) | \(currents)")
    }
}

// least common multiple
var a: Int = 0, b: Int = 0
a = currents[0].loopLen
b = currents[1].loopLen
var l = lcm(a, b)
for i in 2..<currents.count {
    l = lcm(l, currents[i].loopLen)
}

print("Part 2: lcm = \(l)")

// structs

struct Node : CustomStringConvertible {
    var path: [String] = []
    var start: String
    var left: String
    var right: String
    var loopStart: Int = 0
    var loopLen: Int = 0
    
    init(string: String) {
        start = string.components(separatedBy: " = ")[0]
//        path.append(start)
//        startedFrom = string.components(separatedBy: " = ")[0]
        let LR = string.components(separatedBy: " = ")[1].replacing("(", with: "").replacing(")", with: "").components(separatedBy: ", ")
        left = LR[0]
        right = LR[1]
    }

    var description: String {
//        return "(\(start) = (\(left), \(right)) | \(path)) \(loopLen)"
//        return "\(path[0]) \(start) = \(loopStart) x \(loopLen) = \(path.count)"
        return "\(start) = \(loopStart) x \(loopLen) = \(path.count)"
    }
}

func gcd(_ a: Int, _ b: Int) -> Int {
    let rem = a % b
    return rem != 0 ? gcd(b, rem) : abs(b)
}

func lcm(_ a: Int, _ b: Int) -> Int {
    return (a * b) / gcd(a, b)
}
