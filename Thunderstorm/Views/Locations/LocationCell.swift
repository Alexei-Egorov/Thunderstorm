import SwiftUI

struct LocationCell: View {
    
    //MARK: - Properties
    
    var viewModel: LocationCellViewModel
    
    //MARK: - View
    
    var body: some View {
        HStack {
            VStackLayout(alignment: .leading) {
                Text(viewModel.locationName)
                    .font(.title)
                    .foregroundColor(.accentColor)
                Text(viewModel.locationCountry)
                    .font(.body)
                    .foregroundColor(.gray)
                Spacer()
                if let summary = viewModel.summary {
                    Text(summary)
                }
            }
            
            Spacer()
            
            if let temperature = viewModel.temperature,
               let windSpeed = viewModel.windSpeed {
                VStackLayout(alignment: .trailing) {
                    HStack {
                        Image(systemName: "thermometer")
                            .foregroundColor(.gray)
                        Text(temperature)
                    }
                    HStack {
                        Image(systemName: "wind")
                            .foregroundColor(.gray)
                        Text(windSpeed)
                    }
                    Spacer()
                }
            } else {
                ProgressView()
            }
        } // HStack
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray)
                .opacity(0.25)
        }
        .task {
            await viewModel.start()
        }
    }
}

#Preview {
    let viewModel = LocationCellViewModel(
        location: .preview,
        weatherService: WeatherPreviewClient()
    )
    
    return LocationCell(viewModel: viewModel)
}
