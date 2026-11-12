//
//  QuestThreeTests.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/9/26.
//

import Testing

struct QuestThreeTests {

    @Test("Parse ISO Standard and Value", arguments: [
        ("ISO-3210 7654", "ISO-3210", 7654, [3,2,1,0]),
        ("ISO-8742 2468", "ISO-8742", 2468, [8,7,4,2]),
        ("ISO-1111 1111", "ISO-1111", 1111, [1,1,1,1]),
    ])
    func shouldParseISOStandardAndValue(iso: String, standard: String, value: Int, weights: [Int]) async throws {
        let isoStandard = try #require(QuestThree.ElvenISOValue(input: iso))
        #expect(isoStandard.standard.name == standard)
        #expect(isoStandard.standard.standardWeights == weights)
        #expect(isoStandard.value == value)
    }

    @Test("Calculate ISO Standard value", arguments: [
        ("ISO-3210 7654", 222),
        ("ISO-8742 2468", 1252),
        ("ISO-1111 1111", 4),
        ("ISO-789 2465112", 1158390), // longer
        ("ISO-2341 945", 102), // shorter
        ("ISO-34 140856", 1416),
    ])
    func shouldCalculateISOStandardValue(iso: String, value: Int) async throws {
        let isoStandard = try #require(QuestThree.ElvenISOValue(input: iso))
        #expect(isoStandard.weightedValue == value)
    }

    // MARK: -

    @Test func solvePartOneSampleData() async throws {
        let quest = QuestThree(input: QuestThree.samplePart1)
        let answer = try quest.run(part: 1)
        #expect(answer == 1478)
    }

    @Test func solvePartTwoSampleData() async throws {
        let quest = QuestThree(input: QuestThree.samplePart2)
        let answer = try quest.run(part: 2)
        #expect(answer == 1161463)
    }

    @Test func solvePartThreeSampleData() async throws {
        let quest = QuestThree(input: QuestThree.samplePart3)
        let answer = try quest.run(part: 3)
        #expect(answer == 1161463)
    }


    // MARK: -

    @Test func solvePartOne() async throws {
        let data = try #require(String.readText(file: "quest3_part1"))
        let quest = QuestThree(input: data)
        let answer = try quest.run(part: 1)
        #expect(answer == 13825)
    }

    @Test func solvePartTwo() async throws {
        let data = try #require(String.readText(file: "quest3_part2"))
        let quest = QuestThree(input: data)
        let answer = try quest.run(part: 2)
        #expect(answer == 25682445510)
    }

}
