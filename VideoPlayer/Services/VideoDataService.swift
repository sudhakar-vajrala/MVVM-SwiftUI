//
//  VideoDataService.swift
//  VideoPlayer
//
//  Created by Venkata Sudhakar Reddy on 12/04/25.
//

import Foundation

protocol VideoService {
    func fetchVideos() async -> [Video]
    func toggleFavorite(of video: Video) -> Video
}

final class VideoDataService: VideoService {
    
    let videoStore: VideoStore
    
    init(videoStore: VideoStore = InMemoryVideoStore()) {
        self.videoStore = videoStore
    }
    
    func fetchVideos() async -> [Video] {
        await videoStore.fetchVideos()
    }
    
    func toggleFavorite(of video: Video) -> Video {
        videoStore.toggleFavorite(of: video)
    }
}

// MARK: MockService

final class MockVideoDataService: VideoService {
    
    let videoStore: VideoStore
    
    init(videoStore: VideoStore = InMemoryVideoStore()) {
        self.videoStore = videoStore
    }
    
    func fetchVideos() async -> [Video] {
        defaultVideos
    }
    
    func toggleFavorite(of video: Video) -> Video {
        var copy = video
        copy.isFavorite.toggle()
        return copy
    }
}
