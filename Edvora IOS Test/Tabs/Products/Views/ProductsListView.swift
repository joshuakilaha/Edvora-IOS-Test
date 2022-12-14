//
//  ProductsListView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct ProductsListView: View {
    @StateObject private var productVM = ProductViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                // if loading present progress View
                if productVM.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Theme.baseColor))
                } else {
                    productList
                }
            }
            .navigationTitle("Products")
            .task {
                await productVM.getProducts()
            }
        }
        .navigationViewStyle(.stack)
        .alert(isPresented: $productVM.hasError, error: productVM.error) {
            Button("Retry") {
                Task {
                    await productVM.getProducts()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                totalItems
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
            ForEach(productVM.searchProduct, id: \.productId) { product in
                ProductListViewCell(product: product)
            }
            .listRowBackground(Color.clear)
            .background(Theme.background)
        }
        .refreshable {
            Task {
                await productVM.getProducts()
            }
        }
        .listStyle(SidebarListStyle())
        .searchable(text: $productVM.productSearch, prompt: "Search product")
    }
    var totalItems: some View {
        Text("\(productVM.totalProducts) Items")
            .bold()
            .opacity(productVM.isLoading ? 0 : 1)
    }
}
