import Foundation

@MainActor
@Observable final class LocationCellViewModel: Identifiable {
    
    //MARK: - Properties
    
    private let location: Location
    private let weatherService: WeatherService
    
    //MARK: -
    
    private let measurmentFormatter = ClearSkyFormatter()
    
    //MARK: -
    
    private var weatherData: WeatherData?
    
    //MARK: -
    
    var locationViewModel: LocationViewModel {
        .init(
            location: location,
            weatherService: weatherService
        )
    }
    
    //MARK: - Initialization
    
    init(
        location: Location,
        weatherService: WeatherService
    ) {
        self.location = location
        self.weatherService = weatherService
    }
    
    //MARK: - Public API
    
    var locationName: String {
        location.name
    }
    
    var locationCountry: String {
        location.country
    }
    
    var summary: String? {
        weatherData?.currently.summary
    }
    
    var windSpeed: String? {
        guard let windSpeed = weatherData?.currently.windSpeed else {
            return nil
        }
        
        return measurmentFormatter.formatWindSpeed(windSpeed)
    }
    
    var temperature: String? {
        guard let temperature = weatherData?.currently.temperature else {
            return nil
        }
        
        return measurmentFormatter.formatTemperature(temperature)
    }
    
    func start() async {
        do {
            weatherData = try await weatherService.weather(for: location)
        } catch {
            print("Unable to Fetch Weather Data for Location: \(error)")
        }
    }
}
