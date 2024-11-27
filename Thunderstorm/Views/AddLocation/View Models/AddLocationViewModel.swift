import Foundation
import Combine

@MainActor
final class AddLocationViewModel: ObservableObject {
    
    //MARK: - Types
    
    enum State: Equatable {
        
        //MARK: - Cases
        
        case empty
        case quering
        case message(String)
        case results([AddLocationCellViewModel])
    }
    
    //MARK: - Properties
    
    private let store: Store
    private let geocodingService: GeocodingService
    
    @Published var query = ""
    @Published private(set) var locations: [Location] = []
    @Published private(set) var state: State = .empty
    @Published private var isQuering = false
    
    private var subscriptions = Set<AnyCancellable>()
    
    var textFieldPlaceholder: String {
        "Enter the name of a city ..."
    }
    
    //MARK: - Initialization
    
    init(
        store: Store,
        geocodingService: GeocodingService
    ) {
        self.store = store
        self.geocodingService = geocodingService
        
        setupBindings()
    }
    
    //MARK: - Methods
    
    func addLocation(with id: String) {
        guard let location = locations.first(where: { $0.id == id }) else { return }
        
        do {
            try store.addLocation(location)
        } catch {
            print("Unable to Add Location: \(error)")
        }
    }
    
    //MARK: - Helper Methods
    
    private func setupBindings() {
        $query
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .filter { !$0.isEmpty }
            .sink { [weak self] addressString in
                self?.geocodeAddressString(addressString)
            }.store(in: &subscriptions)
        
        $locations
            .map { $0.map(AddLocationCellViewModel.init) }
            .combineLatest($query, $isQuering)
            .map { viewModels, query, isQuering -> State in
                if isQuering {
                    return .quering
                }
                
                if query.isEmpty {
                    return .empty
                }
                
                if viewModels.isEmpty {
                    return .message("No matches found...")
                } else {
                    return .results(viewModels)
                }
            }
            .eraseToAnyPublisher()
            .removeDuplicates()
            .assign(to: &$state)
    }
    
    private func geocodeAddressString(_ addressString: String) {
        isQuering = true
        
        Task {
            do {
                locations = try await geocodingService.geocodeAddressString(addressString)
            } catch {
                locations = []
                print("Unable to Geocode \(addressString) \(error)")
            }
            
            isQuering = false
        }
    }
}
