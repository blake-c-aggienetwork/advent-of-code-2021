//
//  day9.swift
//  aoc2021
//
//  Created by Blake Carr on 2/19/23.
//

import Foundation

func day9(){
    guard let file = try? String(contentsOfFile: "day9Input.txt") else {
        exit(1)
    }
    
    let heightmap = file.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).map( { e in e.split(separator: "").map({ Int($0) ?? 0 })} )
    
    var riskSum = 0
    var basinSizes = Array<Int>()
    
    for i in 0..<heightmap.count{
        for j in 0..<heightmap[0].count{
            if isALowPointAt(i, j, onMatrix: heightmap){
                riskSum += heightmap[i][j]+1
                var map = heightmap
                basinSizes.append(dfsAt(i, j, onMatrix: &map, fromPointWithLastHeight: 0))
            }
        }
    }
    print("Silver: \(riskSum)")
    basinSizes = basinSizes.sorted(by: { $0 > $1 })
    print("Gold: \(basinSizes[0..<3].reduce(1, { $0*$1 }))")
    
}

func dfsAt(_ i: Int, _ j: Int, onMatrix mat: inout [[Int]], fromPointWithLastHeight lastHeight: Int) -> Int {
    guard let p = mat[safe: i]?[safe: j] else {
        return 0
    }
    if p >= lastHeight && p != 9 {
        mat[i][j] = 9
        return 1 + dfsAt(i-1, j, onMatrix: &mat, fromPointWithLastHeight: p) // north
        + dfsAt(i+1, j, onMatrix: &mat, fromPointWithLastHeight: p) // south
        + dfsAt(i, j+1, onMatrix: &mat, fromPointWithLastHeight: p) // east
        + dfsAt(i, j-1, onMatrix: &mat, fromPointWithLastHeight: p) // west
    }
    
    return 0
}

func isALowPointAt(_ i: Int,_ j: Int, onMatrix mat: Array<Array<Int>>) -> Bool{
    let point = mat[i][j]
    if let north = mat[safe: i-1]?[safe: j]{
        if north <= point { return false }
    }
    if let south = mat[safe: i+1]?[safe: j]{
        if south <= point { return false }
    }
    if let east = mat[safe: i]?[safe: j+1]{
        if east <= point { return false }
    }
    if let west = mat[safe: i]?[safe: j-1]{
        if west <= point { return false }
    }
    
    return true
}

// Subscript extension to return a nil value when accessing element outside of a collection objects bounds
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
