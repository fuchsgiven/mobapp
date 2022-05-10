//
//  PreviewAll.swift
//  FruitDetec (iOS)
//
//  Created by Fuchs Simon on 26.04.22.
//

import SwiftUI

struct PreviewAll_Previews: PreviewProvider {
    static var previews: some View {
        PreviewAll()
        PreviewAll().preferredColorScheme(.dark)
    }
}

struct PreviewAll: View {
    
    @EnvironmentObject var slideManager:SlideManager
    
    @State private var currentSlide:Slide?=nil
    
    var body: some View {
        VStack{
            Text(slideManager.slideshowTitle).font(.title)
            if let slide:Slide = currentSlide {
                Image(slide.imgFileName).resizable()
                    .scaledToFit()
                    .padding()
                    .onTapGesture {
                        currentSlide = slideManager.slideAfter(slide: slide)
                    }
                
                Text("\(slide.title) (\(slide.imgFileName))").font(.footnote)
            }else{
                Text("Add slides in the management tab")
                    .padding()
            }
        }.onAppear(){
            currentSlide = slideManager.slides.first
        }
    }
}

