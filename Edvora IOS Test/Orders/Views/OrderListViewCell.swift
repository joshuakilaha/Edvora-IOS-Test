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
    @StateObject var vm = OrderViewModel()
    @State private var userName = ""
    @State private var productName = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(productName)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Text("\(order.quantity) items")
            }
            HStack {
                Text(userName)
                    .bold()
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(dateConveter.dateOrdered(order.orderDate))
                    .multilineTextAlignment(.trailing)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
        .onAppear {
            let userNames = vm.getUserName(order.userId)
            userName = userNames
            let productNames = vm.getProductName(order.productId)
            productName = productNames
        }
    }
}

struct OrderListViewCell_Previews: PreviewProvider {
    static var previewOrder: Order {
        let order = try! FetchJSONFile.decode(file: FileName.OrdersJSONFile, type: [Order].self)
        return order[0]
    }
    static var previews: some View {
        OrderListViewCell(order: previewOrder)
    }
}
