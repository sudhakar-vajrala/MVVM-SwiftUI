//
//  HomeView.swift
//  VideoPlayer
//
//  Created by Venkata Sudhakar Reddy on 11/04/25.
//
import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            appTitle.padding(.bottom, 10)
            
            VideoPlayerView(url: viewModel.state.chosenVideo?.url)
                .showIf(viewModel.state.chosenVideo != nil)
            videoInfo
            videoSelector
            
        }
        .task { await viewModel.action(.onAppear) }
    }
}

fileprivate extension HomeView {
    
    var appTitle: some View {
        Text("Video Player")
            .font(.largeTitle)
            .fontWeight(.heavy)
            .background(
                LinearGradient(
                    gradient: .init(colors: [.red, .yellow, .green, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing
                )
                .opacity(0.3)
                .blur(radius: 25)
                .shadow(radius: 25)
                .scaleEffect(CGSize(width: 1.2, height: 1.2))
            )
    }
    
    @ViewBuilder
    var videoInfo: some View {
        if let video = viewModel.state.chosenVideo {
        VStack(spacing: 0) {
            VideoRow(model: viewModel.viewModel(for: video), isVideoInfoView: true)
            .padding(.horizontal)
            .padding(.vertical, 6)

          Rectangle()
            .fill(Color.primary.opacity(0.2))
            .frame(maxWidth: .infinity)
            .frame(height: 1)
        }
      }
    }
    
    
    var videoSelector: some View {
      List {
        videoFilter

        ForEach(WeekDays.allCases, id: \.self) {
          videoRows(groupedBy: $0)
        }
      }
      .listStyle(.grouped)
    }
    
    var videoFilter: some View {
      Section(header: Text("Video Filter").fontWeight(.heavy)) {
        showFavoriteToggle
        platformSegmentedPicker
      }
    }
    
    var showFavoriteToggle: some View {
        Toggle(isOn: $viewModel.state.showFavoriteOnly) {
        Text("Show Favorite Only")
                .font(.headline)
      }
    }
    
    var platformSegmentedPicker: some View {
        Picker("", selection: $viewModel.state.chosenPlatform) {
          ForEach(viewModel.state.platforms, id: \.self) { platform in
          Text(platform)
            .tag(Platform(rawValue: platform))
        }
      }
      .pickerStyle(SegmentedPickerStyle())
    }
    
    func videoRows(groupedBy weekday: WeekDays) -> some View {
        let viewModels = viewModel.videoViewModelGrouped(by: weekday)
      let headerText = "\(weekday.rawValue.capitalized) (\(viewModels.count))"
      return Section(header: Text(headerText).fontWeight(.heavy)) {
        ForEach(viewModels) { model in
          VideoRow(model: model)
            .contentShape(Rectangle())
            .onTapGesture {
                Task { await viewModel.action(.chosenVideo(model.state.video)) }
            }
        }
      }
    }
    
}

#Preview {
    HomeView()
}
