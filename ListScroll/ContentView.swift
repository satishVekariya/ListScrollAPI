//
//  ContentView.swift
//  ListScroll
//
//  Created by Satish Vekariya on 19/07/2024.
//

import SwiftUI

struct StretchingHeaderView: View {
    @State private var offset: CGFloat = 0
    
    let states: [String] = [
        "Gujarat - GJ",
        "Andhra Pradesh - AP",
        "Arunachal Pradesh - AR",
        "Assam - AS",
        "Bihar - BR",
        "Chhattisgarh - CG",
        "Goa - GA",
        "Haryana - HR",
        "Himachal Pradesh - HP",
        "Jharkhand - JH",
        "Karnataka - KA",
        "Kerala - KL",
        "Madhya Pradesh - MP",
        "Maharashtra - MH",
        "Manipur - MN",
        "Meghalaya - ML",
        "Mizoram - MZ",
        "Nagaland - NL",
        "Odisha - OD",
        "Punjab - PB",
        "Rajasthan - RJ",
        "Sikkim - SK",
        "Tamil Nadu - TN",
        "Telangana - TS",
        "Tripura - TR",
        "Uttar Pradesh - UP",
        "Uttarakhand - UK",
        "West Bengal - WB",
    ]

    var body: some View {
        List {
            Spacer()
                .frame(height: 221)
                .listRowBackground(EmptyView())
            ForEach(states, id: \.self) { state in
                Text(state)
                    .listRowBackground(EmptyView())
                    .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .background(alignment: .top) {
            TheIndianFlag(offset: offset)
                .frame(height: 221 + max(0, -offset))
                .transformEffect(.init(translationX: 0, y: -(max(0, offset))))
        }
        .onScrollGeometryChange(for: CGFloat.self, of: { geo in
            geo.contentOffset.y + geo.contentInsets.top
        }, action: { new, old in
            offset = new
        })
    }
}

struct TheIndianFlag: View {
    let blueColor = Color(red: 6 / 255, green: 3 / 255, blue: 141 / 255)

    let offset: CGFloat
    var body: some View {
        VStack(spacing: 0) {
            Color(red: 255 / 255, green: 103 / 255, blue: 31 / 255)
            Color.white
            Color(red: 4 / 255, green: 106 / 255, blue: 56 / 255)
        }
        .distortionEffect(ShaderLibrary.simpleWave(.float(offset)), maxSampleOffset: .init(width: 8, height: 8))
        .compositingGroup()
        .overlay(alignment: .center) {
            VStack(spacing: 0){
                Color.clear
                Circle()
                    .stroke(blueColor, lineWidth: 4)
                    .overlay {
                        // Spokes
                        ForEach(0..<24) { i in
                            Capsule()
                                .fill(blueColor)
                                .frame(width: 1)
                                .rotationEffect(.degrees(Double(i) * 15))
                                .padding(.all, 6)
                        }
                    }
                    .clipShape(.circle)
                    .padding()
                    .rotationEffect(.degrees(offset))
                Color.clear
            }
        }
    }
}


#Preview {
    StretchingHeaderView()
}
