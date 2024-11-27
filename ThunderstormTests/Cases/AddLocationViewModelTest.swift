import XCTest
import Combine
@testable import Thunderstorm

final class AddLocationViewModelTest: XCTestCase {
    
    //MARK: - Types
    
    private enum AddLocationResult {
        
        //MARK: - Cases
        
        case success
        case failure
    }
    
    //MARK: - Properties
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: - Set Up & Tear Deown
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        subscriptions.removeAll()
    }

    //MARK: - Tests for Text Field Placeholder
    
    func testTextFieldPlaceholder() async throws {
        let viewModel = await AddLocationViewModel(
            store: MockStore(),
            geocodingService: MockGeocodingClient(
                result: .success(Location.mocks)
            )
        )
        
        let textFieldPlaceholder = await viewModel.textFieldPlaceholder
        XCTAssertEqual(textFieldPlaceholder, "Enter the name of a city ...")
    }
    
    //MARK: - Tests for Add Location
    
    func testAddLocationSuccess() async throws {
        try await runAddLocationTest(result: .success)
    }
    
    func testAddLocationFailure() async throws {
        try await runAddLocationTest(result: .failure)
    }
    
    @MainActor
    private func runAddLocationTest(result: AddLocationResult) async throws {
        let locationToAddID = result == .success ? Location.mock.id : "abc"
        
        let store = MockStore()
        let geocodingService = MockGeocodingClient(
            result: .success([Location.mock])
        )
        
        let viewModel = AddLocationViewModel(
            store: store,
            geocodingService: geocodingService
        )
        
        XCTAssertTrue(store.locations.isEmpty)
        
        let expectation = expectation(description: "Validate Locations")
        
        expectation.isInverted = result == .failure
        
        store.locationsPublisher
            .filter { locations in
                locations.contains { $0.id == locationToAddID }
            }
            .sink { _ in
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        viewModel.query = "Brussels"
        
        viewModel.$locations
            .sink { _ in
                DispatchQueue.main.async {
                    viewModel.addLocation(with: locationToAddID)
                }
            }.store(in: &subscriptions)
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }

}
