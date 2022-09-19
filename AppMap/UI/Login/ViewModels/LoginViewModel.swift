//
//  LoginViewModel.swift
//  AppMap
//
//  Created by Nicolas on 09/09/22.
//

import Foundation

protocol LoginViewModelProtocol {
    func onViewLoaded()
    func onLoginAction(user: String, password: String)
}

final class LoginViewModel {
    private weak var viewDelegate: LoginViewProtocol?
    
    init(viewDelegate: LoginViewProtocol){
        self.viewDelegate = viewDelegate
    }
    
    private func loadCredentials(){
        if KeyChain.standar.read(service: KeyChain.SERVICE_TOKEN, account: KeyChain.ACCOUNT) != nil{
            viewDelegate?.redirect()
        }
    }
    
}

extension LoginViewModel: LoginViewModelProtocol {
    
    func onViewLoaded() {
        loadCredentials()
    }
    
    func onLoginAction(user: String, password: String) {
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            viewDelegate?.showError(message: "Error al crear credenciales")
            return
        }
                
        let base64LoginString = loginData.base64EncodedString()

        NetworkHelper.shared.networkCall(
            uri: ApiURL.LOGIN,
            method: "POST",
            authentication: "Basic",
            credentials: base64LoginString,
            jsonRequest: false,
            body: nil) { [weak self] data, error in
                
                if let error = error {
                    self?.viewDelegate?.showError(message: error.rawValue)
                }
                
                guard let data = data, let token = String(data: data, encoding: .utf8) else {
                    self?.viewDelegate?.showError(message: "Error en la respuesta del servidor")
                    return
                }
                
                KeyChain.standar.save(data: token, service: KeyChain.SERVICE_TOKEN, account: KeyChain.ACCOUNT)
                
                self?.viewDelegate?.navigateToHome()
                
            }
    }
    
    
}
