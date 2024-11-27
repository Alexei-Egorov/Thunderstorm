import Foundation

struct ForecastCellViewModel: Identifiable {
    
    //MARK: - Properties
    
    private let dayConditions: WeatherData.DayConditions
    
    //MARK: -
    
    private let dateFormatter = DateFormatter()
    private let measurementFormatter = ClearSkyFormatter()
    
    var id: UUID {
        UUID()
    }
    
    var day: String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: dayConditions.time).capitalized
    }
    
    var date: String {
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: dayConditions.time).capitalized
    }
    
    var summary: String {
        dayConditions.summary
    }
    
    var imageName: String {
        switch dayConditions.icon {
        case "clear-day":
            return "sun.max"
        case "clear-night":
            return "moon"
        case "rain":
            return "cloud.rain"
        case "snow":
            return "cloud.snow"
        case "sleet":
            return "cloud.sleet"
        case "wind", "cloudy", "partly-cloudy-day", "partly-cloudy-night":
            return "cloud"
        default:
            return "sun.max"
        }
    }
    
    var windSpeed: String {
        measurementFormatter.formatWindSpeed(dayConditions.windSpeed)
    }
    
    var lowTemperature: String {
        measurementFormatter.formatTemperature(dayConditions.temperatureLow)
    }
    
    var highTemperature: String {
        measurementFormatter.formatTemperature(dayConditions.temperatureHigh)
    }
    
    //MARK: - Initialization
    
    init(dayConditions: WeatherData.DayConditions) {
        self.dayConditions = dayConditions
    }
}
