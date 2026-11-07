//
//  Questable.swift
//  errbody
//
//  Created by Shawn Veader on 11/7/26.
//

import Foundation

enum QuestError: Error {
    case unknownPart(Int)
}

protocol Questable {
    associatedtype QuestReturn

    var input: String { get }

    func run(part: Int) throws -> QuestReturn

    func partOne() -> QuestReturn
    func partTwo() -> QuestReturn
    func partThree() -> QuestReturn
}

extension Questable {
    func run(part: Int) throws -> QuestReturn {
        switch part {
        case 1:
            return partOne()
        case 2:
            return partTwo()
        case 3:
            return partThree()
        default:
            throw QuestError.unknownPart(part)
        }
    }
}
