//
//  ErrbodyCodes.swift
//  errbody
//
//  Created by Shawn Veader on 11/5/26.
//

import Foundation

struct ErrbodyCodes {
    static func run(quest: Int? = 0, part: Int?, input: String) {
        do {
            switch quest {
            case 1:
                let q = QuestOne(input: input)
                let answer = try q.run(part: part ?? 0)
                print("\(answer)")
            default:
                print("")
            }
        } catch {
            print("Well, that didn't work right...")
            print("\(error.localizedDescription)")
        }
    }
}
