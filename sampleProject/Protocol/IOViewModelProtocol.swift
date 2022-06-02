//
//  IOViewModelProtocol.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/17.
//

import Foundation
import RxSwift

protocol IOViewModelProtocol {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transForm(input: Input) -> Output
}
