//
//  UserController.swift
//  DiscoverabilityIntro
//
//  Created by Andrew Acton on 3/22/23.
//

import Foundation

class UserController {
    
    static let shared = UserController()
    
    var users: [User] = []
    
    let nameFormatter: PersonNameComponentsFormatter = {
       let formatter = PersonNameComponentsFormatter()
        
        formatter.style = .long
        
        return formatter
    }()
    
    func checkForExistingUserWith(email: String, completion: @escaping (User?) -> Void) {
        
        CloudKitManager.shared.fetchUserIdentityWith(email: email) { userIdentity, error in
            if let error = error { print("Error fetching user identity: \(error.localizedDescription)") }
            
            guard let userIdentity = userIdentity,
                  let nameComponents = userIdentity.nameComponents
            else { completion(nil); return }
            
            let name = self.nameFormatter.string(from: nameComponents)
            
            let user = User(name: name)
            
            completion(user)
        }
    }
    
    func fetchAllDiscoverableUser(completion: @escaping () -> Void) {
        
        CloudKitManager.shared.fetchAllDiscoverableUserIdentities { userIdentities, error in
            if let error = error { print("Error fetching all discoverable user identities: \(error.localizedDescription)") }
            
            let nameComponentsArray = userIdentities.compactMap({ $0.nameComponents })
            
            let formattedNames = nameComponentsArray.map({ self.nameFormatter.string(from: $0) })
            
            let user = formattedNames.map({ User(name: $0) })
            
            self.users = user
            
            completion()
        }
    }
    
}//End Of Class
