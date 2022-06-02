//
//  IOViewModel.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/17.
//

import Foundation
import RxSwift
import RxCocoa

// ~Subject는 .completed, .error의 이벤트가 발생하면 subscribe가 종료되는 반면,
// ~Relay는 .completed, .error를 발생하지 않고 Dispose되기 전까지 계속 작동하기 때문에 UI Event에서 사용하기 적절합니다.

//Observable - 방출기능(발생된 이벤트 뿌려줌) onNext, accept등을 통해서 이벤트를 방출 할 수 있어요
//Observer - 구독(이벤트 발생) subscribe, drive등을 통해서 이벤트를 구독 할 수 있어요

class IOViewModel: IOViewModelProtocol {
    struct Input {
        var didTapBtnToggle: Observable<Void>
        var chipsType : Driver<Int>
    }

    struct Output {
        var toggleCount: Driver<Int>
        var chipsType : Driver<Int>
    }

    var disposeBag = DisposeBag()

    func transForm(input: Input) -> Output {
        let toggleCount = BehaviorRelay(value: 0)
        let chipsType = PublishSubject<Int>()
        
        // 비즈니스 로직 처리
        input.didTapBtnToggle.bind(onNext: { _ in
            toggleCount.accept(toggleCount.value + 1)
        }).disposed(by: disposeBag)
        
        input.chipsType
            .drive(chipsType)
            .disposed(by: disposeBag)
        
        chipsType
            .asObservable() 
            .subscribe { value in
                print("CHIPSTYPE - value: \(value)" )
            }
            .disposed(by: disposeBag)
        
        return Output(toggleCount: toggleCount.asDriver(onErrorJustReturn: 0),
                      chipsType: chipsType.asDriverOnErrorNever())
    }
}

extension ObservableType {
    func asDriverOnErrorNever() -> Driver<Element> {
        return asDriver { (error) in
            return .never()
        }
    }
}
