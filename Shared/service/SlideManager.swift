//
//  SlideManager.swift
//  FruitDetec (iOS)
//
//  Created by Fuchs Simon on 26.04.22.
//

import Foundation
class SlideManager :ObservableObject {
    @Published var slideshowTitle: String = "Test Slideshow"
    @Published var slides:[Slide] = []
    
    init(withInitialData:Bool = false){
        if withInitialData {
            seedWithDemoData()
        } else {
            Task {
                let service = SlideService()
                let slideshow = try? await service.fetchSlides()
                
                self.slideshowTitle = slideshow?.title ?? "test"
                self.slides = slideshow?.slides ?? []
            }
        }
    
    }
    
    private init(){}
    static let sharedInstance = SlideManager()
    
    func seedWithDemoData(){
        self.slides.append(contentsOf: [
            Slide(title: "Sunset",
                  imgFileName: "sunset-10"),
            Slide(title: "At the beach",
                  imgFileName: "sunset-11"),
            Slide(title: "Water",
                  imgFileName: "sunset-12"),
            Slide(title: "Sand & Water",
                  imgFileName: "sunset-13")
        ])
    }
    
    func slideAfter(slide:Slide) -> Slide? {
            guard var currIdx:Int = self.slides.firstIndex(of: slide) else {
                return self.slides.first
            }
            currIdx += 1
            return slides.count < currIdx ? slides[currIdx] : self.slides.first
       }

}

