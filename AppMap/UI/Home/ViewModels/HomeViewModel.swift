//
//  HomeViewModel.swift
//  AppMap
//
//  Created by Nicolas on 16/09/22.
//

import Foundation

protocol HomeViewModelProtocol {
    func onViewLoaded()
    func onSignOutAction()
}

final class HomeViewModel {
    private weak var viewDelegate: HomeViewProtocol?
    
    init(viewDelegate: HomeViewProtocol){
        self.viewDelegate = viewDelegate
    }
    
    private func downloadHeroes() {
        
        struct Body: Encodable {
          let name: String
        }
        
        let body = try? JSONEncoder().encode(Body(name: ""))
        
        guard let data = KeyChain.standar.read(service: KeyChain.SERVICE_TOKEN, account: KeyChain.ACCOUNT),
              let token = String(data: data, encoding: .utf8) else {
            self.viewDelegate?.showMessage("Error al leer las credenciales guardadas")
            return
        }
        
        NetworkHelper.shared.networkCall(uri: ApiURL.HEROS_ALL,
                                         method: "POST",
                                         authentication: "Bearer",
                                         credentials: token,
                                         jsonRequest: true,
                                         body: body) { [weak self] data, error in
            
            if let error = error {
                self?.viewDelegate?.showMessage(error.rawValue)
            }
            
            guard let data = data else {
                self?.viewDelegate?.showMessage("Error en la respuesta del servidor")
                return
                
            }
            
            guard let heroesResponse = try? JSONDecoder().decode([Hero].self, from: data) else {
                self?.viewDelegate?.showMessage("Error Interno")
                return
            }
            
            do {
                try CoreDataHelper.shared.save(heroes: heroesResponse)
            } catch {
                self?.viewDelegate?.showMessage("Error al guardar los datos")
            }
        }
        
    }
    
}

extension HomeViewModel: HomeViewModelProtocol {
    func onViewLoaded(){
        do {
            let heroes = try CoreDataHelper.shared.getLocalHeroes()
            if heroes.count == 0 {
                downloadHeroes()
            } else {
              //load table
                print("load table \(heroes.count)")
            }
        } catch {
            self.viewDelegate?.showMessage("Error al leer los datos")
        }
    }
    
    func onSignOutAction() {
        KeyChain.standar.delete(service: KeyChain.SERVICE_TOKEN, account: KeyChain.ACCOUNT)
        viewDelegate?.navigateToLogin()
    }
    
    
}
