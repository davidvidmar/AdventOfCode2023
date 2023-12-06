import Foundation
 
// https://adventofcode.com/2023/day/6

let day = "06"
print("Hello, AoC 2023! This is Day \(day).")

let path = "/Users/david/Library/CloudStorage/OneDrive-Personal/20-29 Projects/21 Code/21.24 AdventOfCode/AdventOfCode2023-Swift/"
let content = try String(contentsOfFile: path + "/Day\(day)/Day\(day)/input.txt", encoding: String.Encoding.utf8)
let lines = content.components(separatedBy: "\n").filter { !$0.isEmpty }

// parse input

// sample
//let races: [Race] = [
//    Race(time: 7, distance: 9),
//    Race(time: 15, distance: 40),
//    Race(time: 30, distance: 200)
//]

// input
// Time:        47     70     75     66
// Distance:   282   1079   1147   1062
var races: [Race] = [
    Race(time: 47, distance: 282),
    Race(time: 70, distance: 1079),
    Race(time: 75, distance: 1147),
    Race(time: 66, distance: 1062)
]

// part 1

var result1 = 1

for i in 0..<races.count {
    
    var wins = 0
    
    let time = races[i].time
    let distance = races[i].distance
    
    for holdTime in 0...races[i].time {
        let speed = holdTime
        let traveled = speed * (time - holdTime)
        if (traveled > distance) {
//            print("\(i):\(speed) \(traveled)")
            wins = wins + 1
        }
    }
    
    if (wins > 0) { result1 = result1 * wins }
}

print("Part 1: \(result1)")

// part 2

//races = [ Race(time: 71530, distance: 940200) ]
races = [ Race(time:  47707566, distance: 282107911471062) ]

// could be smarter, but it works & is fast anyway

var result2 = 1

for i in 0..<races.count {
    
    var wins = 0
    
    let time = races[i].time
    let distance = races[i].distance
    
    for holdTime in 0...races[i].time {
        let speed = holdTime
        let traveled = speed * (time - holdTime)
        if (traveled > distance) {
//            print("\(i):\(speed) \(traveled)")
            wins = wins + 1
        }
    }
    
    if (wins > 0) { result2 = result2 * wins }
}

print("Part 2: \(result2)")

struct Race {
    var time: Int
    var distance: Int
}
