//
//  ViewModel.swift
//  MVVMRxSwift
//
//  Created by Tiz on 25/12/21.
//

import Foundation
import RxDataSources

struct ViewModel {
    let sections = [
        SectionOfCustomData(header: "First section", items: [CustomData(title: "Zero"), CustomData(title: "One")]),
        SectionOfCustomData(header: "Second section", items: [CustomData(title: "Two"), CustomData(title: "Three")]),
    ]
}

struct CustomData {
    var title: String
}

struct SectionOfCustomData {
    var header: String
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
    typealias Item = CustomData

    init(original: SectionOfCustomData, items: [Item]) {
        self = original
        self.items = items
    }
}
