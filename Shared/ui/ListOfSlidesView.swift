//
//  ListOfSlidesView.swift
//  FruitDetec (iOS)
//
//  Created by Fuchs Simon on 26.04.22.
//

import SwiftUI
import MapKit
import CoreLocation

class CustomLocationManager: NSObject,
                             CLLocationManagerDelegate, // methods called on updated location and so on...
                             ObservableObject // Note: we include a @Published var (i.e. we inform when region changed)
    {
        
    @Published var region = MKCoordinateRegion()
    private let clmgr = CLLocationManager()
    
    override init() {
        super.init()
        clmgr.delegate = self // we handle callbacks in our "CustomLocationManager" class
        clmgr.desiredAccuracy = kCLLocationAccuracyBest
        clmgr.requestWhenInUseAuthorization() // Info.plist entry required!
        clmgr.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locations.last.map {
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
}


struct ListOfSlidesView: View {
    @EnvironmentObject var slideManager:SlideManager
    
    @StateObject var manager = CustomLocationManager()
    @State var trackingMode:MapUserTrackingMode = .none

    
    var body: some View {
        VStack{
            Text(slideManager.slideshowTitle).font(.title)
            List(slideManager.slides) {slide in Text("\(slide.number) | \(slide.title) (\(slide.imgFileName))")}
            //Map(coordinateRegion: $homeRegion)
            Map(coordinateRegion: $manager.region,
                showsUserLocation: true,
                userTrackingMode: $trackingMode
                )
        }
    }
}

struct ListOfSlidesView_Previews: PreviewProvider {
    static var previews: some View {
        ListOfSlidesView()
        ListOfSlidesView().preferredColorScheme(.dark)
    }
}
