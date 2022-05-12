//
//  ViewController.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/09.
//

import UIKit

class ViewController: UIViewController {
    
    // 클로저
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
    }
    
    deinit {
        print("deinit - ViewController")
    }
}

