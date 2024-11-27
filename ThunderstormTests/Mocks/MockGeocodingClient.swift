import Foundation
@testable import Thunderstorm

struct MockGeocodingClient: GeocodingService {
    
    //MARK: - Types
    
    enum GeocodingError: Error {
        
        //MARK: - Cases
        
        case requestFailed
    }
    
    //MARK: - Properties
    
    let result: Result<[Location], GeocodingError>
    
    //MARK: - Geocoding Service
    
    func geocodeAddressString(_ addressString: String) async throws -> [Location] {
        switch result {
        case .success(let locations):
            return locations
        case .failure(let error):
            throw error
        }
    }
}
