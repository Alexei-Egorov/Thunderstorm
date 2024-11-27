import Combine

final class PreviewStore: Store {
    
    //MARK: - Properties
    
    @Published private var locations = Location.previews
    
    //MARK: -
    
    var locationsPublisher: AnyPublisher<[Location], Never> {
        $locations
            .eraseToAnyPublisher()
    }
    
    //MARK: - Methods
    
    func addLocation(_ location: Location) throws {
        locations.append(location)
    }
    
    func removeLocation(_ location: Location) throws {
        locations.removeAll { $0.id == location.id }
    }
}
