//
//  Even.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/09.
//

import Foundation

struct Even {
    let number: Int
    var isEven: Bool {
        get {
            return number % 2 == 0
        }
    }
}
