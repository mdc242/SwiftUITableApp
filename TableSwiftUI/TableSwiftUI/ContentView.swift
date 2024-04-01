//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Chase, Meadow D on 4/1/24.
//

import SwiftUI
import MapKit


let data = [
    Item(name: "FoodHeads", neighborhood: "North University", desc:  "Cafe for housemade soups, sandwiches, iced teas and more from a converted home with yard seating. Great coffee and pastries!", lat: 30.301424424267477, long: -97.74027531811528, imageName: "foodheads"),

        Item(name: "The Pizza Press", neighborhood: "West Campus", desc: "Nostalgic restaurant doling out pizza, beer and more in casual, 1920s-style surroundings. Newsroom-themed joint.", lat: 30.291317848756094, long: -97.74195665321625, imageName: "ppress"),

        Item(name: "Dirty Martin’s Place", neighborhood: "West Campus", desc: "An Austin mainstay since 1926 with burgers, beer and American chow served in an old-school space. Right by UT-Austin.", lat: 30.294537730061418, long: -97.74224754641993, imageName: "dmartins"),

        Item(name: "Better Half", neighborhood: "Market District", desc: "Cafe with globally inspired fare, plus coffee, draft cocktails, wine, craft ciders and beer. Great coffee and pastries!", lat: 30.271948125061364, long: -97.75854966383939, imageName: "betterhalf"),

        Item(name: "Uncle Nicky's", neighborhood: "Hyde Park", desc: "Airy, casual all-day cafe for Italian fare alongside coffee, pastries and cocktails plus patio seats. Happy Hour all week!", lat: 30.304890, long: -97.726220, imageName: "unclenickys")
]
  struct Item: Identifiable {
      let id = UUID()
      let name: String
      let neighborhood: String
      let desc: String
      let lat: Double
      let long: Double
      let imageName: String
  }



struct ContentView: View {
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
                @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30.294537730061418, longitude: -97.74224754641993), span: MKCoordinateSpan(latitudeDelta: 0.07, longitudeDelta: 0.07))
    
    var body: some View {
        NavigationView {
        VStack {
            List(data, id: \.name) { item in
                NavigationLink(destination: DetailView(item: item)) {
                HStack {
                    Image(item.imageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.neighborhood)
                            .font(.subheadline)
                    } // end internal VStack
                } // end HStack
                } // end NavigationLink
            } // end List
            //add this code in the ContentView within the main VStack.
                       Map(coordinateRegion: $region, annotationItems: data) { item in
                           MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                               Image(systemName: "mappin.circle.fill")
                                   .foregroundColor(.red)
                                   .font(.title)
                                   .overlay(
                                       Text(item.name)
                                           .font(.subheadline)
                                           .foregroundColor(.black)
                                           .fixedSize(horizontal: true, vertical: false)
                                           .offset(y: 25)
                                   )
                           }
                       } // end map
                       .frame(height: 300)
                       .padding(.bottom, -30)
        } // end VStack
        .listStyle(PlainListStyle())
              .navigationTitle("ATX Eateries")
          } // end NavigationView
    } // end body

}

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
         @State private var region: MKCoordinateRegion
         
         init(item: Item) {
             self.item = item
             _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
         }
      let item: Item
              
      var body: some View {
          VStack {
              Image(item.imageName)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
                  .frame(maxWidth: 200)
              Text("Neighborhood: \(item.neighborhood)")
                  .font(.subheadline)
              Text("Description: \(item.desc)")
                  .font(.subheadline)
                  .padding(10)
              
              // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                   Map(coordinateRegion: $region, annotationItems: [item]) { item in
                     MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                         Image(systemName: "mappin.circle.fill")
                             .foregroundColor(.red)
                             .font(.title)
                             .overlay(
                                 Text(item.name)
                                     .font(.subheadline)
                                     .foregroundColor(.black)
                                     .fixedSize(horizontal: true, vertical: false)
                                     .offset(y: 25)
                             )
                     }
                 } // end Map
                     .frame(height: 300)
                     .padding(.bottom, -30)
              
              
                  } // end VStack
                   .navigationTitle(item.name)
                   Spacer()
       } // end body
    } // end DetailView


#Preview {
    ContentView()
}
