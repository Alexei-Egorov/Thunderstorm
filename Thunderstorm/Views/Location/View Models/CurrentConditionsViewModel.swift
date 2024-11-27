import Foundation

struct CurrentConditionsViewModel {
    
    //MARK: - Properties
    
    private let location: Location
    private let store: Store
    private let currently: WeatherData.CurrentConditions
    
    //MARK: - 
    
    private let measurementFormatter = ClearSkyFormatter()
    
    //MARK: - Public API
    
    var summary: String {
        currently.summary
    }
    
    var windSpeed: String {
        measurementFormatter.formatWindSpeed(currently.windSpeed)
    }
    
    var temperature: String {
        measurementFormatter.formatTemperature(currently.temperature)
    }
    
    //MARK: - Initialization
    
    init(
        location: Location,
        store: Store,
        currently: WeatherData.CurrentConditions
    ) {
        self.location = location
        self.store = store
        self.currently = currently
    }
    
    //MARK: - Public API Methods
    
    func delete() {
        do {
            try store.removeLocation(location)
        } catch {
            print("Unable to Remove Location: \(error)")
        }
    }
}
