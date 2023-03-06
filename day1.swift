//
//  day1.swift
//  aoc2021
//
//  Created by Blake Carr on 2/12/23.
//

import Foundation

func day1() {
    guard let file:String = try? String(contentsOfFile: "day1Input.txt", encoding: .utf8) else {
        exit(1)
    }

    let lines = file.split(whereSeparator: \.isNewline).map({ Int($0) ?? 0})

    var silver: Int = 0

    for i in 1..<lines.count {
        if(lines[i] > lines[i-1]){
            silver += 1
        }
    }

    print(silver)

    var gold: Int = 0

    for i in 3..<lines.count{
        let sum1 = lines[i-3]+lines[i-2]+lines[i-1]
        let sum2 = lines[i-2]+lines[i-1]+lines[i]
        if(sum2 > sum1){ gold += 1}
    }

    print(gold)

}
