import SwiftUI

struct LocationsView: View {
    
    // MARK: - Properties
    
    private(set) var viewModel: LocationsViewModel
    
    @State private var showsAddLocationView = false
    
    // MARK: - View
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem()], spacing: 20) {
                    Button(viewModel.addLocationTitle) {
                        showsAddLocationView.toggle()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .clipShape(Capsule())
                    
                    ForEach(viewModel.locationCellViewModels) { viewModel in
                        NavigationLink {
                            LocationView(viewModel: viewModel.locationViewModel)
                        } label: {
                            LocationCell(viewModel: viewModel)
                        }
                    } // ForEach
                } // LazyVGrid
                .padding()
            } // ScrollView
            .navigationTitle("Thunderstorm")
            .sheet(isPresented: $showsAddLocationView) {
                AddLocationView(
                    viewModel: viewModel.addLocationViewModel,
                    showsAddLocationView: $showsAddLocationView
                )
            }
        } // NavigationView
        .onAppear {
            viewModel.start()
        }
    } // body
}

#Preview {
    LocationsView(
        viewModel: .init(
            store: PreviewStore(),
            weaherService: WeatherPreviewClient()
        )
    )
}
