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
        List {
            ForEach(users, id: \.userId) { user in
                Text(user.name)
            }
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
