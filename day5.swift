//
//  day5.swift
//  aoc2021
//
//  Created by Blake Carr on 2/13/23.
//

import Foundation

func day5(){
    guard let file = try? String(contentsOfFile: "day5Input.txt") else{
        exit(1)
    }
    var lines = file.components(separatedBy: .newlines)
    lines.remove(at: lines.count-1)
    let pointPairsStr = lines.map({ $0.split(separator: " -> ").map({ $0.split(separator: ",")})})
    
    let pointPairs = pointPairsStr.map({ $0.map( { $0.map( {Int($0) ?? -1 })} ) })
    
//    print(pointPairs)
    var silverVents: Dictionary<Array<Int>,Int> = [:]
    
    
    for pair in pointPairs{
        if pair[0][0] == pair[1][0] { // x value are equal, iterate through y
            let x = pair[0][0]
            for y in pair[0][1] < pair[1][1] ? pair[0][1]...pair[1][1] : pair[1][1]...pair[0][1]{
                silverVents[[x,y]] = (silverVents[[x,y]] ?? 0) + 1
            }
        }else if pair[0][1] == pair[1][1]{ // y values are equal, iterate throug x
            let y = pair[0][1]
            for x in pair[0][0] < pair[1][0] ? pair[0][0]...pair[1][0] : pair[1][0]...pair[0][0]{
                silverVents[[x,y]] = (silverVents[[x,y]] ?? 0) + 1
            }
        }
    }
    
    let silver = silverVents.values.reduce(0, { $0 + ($1>1 ? 1 : 0) })
    print(silver)
    
    
    var goldVents: Dictionary<Array<Int>, Int> = silverVents
    
    for pair in pointPairs{
        if pair[0][0] == pair[1][0] { // x value are equal, iterate through y
            // already computed
        }else if pair[0][1] == pair[1][1]{ // y values are equal, iterate throug x
            // already computed
        }else{ // diagonal vent
            var p1 = pair[0]
            let p2 = pair[1]
            goldVents[p2] = (goldVents[p2] ?? 0) + 1
            while(p1 != p2){
                goldVents[p1] = (goldVents[p1] ?? 0) + 1
                p1[0] += p1[0] < p2[0] ? 1 : -1
                p1[1] += p1[1] < p2[1] ? 1 : -1
            }
        }
    }
    
    let gold = goldVents.values.reduce(0, { $0 + ($1>1 ? 1 : 0) })
    print(gold)
    
}
