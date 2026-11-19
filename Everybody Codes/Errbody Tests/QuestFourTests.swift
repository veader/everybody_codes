//
//  QuestFourTests.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/15/26.
//

import Testing

struct QuestFourTests {

    @Test func solvePartOneSampleData() async throws {
        let quest = QuestFour(input: QuestFour.samplePart1)
        let answer = try quest.run(part: 1)
        #expect(answer == 27598)
    }

    @Test func solvePartTwoSampleData() async throws {
        let quest = QuestFour(input: QuestFour.samplePart2)
        let answer = try quest.run(part: 2)
        #expect(answer == 6470)
    }

    @Test func solvePartThreeSampleData() async throws {
        let quest = QuestFour(input: QuestFour.samplePart3)
        let answer = try quest.run(part: 3)
        #expect(answer == 2998)
    }

    @Test func solvePartThreeSampleData2() async throws {
        let quest = QuestFour(input: QuestFour.samplePart3_2)
        let answer = try quest.run(part: 3)
        #expect(answer == 3004)
    }


    // MARK: -
    @Test func solvePartOne() async throws {
        let data = try #require(String.readText(file: "quest4_part1"))
        let quest = QuestFour(input: data)
        let answer = try quest.run(part: 1)
        #expect(answer == 192386)
    }

    @Test func solvePartTwo() async throws {
        let data = try #require(String.readText(file: "quest4_part2"))
        let quest = QuestFour(input: data)
        let answer = try quest.run(part: 2)
        #expect(answer == 587022019)
    }

    @Test func solvePartThree() async throws {
        let data = try #require(String.readText(file: "quest4_part3"))
        let quest = QuestFour(input: data)
        let answer = try quest.run(part: 3)
        #expect(answer == 6229092)
    }
}
