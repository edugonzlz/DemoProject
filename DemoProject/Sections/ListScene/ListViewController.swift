import UIKit

protocol ListViewControllerType: class, Loadable, Alertable {
    func present(data: UserTableData)
}

class ListViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: AccountTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: AccountTableViewCell.cellId)
            tableView.register(UINib(nibName: CardTableViewCell.cellId, bundle: nil), forCellReuseIdentifier: CardTableViewCell.cellId)
        }
    }
    
    // MARK: - Private
    var presenter: ListPresenterType!
    var tableData: UserTableData?
    
    // MARK: - Init
    deinit {
        print("deinit ListViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
        tableView.deselectSelectedRow(animated: true)
    }
}

extension ListViewController: ListViewControllerType {
    func present(data: UserTableData) {
        self.title = data.username
        self.tableData = data
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let tableData = tableData else { return 0 }
        return tableData.data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tableData = tableData else { return 0 }
        
        let dataSection = tableData.data[section]
        switch dataSection {
        case .accounts(let items):
            return items.count
        case .cards(let items):
            return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let tableData = tableData else { return "" }
        
        let dataSection = tableData.data[section]
        switch dataSection {
        case .accounts:
            return "Accounts"
        case .cards:
            return "Cards"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableData = tableData else { return UITableViewCell() }
        let dataSection = tableData.data[indexPath.section]

        switch dataSection {
        case .accounts(let items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountTableViewCell.cellId) as? AccountTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: items[indexPath.row])
            return cell
            
        case .cards(let items):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CardTableViewCell.cellId) as? CardTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: items[indexPath.row])
            return cell
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.navigateTo(detail: indexPath)
    }
}
