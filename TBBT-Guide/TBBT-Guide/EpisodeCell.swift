//
//  EpisodeCell.swift
//  TBBT-Guide
//
//  Created by Fran Malo on 27/8/24.
//

import SwiftUI

struct EpisodeCell: View {
    //@Environment(EpisodesListViewModel.self) var vm
    
    @State var episode: Episode
    var body: some View {
        HStack {
            Text(episode.tipicNumber)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(episode.watched ? Color.blue.opacity(0.5) : Color.gray.opacity(0.5))
                )
            
            Text(episode.name)
            Spacer()
            Image(systemName: "heart.fill")
                .foregroundStyle(episode.isFavorited ? .red : .clear)
        }
    }
}

#Preview {
    List {
        EpisodeCell(episode: .preview1)
        //.environment(EpisodesListViewModel())
        EpisodeCell(episode: .preview2)
        //.environment(EpisodesListViewModel())
    }
}
