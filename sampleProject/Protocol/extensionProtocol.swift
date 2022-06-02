//
//  extensionProtocol.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/16.
//

import Foundation

// https://swift-it-world.tistory.com/21

protocol ExtensionProtocol {
    func testMethod()
}

extension ExtensionProtocol {
    func testMethod() {
        print("ExtensionProtocol")
    }
}
