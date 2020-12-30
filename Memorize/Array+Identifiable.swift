//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by Ievgen Iatsenko on 2020-12-26.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching: Element) -> Int? {
        for i in 0..<count {
            if self[i].id == matching.id {
                return i
            }
        }
        return nil
    }
}

