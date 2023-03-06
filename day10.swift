//
//  day10.swift
//  aoc2021
//
//  Created by Blake Carr on 2/21/23.
//

import Foundation

func day10(){
    guard let file = try? String(contentsOfFile: "day10Input.txt") else {
        exit(1)
    }
    
    let subsysLines = file.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines)
    
    let openToCloseChunkLookUp: Dictionary<Character,Character> = [
        "(":")",
        "[":"]",
        "{":"}",
        "<":">"
    ]
    
    let illegalCharScoreLookUp: Dictionary<Character,Int> = [
        ")":3,
        "]":57,
        "}":1197,
        ">":25137
    ]
    
    let missingCharScoreLookUp: Dictionary<Character,Int> = [
        ")":1,
        "]":2,
        "}":3,
        ">":4
    ]
    
    var illegalScore = 0
    var missingCharScores = Array<Int>()
    
    outerloop: for line in subsysLines{
        var stack = Array<Character>()
        for c in line{
            if openToCloseChunkLookUp.keys.contains(c) { // Found an opening chunk
                stack.append(openToCloseChunkLookUp[c] ?? "x")
            }else{ // Found a closing chunk
                if stack.last == c {
                    stack.remove(at: stack.endIndex-1)
                }else{
    //                print("Expected \(stack.last ?? "x"), but found \(c) instead")
                    illegalScore += illegalCharScoreLookUp[c] ?? 0
                    continue outerloop;
                }
            }
        }
        // Calculate missing Char Score
        stack = stack.reversed()
        var missingCharScore = 0
        for c in stack {
            missingCharScore *= 5
            missingCharScore += missingCharScoreLookUp[c] ?? 0
        }
        missingCharScores.append(missingCharScore)
    }
    
    print("Silver: \(illegalScore)")
    print("Gold: \(missingCharScores.sorted(by: { $0 > $1 })[missingCharScores.endIndex/2] )")
    
    
}
