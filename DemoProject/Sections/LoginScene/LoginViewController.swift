import UIKit

protocol LoginViewControllerType: class, Loadable, Alertable, Dimissisible {
    func usernameIsValid(error: String?)
    func passwordIsValid(error: String?)
    func enableLoginButton(_ enable:Bool)
}

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var usernameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Private
    var presenter: LoginPresenterType!
    
    // MARK: - Init
    
    deinit {
        print("deinit LoginViewController")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        presenter.loginButtonTapped()
    }
}

extension LoginViewController: LoginViewControllerType {
    func enableLoginButton(_ enable: Bool) {
        loginButton.isEnabled = enable
    }
    func usernameIsValid(error: String?) {
        usernameErrorLabel.text = error
    }
    func passwordIsValid(error: String?) {
        passwordErrorLabel.text = error
    }
}

private extension LoginViewController {
    @objc func textFieldDidChange(_ textfield: UITextField) {
        if textfield == usernameTextfield {
            presenter.username(usernameTextfield.text)
        } else if textfield == passwordTextfield {
            presenter.password(passwordTextfield.text)
        }
    }
    
    func configureViews() {
        loginButton.isEnabled = false
        usernameTextfield.delegate = self
        usernameTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        passwordTextfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEqual(usernameTextfield), let text = textField.text {
            usernameTextfield.text = (text as NSString).replacingCharacters(in: range, with: string.uppercased())
            textFieldDidChange(textField)
            return false
        }
        return true
    }

}
