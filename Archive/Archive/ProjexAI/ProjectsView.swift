//
//  ProjectsView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct ProjectsView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                List {
                    ForEach(appState.projects) { project in
                        NavigationLink {
                            ProjectOverviewView(project: project)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(project.name)
                                    .foregroundColor(Theme.whiteText)
                                Text("Due \(project.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption)
                                    .foregroundColor(Theme.mutedText)
                            }
                        }
                        .listRowBackground(Theme.surface)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Projects")
        }
    }
}

