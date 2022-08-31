//
//  ProductsListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct ProductsListView: View {
    @State private var products: [Product] = []

    var body: some View {
        NavigationView {
            productList
                .navigationTitle("Products")
            .onAppear {
                do {
                    let productData = try FetchJSONFile.decode(file: FileName.ProductsJSONFile, type: [Product].self)
                    print("Product Data \(productData)")
                    products = productData
                } catch {
                    print(error)
                }
            }
        }
    }
}

struct ProductsListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsListView()
    }
}
extension ProductsListView {
    // MARK: -List View
    var productList: some View {
        List {
            ForEach(products, id: \.productId) { product in
                ProductListViewCell(product: product)
            }
            .listRowBackground(Color.clear)
            .background(Theme.background)
        }
        .listStyle(SidebarListStyle())
    }
}
