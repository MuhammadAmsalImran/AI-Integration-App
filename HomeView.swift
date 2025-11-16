import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var showAddProject = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        if let user = appState.currentUser {
                            Text("Welcome back,")
                                .foregroundColor(Theme.mutedText)
                            Text(user.name)
                                .foregroundColor(Theme.gold)
                                .font(.title2.bold())
                        }

                        HStack {
                            Text("Active Projects")
                                .font(.headline)
                                .foregroundColor(Theme.whiteText)
                            Spacer()
                            Button {
                                showAddProject = true
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .background(Theme.gold)
                                    .clipShape(Circle())
                            }
                        }

                        VStack(spacing: 16) {
                            ForEach(appState.projects) { project in
                                NavigationLink {
                                    ProjectOverviewView(project: project)
                                } label: {
                                    ProjectCard(project: project)
                                }
                            }
                        }

                        Spacer()
                    }
                    .padding(24)
                }
            }
            .navigationTitle("Projex AI")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showAddProject) {
                AddProjectView()
                    .environmentObject(appState)
            }
        }
    }
}

struct ProjectCard: View {
    var project: Project

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(project.name)
                .font(.headline)
                .foregroundColor(Theme.whiteText)

            Text("Due: \(project.dueDate.formatted(date: .abbreviated, time: .omitted))")
                .font(.caption)
                .foregroundColor(Theme.mutedText)

            Text(project.goal)
                .font(.caption)
                .foregroundColor(Theme.silver)
                .lineLimit(2)

            HStack(spacing: 8) {
                Circle().fill(Theme.goldSoft).frame(width: 10, height: 10)
                Circle().fill(Theme.silverSoft).frame(width: 10, height: 10)
                Circle().fill(Theme.gold).frame(width: 10, height: 10)

                Text("\(project.members.count) members")
                    .font(.caption)
                    .foregroundColor(Theme.mutedText)
            }
            .padding(.top, 4)
        }
        .padding()
        .background(Theme.cardGradient())
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Theme.gold.opacity(0.2), lineWidth: 1)
        )
    }
}
