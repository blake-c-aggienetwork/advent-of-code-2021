//
//  day7.swift
//  aoc2021
//
//  Created by Blake Carr on 2/14/23.
//

import Foundation

func day7(){
    guard let file = try? String(contentsOfFile: "day7Input.txt") else {
        exit(1)
    }
    
    let crabs = file.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ",").map({ Int($0) ?? 0})
    
    var silverFuelCost:Int = .max
    for pos in crabs.min()!...crabs.max()!{
        let fuelCost = crabs.reduce(0, { total, cur in
            if(pos <= cur){
                return total + cur-pos
            }else{
                return total + pos-cur
            }
        })
        silverFuelCost = min(silverFuelCost, fuelCost)
    }
    print(silverFuelCost)
    
    var goldFuelCost: Int = .max
    var goldFuelNoChangeCnt: Int = 0
    for pos in crabs.min()!...crabs.max()!{
        var fuelCost = 0
        for crab in crabs {
            if(pos <= crab){
                fuelCost += gasCost(crab-pos)
            }else{
                fuelCost += gasCost(pos-crab)
            }
            if fuelCost > goldFuelCost { break }
        }
        goldFuelCost = min(goldFuelCost, fuelCost)
        if goldFuelCost != fuelCost{
            goldFuelNoChangeCnt += 1
            if(goldFuelNoChangeCnt >= 50){
                break
            }
        }
    }
    print(goldFuelCost)
    
}

func gasCost(_ n: Int) -> Int{
    if n == 0 { return 0}
    return (1...n).reduce(0, { $0 + $1 })
}
