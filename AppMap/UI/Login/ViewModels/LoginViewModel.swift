//
//  LoginViewModel.swift
//  AppMap
//
//  Created by Nicolas on 09/09/22.
//

import Foundation

protocol LoginViewModelProtocol {
    func onViewsLoaded()
    func onLoginAction(user: String, password: String)
}

final class LoginViewModel {
    private weak var viewDelegate: LoginViewProtocol?
    
    init(viewDelegate: LoginViewProtocol){
        self.viewDelegate = viewDelegate
    }
    
    private func loadCredentials(){
        if let user = LocalData.getEmail(){
            if let data = KeyChain.standar.read(service: KeyChain.SERVICE, account: user) , let pass = String(data: data, encoding: .utf8){
                viewDelegate?.setCredentials(user: user, password: pass)
            }
        }
    }
    
}

extension LoginViewModel: LoginViewModelProtocol {
    func onViewsLoaded() {
        loadCredentials()
    }
    
    
    func onLoginAction(user: String, password: String) {
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            viewDelegate?.showError(message: "Error Interno 1")
            return
        }
                
        let base64LoginString = loginData.base64EncodedString()

        NetworkModel.shared.networkCall(
            uri: ApiURL.LOGIN,
            method: "POST",
            authentication: "Basic",
            credentials: base64LoginString,
            jsonRequest: false,
            body: nil) { [weak self] data, error in
                if let error = error {
                    if let user = LocalData.getEmail(){
                        KeyChain.standar.delete(service: KeyChain.SERVICE, account: user)
                        LocalData.deleteEmail()
                    }
                    self?.viewDelegate?.showError(message: error.rawValue)
                }
                guard let data = data, let token = String(data: data, encoding: .utf8) else {
                    self?.viewDelegate?.showError(message: "Error interno 2")
                    return
                }
                
                NetworkModel.shared.token = token
                LocalData.save(email: user)
                KeyChain.standar.save(data: password, service: KeyChain.SERVICE, account: user)
                
                self?.viewDelegate?.navigateToMap()
                
            }
    }
    
    
}
