import SwiftUI

struct ForecastCell: View {
    
    //MARK: - Properties
    
    let viewModel: ForecastCellViewModel
    
    //MARK: - View
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.day)
                    .font(.title)
                    .foregroundColor(.accentColor)
                
                
                Group {
                    Text(viewModel.date)
                    Spacer()
                    Text(viewModel.summary)
                }
                .font(.body)
                .foregroundColor(.darkGray)
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Image(systemName: viewModel.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                    .foregroundColor(.darkGray)
                
                Spacer()
                
                Text(viewModel.windSpeed)
                    .font(.body)
                    .foregroundColor(.darkGray)
                
                HStack {
                    Text(viewModel.lowTemperature)
                    Text("-")
                    Text(viewModel.highTemperature)
                }
                .font(.body)
                .foregroundColor(.darkGray)
            }
        } // HStack
    } // body
}

#Preview {
    ForecastCell(
        viewModel: .init(
            dayConditions: WeatherData.preview.forecast[0]
        )
    )
}
