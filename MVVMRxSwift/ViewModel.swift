import Foundation
import RxCocoa
import RxDataSources
import RxSwift

class ViewModel {
    enum NextViewModel {
        case vc2(ViewModel2)
    }

    private let modelLoader: ModelLoading

    let loadTrigger = PublishRelay<Void>()
    let selectedRow = PublishRelay<CustomData>()

    let nextTrigger = PublishRelay<Void>()
    let disposeBag = DisposeBag()

    var sections: Observable<[Section]> = .empty()

    var tableData: Driver<[Section]> {
        sections.asDriver { _ in
            .empty()
        }
    }

    init(modelLoader: ModelLoading) {
        self.modelLoader = modelLoader

        initBindings()
    }

    func initBindings() {
        loadTrigger
            .subscribe(onNext: { [unowned self] _ in
                self.sections = Observable.just([
                    Section(header: "First section", items: [CustomData(title: "Zero"), CustomData(title: "One")]),
                    Section(header: "Second section", items: [CustomData(title: "Two"), CustomData(title: "Three")]),
                ])
            })
            .disposed(by: disposeBag)

        selectedRow
            .subscribe { customDate in
                print(customDate)
            }
            .disposed(by: disposeBag)
    }

    var nextViewModel: Driver<NextViewModel> {
        nextTrigger
            .map { _ in
                NextViewModel.vc2(ViewModel2())
            }
            .asDriver(onErrorRecover: { _ in
                .empty()
            })
    }
}

struct CustomData {
    var title: String
}

struct Section {
    var header: String
    var items: [Item]
}

extension Section: SectionModelType {
    typealias Item = CustomData

    init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
}
