import SwiftUI

struct CurrentConditionsView: View {
    
    //MARK: - Properties
    
    let viewModel: CurrentConditionsViewModel
    
    //MARK: - View
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.temperature)
                    .font(.largeTitle)
                
                Group {
                    HStack {
                        Image(systemName: "wind")
                            .foregroundColor(.gray)
                        Text(viewModel.windSpeed)
                    }
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text(viewModel.summary)
                } // Group
                .font(.body)
            } // VStack
            
            Spacer()
            
            Button {
                viewModel.delete()
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(.accentColor)
            }

        } // HStack
        .padding()
    } // body
}

#Preview {
    CurrentConditionsView(
        viewModel: .init(
            location: .preview,
            store: PreviewStore(),
            currently: WeatherData.preview.currently
        )
    )
}
