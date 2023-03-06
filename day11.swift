//
//  day11.swift
//  aoc2021
//
//  Created by Blake Carr on 2/22/23.
//

import Foundation

func day11(){
    guard let file = try? String(contentsOfFile: "day11Input.txt") else {
        exit(1)
    }
    
    var octoEnergies = file.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map( { $0.split(separator: "").map( { Int($0) ?? 0 }) } )
    
    
    let offsets: Array<(Int,Int)> = [
        (0,-1), // Up
        (0,1), // down
        (-1,0), // left
        (1,0), // right
        (-1,-1), // Top left
        (-1,1), // Top Right
        (1,-1), // Bottom Left
        (1,1), // Bottom Right
    ]
    
    var toFlash = Array<(Int,Int)>()
    
    for _ in 1...2{
        // Go Through Step 1
        for y in 0..<octoEnergies.count{
            for x in 0..<octoEnergies[0].count{
                octoEnergies[y][x] += 1
                if octoEnergies[y][x] > 9 { toFlash.append((y,x)) }
            }
        }
        
        // Step 2, pop the flashes continously
        while(toFlash.count > 0){
            let (y,x) = toFlash.remove(at: 0)
            // increment nearby octos
            for (xOffset, yOffset) in offsets{
                guard let _ = octoEnergies[safe: y+yOffset]?[safe: x+xOffset] else {
                    continue
                }
                octoEnergies[y+yOffset][x+xOffset] += 1
                if octoEnergies[y+yOffset][x+xOffset] > 9 {
                    toFlash.append((y+yOffset,x+xOffset))
                }
            }
        }
        	
    }
    
    print(octoEnergies)
}
