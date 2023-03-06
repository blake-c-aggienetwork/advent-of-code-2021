//
//  day4.swift
//  aoc2021
//
//  Created by Blake Carr on 2/13/23.
//

import Foundation

func day4(){
    guard let file: String = try? String(contentsOfFile: "day4Input.txt") else {
        exit(1)
    }
    
    var lines = file.components(separatedBy: .newlines)
    let drawings = lines.remove(at: 0).split(separator: ",").map({ Int($0) ?? -1 })
    
    lines.remove(at: 0)
    var boards = Array<[String]>()
    
    var curBoard: [String] = []
    while(lines.count != 0){
        let row = lines.remove(at: 0)
        if(row == ""){
            boards.append(Array<String>(curBoard))
            curBoard = []
            continue
        }
        curBoard.append(row)
    }
    
    var boardsProcessed = boards.map({ $0.map({ $0.split(whereSeparator: \.isWhitespace).map({ Int($0) ?? 0 }) }) })
    
    for draw in drawings{
        var toRemove: Array<Int> = []
        for i in 0..<boardsProcessed.count{
            if mark(draw: draw, onBoard: &boardsProcessed[i]){
                toRemove.append(i)
                if(boardsProcessed.count == 1 || boardsProcessed.count == boards.count){
                    let boardSum = boardsProcessed[i].reduce(0, { $0 + $1.reduce(0, { $0 + (($1 == -1) ? 0 : $1 )}) })
                    let score = boardSum*draw
                    print("This board won first or last with score: \(score)")
                }
            }
        }
        if toRemove.count > 0 {
            toRemove = toRemove.sorted(by: { $0 > $1 })
            _ = toRemove.map({ boardsProcessed.remove(at: $0)})
            toRemove = []
        }
    }
    
}

func mark(draw: Int, onBoard board: inout Array<Array<Int>>) -> Bool {
    for i in 0..<board.count{
        for j in 0..<board[0].count{
            if(board[i][j] == draw){
                board[i][j] = -1
                if(checkForWin(onBoard: &board, withRow: i, andCol: j)){ return true }
            }
        }
    }
    return false
}

func checkForWin(onBoard board: inout Array<Array<Int>>, withRow row: Int, andCol col: Int) -> Bool {
    for i in 0..<board.count{
        if board[i][col] != -1{ break }
        if i == board.count-1 { return true }
    }
    for j in 0..<board[0].count{
        if board[row][j] != -1{ break }
        if j == board[0].count-1 { return true }
    }
    return false
}
