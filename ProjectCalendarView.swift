//
//  ProjectCalendarView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct ProjectCalendarView: View {
    let project: Project

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 24) {
                    Text("Project Calendar")
                        .font(.title2.bold())
                        .foregroundColor(Theme.whiteText)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Theme.surface)
                        .overlay(
                            VStack(spacing: 16) {
                                Text(project.dueDate, format: .dateTime.month(.wide).year())
                                    .foregroundColor(Theme.silver)

                                // very simple pseudo calendar: just show task dates
                                ForEach(project.tasks) { task in
                                    HStack {
                                        Text(task.dueDate.formatted(date: .numeric, time: .omitted))
                                            .foregroundColor(Theme.gold)
                                        Spacer()
                                        Text(task.title)
                                            .foregroundColor(Theme.whiteText)
                                    }
                                }
                            }
                            .padding()
                        )
                        .frame(height: 230)

                    Text("Upcoming Deadlines")
                        .font(.headline)
                        .foregroundColor(Theme.whiteText)

                    VStack(spacing: 12) {
                        ForEach(project.tasks) { task in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.title)
                                    .foregroundColor(Theme.whiteText)
                                Text(task.dueDate.formatted(date: .abbreviated, time: .omitted))
                                    .font(.caption)
                                    .foregroundColor(Theme.mutedText)
                            }
                            .padding()
                            .background(Theme.surface)
                            .cornerRadius(16)
                        }
                    }

                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("Project Calendar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

