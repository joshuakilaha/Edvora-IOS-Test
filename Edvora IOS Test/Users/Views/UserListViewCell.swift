//
//  UserListViewCell.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct UserListViewCell: View {
    let user: User
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(user.name)
                .bold()
                .font(.title2)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
}


struct UserListViewCell_Previews: PreviewProvider {
    static var previewUser: User {
        let users = try! FetchJSONFile.decode(file: FileName.UsersJSONFile, type: [User].self)
        
        return users[0]
    }
    static var previews: some View {
        UserListViewCell(user: previewUser)
    }
}
