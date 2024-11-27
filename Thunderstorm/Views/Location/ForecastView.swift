import SwiftUI

struct ForecastView: View {
    
    //MARK: - Properties
    
    let viewModel: ForecastViewModel
    
    //MARK: - View
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem()]) {
                ForEach(viewModel.forecastCellViewModels) { cellViewModel in
                    ForecastCell(viewModel: cellViewModel)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ForecastView(
        viewModel: .init(
            forecast: WeatherData.preview.forecast
        )
    )
}
