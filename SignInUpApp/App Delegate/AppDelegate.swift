//
//  AppDelegate.swift
//  SignInUpApp
//
//  Created by Kate on 23/08/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

import CoreData


var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "MyModel") // Имя должно совпадать с именем вашего .xcdatamodeld файла
    container.loadPersistentStores(completionHandler: { _, error in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

func saveUser(userModel: UserModel) {
    let context = persistentContainer.viewContext
    let userEntity = NSEntityDescription.entity(forEntityName: "User", in: context)!
    let user = NSManagedObject(entity: userEntity, insertInto: context)

    user.setValue(userModel.name, forKey: "name")
    user.setValue(userModel.email, forKey: "email")
    user.setValue(userModel.pass, forKey: "pass")

    do {
        try context.save()
    } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
    }
}

func fetchUsers() -> [UserModel] {
    let context = persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    var users: [UserModel] = []

    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            let name = data.value(forKey: "name") as? String
            let email = data.value(forKey: "email") as! String
            let pass = data.value(forKey: "pass") as! String

            users.append(UserModel(name: name, email: email, pass: pass))
        }
    } catch {
        print("Failed fetching")
    }

    return users
}
