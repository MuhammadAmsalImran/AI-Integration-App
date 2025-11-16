//
//  AdminDashboardView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct AdminDashboardView: View {
    @EnvironmentObject var appState: AppState
    @State private var showSettings = false
    @State private var showUserDetails = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Admin Dashboard")
                            .font(.title2.bold())
                            .foregroundColor(Theme.whiteText)

                        HStack(spacing: 16) {
                            dashboardCard(title: "1,247", subtitle: "Total Users", icon: "person.3.fill")
                            dashboardCard(title: "342", subtitle: "Active Projects", icon: "folder.fill")
                        }

                        HStack(spacing: 16) {
                            dashboardCard(title: "+23%", subtitle: "This Month", icon: "chart.line.uptrend.xyaxis")
                            dashboardCard(title: "95%", subtitle: "Task Completion", icon: "checkmark.circle.fill")
                        }

                        Text("Recent Sign-ups")
                            .font(.headline)
                            .foregroundColor(Theme.whiteText)

                        VStack(spacing: 12) {
                            Button {
                                showUserDetails = true
                            } label: {
                                recentRow(name: "Urmi Popuri", time: "2 hours ago")
                            }

                            Button {
                                showUserDetails = true
                            } label: {
                                recentRow(name: "Muhammad Amsal Imran", time: "5 hours ago")
                            }
                        }

                        Spacer()
                    }
                    .padding(24)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Theme.gold)
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                AdminSettingsView()
            }
            .sheet(isPresented: $showUserDetails) {
                AdminUserDetailView()
            }
        }
    }

    func dashboardCard(title: String, subtitle: String, icon: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                Spacer()
            }
            .foregroundColor(Theme.gold)

            Text(title)
                .font(.title2.bold())
                .foregroundColor(Theme.whiteText)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(Theme.mutedText)
        }
        .padding()
        .background(Theme.surface)
        .cornerRadius(18)
    }

    func recentRow(name: String, time: String) -> some View {
        HStack {
            Circle().fill(Theme.goldSoft).frame(width: 36, height: 36)
            VStack(alignment: .leading) {
                Text(name)
                    .foregroundColor(Theme.whiteText)
                Text(time)
                    .font(.caption2)
                    .foregroundColor(Theme.mutedText)
            }
            Spacer()
        }
        .padding()
        .background(Theme.surface)
        .cornerRadius(16)
    }
}

