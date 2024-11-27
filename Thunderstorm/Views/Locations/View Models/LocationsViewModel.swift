import Foundation
import Combine

@MainActor
@Observable final class LocationsViewModel {
    
    // MARK: - Properties
    
    private let store: Store
    private let weatherService: WeatherService
    
    private var subscriptions = Set<AnyCancellable>()
    
    var title: String {
        "Thunderstorm"
    }
    
    var addLocationTitle: String {
        "Add a Location"
    }
    
    private(set) var locationCellViewModels: [LocationCellViewModel] = []
    
    var addLocationViewModel: AddLocationViewModel {
        AddLocationViewModel(
            store: store,
            geocodingService: GeocodingClient()
        )
    }
    
    //MARK: - Initialization
    
    init(
        store: Store,
        weaherService: WeatherService
    ) {
        self.store = store
        self.weatherService = weaherService
    }
    
    //MARK: - Public API
    
    func start() {
        let weatherService = self.weatherService
        
        store.locationsPublisher
            .map { locations in
                locations.map { location in
                    LocationCellViewModel(
                        location: location,
                        weatherService: weatherService
                    )
                }
            }
            .eraseToAnyPublisher()
            .sink { [weak self] locationCellViewModels in
                self?.locationCellViewModels = locationCellViewModels
            }.store(in: &subscriptions)
    }
}
