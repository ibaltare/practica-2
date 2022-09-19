//
//  CoreDataHelper.swift
//  AppMap
//
//  Created by Nicolas on 17/09/22.
//

import Foundation
import CoreData
import UIKit

final class CoreDataHelper {
    
    static let shared = CoreDataHelper()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    func save(heroes: [Hero]) throws {
        for hero in heroes {
            if heroToEntityHeroMapper(hero) != nil {
                try self.context.save()
            }
        }
    }
    
    func saveHeroes2(heroes: [Hero]) {
        for hero in heroes {
            if heroToEntityHeroMapper( hero) != nil {
                do {
                    try self.context.save()
                }
                catch {
                    print("error al guardar datos")
                    break
                }
            }
        }
    }
    
    func getLocalHeroes() throws -> [EntityHero] {
            let heroes = try context.fetch(EntityHero.fetchRequest())
            return heroes
    }
    
    func heroToEntityHeroMapper(_ hero: Hero?) -> EntityHero? {
        guard let hero = hero else { return nil }
        let heroEntity = EntityHero(context: self.context)
        heroEntity.name = hero.name
        heroEntity.id = hero.id
        heroEntity.descrip = hero.description
        heroEntity.photo = hero.photo
        heroEntity.favorite = hero.favorite ?? false
        return heroEntity
    }
    
}
