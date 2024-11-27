import XCTest
@testable import Thunderstorm

final class ClearSkyFormatterTests: XCTestCase {

    //MARK: - Tests for Format Wind Speed
    
    func testFormatWindSpeed() throws {
        let locale = Locale(identifier: "pl-PL")
        let formatter = ClearSkyFormatter(locale: locale)
        
        XCTAssertEqual(
            formatter.formatWindSpeed(12.35),
            "20 km/godz."
        )
    }
    
    //MARK: - Tests for Format Temperature
    
    func testFormatRemperature() throws {
        let locale = Locale(identifier: "pl-PL")
        let formatter = ClearSkyFormatter(locale: locale)
        
        XCTAssertEqual(
            formatter.formatTemperature(32.0),
            "0 st. C"
        )
    }

}
