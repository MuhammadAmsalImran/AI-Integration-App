//
//  ProjectOverviewView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct ProjectOverviewView: View {
    let project: Project
    @State private var showCalendar = false
    @State private var showAIChat = false
    @State private var showVotePlan = false

    var body: some View {
        ZStack {
            Theme.background.ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    Text(project.name)
                        .font(.title2.bold())
                        .foregroundColor(Theme.whiteText)

                    Text("Due: \(project.dueDate.formatted(date: .abbreviated, time: .omitted))")
                        .foregroundColor(Theme.mutedText)

                    GroupBoxLabel(title: "Team Members")
                    VStack(spacing: 12) {
                        ForEach(project.members, id: \.self) { member in
                            HStack {
                                Circle()
                                    .fill(Theme.goldSoft)
                                    .frame(width: 36, height: 36)
                                VStack(alignment: .leading) {
                                    Text(member)
                                        .foregroundColor(Theme.whiteText)
                                    Text("Member")
                                        .font(.caption2)
                                        .foregroundColor(Theme.mutedText)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Theme.surface)
                            .cornerRadius(14)
                        }
                    }

                    GroupBoxLabel(title: "Upcoming Tasks")

                    VStack(spacing: 12) {
                        ForEach(project.tasks) { task in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.title)
                                    .foregroundColor(Theme.whiteText)
                                Text("Due: \(task.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption)
                                    .foregroundColor(Theme.mutedText)
                            }
                            .padding()
                            .background(Theme.surface)
                            .cornerRadius(14)
                        }
                    }

                    HStack(spacing: 16) {
                        Button {
                            showCalendar = true
                        } label: {
                            Label("Calendar", systemImage: "calendar")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.surface)
                                .foregroundColor(Theme.gold)
                                .cornerRadius(16)
                        }

                        Button {
                            showVotePlan = true
                        } label: {
                            Label("AI Plan", systemImage: "chart.bar.doc.horizontal")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.gold)
                                .foregroundColor(.black)
                                .cornerRadius(16)
                        }
                    }

                    Button {
                        showAIChat = true
                    } label: {
                        Label("AI Chat", systemImage: "bubble.left.and.bubble.right.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.surfaceAlt)
                            .foregroundColor(Theme.silver)
                            .cornerRadius(16)
                    }

                    Spacer()
                }
                .padding(24)
            }
        }
        .navigationTitle(project.name)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showCalendar) {
            ProjectCalendarView(project: project)
        }
        .sheet(isPresented: $showAIChat) {
            AIChatView()
        }
        .sheet(isPresented: $showVotePlan) {
            VotePlanView()
        }
    }
}

struct GroupBoxLabel: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(Theme.whiteText)
    }
}

