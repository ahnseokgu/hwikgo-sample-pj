//
//  Dummy.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/12.
//

import Foundation

class ClosurePractice {
    var completionHandlers: [(Int) -> Int] = []
    func someFunctionWithEscapingClosure(completionHandler: @escaping (Int) -> Int) {
        completionHandlers.append(completionHandler)
    }
    
    func someFunctionWithNonescapingClosure(closure: (Int) -> Int) {
        let resultValue = closure(1)
        print(resultValue)
    }
    
    func callFunctionWithEscapingClousre() {
        if let resultValue = completionHandlers.first?(2) {
            print(resultValue)
        }
    }
    
    deinit {
        print("deinit - ClosurePractice")
    }
}
