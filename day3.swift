//
//  day3.swift
//  aoc2021
//
//  Created by Blake Carr on 2/12/23.
//

import Foundation

func day3(){
    guard let file:String = try? String(contentsOfFile: "day3Input.txt", encoding: .utf8) else {
        exit(1)
    }

    let lines = file.split(whereSeparator: \.isNewline).map({ String($0) })
    
    var bitCnt: Array<Int> = Array(repeating: 0, count: lines[0].count)
    for line in lines{
        for i in 0..<line.count{
            bitCnt[i] += (line[i] == Character("1")) ? 1 : -1
        }
    }
    
    var bitString = bitCnt.map({ $0 > 0 ? String(1) : String(0)})
    
    let gammaRate = Int(bitString.reduce("", { $0.appending($1) }), radix: 2)
    bitString = bitString.map({ $0 == "0" ? "1" : "0"}) // Flip the bits
    let epsilonRate = Int(bitString.reduce("", { $0.appending($1) }), radix: 2)
    
    let silver = gammaRate! * epsilonRate!
    print(silver)
    
    // MARK: Part 2
    var oxygenLines = lines
    for i in 0..<oxygenLines[0].count{
        let filter = oxygenLines.map( { $0[i] }).reduce(0, { $0 + ($1 == "1" ? 1 : -1) }) >= 0 ? "1" : "0"
        oxygenLines = oxygenLines.filter({ $0[i...i] == filter})
        if(oxygenLines.count == 1){ break }
    }
    let oxygenRate = Int(oxygenLines[0], radix: 2)
    
    var co2Lines = lines
    for i in 0..<co2Lines[0].count{
        let filter = co2Lines.map( { $0[i] }).reduce(0, { $0 + ($1 == "1" ? 1 : -1) }) >= 0 ? "0" : "1"
        co2Lines = co2Lines.filter({ $0[i...i] == filter})
        if(co2Lines.count == 1){ break }
    }
    let co2Rate = Int(co2Lines[0], radix: 2)
        
    let gold = oxygenRate! * co2Rate!
    
    print(gold)
    
}


// Extension to string protocol to allow fetching by Int index
// Apple does not allow you to do this normally this it is innefficient and does not have
// many practical use cases
// https://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift
extension StringProtocol {
    subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
    subscript(range: Range<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: ClosedRange<Int>) -> SubSequence {
        let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
        return self[startIndex..<index(startIndex, offsetBy: range.count)]
    }
    subscript(range: PartialRangeFrom<Int>) -> SubSequence { self[index(startIndex, offsetBy: range.lowerBound)...] }
    subscript(range: PartialRangeThrough<Int>) -> SubSequence { self[...index(startIndex, offsetBy: range.upperBound)] }
    subscript(range: PartialRangeUpTo<Int>) -> SubSequence { self[..<index(startIndex, offsetBy: range.upperBound)] }
}
