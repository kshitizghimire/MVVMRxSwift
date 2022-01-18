import Foundation
import RxSwift

protocol ModelLoading {
    func load<T: Decodable>(for url: URL, with type: T.Type) -> Observable<T>
}
