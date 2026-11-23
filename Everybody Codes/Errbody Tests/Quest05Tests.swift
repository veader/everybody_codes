//
//  Quest05Tests.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/18/26.
//

import Testing

struct Quest05Tests {

    @Test func solvePartOneSampleData() async throws {
        let quest = Quest05(input: Quest05.samplePart1)
        let answer = try quest.run(part: 1)
        #expect(answer == 137)
    }

    @Test func solvePartTwoSampleData() async throws {
        let quest = Quest05(input: Quest05.samplePart2)
        let answer = try quest.run(part: 2)
        #expect(answer == 69)
    }

//    @Test func solvePartThreeSampleData() async throws {
//        let quest = Quest04(input: Quest04.samplePart3)
//        let answer = try quest.run(part: 3)
//        #expect(answer == 2998)
//    }


    // MARK: -
    @Test func solvePartOne() async throws {
        let data = try #require(String.readText(file: "quest5_part1"))
        let quest = Quest05(input: data)
        let answer = try quest.run(part: 1)
        #expect(answer == 1255)
    }

    @Test func solvePartTwo() async throws {
        let data = try #require(String.readText(file: "quest5_part2"))
        let quest = Quest05(input: data)
        let answer = try quest.run(part: 2)
        #expect(answer == 1096)
        // 1096 (not correct) correct: length and first digit
    }

//    @Test func solvePartThree() async throws {
//        let data = try #require(String.readText(file: "quest5_part3"))
//        let quest = Quest05(input: data)
//        let answer = try quest.run(part: 3)
//        #expect(answer == 6229092)
//    }

}
