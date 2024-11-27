import Foundation
import Combine
@testable import Thunderstorm

final class MockStore: Store {
    
    //MARK: - Properties
    
    @Published private(set) var locations: [Location]
    
    //MARK: - Initialization
    
    init(locations: [Location] = []) {
        self.locations = locations
    }
    
    //MARK: - Store
    
    var locationsPublisher: AnyPublisher<[Location], Never> {
        $locations
            .eraseToAnyPublisher()
    }
    
    func addLocation(_ location: Location) throws {
        locations.append(location)
    }
    
    func removeLocation(_ location: Location) throws {
        locations.removeAll(where: { $0.id == location.id })
    }
}
