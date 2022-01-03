//
//  ViewController.swift
//  MVVMRxSwift
//
//  Created by Tiz on 25/12/21.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class ViewController: UITableViewController {
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let viewModel: ViewModel
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        let dataSource = RxTableViewSectionedReloadDataSource<SectionOfCustomData>(
            configureCell: { _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.text = "Item \(item.title)"
                return cell
            })

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }

        tableView.delegate = nil
        tableView.dataSource = nil

        Observable.just(viewModel.sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

class Cell: UITableViewCell {}
