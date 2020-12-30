//
//  Array+Only.swift
//  Memorize
//
//  Created by Ievgen Iatsenko on 2020-12-26.
//

import Foundation

extension Array  {
    var only: Element? {
        count == 1 ? first : nil
    }
}
