//
//  String.swift
//  Errbody Tests
//
//  Created by Shawn Veader on 11/7/26.
//

import Foundation

extension String {
    static func readText(file: String) -> String? {
        let bundle = Bundle(for: SomeDummyClass.self)
        guard let fileURL = bundle.url(forResource: file, withExtension: "txt") else {
            print("File not found in the project bundle.")
            return nil
        }

        do {
            return try String(contentsOf: fileURL, encoding: .utf8)
        } catch {
            print("Error reading file: \(error.localizedDescription)")
            return nil
        }
    }
}
