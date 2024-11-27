import CoreLocation

protocol Geocoder {
    
    func geocodeAddressString(_ addressString: String) async throws -> [CLPlacemark]
}
