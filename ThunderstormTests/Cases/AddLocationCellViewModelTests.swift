import XCTest
@testable import Thunderstorm

final class AddLocationCellViewModelTests: XCTestCase {

    //MARK: - Tests for Identifiable Conformance
    
    func testIdentifiableConformance() throws {
        let location: Location = .mock
        let viewModel = AddLocationCellViewModel(location: location)
        
        XCTAssertEqual(viewModel.id, location.id)
    }
    
    //MARK: - Tests for Computed Properties
    
    func testComputedProperties() throws {
        let location: Location = .mock
        let viewModel = AddLocationCellViewModel(location: location)
        
        XCTAssertEqual(viewModel.name, location.name)
        XCTAssertEqual(viewModel.country, location.country)
        
        XCTAssertEqual(
            viewModel.coordinates,
            "\(location.latitude) \(location.longitude)"
        )
    }

}
