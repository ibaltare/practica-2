//
//  LoginViewController.swift
//  AppMap
//
//  Created by Nicolas on 09/09/22.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func navigateToHome()
    func redirect()
    func showError(message: String)
}

final class LoginViewController: UIViewController {

    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.onViewLoaded()
    }

    @IBAction func loginAction(_ sender: Any) {
        if let user = userText.text, let pass = passwordText.text {
            if !user.isEmpty, !pass.isEmpty{
                loginButton.isEnabled = false
                activityIndicator.startAnimating()
                viewModel?.onLoginAction(user: user, password: pass)
            }
        }
    }

}

extension LoginViewController: LoginViewProtocol {
    
    func redirect() {
        let nextView = HomeViewController();
        nextView.viewModel = HomeViewModel(viewDelegate: nextView)
        navigationController?.setViewControllers([nextView], animated: true)
    }
    
    func showError(message: String) {
        DispatchQueue.main.sync {
            showAlert(title: "Mensaje", message: message)
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
        }
    }
    
    func navigateToHome() {
        DispatchQueue.main.sync {
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
            redirect()
        }
    }
    
    
}
