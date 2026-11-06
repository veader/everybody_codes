//
//  ErrbodyCodes.swift
//  errbvody
//
//  Created by Shawn Veader on 11/5/26.
//

import Foundation

struct ErrbodyCodes {
    static func run(day: Int? = 0, part: Int?, input: String) {
        switch day {
        case 1:
            let day = DayOne(input: input)
            let answer = day.run(part: part ?? 0)
            print("\(answer)")
        default:
            print("")
        }
    }
}
