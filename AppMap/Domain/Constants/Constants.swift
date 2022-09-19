//
//  Constants.swift
//  AppMap
//
//  Created by Nicolas on 09/09/22.
//

import Foundation

enum ApiURL {
    static let LOGIN = "https://vapor2022.herokuapp.com/api/auth/login"
    static let HEROS_ALL = "https://vapor2022.herokuapp.com/api/heros/all"
    static let HEROS_LOCATIONS = "https://vapor2022.herokuapp.com/api/heros/locations"
}

enum NetworkError: String {
    case malformedURL = "Error en URL"
    case errorResponse = "Error de conexión"
    case notAuthenticated = "Error de Autenticación"
}
