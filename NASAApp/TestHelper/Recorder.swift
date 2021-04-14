//
//  Recorder.swift
//  NASAApp
//
//  Created by Ludovik on 14/04/2021.
//

import Foundation
import RxSwift

/// Used for testing PublishSubjects from ViewModel
class Recorder<T> {
    var items = [T]()
    let bag = DisposeBag()

    func on(arraySubject: PublishSubject<[T]>) {
        arraySubject.subscribe(onNext: { value in
            self.items = value
        }).disposed(by: bag)
    }

    func on(valueSubject: PublishSubject<T>) {
        valueSubject.subscribe(onNext: { value in
            self.items.append(value)
        }).disposed(by: bag)
    }
}
