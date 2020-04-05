//
//  ContentView.swift
//  TravelApp
//
//  Created by Alex Sikand on 4/5/20.
//  Copyright © 2020 AlexSikandEngineering. All rights reserved.
//

import SwiftUI

let categories = ["Flights", "Hotels", "Holidays", "Fun"]
let lightGray = Color(hex: "#F1F5FA")
let icons = [Image("planeVertical"), Image("hotelBed"), Image("holidayIsland"), Image("zipline")]

let destinations = ["Miami", "New York", "Boston"]
let destinationImages : [Image] = [Image("miami"), Image("newyork"), Image("boston")]

let destinations2 = ["Las Vegas", "Los Angeles", "Tokyo"]
let destinationImages2 : [Image] = [Image("lasvegas"), Image("losangeles"), Image("tokyo")]

struct DestinationCard: View {
    var image: Image
    var title: String
    
    var body: some View {
        VStack(alignment: .center){
            image.resizable().clipShape(RoundedRectangle(cornerRadius: 12))
            Text(title).fontWeight(.medium)
            
        }
    }
}



struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            BannerCard(colors: blueGradient, title: "Welcome Aboard", body: "We'll help you find the best experiences and adventures. So enjoy your journey!", buttonText: "Get Started", showArrow: true)
            Text("What are you looking for?").font(.largeTitle).fontWeight(.bold)
                .padding([.leading, .trailing, .bottom])
            HStack {
                
                ForEach((0...categories.count-1), id: \.self) {
                    categoryCard(bgColor: Color.gray.opacity(0.12), iconImage: icons[$0], title: categories[$0])//.frame(width: 100, height: 90)
                }
            }.padding(.leading)
            
          
            Text("Popular Destinations").font(.title).fontWeight(.bold)
                .padding(.all)
            
            HStack {
                ForEach((0...destinations.count-1), id: \.self) {
                    DestinationCard(image: destinationImages[$0], title: destinations[$0])
                }
                
                //ForEach((0...destinations.count-2), id: \.self) {
                 //   DestinationCard(image: Image("boston"), title: "Boston")
                //}
            }.padding(.horizontal)
            HStack {
                ForEach((0...destinations2.count-1), id: \.self) {
                    DestinationCard(image: destinationImages2[$0], title: destinations2[$0])
                }
                
                //ForEach((0...destinations.count-2), id: \.self) {
                 //   DestinationCard(image: Image("boston"), title: "Boston")
                //}
            }.padding(.horizontal)
           
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let blueGradient = [Color(hex: "#021B79"), Color(hex: "#0575E6")]
let purpleGradient = [Color(hex: "#8e2de2"), Color(hex: "#4a00e0")]



let stylesCard = BannerCard(colors: purpleGradient, title: "Styles you'll love", body: "We’ve all spent unneeded time staring at our closet deciding what to wear. Stop! When in doubt, throw on a white tee! It doesn’t matter if you’re wearing shorts, denim, pencil skirts, full skirts or anything in between, a white tee is going to look amazing with it! ", buttonText: "Start Shopping", showArrow: false)



struct BannerCard : View {
    
    var colors: [Color]
    var bodyText: String
    var titleText: String
    var showArrow: Bool
    var buttonText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // First Row
            HStack(alignment: .top) {
                
                // Title
                Text(titleText).font(.title).fontWeight(.semibold).foregroundColor(.white).multilineTextAlignment(.leading)
                
                Spacer()
                
                // Dismiss Button
                Button(action: {}) {
                    Image(systemName: "xmark").font(.headline).foregroundColor(.white)
                }.padding(.top)
                
            }.padding([.leading, .top, .trailing])
            
            
            Text(bodyText).font(.body).multilineTextAlignment(.leading).foregroundColor(.white).padding([.leading, .top, .trailing]).opacity(0.75).fixedSize(horizontal: false, vertical: true) 
            
            Button(action: {
                print("Delete tapped!")
            }) {
                HStack {
                    Text(buttonText)
                        .fontWeight(.semibold)
                        .font(.callout)
                    if (showArrow == true) {
                        Image(systemName: "arrow.right")
                        .font(.callout)
                    }
                }
                .padding()
                .foregroundColor(.white)
            }
            .background(Capsule())
            .padding(.all)
           
        }
            // Gradient background and corner radius
            .background(LinearGradient(gradient: Gradient(colors: self.colors), startPoint: .leading, endPoint: .trailing)).clipShape(RoundedRectangle(cornerRadius: 12)).shadow(color: Color.gray, radius: 12, x: 0, y: 0)
            .padding([.all])
                
        
    }
}

extension BannerCard {
    init(colors: [Color], title: String, body: String, buttonText: String, showArrow: Bool) {
        self.colors = colors
        self.bodyText = body
        self.titleText = title
        self.buttonText = buttonText
        self.showArrow = showArrow
    }
}

struct categoryCard: View {
    var bgColor: Color
    var iconImage: Image
    var title: String
    
    var body: some View {
        VStack {
            iconImage.resizable().frame(width: 40, height: 40).aspectRatio(contentMode: .fit)
            Text(title).font(.callout).fontWeight(.medium).foregroundColor(Color.black.opacity(0.7))
            }.padding().background(bgColor).clipShape(RoundedRectangle(cornerRadius: 12))
            .shadow(color: Color.gray.opacity(0.5), radius: 12, x: 0, y: 0)
       
        
    }
}








extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
