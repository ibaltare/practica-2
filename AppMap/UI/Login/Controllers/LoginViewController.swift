//
//  LoginViewController.swift
//  AppMap
//
//  Created by Nicolas on 09/09/22.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func setCredentials(user: String, password: String)
    func navigateToMap()
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

        viewModel?.onViewsLoaded()
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
    func setCredentials(user: String, password: String) {
            userText.text = user
            passwordText.text = password
    }
    
    func showError(message: String) {
        DispatchQueue.main.sync {
            showAlert(title: "Mensaje", message: message)
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
        }
    }
    
    func navigateToMap() {
        DispatchQueue.main.sync {
            loginButton.isEnabled = true
            activityIndicator.stopAnimating()
            let nextView = MapViewController();
            nextView.viewModel = MapViewModel(viewDelegate: nextView)
            navigationController?.setViewControllers([nextView], animated: true)
        }
    }
    
    
}
