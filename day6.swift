//
//  day6.swift
//  aoc2021
//
//  Created by Blake Carr on 2/14/23.
//

import Foundation

func day6(){
    guard let file = try? String(contentsOfFile: "day6Input.txt") else {
        exit(1)
    }
    
    let fish = file.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",").map({ Int($0) ?? 0})
    var lanternFish = fish
    
    for _ in 1...80{
        simulateDay(for: &lanternFish)
    }
    print("silver: after 80 days there are \(lanternFish.count)")
    
    // key: days, val: fish count
    var fishDic: Array<Int> = Array<Int>(repeatElement(0, count: 9))
    for f in fish{
        fishDic[f] += 1
    }
    
    for _ in 1...256{
        simulateDay(forCountOf: &fishDic)
    }
    print("Gold: After 256 days there are \(fishDic.reduce(0, { $0 + $1 }))")
    
}

func simulateDay(forCountOf lanternFish: inout Array<Int>){
    let zeroDayFish = Int(lanternFish[0])
    lanternFish[0] = 0
    for day in 1...8{
        lanternFish[day-1] = lanternFish[day]
    }
    
    lanternFish[6] += zeroDayFish
    lanternFish[8] = zeroDayFish
    
}

func simulateDay(for lanternFish: inout Array<Int>){
    for i in 0..<lanternFish.count{
        if lanternFish[i] == 0{
            lanternFish[i] = 6
            lanternFish.append(8)
        }else{
            lanternFish[i] -= 1
        }
    }
}
