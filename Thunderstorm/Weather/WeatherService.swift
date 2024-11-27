import Foundation

protocol WeatherService {
    
    //MARK: - Methods
    
    func weather(for location: Location) async throws -> WeatherData
}
