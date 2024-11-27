//
//  ThunderstormApp.swift
//  Thunderstorm
//
//  Created by Aliaksei on 09/01/2024.
//

import SwiftUI
import Swinject

@main
struct ThunderstormApp: App {
    
    //MARK: - Initialization
    
    init() {
        registerServices()
    }
    
    //MARK: - App
    
    var body: some Scene {
        WindowGroup {
            LocationsView(
                viewModel: .init(
                    store: Container.store,
                    weaherService: WeatherClient()
                )
            )
        }
    }
    
    //MARK: - Helper Methods
    
    private func registerServices() {
        Container.shared.register(Store.self) { _ in
            UserDefaults.standard
        }
    }
}
