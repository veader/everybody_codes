//
//  QuestFour.swift
//  Everybody Codes
//
//  Created by Shawn Veader on 11/15/26.
//

import Foundation
import RegexBuilder

class QuestFour: Questable {

    static let samplePart1 = """
        id=1 quest=1 part=1 time=187
        id=3 quest=1 part=1 time=413
        id=5 quest=1 part=3 time=744
        id=2 quest=1 part=3 time=745
        id=4 quest=1 part=2 time=558
        id=1 quest=1 part=2 time=299
        id=1 quest=1 part=3 time=362
        id=4 quest=1 part=3 time=1268
        id=4 quest=1 part=1 time=457
        id=5 quest=1 part=1 time=257
        id=2 quest=1 part=1 time=192
        id=3 quest=1 part=3 time=1168
        id=5 quest=1 part=2 time=346
        id=3 quest=1 part=2 time=455
        id=2 quest=1 part=2 time=562
        """

    static let samplePart2 = """
        id=2 quest=1 part=1 time=100
        id=4 quest=2 part=1 time=150
        id=1 quest=2 part=1 time=140
        id=1 quest=1 part=2 time=180
        id=2 quest=2 part=1 time=130
        id=4 quest=1 part=1 time=110
        id=1 quest=2 part=2 time=210
        id=2 quest=2 part=2 time=240
        id=1 quest=2 part=3 time=330
        id=2 quest=1 part=2 time=170
        id=3 quest=1 part=1 time=90
        id=4 quest=1 part=2 time=175
        id=3 quest=2 part=1 time=120
        id=1 quest=1 part=1 time=120
        id=3 quest=2 part=2 time=220
        id=2 quest=2 part=3 time=350
        id=3 quest=1 part=2 time=160
        """
    static let samplePart3 = """
        id=2 quest=1 part=1 time=100
        id=4 quest=2 part=1 time=150
        id=1 quest=2 part=1 time=140
        id=1 quest=1 part=2 time=180
        id=2 quest=2 part=1 time=130
        id=4 quest=1 part=1 time=110
        id=1 quest=2 part=2 time=210
        id=2 quest=2 part=2 time=240
        id=1 quest=2 part=3 time=330
        id=2 quest=1 part=2 time=170
        id=3 quest=1 part=1 time=90
        id=4 quest=1 part=2 time=175
        id=3 quest=2 part=1 time=120
        id=1 quest=1 part=1 time=120
        id=3 quest=2 part=2 time=220
        id=2 quest=2 part=3 time=350
        id=3 quest=1 part=2 time=160
        """

    static let samplePart3_2 = """
        id=2 quest=1 part=1 time=90
        id=4 quest=2 part=1 time=150
        id=1 quest=2 part=1 time=130
        id=1 quest=1 part=2 time=180
        id=2 quest=2 part=1 time=130
        id=4 quest=1 part=1 time=110
        id=1 quest=2 part=2 time=210
        id=2 quest=2 part=2 time=220
        id=1 quest=2 part=3 time=330
        id=2 quest=1 part=2 time=170
        id=3 quest=1 part=1 time=90
        id=4 quest=1 part=2 time=170
        id=3 quest=2 part=1 time=120
        id=1 quest=1 part=1 time=120
        id=3 quest=2 part=2 time=220
        id=2 quest=2 part=3 time=350
        id=3 quest=1 part=2 time=170
        """

    struct ElvenQuestTiming {
        /// identifier of the elf
        let id: Int

        /// Which quest they performed
        let quest: Int

        /// Which part of the quest they performed
        let part: Int

        /// How long it took (in seconds)
        let time: Int

        init?(_ input: String) {
            let regex = /id=(\d+)\squest=(\d+)\spart=(\d+)\stime=(\d+)/
            guard
                let match = input.firstMatch(of: regex),
                let inputID = Int(match.1),
                let inputQuest = Int(match.2),
                let inputPart = Int(match.3),
                let inputTime = Int(match.4)
            else { return nil }

            self.id = inputID
            self.quest = inputQuest
            self.part = inputPart
            self.time = inputTime
        }
    }

