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
                .font(.body)
                .foregroundColor(Theme.baseColor)
        }
        .frame(maxWidth: .infinity, maxHeight: .none,alignment: .leading)
        .padding()
        .shadow(color: Theme.baseColor.opacity(0.4), radius: 2, x: 0, y: 1)
        .background(Theme.cellBackground)
        .clipShape(RoundedRectangle(cornerRadius:15, style: .continuous))
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
