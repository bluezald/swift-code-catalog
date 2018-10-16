//: Playground - noun: a place where people can play

import UIKit
import RxSwift

var str = "Hello, playground"

_ = Observable.of("Hello World!")

example(of: "creating observables") {
  
  let mostPopular: Observable<String> = Observable<String>.just(episodeV)
  let originalTrilogy = Observable.of(episodeIV, episodeV, episodeVI)
}

example(of: "subscribe") {
  
  let observable = Observable.of(episodeIV, episodeV, episodeVI)
  
//  observable.subscribe({ event in
//    print(event.element ?? event)
//  })
  
  observable.subscribe(onNext: { element in
    print(element)
  })
  
}

example(of: "empty") {
  
  let observable = Observable<Void>.empty()
  
  observable.subscribe(onNext: { element in
    print(element)
  }, onCompleted: {
    print("Completed")
  })
  
}

example(of: "never") {
  
  let observable = Observable<Any>.never()
  
  observable.subscribe(onNext: { element in
    print(element)
  }, onCompleted: {
    print("Completed")
  })
}

example(of: "dispose") {
  
  let mostPopular = Observable.of(episodeIV, episodeV, episodeVI)
  
  let subscription = mostPopular.subscribe(onNext: { event in
    print(event)
  })
  subscription.dispose()
}

example(of: "Dispose Bag") {
  
  let disposeBag = DisposeBag()
  
  Observable.of(episodeIV, episodeV, episodeVI)
    .subscribe {
      print($0)
  }
    .disposed(by: disposeBag)
}

example(of: "Create") {
  
  enum Droid: Error {
    case OU812
  }
  
  let disposeBag = DisposeBag()
  
  Observable<String>.create() { observer in
    
    observer.onNext("R2-D2")
    observer.onNext("C-3PO")
    observer.onNext("K-2SO")
    
    return Disposables.create()
  }
  .subscribe(
    onNext: { print($0) },
    onError: { print("Error", $0) },
    onCompleted: { print("Completed") },
    onDisposed: { print("Disposed") }
  )
  .disposed(by: disposeBag)
  
}

example(of: "Single") {
  
}





