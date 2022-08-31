//
//  UsersListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct UsersListView: View {
    @State private var users: [User] = []

    var body: some View {
        NavigationView {
            userList
                .navigationTitle("Users")
        }
        .onAppear {
            do {
                let userData = try FetchJSONFile.decode(file: FileName.UsersJSONFile, type: [User].self)
                print("User Data \(userData)")
                users = userData
            } catch {
                print(error)
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}

extension UsersListView {
    // MARK: -List View
    var userList: some View {
        List {
            ForEach(users, id: \.userId) { user in
                UserListViewCell(user: user)
            }
            .listRowBackground(Color.clear)
            .background(Theme.background)
        }
        .listStyle(SidebarListStyle())
    }
}
