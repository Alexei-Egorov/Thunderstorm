import Foundation

struct GeocodingPreviewClient: GeocodingService {
    
    //MARK: - Geocoding Service
    
    func geocodeAddressString(_ addressString: String) async throws -> [Location] {
        Location.previews
    }
}
