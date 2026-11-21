//
//  Quest05.swift
//  Everybody Codes
//
//  Created by Shawn Veader on 11/18/26.
//

import Foundation

class Quest05: Questable {

    static let samplePart1 = """
        010100100100001101000
        111101001000001110000
        101111011000101010011
        001000101010000100000
        000110100110011001100
        000001110111111000000
        101100010101011110000
        001101100000001010011
        001001001111010001001
        100011011110011010101
        001100101110010010000
        """

    static let samplePart2 = """
        010100100100001101000
        111101001000001110000
        101111011000101010011
        001000101010000100000
        000110100110011001100
        000001110111111000000
        101100010101011110000
        001101100000001010011
        001001001111010001001
        100011011110011010101
        001100101110010010000
        """

    static let samplePart3 = "3,11,12,16,24,25"

    let input: String
    var grid: GridMap<String>

    init(input: String) {
        self.input = input
        let lines = input.split(separator: "\n").map(String.init)
        let mapData = lines.map { $0.map(String.init) }
        self.grid = GridMap<String>(items: mapData)
    }

    internal func partOne() -> Int {
        createLand()
        return grid.count(where: { $0 == "#" })
    }

    internal func partTwo() -> Int {
        return 0
    }

    internal func partThree() -> Int {
        return 0
    }

    /// Crawl through the coordinate space and create the land (and water)
    ///
    /// - Insert Genesis ref here...
    private func createLand() {
        var toInvestigate: Set<Coordinate> = [grid.center]

        /// New land we've added, which will mean it's on the edges
        var borderLand: Set<Coordinate> = []
        /// Land that is surrounded on all sides by land - optimization
        var centerLand: Set<Coordinate> = []

        // grid.printGrid()

        while !toInvestigate.isEmpty {
            var newLand: Set<Coordinate> = []

            for c in toInvestigate {
                let adjacent = grid.adjacentItems(to: c)
                let land = adjacent.filter { $0 != "0" }
                if land.count >= 5 {
                    newLand.insert(c)
                    borderLand.insert(c)
                } else if c == grid.center {
                    // we always draw land at the center (missed this in the reading)
                    newLand.insert(c)
                    borderLand.insert(c)
                }
            }

            // build land in the new places
            for c in newLand {
                grid.update(at: c, with: "#")
            }

            // see if any of our land is now surrounded by other land
            var landGrab: Set<Coordinate> = []
            for land in borderLand {
                guard grid.adjacentItems(to: land).filter({ $0 == "#" }).count == 8 else { continue }
                landGrab.insert(land)
            }

            centerLand.formUnion(landGrab)
            borderLand.subtract(landGrab)

            var newToInvestigate: Set<Coordinate> = []
            for land in borderLand {
                let adj = grid.adjacentCoordinates(to: land).filter { c in
                    !borderLand.contains(c) &&
                    !centerLand.contains(c)
                }
                newToInvestigate.formUnion(adj)
            }

            // we stop if we find that our places to check aren't changing...
            if newToInvestigate == toInvestigate {
                toInvestigate = []
            } else {
                toInvestigate = newToInvestigate
            }
        }

        // finally create the water from "not land"
        grid.updateEach { c, s in
            if s == "#" {
                "#"
            } else {
                "."
            }
        }

        // grid.printGrid()
    }
}
