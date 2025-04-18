//
//  VideoRowViewModel.swift
//  VideoPlayer
//
//  Created by Venkata Sudhakar Reddy on 12/04/25.
//

import Foundation

final class VideoRowViewModel: ObservableObject, Identifiable {
    
    @Published var state: State
    let videoService: VideoService
    
    init(state: State, videoService: VideoService) {
        self.state = state
        self.videoService = videoService
        self.action(.initialize)
    }
    
    
    struct State {
        var video: Video
    }
    
    
    enum Action {
        case initialize
        case onAppear
        case toggleFavorite
    }
    
    
    func action(_ action: Action) {
        switch action {
        case .initialize:
            break
        case .onAppear:
            break
        case .toggleFavorite:
            state.video = videoService.toggleFavorite(of: state.video)
        }
    }
    
    
}

extension VideoRowViewModel {
    var platforms: String {
        state.video.platforms
            .map({ $0.rawValue })
            .joined(separator: ", ")
    }
    var timeFormattedDuration: String {
        let hours = state.video.duration / 3600
        let minutes = (state.video.duration % 3600) / 60
        let seconds = (state.video.duration % 3600) % 60
        return String(format: "%2d:%02d:%02d", hours, minutes, seconds)
    }
}
