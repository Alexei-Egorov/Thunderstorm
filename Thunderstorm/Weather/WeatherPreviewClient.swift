import Foundation

struct WeatherPreviewClient: WeatherService {
    
    //MARK: - Types
    
    struct WeatherDataError: Error { }
    
    //MARK: - Properties
    
    private let result: Result<WeatherData, WeatherDataError>
    
    //MARK: - Initialization
    
    init(result: Result<WeatherData, WeatherDataError> = .success(.preview)) {
        self.result = result
    }
    
    //MARK: - Weather Service
    
    func weather(for location: Location) async throws -> WeatherData {
        switch result {
        case .success(let weatherData):
            return weatherData
        case .failure(let error):
            throw error
        }
    }
}
