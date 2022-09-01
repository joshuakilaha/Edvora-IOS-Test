//
//  UsersListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct UsersListView: View {
    @StateObject private var userVM = UserViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                if userVM.isLoading {
                    ProgressView()
                } else {
                    userList
                }
            }
            .navigationTitle("Users")
        }
        .navigationViewStyle(.stack)
        .task {
            await userVM.getUsers()
        }
        .alert(isPresented: $userVM.hasError, error: userVM.error) {
            Button("Retry") {
                Task {
                    await userVM.getUsers()
                }
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
            ForEach(userVM.users, id: \.userId) { user in
                UserListViewCell(user: user)
            }
            .listRowBackground(Color.clear)
            .background(Theme.background)
        }
        .listStyle(SidebarListStyle())
    }
}
