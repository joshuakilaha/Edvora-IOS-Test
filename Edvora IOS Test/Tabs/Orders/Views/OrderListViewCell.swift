//
//  OrderListViewCell.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI

struct OrderListViewCell: View {
    let order: Order
    private let dateConveter = DateConverter()
    @StateObject var orderVM = OrderViewModel()
    @State private var userName = ""
    @State private var productName = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Product Ordered:")
                    .bold()
                    .foregroundColor(Theme.baseColor)
                Spacer()
                Text(productName)
                    .bold()
                    .multilineTextAlignment(.leading)
                    .onAppear {
                        Task {
                            productName = await orderVM.getProductName(order.productId)
                        }
                    }
            }
            HStack {
                Text("Quantity:")
                    .bold()
                    .foregroundColor(Theme.baseColor)
                Spacer()
                Text("\(order.quantity) Items")
                    .font(.body).fontWeight(.light)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
            }
            
            HStack {
                Text("Date:")
                    .bold()
                    .foregroundColor(Theme.baseColor)
                Spacer()
                Text(dateConveter.dateOrdered(order.orderDate))
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

struct OrderListViewCell_Previews: PreviewProvider {
    /// Returns first element from JSON local File
    static var previewOrder: Order {
        let order = try! FetchJSONFile.decodeLocalFile(file: FileName.OrdersJSONFile, type: [Order].self)
        return order[0]
    }
    static var previews: some View {
        OrderListViewCell(order: previewOrder)
    }
}
