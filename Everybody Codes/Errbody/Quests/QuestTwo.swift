//
//  QuestTwo.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/7/26.
//

import Foundation
import RegexBuilder

class QuestTwo: Questable {

    static let samplePart1 = """
        4<3 2<5 3>1 1>2 1<5 4<1 3>2 4<2 3>5 4<5
        4>1 2>1 3>2 1<5 4>5 2<5 3>1 4>3 2<4 5<3
        5>1 5>2 4>1 2<4 3>2 3<4 1>2 3>5 1<3 4>5
        """

    static let samplePart2 = """
        2<5 3>1 1>2 1<5 4<1 3>2 4<2 3>5 4<5
        2>1 3>2 1<5 4>5 2<5 3>1 4>3 2<4 5<3
        5>1 5>2 4>1 3>2 3<4 1>2 3>5 1<3 4>5
        """

    static let samplePart3 = """
        3>1 1>2 1<5 4<2 3>5
        2>1 2<5 3>1 4>3 2<4 5<3
        5>1 3<4 1>2 3>5
        """

    let input: String
    let lines: [String]

    struct AlloyCompare: CustomDebugStringConvertible {
        let lesser: Int
        let greater: Int

        init?(input: String) {
            var lesserStr: Substring?
            var greaterStr: Substring?

            if let match = input.firstMatch(of: /(\d)<(\d)/) {
                lesserStr = match.1
                greaterStr = match.2
            } else if let match = input.firstMatch(of: /(\d)>(\d)/) {
                lesserStr = match.2
                greaterStr = match.1
            }

            guard
                let lesserInt = Int(lesserStr ?? ""),
                let greaterInt = Int(greaterStr ?? "")
            else { return  nil }

            self.lesser = lesserInt
            self.greater = greaterInt
        }

        var debugDescription: String {
            "\(lesser) < \(greater)"
        }
    }

    init(input: String) {
        self.input = input
        self.lines = input.split(separator: "\n").map(String.init)
    }


    // MARK: -

    private func solve(line: String) -> Int? {
        let compares = line.split(separator: " ").map(String.init).compactMap { AlloyCompare(input: $0) }
        let numbers = Set(line.replacing(/\D/, with: "").map(String.init).compactMap(Int.init))

        // build lookup hash
        var lookup: [Int: Set<Int>] = [:]
        for num in numbers {
            // find all things less than this num
            let foundCompares = compares.filter { $0.greater == num }
            lookup[num] = Set(foundCompares.map(\.lesser))
        }

        var sorted: [Int] = []
        var theRest: Set<Int> = numbers

        while !theRest.isEmpty {
            // which number has nothing less than it?
            var weakest = lookup.filter { ($1.subtracting(sorted)).count == 0 }
            weakest = weakest.filter { !sorted.contains($0.key) }

            if weakest.count > 1 {
                print("Oh no! Weakest: \(weakest)\nSorted: \(sorted)\nRest: \(theRest)")
                return nil
            }

            guard let theWeakest = weakest.first?.key else {
                print("Womp womp...\nSorted: \(sorted)\nRest: \(theRest)")
                return nil
            }

            theRest.remove(theWeakest)
            sorted.append(theWeakest)
        }

        let answer = Int(sorted.reversed().map(String.init).joined())
        return answer
    }

    private func solve() -> Int {
        let answers = lines.compactMap { solve(line: $0) }
        return answers.reduce(0, +)
    }

    internal func partOne() -> Int {
        solve()
    }

    internal func partTwo() -> Int {
        solve()
    }

    internal func partThree() -> Int {
        solve()
    }
}
