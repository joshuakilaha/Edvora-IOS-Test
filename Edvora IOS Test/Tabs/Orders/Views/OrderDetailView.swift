//
//  OrderDetailView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 01/09/2022.
//

import SwiftUI

struct OrderDetailView: View {
    let order: Order
    private let dateConveter = DateConverter()
    @StateObject var orderVM = OrderViewModel()
    @State private var userName = ""
    @State private var productName = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Order Id: #\(order.orderId)")
                .font(.body).fontWeight(.light)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 50) {
                HStack {
                    Text("User Name:")
                        .bold()
                        .foregroundColor(Theme.baseColor)
                    Spacer()
                    Text(userName)
                        .font(.body).fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                        .onAppear {
                            Task {
                                userName = await orderVM.getUserName(order.userId)
                            }
                        }
                }
                
                HStack {
                    Text("Product Name:")
                        .bold()
                        .foregroundColor(Theme.baseColor)
                    Spacer()
                    Text(productName)
                        .font(.body).fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                        .onAppear {
                            Task {
                                    productName = await orderVM.getProductName(order.productId)
                            }
                        }
                }
                
                HStack {
                    Text("Quantity Name:")
                        .bold()
                        .foregroundColor(Theme.baseColor)
                    Spacer()
                    Text("\(order.quantity)")
                        .font(.body).fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
                
                HStack {
                    Text("Date Orderd:")
                        .bold()
                        .foregroundColor(Theme.baseColor)
                    Spacer()
                    Text(dateConveter.dateOrdered(order.orderDate))
                        .font(.body).fontWeight(.light)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.trailing)
                }
            }
            
            .frame(maxWidth: .infinity, maxHeight: .none,alignment: .leading)
            .padding(.horizontal, 18)
            .padding(.vertical, 30)
            .shadow(color: Theme.baseColor.opacity(0.4), radius: 2, x: 0, y: 1)
            .background(Theme.cellBackground)
            .clipShape(RoundedRectangle(cornerRadius:15, style: .continuous))
            Spacer()
        }
        .navigationTitle("Order Detail")
        .padding()
        .onAppear {
            Task {
                    userName = await orderVM.getUserName(order.userId)
                    productName = await orderVM.getProductName(order.productId)
            }
        }
    }
    
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previewOrder: Order {
        let order = try! FetchJSONFile.decode(file: FileName.OrdersJSONFile, type: [Order].self)
        return order[0]
    }
    static var previews: some View {
        OrderDetailView(order: previewOrder)
    }
}
