//
//  Quest03.swift
//  errbody
//
//  Created by Shawn Veader on 11/9/26.
//

import Foundation
import RegexBuilder

class Quest03: Questable {

    static let samplePart1 = """
        ISO-3210 7654
        ISO-8742 2468
        ISO-1111 1111
        """

    static let samplePart2 = """
        ISO-3210 7654
        ISO-8742 2468
        ISO-1 1111
        ISO-13 777
        ISO-34 140856
        ISO-789 2465112
        ISO-2341 945
        """

    static let samplePart3 = """
        ISO2-3 23
        ISO2-61 149
        ISO2-978 99
        ISO2-5887 5923
        ISO2-76988 123749
        ISO2-435657 929977
        ISO2-3949 870737
        """

    let input: String
    let isoValues: [ElvenISOValue]

    struct ElvenISOStandard {
        /// Full standard name. Example: ISO-3210
        let name: String

        /// Split ISO standard weights
        let standardWeights: [Int]

        /// Input is expected to be in the format of "ISO-3210"
        init?(input: String) {
            guard let match = input.firstMatch(of: /ISO[2]?-(\d+)/) else { return nil }

            self.name = input
            self.standardWeights = match.1.map(String.init).compactMap(Int.init)
        }

        func calculateDecimal(value input: Int) -> Int {
            let digits = "\(input)".map(String.init).compactMap(Int.init).reversed()
            let weights = Array(standardWeights.reversed())
            let size = weights.count

            let weighted = digits.enumerated().map { (idx, num) in
                let modIdx = idx % size
                let weight = Double(weights[modIdx])
                let power = Double(idx)

                return num * Int(pow(weight, power))
            }

            return weighted.reduce(0, +)
        }
    }

    struct ElvenISOValue {
        /// Elven ISO Standard
        let standard: ElvenISOStandard

        /// Original (unweighted) value
        let value: Int

        /// Input is expected to be in the format of "ISO-3210 7654"
        init?(input: String) {
            guard
                let match = input.firstMatch(of: /(ISO[2]?-\d+) (\d+)/),
                let std = ElvenISOStandard(input: String(match.1)),
                let val = Int(match.2)
            else { return nil }

            self.standard = std
            self.value = val
        }

        var weightedValue: Int {
            standard.calculateDecimal(value: value)
        }
    }


    init(input: String) {
        self.input = input
        self.isoValues = input.split(separator: "\n")
            .map(String.init)
            .compactMap { ElvenISOValue(input: $0) }
    }


    // MARK: -


    internal func partOne() -> Int {
        isoValues.map(\.weightedValue).reduce(0, +)
    }

    internal func partTwo() -> Int {
        isoValues.map(\.weightedValue).reduce(0, +)
    }

    internal func partThree() -> Int {
        // first, separate the values into matching ISO standard buckets
        var isoMap: [String: ElvenISOStandard] = [:]
        var isoValueMap: [String: [Int]] = [:]

        for isoValue in isoValues {
            let isoName = isoValue.standard.name
            var theMap = isoValueMap[isoName] ?? []
            theMap.append(isoValue.value)
            isoValueMap[isoName] = theMap
            isoMap[isoName] = isoValue.standard
        }

        var sum = 0

        // next, for each ISO standard bucket, let's determine decimal values and look for overlaps
        for (isoName, iso) in isoMap {
            guard let values = isoValueMap[isoName] else { continue }
            let validValues = validISO2(standard: iso, values: values)
            let decimalValues = validValues.map { iso.calculateDecimal(value: $0) }
            sum += decimalValues.reduce(0, +)
        }

        return sum
    }

    private func validISO2(standard: ElvenISOStandard, values: [Int]) -> [Int] {
        values.sorted().reversed().filter { value in
            let decimal = standard.calculateDecimal(value: value)

            for i in (decimal..<value) {
                let idec = standard.calculateDecimal(value: i)
                guard idec != decimal else { return false }
            }

            return true
        }
    }
}
