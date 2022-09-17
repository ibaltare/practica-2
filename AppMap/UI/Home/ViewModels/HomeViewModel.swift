//
//  HomeViewModel.swift
//  AppMap
//
//  Created by Nicolas on 16/09/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func onSignOnAction()
}

final class HomeViewModel {
    private weak var viewDelegate: HomeViewProtocol?
    
    init(viewDelegate: HomeViewProtocol){
        self.viewDelegate = viewDelegate
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    
    func onSignOnAction() {
        KeyChain.standar.delete(service: KeyChain.SERVICE_TOKEN, account: KeyChain.ACCOUNT)
        viewDelegate?.navigateToLogin()
    }
    
    
}
