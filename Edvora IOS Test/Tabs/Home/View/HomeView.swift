//
//  ContentView.swift
//  Edvora IOS Test
//
//  Created by Mroot on 31/08/2022.
//

import SwiftUI
import SwiftUICharts

struct HomeView: View {
    @StateObject var productVM = ProductViewModel()
    @State private var openPhotos = false
    @State private var image: Data? = .init(count: 0)
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                topView
                if productVM.isLoading {
                    ProgressView()
                } else {
                    productChart
                }
                Spacer()
            }
        }
        .sheet(isPresented: $openPhotos) {
            ImagePicker(show: $openPhotos, image: $image)
        }
        .task {
            await productVM.getProducts()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    var topView: some View {
        HStack {
            Spacer()
            Image(data: self.image)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .onTapGesture {
                    openPhotos.toggle()
                }
        }
        .padding()
    }
    
    @ViewBuilder
    var productChart: some View {
        // MARK: Title
        Text("Products In Stock")
            .font(.system(size: 34).weight(.heavy))
            .bold()
            .foregroundColor(Theme.baseColor)
            .padding(.horizontal, 20)
            .frame(width: .none, alignment: .leading)
        
        // MARK: Bar Chart
        let data: BarChartData = StartsData()
        BarChart(chartData: data)
                    .xAxisGrid(chartData: data)
                    .yAxisGrid(chartData: data)
                    .xAxisLabels(chartData: data)
                    .yAxisLabels(chartData: data, colourIndicator: .custom(colour: ColourStyle(colour: Theme.baseColor), size: 12))
                    .headerBox(chartData: data)
                    .id(data.id)
                    .frame(minWidth: 150, maxWidth: 900, minHeight: 100, idealHeight: 250, maxHeight: 500, alignment: .center)
                    .accessibilityElement(children: .combine)
                    .padding(.horizontal, 10)
                    .background(Theme.cellBackground)
    }
}

private extension Image {
     init(data: Data?) {
        guard let data = data,
          let uiImage = UIImage(data: data) else {
            self = Symbols.profile
            return
        }
        self = Image(uiImage: uiImage)
    }
}

extension HomeView {
    // MARK: - Bar Chart
        func StartsData() -> BarChartData {
            var startsData = [BarChartDataPoint]()
            for product in productVM.products.prefix(20) {
                let trimm = product.name.components(separatedBy: " ")[0]

                
                startsData.append(BarChartDataPoint(value: Double(product.stock), xAxisLabel: trimm, colour: ColourStyle(colour: .red)))
            }

            let sets = BarDataSet(dataPoints: startsData)
            let data: BarDataSet = sets
            let metadata = ChartMetadata(title: "", subtitle: "")
            let gridStyle = GridStyle(numberOfLines: 20,
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
