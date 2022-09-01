//
//  ProductChart.swift
//  Edvora IOS Test
//
//  Created by Mroot on 01/09/2022.
//

import SwiftUI
import SwiftUICharts

struct ProductChart: View {
    @StateObject var productVm = ProductViewModel()
    var body: some View {
        VStack {
                    Section(header: Text("All products including Taxes in WareHouse")) {
                        let data: BarChartData = StartsData()
                        BarChart(chartData: data)
                                    .xAxisGrid(chartData: data)
                                    .yAxisGrid(chartData: data)
                                    .xAxisLabels(chartData: data)
                                    .yAxisLabels(chartData: data, colourIndicator: .custom(colour: ColourStyle(colour: .red), size: 12))
                                    .headerBox(chartData: data)
                                    .id(data.id)
                                    .frame(minWidth: 150, maxWidth: 900, minHeight: 100, idealHeight: 250, maxHeight: 500, alignment: .center)
                                    .accessibilityElement(children: .combine)
                    }
                }.task {
                    await productVm.getProducts()
                }
    }
}

struct ProductChart_Previews: PreviewProvider {
    static var previews: some View {
        ProductChart()
    }
}

extension ProductChart {
    // MARK: - Bar Chart
        func StartsData() -> BarChartData {
            var startsData = [BarChartDataPoint]()
            //loop through product
            
            for product in productVm.products.prefix(20) {

               // let items = product.name.map{ $0 }
               // let dispaly = product.name.prefix(10)
                let trimm = product.name.components(separatedBy: " ")[0]

                
                startsData.append(BarChartDataPoint(value: Double(product.stock), xAxisLabel: trimm, colour: ColourStyle(colour: .red)))
            }

            let sets = BarDataSet(dataPoints: startsData)
            let data: BarDataSet = sets
            let metadata = ChartMetadata(title: "", subtitle: "")
            let gridStyle = GridStyle(numberOfLines: 10,
                                           lineColour: Color(.lightGray).opacity(0.2),
                                      lineWidth: 5.0)
            let chartStyle = BarChartStyle(infoBoxPlacement: .header,
                                               markerType: .bottomLeading(),
                                               xAxisGridStyle: gridStyle,
                                               xAxisLabelPosition: .bottom,
                                               xAxisLabelsFrom: .dataPoint(rotation: .degrees(90)),
                                               xAxisTitle: "Products",
                                               yAxisGridStyle: gridStyle,
                                               yAxisLabelPosition: .leading,
                                               yAxisNumberOfLabels: 2,
                                               yAxisTitle: "Stock",
                                               baseline: .zero,
                                               topLine: .maximumValue)
            return BarChartData(dataSets: data,
                                    metadata: metadata,
                                    xAxisLabels: ["One"],
                                   barStyle: BarStyle(barWidth: 0.3,
                                                       cornerRadius: CornerRadius(top: 50, bottom: 0),
                                                       colourFrom: .dataPoints,
                                                       colour: ColourStyle(colour: .blue)),
                                    chartStyle: chartStyle)
            }
}


