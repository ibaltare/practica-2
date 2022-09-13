//
//  HeroModel.swift
//  AppMap
//
//  Created by Nicolas on 09/09/22.
//

import Foundation

struct HeroModel: Decodable {
    let id: String
    let name: String
    let description: String
    let photo: URL
    let favorite: Bool?
}
