//
//  Quest02Tests.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/8/26.
//

import Testing

struct Quest02Tests {

    @Test func solvePartOneSampleData() async throws {
        let quest = Quest02(input: Quest02.sampleData(1))
        let answer = try quest.run(part: 1)
        #expect(answer == 122157)
    }

    @Test func solvePartTwoSampleData() async throws {
        let quest = Quest02(input: Quest02.sampleData(2))
        let answer = try quest.run(part: 2)
        #expect(answer == 122157)
    }

    @Test func solvePartThreeSampleData() async throws {
        let quest = Quest02(input: Quest02.sampleData(3))
        let answer = try quest.run(part: 3)
        #expect(answer == 122157)
    }


    // MARK: -
    @Test func solvePartOne() async throws {
        let data = try #require(String.readText(file: "quest2_part1"))
        let quest = Quest02(input: data)
        let answer = try quest.run(part: 1)
        #expect(answer == 302604)
    }

    @Test func solvePartTwo() async throws {
        let data = try #require(String.readText(file: "quest2_part2"))
        let quest = Quest02(input: data)
        let answer = try quest.run(part: 2)
        #expect(answer == 60415334487)
    }

    @Test func solvePartThree() async throws {
        let data = try #require(String.readText(file: "quest2_part3"))
        let quest = Quest02(input: data)
        let answer = try quest.run(part: 3)
        #expect(answer == 616325837283)
    }

}
