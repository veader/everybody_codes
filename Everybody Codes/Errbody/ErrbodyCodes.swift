//
//  ErrbodyCodes.swift
//  errbody
//
//  Created by Shawn Veader on 11/5/26.
//

import Foundation

struct ErrbodyCodes {
    static func run(quest questNum: Int?, part: Int, useSampleData: Bool, input: String) {
        do {
            guard let questNum else { throw ErrbodyError.unknownQuest(questNum) }
            var quest: any Questable

            switch questNum {
            case 1:
                quest = Quest01(input: useSampleData ? Quest01.sampleData(part) : input)
            case 2:
                quest = Quest02(input: useSampleData ? Quest02.sampleData(part) : input)
            default:
                throw ErrbodyError.unknownQuest(questNum)
            }

            let answer = try quest.run(part: part)
            print("\(answer)")
        } catch {
            print("Well, that didn't work right...")
            print("\(error.localizedDescription)")
        }
    }
}
