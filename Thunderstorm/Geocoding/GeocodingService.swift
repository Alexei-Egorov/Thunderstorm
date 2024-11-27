import Foundation

protocol GeocodingService {
    
    //MARK: - Methods
    
    func geocodeAddressString(_ addressString: String) async throws -> [Location]
    
}
