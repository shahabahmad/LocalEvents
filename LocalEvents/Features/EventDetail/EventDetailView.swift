//
//  EventDetailView.swift
//  LocalEvents
//
//  Created by Shahab Ahmad on 24/07/26.
//

import SwiftUI

struct EventDetailView: View {
    
    @State var viewModel: EventDetailViewModel
    
    init(viewModel: EventDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            
            Text(viewModel.event.title)
                .font(.title)
            Text(viewModel.getTimeString())
        }
        .onAppear {
            if viewModel.image == nil {
                viewModel.loadImage()
            }
        }
    }
}

//#Preview {
//    EventDetailView()
//}
