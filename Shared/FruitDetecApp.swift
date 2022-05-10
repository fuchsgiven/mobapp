//
//  FruitDetecApp.swift
//  Shared
//
//  Created by Fuchs Simon on 25.04.22.
//

import SwiftUI

@main
struct FruitDetecApp: App {
    
    let slideManager = SlideManager(withInitialData: false)
    let slideService = SlideService()
            
        var body: some Scene {
            WindowGroup {
                ContentView().environmentObject(slideManager)
            }
        }

}
