//
//  EventChildView.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import SwiftUI

struct EventChildView: View {
    
    let event: LocalEvent
    let coordinate: Coordinate?
    var bookmarkTapped: () -> Void
    let distanceCalulator = DistanceCalculator()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                if let coordinate = coordinate {
                    let distance = distanceCalulator.calculate(from: coordinate, to: event.location)
                    Text("\(distance) metres")
                        .font(.footnote)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                }

            }

                
            Spacer()
            Button {
                bookmarkTapped()
            } label: {
                Image(systemName: event.isBookMarked ? "bookmark.fill" : "bookmark")
            }
            .foregroundStyle(.yellow)
            .padding(10)
            .background(
                Circle()
                    .fill(.black.opacity(0.1))
            )
            .buttonStyle(.plain)
        }
    }
}

//#Preview {
//    EvenetChildView()
//}
