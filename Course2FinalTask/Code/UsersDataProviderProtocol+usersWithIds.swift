//
//  User+usersByIds.swift
//  Course2FinalTask
//
//  Created by Denis Ravkin on 31.07.2021.
//  Copyright © 2021 e-Legion. All rights reserved.
//

import Foundation
import DataProvider

extension UsersDataProviderProtocol {
    func users(withIds ids: [User.Identifier]) -> [User] {
        var users: [User] = []
        for userId in ids {
            if let user = DataProviders.shared.usersDataProvider.user(with: userId) {
                users.append(user)
            }
        }
        return users
    }
}
