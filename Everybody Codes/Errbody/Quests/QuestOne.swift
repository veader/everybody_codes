//
//  QuestOne.swift
//  errbody
//
//  Created by Shawn Veader on 11/5/26.
//

import Foundation

class QuestOne: Questable {    

    let input: String
    var numbers: [Int] = []

    init(input: String) {
        self.input = input
        self.numbers = input.split(separator: ",").map(String.init).compactMap(Int.init)
    }

    internal func partOne() -> Int {
        let missing = numbers.map { num in
            let sq = Double(num).squareRoot()

            let ceiling = sq.rounded(.up)
            let upperBound = Int(ceiling * ceiling)

            if upperBound == num {
                // print("Nothing to get (upper)")
                return 0
            }

            let floor = sq.rounded(.down)
            let lowerBound = Int(floor * floor)

            if lowerBound == upperBound {
                print("Same Bounds")
                return Int.max
            } else if lowerBound == num {
                // print("Nothing to get (lower)")
                return 0
            } else if upperBound > num, num > lowerBound {
                // print("We need \(upperBound - num)")
                return upperBound - num
            } else {
                print("Unsure...")
                return Int.min
            }
        }

        return missing.reduce(0, +)
    }

    internal func partTwo() -> Int {
        let missing = numbers.map { num in
            var size = 3 // min size is 3x3
            var border = (size * 4) - 4
            while border < num {
                size += 1
                border = (size * 4) - 4
            }

            return border - num
        }

        return missing.reduce(0, +)
    }

    internal func partThree() -> Int {
        let missing = numbers.map { num in
            var size = 3 // min size is 3x3
            var count = (size * size) - 1
            while count < num {
                size += 2 // only odd numbers
                count = (size * size) - 1
            }

            return count - num
        }

        return missing.reduce(0, +)
    }
}
