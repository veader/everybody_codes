//
//  QuestOneTests.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/7/26.
//

import Testing

struct QuestOneTests {

    @Test func solvePartOneSampleData() async throws {
        let quest = QuestOne(input: QuestOne.samplePart1)
        let answer = try quest.run(part: 1)
        #expect(answer == 11)
    }

    @Test func solvePartTwoSampleData() async throws {
        let quest = QuestOne(input: QuestOne.samplePart2)
        let answer = try quest.run(part: 2)
        #expect(answer == 9)
    }

    @Test func solvePartThreeSampleData() async throws {
        let quest = QuestOne(input: QuestOne.samplePart3)
        let answer = try quest.run(part: 3)
        #expect(answer == 61)
    }


    // MARK: -
    @Test func solvePartOne() async throws {
        let data = try #require(String.readText(file: "quest1_part1"))
        let quest = QuestOne(input: data)
        let answer = try quest.run(part: 1)
        #expect(answer == 1277)
    }

    @Test func solvePartTwo() async throws {
        let data = try #require(String.readText(file: "quest1_part2"))
        let quest = QuestOne(input: data)
        let answer = try quest.run(part: 2)
        #expect(answer == 297)
    }

    @Test func solvePartThree() async throws {
        let data = try #require(String.readText(file: "quest1_part3"))
        let quest = QuestOne(input: data)
        let answer = try quest.run(part: 3)
        #expect(answer == 637995)
    }
}
