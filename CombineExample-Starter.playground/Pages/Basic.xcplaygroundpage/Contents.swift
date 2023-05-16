import Combine
import Foundation

check("Empty") {
    Empty<Int, SampleError>()
}

check("Just") {
    Just("Hello SwiftUI")
}

check("Sequence") {
    Publishers.Sequence<[Int] ,Never>(sequence: [1,2,3])
}

check("Array") {
    [1 ,2 ,3].publisher
}

check("Map") {
    [1,2,3]
        .publisher
        .map { $0 * 2 }
}

check("Map Just") {
    Just(5)
        .map{ $0 * 2 }
}

check("Reduce") {
    [1 ,2 ,3, 4, 5].publisher.reduce(0, +)
}

check("Scan") {
    [1 ,2, 3, 4, 5].publisher.scan(0, +)
}

check("Compact Map") {
    ["1" ,"2" ,"3", "cat", "5"]
        .publisher
        .compactMap { Int($0) }
}

check("Flat Map 1") {
    [[1 ,2 ,3], ["a", "b", "c"]]
        .publisher
        .flatMap {
            $0.publisher
        }
}

check("Flat Map 2") {
    ["A", "B", "C"]
        .publisher
        .flatMap { letter in
            [1, 2, 3]
                .publisher
                .map {
                    "\(letter)\($0)"
                }
        }
}

check("Remove Duplicates") {
    ["S", "Sw", "Sw", "Sw", "Swi", "Swif", "Swift", "Swift", "Swif"]
        .publisher
        .removeDuplicates()
}

check("Fail") {
    Fail<Int, SampleError>(error: .sampleError)
}

//check("Map Error") {
//    Fail<Int, SampleError>(error: .sampleError)
//        .mapError { _ in MyError.myerror }
//}

//check("Throw") {
//    ["1" ,"2" ,"swift", "4"].publisher
//        .tryMap { s -> Int in
//            guard let value = Int(s) else {
//                throw MyError.myError
//            }
//            return value
//        }
//}

check("Replace Error") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw SampleError.sampleError
            }
            return value
        }
        .replaceError(with: -1)
}

check("Catch with Just") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw SampleError.sampleError
            }
            return value
        }
        .catch { _ in
            Just(-1)
        }
}

check("Catch with Another Publisher") {
    ["1", "2", "Swift", "4"].publisher
        .tryMap { s -> Int in
            guard let value = Int(s) else {
                throw SampleError.sampleError
            }
            return value
        }
        .catch { _ in
            [-1 ,-2 ,-3].publisher
        }
}


check("Catch and Continue") {
    ["1", "2", "Swift", "4"].publisher
        .print("[Original]")
        .flatMap { s in
            return Just(s)
                .tryMap { s -> Int in
                    guard let value = Int(s) else {
                        throw SampleError.sampleError
                    }
                    return value
                }
                .print("[TryMap]")
                .catch { _ in
                    Just(-1).print("[Just]")
                }.print("[Catch]")
        }
}


check("Filter") {
    [1,2,3,4,5].publisher
        .filter { $0 % 2 == 0 }
}

check("Contains") {
    [1,2,3,4,5].publisher
        .print("[Original]")
        .contains(3)
}

check("Timer") {
    [1: "A", 2: "B", 3: "C"].timerPublisher
        .merge(with: [4: "D", 5: "E", 6: "F"].timerPublisher)
}

let s1 = check("Subject") {
    () -> PassthroughSubject<Int ,Never> in
    let subject = PassthroughSubject<Int ,Never>()
    delay(1, on: .main) {
        subject.send(1)
        delay(1, on: .main) {
            subject.send(2)
            delay(1, on: .main) {
                subject.send(completion: .finished)
            }
        }
    }
    return subject
}

let subject_example1 = PassthroughSubject<Int, Never>()
let subject_example2 = PassthroughSubject<Int, Never>()

check("Subject Order") {
    subject_example1.merge(with: subject_example2)
}

subject_example2.send(20)
subject_example2.send(1)
subject_example1.send(40)
subject_example1.send(60)
subject_example2.send(1)
subject_example1.send(80)
subject_example1.send(100)
subject_example1.send(completion: .finished)
subject_example2.send(completion: .finished)

func loadPage(url: URL, handler: @escaping(Data?, URLResponse?,Error?) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        handler(data ,response,error)
    }.resume()
}

let future = check("Future") {
    Future<(Data, URLResponse) ,Error> { promise in
        loadPage(url: URL(string: "https://example.com")!) { data, response, error in
            
        }
    }
}

