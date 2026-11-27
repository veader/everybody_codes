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

    static let samplePart3 = """
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

        return grid.count(where: { $0 == "#" }) // count land
    }

    internal func partTwo() -> Int {
        createLand()
        createSand()

        return grid.count(where: { $0 == "=" }) // count sand
    }

    internal func partThree() -> Int {
        createLand()
        createSand()

        // plant initial trees
        createTrees()

        // grow forest twice
        growForest()
        growForest()

        return grid.count(where: { $0 == "@" }) // count trees
    }


    // MARK: - Map Building

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
            guard s != "#" else { return s } // keep land
            return "." // make water
        }

        // grid.printGrid()
    }

    private func createSand() {
        // find all land touching water
        var starterSand: Set<Coordinate> = []

        let water = grid.filter { $1 == "." }
        for coordinate in water {
            let neighbors = grid.adjacentCoordinates(to: coordinate)
            let land = neighbors.filter { grid.item(at: $0) == "#" }
            starterSand.formUnion(Set(land))
        }

        // find all land touching edge of map
        let edges = grid.boundaryCoordinates()
        for coordinate in edges {
            guard grid.item(at: coordinate) == "#" else { continue }
            starterSand.insert(coordinate)
        }

        // build our starter sand
        starterSand.forEach { grid.update(at: $0, with: "=") }

        var toInvestigate = findPotentialSand()
        while !toInvestigate.isEmpty {
            let newSand = toInvestigate
            newSand.forEach { grid.update(at: $0, with: "=") }

            let investigateNext = findPotentialSand()
            if investigateNext == toInvestigate {
                toInvestigate = [] // done
            } else {
                toInvestigate = investigateNext
            }
        }
    }


    private func createTrees() {
        // find our search area. since we need at least 2 points vertically and horizontally, move space in
        let searchSpace: [Coordinate] = (2..<grid.yBounds.upperBound - 2).flatMap { y in
            (2..<grid.xBounds.upperBound - 2).map { x in
                Coordinate(x: x, y: y)
            }
        }

        let nope = [".", "="] // nothing sand or water

        // look through search space looking for our pattern
        for c in searchSpace {
            let surrounding = treeSearchArea(at: c)

            // if we find water in the search area, we don't plant a tree
            let testLambda: ((Coordinate) -> Bool) = {
                guard let i = self.grid.item(at: $0) else { return false }
                return nope.contains(i)
            }

            if surrounding.first(where: testLambda) == nil {
                grid.update(at: c, with: "@")
            }
        }
    }

    private func growForest() {
        var plantingSpots: Set<Coordinate> = []

        // find all land spots
        let land = grid.filter(by: { $1 == "#" })

        // find places to plant trees
        for c in land {
            let adj = grid.adjacentItems(to: c)
            // this is a plantable spot if there are no adjacent sand spots
            // AND at least 4+ neighbors are already trees
            if adj.count(where: { $0 == "=" }) == 0 && adj.count(where: { $0 == "@" }) >= 4 {
                plantingSpots.insert(c)
            }
        }

        plantingSpots.forEach { grid.update(at: $0, with: "@") }
    }


    // MARK: - Helpers

    // Tree search area looks a bit like this...
    // Ignore `.` and `X` (this coordinate)
    // Find   `+`
    //
    // .+++.
    // +++++
    // ++X++
    // +++++
    // .+++.
    private func treeSearchArea(at coordinate: Coordinate) -> [Coordinate] {
        ((coordinate.y - 2)...(coordinate.y + 2)).flatMap { y in
            ((coordinate.x - 2)...(coordinate.x + 2)).compactMap { x -> Coordinate? in
                if (y == coordinate.y - 2 || y == coordinate.y + 2) &&
                    (x == coordinate.x - 2 || x == coordinate.x + 2) {
                    // ignore the corners
                    return nil
                } else if x == coordinate.x && y == coordinate.y {
                    // ignore "self"
                    return nil
                }

                return Coordinate(x: x, y: y)
            }
        }
    }

    private func findPotentialSand() -> [Coordinate] {
        // look for any place within the grid that has land that has 5 or more neighbors.
        grid.filter { c, s in
            guard s == "#" else { return false }
            let adj = grid.adjacentItems(to: c)
            return adj.filter({ $0 == "=" }).count >= 5
        }
    }
}
