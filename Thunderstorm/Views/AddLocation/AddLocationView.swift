import SwiftUI

struct AddLocationView: View {
    
    //MARK: - Properties
    
    @StateObject var viewModel: AddLocationViewModel
    
    @Binding var showsAddLocationView: Bool
    
    //MARK: - View
    
    var body: some View {
        VStack {
            TextField(viewModel.textFieldPlaceholder, text: $viewModel.query)
                .padding()
            
            switch viewModel.state {
            case .empty:
                Spacer()
            case .quering:
                MessageView(style: .progressView)
            case .message(let message):
                MessageView(style: .message(message))
            case .results(let viewModels):
                List {
                    ForEach(viewModels) { cellViewModel in
                        AddLocationCell(viewModel: cellViewModel) {
                            viewModel.addLocation(with: cellViewModel.id)
                            showsAddLocationView.toggle()
                        }
                    }
                }
            }
        }
    }
}

fileprivate struct MessageView: View {
    
    //MARK: - Types
    
    enum Style {
        
        //MARK: - Cases
        
        case progressView
        case message(String)
    }
    
    //MARK: - Properties
    
    let style: Style
    
    //MARK: - View
    
    var body: some View {
        VStack {
            Spacer()
            switch style {
            case .progressView:
                ProgressView()
            case .message(let message):
                Text(message)
                    .font(.body)
                    .foregroundColor(.darkGray)
            }
            Spacer()
        }
    }
}

#Preview {
    let viewModel = AddLocationViewModel(
        store: PreviewStore(),
        geocodingService: GeocodingPreviewClient()
    )
    
    return AddLocationView(
        viewModel: viewModel,
        showsAddLocationView: .constant(true)
    )
}
