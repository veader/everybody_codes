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
    /// The generic type used for the return of this quest
    associatedtype QuestReturn

    /// Sample data to be used during initial testing
    static var samplePart1: String { get }
    static var samplePart2: String { get }
    static var samplePart3: String { get }

    /// Storage for the input to the quest (provided by the user)
    var input: String { get }

    /// Run a part of our quest and seek the answer
    func run(part: Int) throws -> QuestReturn

    func partOne() -> QuestReturn
    func partTwo() -> QuestReturn
    func partThree() -> QuestReturn
}

extension Questable {
    /// Run a part of our quest and seek the answer
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

    /// Simple mechanism to get default sample data per part
    static func sampleData(_ part: Int) -> String {
        switch part {
        case 1:
            Self.samplePart1
        case 2:
            Self.samplePart2
        case 3:
            Self.samplePart3
        default:
            ""
        }
    }
}
