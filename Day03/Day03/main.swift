import Foundation
 
let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"

// https://adventofcode.com/2023/day/2
let day = "03"
print("Hello, AoC 2023! This is Day \(day).")
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// part 1

var result1 = 0

for (linenum, line) in lines.enumerated() {
    
    let regex = try! NSRegularExpression(pattern: "\\d+")
    let numMatches = regex.matches(in: line, range: NSRange(line.startIndex..., in:line))
    
    let symbols = "*+-/@%#=&$"
    
    var indices = line.enumerated().compactMap { symbols.contains($0.element) ? $0.offset : nil }
    if (linenum > 0) { indices.append(contentsOf: lines[linenum-1].enumerated().compactMap { symbols.contains($0.element) ? $0.offset : nil }) }
    if (linenum < line.count - 1) { indices.append(contentsOf: lines[linenum+1].enumerated().compactMap { symbols.contains($0.element) ? $0.offset : nil }) }

    //for (_, match) in numMatches.enumerated() {
        // print("\(linenum): \(match.range)")
    //}
    
    // print(indices.map(String.init).joined(separator: ","))
    
    for m in numMatches {
        let range = expandRange(range: m.range, inString: line)
        
        var valid = false
        for i in indices {
            if range.contains(i) {
                valid = true
                break
            }
        }
        if valid {
            let number = Int((line as NSString).substring(with: m.range))!
            // print(number)
            result1 += number
        }
    }
    
}

print("Part 1: \(result1)")

// part 2

var result2 = 0

for (linenum, line) in lines.enumerated() {
    
    let symbols = "*+-/@%#=&$"
    let indices = line.enumerated().compactMap { symbols.contains($0.element) ? $0.offset : nil }
    
    let regex = try! NSRegularExpression(pattern: "\\d+")
    let numMatches = regex.matches(in: line, range: NSRange(line.startIndex..., in:line))

    //for (_, match) in numMatches.enumerated() {
        // print("\(linenum): \(match.range)")
    //}
    
    // print(indices.map(String.init).joined(separator: ","))
    
    for i in indices {
        
        var expRanges: [NSRange] = []
        var ints: [Int] = []
        
        for m in numMatches {
            let string = line
            let range = expandRange(range: m.range, inString: string)
            ints.append(Int(string[Range(m.range, in: string)!])!)
            expRanges.append(range)
        }
            
        if (linenum > 0) {
            let string = lines[linenum-1]
            let prevLineMatches = regex.matches(in: string, range: NSRange(string.startIndex..., in:string))
            for m in prevLineMatches {
                ints.append(Int(string[Range(m.range, in: string)!])!)
                expRanges.append(expandRange(range: m.range, inString: string))
            }
        }
        
        if (linenum < line.count - 1) {
            let string = lines[linenum+1]
            let nextLineMatches = regex.matches(in: string, range: NSRange(string.startIndex..., in:string))
            for m in nextLineMatches {
                ints.append(Int(string[Range(m.range, in: string)!])!)
                expRanges.append(expandRange(range: m.range, inString: string))
            }
        }

        let offsets = expRanges.enumerated()
            .filter { $0.element.contains(i) }
            .map { $0.offset }

        if offsets.count == 2 {
            // print("\(ints[offsets[0]]), \(ints[offsets[1]])")
            result2 = result2 + ints[offsets[0]] * ints[offsets[1]]
        }
        else if (offsets.count > 2) {
            fatalError("trije zadetki")
        }
                        
    }
    
}
print("Part 2: \(result2)")

func expandRange(range: NSRange, inString string: String) -> NSRange {
    let startOffset = max(range.location - 1, 0)
    let endOffset = min(range.location + range.length + 1, string.count)
    let expandedRange = NSRange(location: startOffset, length: endOffset - startOffset)
    return expandedRange
}
