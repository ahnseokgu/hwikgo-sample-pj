//
//  SecondViewController.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/10.
//

import UIKit
import Combine

class StartViewController: UIViewController {
    var addValue: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .blue
        
        // 클로저
        callClosures()
        
        // MVVM 패턴 : Combine
        callCombine()
    }
    
    func callClosures() {
        var closurePractice:ClosurePractice? = ClosurePractice()

        closurePractice?.someFunctionWithEscapingClosure(completionHandler: { paramValue in
            self.addValue = 100
            return paramValue + self.addValue
        })
        print(addValue)
        
        closurePractice?.someFunctionWithNonescapingClosure(closure: { paramValue in
            addValue = 200
            return paramValue + addValue
        })
        print(addValue)
        
        closurePractice?.callFunctionWithEscapingClousre()
        print(addValue)
        
        closurePractice = nil
    }
    
    func callCombine() {
        let _ = Just(5)
            .sink(receiveValue: { paramValue in
                print(paramValue)
            })
    }
}
