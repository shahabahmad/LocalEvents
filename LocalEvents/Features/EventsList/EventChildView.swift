//
//  EventChildView.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import SwiftUI

struct EventChildView: View {
    
    let event: LocalEvent
    
    var bookmarkTapped: () -> Void
    
    var body: some View {
        HStack {
            Text(event.title)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                
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
