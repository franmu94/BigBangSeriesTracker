//
//  EpisodeCell.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 27/8/24.
//

import SwiftUI

struct EpisodeCell: View {
    @Environment(EpisodesListViewModel.self) var vm

    @State var episode: Episode
    var correctedNumber: String {
        episode.number > 10 ? "0\(episode.number)" : "\(episode.number)"
    }
    var body: some View {
        HStack {
            HStack() {
                Text("\(episode.season)x\(episode.number < 10 ? "0\(episode.number)" : "\(episode.number)")")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(episode.watched ? Color.gray.opacity(0.5) : Color.blue.opacity(0.5))
                    )
                
                Text(episode.name)
            }
            Spacer()
            Button {
                vm.favoritedToggle(episode: episode)
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(episode.isFavorited ? .red : .gray)
            }
            
            
        }
    }
}

#Preview {
    List {
        EpisodeCell(episode: .preview1)
            .environment(EpisodesListViewModel())
        EpisodeCell(episode: .preview2)
            .environment(EpisodesListViewModel())
    }
}
