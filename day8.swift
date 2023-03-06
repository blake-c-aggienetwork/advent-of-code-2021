//
//  day8.swift
//  aoc2021
//
//  Created by Blake Carr on 2/15/23.
//

import Foundation

func day8(){
    guard let file = try? String(contentsOfFile: "day8Input.txt") else {
        exit(1)
    }
    let output = file.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map { str in
        let marker = str.index(after: str.firstIndex(of: "|")!)
        return str[marker...].split(separator: " ")
    }
    
    var segmentCntFreq = Array<Int>(repeating: 0, count: 8)

    for outputDigits in output{
        for digit in outputDigits{
            segmentCntFreq[digit.count] += 1
        }
    }

//    print(segmentCntFreq)
//    print("There are \(segmentCntFreq[2]) ones")
//    print("There are \(segmentCntFreq[4]) fours")
//    print("There are \(segmentCntFreq[3]) sevens")
//    print("There are \(segmentCntFreq[7]) eights")

    let uniqueSegmentCount = segmentCntFreq[2]+segmentCntFreq[4]+segmentCntFreq[3]+segmentCntFreq[7]
    print("Silver: Count of digits with unique segment counts \(uniqueSegmentCount)")
    
    let signalOutputPair = file.trimmingCharacters(in: .newlines).components(separatedBy: .newlines).map( { $0.split(separator: " | ").map({ $0.split(separator: " ") })})
    
//    print(signalOutputPair)
    
    var sum = 0
    
    for pair in signalOutputPair{
        let signals = pair[0]
        let lookUp = buildLookUpDicFor(signals: signals)
        let output = pair[1].map({ String($0.sorted(by: { $0 < $1})) })
        
        let decodedOutput = Int(output.map({ String(lookUp[$0]!) }).joined()) ?? 0
        sum += decodedOutput
    }
    
    print("Gold: \(sum)")
    
}

func buildLookUpDicFor(signals: Array<any StringProtocol>) -> Dictionary<String,Int>{
    let signals = signals.map({ String($0) })
    var lookUp = Dictionary<String,Int>()
    
    lookUp.updateValue(1, forKey: signals.filter({ $0.count == 2 })[0] )
    lookUp.updateValue(4, forKey: signals.filter({ $0.count == 4 })[0] )
    lookUp.updateValue(7, forKey: signals.filter({ $0.count == 3 })[0] )
    lookUp.updateValue(8, forKey: signals.filter({ $0.count == 7 })[0] )
    
    // Signals of legnth 6: 9,6,0
    var length6Signals = signals.filter({ $0.count == 6})
    
    // 9 and 6 both contain 1 therefore 6 will be left
    let one = signals.filter({ $0.count == 2 })[0]
    let six = length6Signals.filter({ !($0.contains(one[0]) && $0.contains(one[1])) })[0]
    lookUp.updateValue(6, forKey: six)
    length6Signals = length6Signals.filter({ $0 != six })
    
    // 9 will contain 4 but 0 will not
    let four = signals.filter({ $0.count == 4})[0]
    let nine = length6Signals.filter({ $0.contains(four[0]) && $0.contains(four[1]) && $0.contains(four[2]) && $0.contains(four[3]) })[0]
    lookUp.updateValue(9, forKey: nine)
    
    // 0 is remaining
    lookUp.updateValue(0, forKey: length6Signals.filter({ $0 != nine })[0])
    
    // Signals of length 5: 5,2,3
    var length5Signals = signals.filter({ $0.count == 5})
    
    // 3 will contain 1 but 5 and 2 will not
    let three = length5Signals.filter({ $0.contains(one[0]) && $0.contains(one[1])})[0]
    lookUp.updateValue(3, forKey: three)
    length5Signals = length5Signals.filter({ $0 != three} )
    
    // 5 will contain the diference of 4 and 1 but 2 will not
    let fourDifTwo = four.filter({ $0 != one[0] && $0 != one[1] })
    let five = length5Signals.filter({ $0.contains(fourDifTwo[0]) && $0.contains(fourDifTwo[1]) })[0]
    lookUp.updateValue(5, forKey: five)
    
    // 2 is remaining
    lookUp.updateValue(2, forKey: length5Signals.filter({ $0 != five})[0] )
    
    for (key, val) in lookUp{
        let newKey = String(key.sorted(by: { $0 < $1 }))
        lookUp[key] = nil
        lookUp.updateValue(val, forKey: newKey)
    }
    
    
    
    return lookUp
}
