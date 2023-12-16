import Foundation

let day = "15"
print("AoC 2023, Day \(day)\n")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

var result1 = 0

for line in lines {
    let steps = line.components(separatedBy: ",")
    for step in steps {
//        print(step, terminator: " => ")
        var value = 0
        for c in step {
            value += Int(c.asciiValue ?? 0)
            value = value*17
            value = value % 256
        }
//        print(value)
        result1 += value
    }
}

print("Part 1: \(result1)")

// part 2

var boxes: [[String]] = Array(repeating: [], count: 256)

for line in lines {
    let steps = line.components(separatedBy: ",")
    for step in steps {
        
        var label = "?"
        var fl = 0

        var command = ""
        
        if (step.contains("-")) {
            label = String(step.dropLast())
            command = "-"
        } else if (step.contains("=")) {
            let x = step.components(separatedBy: "=")
            label = x[0]
            fl = Int(x[1])!
            command = "="
        }
        assert(label != "?")
               
        var box = 0
        for c in label {
            box += Int(c.asciiValue ?? 0)
            box *= 17
            box %= 256
        }
        
        let i = boxes[box].firstIndex { $0.starts(with: label + " ") }
        if (command == "=") {
            if (i != nil) {
                // replace
                boxes[box][i!] = "\(label) \(fl)"
            } else {
                // append
                boxes[box].append("\(label) \(fl)")
            }
        } else if (command == "-") {
            // remove
            if i != nil { boxes[box].remove(at: i!) }
        }
        
        // nasty bug - sccp starts with scc, which is not same label!
//        if (box == 89) {
//            print("\(step) - \(boxes[box])")
//        }
//        print("\(step): \(label) \(fl) @ \(box)", terminator: " => ")
//        print(boxes[0...4])
    }
}

var result2  = 0
for (i, b) in boxes.enumerated() {
//    if !b.isEmpty { print (i+1, " ", b) }
    for (j, l) in b.enumerated() {
        let fl = Int(l.components(separatedBy: " ")[1])!
        let x = (i+1) * (j+1) * fl
//        print("\(result2)\t+=\t\(i+1)\t*\t\(j+1)\t*\t\(fl)\t=\t\(x)")
        result2 += x
    }
}

print("Part 2: \(result2)")
