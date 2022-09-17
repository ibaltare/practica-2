//
//  HomeViewController.swift
//  AppMap
//
//  Created by Nicolas on 16/09/22.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func navigateToLogin()
}

final class HomeViewController: UIViewController {

    var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Heroes"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salir",
                                                                 style: .done,
                                                                 target: self,
                                                                 action: #selector(signOut))
    }


    @objc func signOut(){
        viewModel?.onSignOnAction()
    }

}

extension HomeViewController: HomeViewProtocol {
    
    func navigateToLogin() {
        let nextView = LoginViewController();
        nextView.viewModel = LoginViewModel(viewDelegate: nextView)
        navigationController?.setViewControllers([nextView], animated: true)
        
        //UIView.transition(with: nextView, duration: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
    }
    
    
}
