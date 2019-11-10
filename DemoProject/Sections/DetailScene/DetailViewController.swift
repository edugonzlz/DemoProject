import UIKit

protocol DetailViewControllerType: class {
    func present(item: DetailItem)
}

class DetailViewController: UIViewController {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var aliasTextField: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - Private
    var presenter: DetailPresenterType!
    
    // MARK: - Init
    deinit {
        print("deinit DetailViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getData()
        aliasTextField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
    }
    
    @objc private func textFieldDidChange(textfield: UITextField) {
        presenter.set(newAlias: textfield.text)
    }
}

extension DetailViewController: DetailViewControllerType {
    func present(item: DetailItem) {
        aliasTextField.text = item.name
        idLabel.text = item.id
        balanceLabel.text = item.balance
        balanceLabel.textColor = item.balance.contains("-") ? .red : .gray
    }

}
