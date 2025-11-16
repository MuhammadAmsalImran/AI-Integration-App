//
//  QuickQuestionsView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct QuickQuestionsView: View {
    let onSelect: (String) -> Void

    let questions = [
        "Create project timeline",
        "Divide tasks by skills",
        "Suggest milestones",
        "Balance workload",
        "Set deadline reminders"
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                List {
                    ForEach(questions, id: \.self) { q in
                        Button {
                            onSelect(q)
                        } label: {
                            HStack {
                                Text(q)
                                    .foregroundColor(Theme.whiteText)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Theme.mutedText)
                            }
                        }
                        .listRowBackground(Theme.surface)
                    }
                }
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Quick Questions")
        }
    }
}

