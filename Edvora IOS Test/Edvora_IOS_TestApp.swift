//
//  Edvora_IOS_TestApp.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

@main
struct Edvora_IOS_TestApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
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
        }
    }
}
