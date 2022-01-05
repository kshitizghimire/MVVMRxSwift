import Foundation
import RxDataSources

struct ViewModel {
    let sections = [
        Section(header: "First section", items: [CustomData(title: "Zero"), CustomData(title: "One")]),
        Section(header: "Second section", items: [CustomData(title: "Two"), CustomData(title: "Three")]),
    ]
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
