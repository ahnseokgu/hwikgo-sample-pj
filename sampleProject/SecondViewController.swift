//
//  SecondViewController.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/10.
//

import UIKit
import Combine

class SecondViewController: UIViewController {
    var addValue: Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .blue
        
        // 클로저
        testClosures()
        
        // MVVM 패턴
//        testMVVMPatten()
        
        // RxSwift 패턴 사용
    }
    
    func testClosures() {
        var mainViewController:ViewController? = ViewController()

        mainViewController?.someFunctionWithEscapingClosure(completionHandler: { paramValue in
            self.addValue = 100
            return paramValue + self.addValue
        })
        print(addValue)
        
        mainViewController?.someFunctionWithNonescapingClosure(closure: { paramValue in
            addValue = 200
            return paramValue + addValue
        })
        print(addValue)
        
        mainViewController?.callFunctionWithEscapingClousre()
        print(addValue)
        
        mainViewController = nil
    }
    
    func testMVVMPatten() {
        let _ = Just(5)
            .sink(receiveValue: { paramValue in
                print(paramValue)
            })
    }
}
