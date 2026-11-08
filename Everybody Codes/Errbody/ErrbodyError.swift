//
//  ErrbodyError.swift
//  errbody
//
//  Created by Shawn Veader on 11/8/26.
//

import Foundation

enum ErrbodyError: Error {
    case unknownQuest(Int?)
}

extension ErrbodyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknownQuest(let questNum):
            if let questNum {
                return String(localized: "Unknown Quest. Given quest: \(questNum)")
            } else {
                return String(localized: "Unknown Quest. No quest given.")
            }
        }
    }
}
