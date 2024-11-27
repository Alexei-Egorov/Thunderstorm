import Foundation
import Combine

extension UserDefaults: Store {
    
    //MARK: - Properties
    
    var locationsPublisher: AnyPublisher<[Location], Never> {
        publisher(for: \.locations)
            .compactMap { $0 }
            .decode(
                type: [Location].self,
                decoder: JSONDecoder()
            )
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
