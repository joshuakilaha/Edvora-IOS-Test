//
//  TabsView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 02/09/2022.
//

import SwiftUI

struct TabsView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Symbols.home
                    Text("Home")
                }
            OrdersListView()
                .tabItem {
                    Symbols.orders
                    Text("Orders")
                }
            ProductsListView()
                .tabItem {
                    Symbols.product
                    Text("Products")
                }
            UsersListView()
                .tabItem {
                    Symbols.user
                    Text("Users")
                }
        }
        .accentColor(Theme.baseColor)
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
