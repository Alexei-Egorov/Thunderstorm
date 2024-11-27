import Foundation

final class ClearSkyDecoder: JSONDecoder {
    
    //MARK: - Initialization
    
    override init() {
        super.init()
        
        dateDecodingStrategy = .secondsSince1970
    }
}
