import Foundation

struct ForecastViewModel {
    
    //MARK: - Properties
    
    private let forecast: [WeatherData.DayConditions]
    
    //MARK: -
    
    var forecastCellViewModels: [ForecastCellViewModel] {
        forecast.map(ForecastCellViewModel.init(dayConditions:))
    }
    
    //MARK: - Initialization
    
    init(forecast: [WeatherData.DayConditions]) {
        self.forecast = forecast
    }
}