    let input: String
    let timings: [ElvenQuestTiming]

    init(input: String) {
        self.input = input
        self.timings = input.split(separator: "\n").map(String.init).compactMap{ ElvenQuestTiming.init($0) }
    }

    internal func partOne() -> Int {
        // mapping the participant to the sum of all their times
        var participantMap: [Int: Int] = [:]

        for timing in timings {
            var sum = participantMap[timing.id] ?? 0
            sum += timing.time
            participantMap[timing.id] = sum
        }

        // sort participants by their total times
        let sorted = participantMap.sorted { $0.value < $1.value }
        return sorted.enumerated().reduce(0) { partialResult, enumParticipant in
            partialResult + (enumParticipant.offset + 1) * enumParticipant.element.value
        }
    }

    internal func partTwo() -> Int {
        // mapping the participant to the collection of their times
        var participantMap: [Int: (count:Int, sum:Int)] = [:]

        for timing in timings {
            var (count, sum) = participantMap[timing.id] ?? (0,0)
            count += 1
            sum += timing.time
            participantMap[timing.id] = (count, sum)
        }

        // sort participants by the number of events they completed and by least amount of time
        let sorted = participantMap.sorted {
            if $0.value.count > $1.value.count {
                true
            } else if $0.value.count == $1.value.count {
                $0.value.sum < $1.value.sum
            } else {
                false
            }
        }

        return sorted.enumerated().reduce(0) { partialResult, enumParticipant in
            partialResult + (enumParticipant.offset + 1) * enumParticipant.element.value.sum
        }
    }

    internal func partThree() -> Int {
        // mapping from participant to their score(s)
        var scores: [Int: [Int]] = [:]

        // group timings by quest
        var quests: [Int: [ElvenQuestTiming]] = [:]
        for timing in timings {
            let questID = timing.quest
            quests[questID] = (quests[questID] ?? []) + [timing]
        }

        for (_ /*questID*/, timingArray) in quests.sorted(by: { $0.key < $1.key }) {
            // group these quest timings by parts
            var parts: [Int: [ElvenQuestTiming]] = [:]
            for part in timingArray {
                let partID = part.part
                parts[partID] = (parts[partID] ?? []) + [part]
            }

            // mapping from participant for their total time after each part
            var questTimes: [Int: Int] = [:]

            for (partID, partArray) in parts.sorted(by: { $0.key < $1.key }) {
                // max score is 50 for part 1, 100 for part 2, 150 for part 3, etc
                let scoreBase = 50 * partID
                var score = scoreBase

                let sortedParts = partArray.sorted(by: {
                    ((questTimes[$0.id] ?? 0) + $0.time) < ((questTimes[$1.id] ?? 0) + $1.time)
                })
                
                var currentTime = 0
                for (idx, part) in sortedParts.enumerated() {
                    // keep a total time for the participant across parts
                    let totalTime = (questTimes[part.id] ?? 0) + part.time
                    questTimes[part.id] = totalTime

                    // adjust score as we increase time
                    if currentTime > 0 && currentTime < totalTime {
                        let adjustedScore = scoreBase - idx
                        score = (adjustedScore > 0) ? adjustedScore : 0
                    }

                    currentTime = totalTime
                    scores[part.id] = (scores[part.id] ?? []) + [score]
                }
            }
        }

        // build a mapping from the final score to each participant
        var groupedScores: [Int: [Int]] = [:]
        scores.forEach { (playerID, scores) in
            let finalScore = scores.reduce(0, +)
            groupedScores[finalScore] = (groupedScores[finalScore] ?? []) + [playerID]
        }

        let sortedScores = groupedScores.sorted(by: { $0.key > $1.key })
        print(sortedScores)

        var checksum = 0
        var offset = 1 // start at the first one

        for (score, players) in sortedScores {
            checksum += (offset * score) * players.count
            offset += players.count
        }

        return checksum
    }
}
