//
//  ProductListViewCell.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct ProductListViewCell: View {
    let product: Product
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .bold()
                .multilineTextAlignment(.leading)
            
            HStack {
                Text("Stock")
                    .bold()
                Spacer()
                Text("\(product.stock) items")
            }
            HStack {
                Text("Price")
                    .bold()
                Spacer()
                Text("$\(product.sellingPrice)")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
    }
}

struct ProductListViewCell_Previews: PreviewProvider {
    static var previewProduct: Product {
        let product = try! FetchJSONFile.decode(file: FileName.ProductsJSONFile, type: [Product].self)
        return product[0]
    }
    static var previews: some View {
        ProductListViewCell(product: previewProduct)
    }
}
