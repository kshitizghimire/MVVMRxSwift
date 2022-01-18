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

    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadTrigger.accept(())

        configureDisplay()
        configurePresentation()
        configureInteraction()
    }

    func configureDisplay() {
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = nil
        tableView.dataSource = nil

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: nil, action: nil)
    }

    func configurePresentation() {
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { _, tableView, indexPath, item in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                cell.textLabel?.text = "Item \(item.title)"
                return cell
            })

        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }

        viewModel.tableData
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        viewModel.nextViewModel
            .drive { [unowned self] _ in
                self.show(UIViewController(), sender: self)
            }
            .disposed(by: disposeBag)
    }

    func configureInteraction() {
        tableView.rx.modelSelected(CustomData.self)
            .bind(to: viewModel.selectedRow)
            .disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx.tap
            .bind(to: viewModel.nextTrigger)
            .disposed(by: disposeBag)

        button.rx.controlEvent(.primaryActionTriggered)
            .bind(to: viewModel.loadTrigger)
            .disposed(by: disposeBag)
    }
}

class Cell: UITableViewCell {}
