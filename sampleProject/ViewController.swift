//
//  ViewController.swift
//  sampleProject
//
//  Created by iOS_Hwik on 2022/05/09.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    enum MyError: Error {
        case anError
    }
    
    @IBOutlet weak var ButtonOne: UIButton!
    
    @IBOutlet weak var ButtonTow: UIButton!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var labelOne: UILabel!
    
    // 일반 RxSwift
//    let disposeBag = DisposeBag()
    
    // RxSwift 이벤트
    let disposeBag = DisposeBag()
    private let viewModel = IOViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 일반 RxSwift
//        ButtonOne.addTarget(self, action: #selector(clickRxSwiftObservable), for: .touchUpInside)
        ButtonTow.addTarget(self, action: #selector(clickRxSwiftPublishSubject), for: .touchUpInside)
        
        // RxSwift 이벤트
        bindIOViewModel()
    }
    
    // 일반 RxSwift
    @objc func clickRxSwiftObservable() {
        testRxSwiftObservableJust()
    }
    
    @objc func clickRxSwiftPublishSubject() {
//        testRxSwiftPublishSubject()
//        testRxSwiftBehaviorPublishSubject()
        
        clickChips.onNext(1)
    }
    
    func testRxSwiftObservableJust() {
        Observable.just("800x600")
            .map { $0.replacingOccurrences(of: "x", with: "/") }
            .map { "https://picsum.photos/\($0)?random" }
            .map { URL(string: $0) }
            .filter { $0 != nil }
            .map { $0! }
            .map { try Data(contentsOf:  $0) }
            .map { UIImage(data:$0) }
            .subscribe(onNext: { image in
                var _: UIImage? = image
                print("success - subscribe")
            })
            .disposed(by: disposeBag)
        
        print("testRxSwiftObservable - end")
    }
    
    func testRxSwiftPublishSubject() {
        let subject = PublishSubject<String>()
        
        // subscribe 생성하면 호출되지 않음
        subject.onNext("test")
        
        let subscriptionOne = subject.subscribe(onNext: { testData in
            print("one: \(testData)")
        })
    
        subject.onNext("1")
        subscriptionOne.dispose()
        subject.onNext("2")
        subject.onCompleted()
        subject.onNext("3")
        
        let subscriptionTow = subject.subscribe(onNext: { testData in
            print("tow: \(testData)")
        })
        
        subject.onNext("4")
        subscriptionTow.dispose()
    }
    
    func testRxSwiftBehaviorPublishSubject() {
        let subject = BehaviorSubject(value: "Initial value")
        let disposeBag = DisposeBag()
        
        // subscribe 생성하면 호출 됨
        subject.onNext("X") // 주석 처리 하면 위 초기화 문구 표시
        
        subject.subscribe { testData in
            print("one: \(testData)")
        }
        .disposed(by: disposeBag)
        
        subject.onError(MyError.anError)
        
        subject.subscribe { testData in
            print("Tow: \(testData)")
        }
        .disposed(by: disposeBag)
    }
    
    private let clickChips = PublishSubject<Int>()
    
    // RxSwift 이벤트
//    private func bindIOViewModel() {
//        let input = IOViewModel.Input (didTapBtnToggle: self.ButtonOne.rx.tap.asObservable())
//        let output = viewModel.transForm(input: input)
//
//        output.toggleCount
//            .map { String($0) }
//            .drive(labelOne.rx.text)
//            .disposed(by: disposeBag)
//    }
    private func bindIOViewModel() {
        let input = IOViewModel.Input (didTapBtnToggle: self.ButtonOne.rx.tap.asObservable(),
                                       chipsType: clickChips.asDriverOnErrorNever())
        let output = viewModel.transForm(input: input)

        output.toggleCount
            .map { String($0) }
            .drive(labelOne.rx.text)
            .disposed(by: disposeBag)
        
        output.chipsType
            .drive { value in
                print("OUTPUT.CHIPSTYPE - value: \(value)" )
            }
            .disposed(by: disposeBag)
        
        let source = output.chipsType.map {
            $0 == 0
        }.asObservable()
        
        let source1 = output.chipsType.map {
            $0 == 1
        }.asObservable()
        
        Observable
            .combineLatest([source,source1])
            .map({ bools -> Bool in
                var returnBool = true
                bools.forEach{ item in
                    if(item == false){
                        returnBool = false
                    }
                }
                return returnBool
            })
            .asDriverOnErrorNever()
            .drive { value in
                print("TRUE:FALSE - \(value)")
            }
            .disposed(by: disposeBag)
    }

}

