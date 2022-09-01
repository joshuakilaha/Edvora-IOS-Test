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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Product:")
                    .bold()
                    .foregroundColor(Theme.baseColor)
                Spacer()
                Text(product.name)
                    .bold()
                    .multilineTextAlignment(.leading)
            }
            
            HStack {
                Text("Stock:")
                    .bold()
                    .foregroundColor(Theme.baseColor)
                Spacer()
                Text("\(product.stock) Items")
                    .font(.body).fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            
            HStack {
                Text("Price:")
                    .bold()
                    .foregroundColor(Theme.baseColor)
                Spacer()
                Text("Ksh. \(product.sellingPrice)")
                    .font(.body).fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .none,alignment: .leading)
        .padding()
        .shadow(color: Theme.baseColor.opacity(0.4), radius: 2, x: 0, y: 1)
        .background(Theme.cellBackground)
        .clipShape(RoundedRectangle(cornerRadius:15, style: .continuous))
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
