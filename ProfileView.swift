//
//  ProfileView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showAdmin = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: 24) {
                    if let user = appState.currentUser {
                        VStack(spacing: 12) {
                            Circle()
                                .fill(Theme.gold)
                                .frame(width: 80, height: 80)

                            Text(user.name)
                                .font(.title2.bold())
                                .foregroundColor(Theme.whiteText)

                            Text(user.email)
                                .font(.footnote)
                                .foregroundColor(Theme.mutedText)

                            Text(user.university)
                                .font(.footnote)
                                .foregroundColor(Theme.silver)
                        }
                    }

                    Toggle("Admin Mode", isOn: Binding(
                        get: { appState.currentUser?.isAdmin ?? false },
                        set: { _ in appState.toggleAdminMode() }
                    ))
                    .tint(Theme.gold)
                    .foregroundColor(Theme.whiteText)
                    .padding()

                    if appState.currentUser?.isAdmin == true {
                        Button {
                            showAdmin = true
                        } label: {
                            Text("Open Admin Dashboard")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Theme.gold)
                                .cornerRadius(14)
                        }
                    }

                    Button(role: .destructive) {
                        appState.isAuthenticated = false
                        appState.currentUser = nil
                    } label: {
                        Text("Sign Out")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.surface)
                            .cornerRadius(14)
                    }

                    Spacer()
                }
                .padding(24)
            }
            .navigationTitle("Profile")
            .sheet(isPresented: $showAdmin) {
                AdminDashboardView()
                    .environmentObject(appState)
            }
        }
    }
}

