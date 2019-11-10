import UIKit

protocol InfoViewControllerType: class {

}

class InfoViewController: UIViewController {
    
    
    // MARK: - Outlets

    
    // MARK: - Private
    var presenter: InfoPresenterType!
    
    // MARK: - Init
    deinit {
        print("deinit InfoViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigateToRepoButton(_ sender: Any) {
        presenter.navigateToRepo()
    }
    
    @IBAction func logoutButton(_ sender: Any) {
        presenter.logout()
    }
}

extension InfoViewController: InfoViewControllerType {

}
