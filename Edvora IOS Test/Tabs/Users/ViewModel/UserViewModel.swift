//
//  UserViewModel.swift
//  Edvora IOS Test
//
//  Created by Mroot on 01/09/2022.
//

import Foundation

final class UserViewModel: ObservableObject {
    @Published private(set) var users = [User]()
    @Published private(set) var error: NetworkManager.NetworkError?
    @Published var hasError = false
    @Published var isLoading = false
    @Published var userSearch = ""
    
    func getUsers() async {
     isLoading = true
        do {
            let usersDecoded = try await NetworkManager.shared.fetchRequest(API.baseURL + API.users, T: [User].self)
            DispatchQueue.main.async {
                defer { self.isLoading = false }
                self.users = usersDecoded
            }
        } catch {
            hasError = true
            if let networkError = error as? NetworkManager.NetworkError {
                self.error = networkError
            } else {
                self.error = .customError(error: error)
            }
        }
    }
    var searchUser: [User] {
        if userSearch.isEmpty {
            return users
        } else {
            return users.filter {
                $0.name.localizedCaseInsensitiveContains(userSearch)
            }
        }
    }
}
