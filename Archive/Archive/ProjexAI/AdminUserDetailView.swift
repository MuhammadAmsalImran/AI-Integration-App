//
//  AdminUserDetailView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct AdminUserDetailView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: 24) {
                    Circle()
                        .fill(Theme.gold)
                        .frame(width: 90, height: 90)

                    Text("Urmi Popuri")
                        .font(.title2.bold())
                        .foregroundColor(Theme.whiteText)
                    Text("Active User")
                        .font(.subheadline)
                        .foregroundColor(Theme.mutedText)

                    VStack(spacing: 12) {
                        detailRow(icon: "envelope.fill", title: "Email",
                                  value: "urmi.p@university.edu")
                        detailRow(icon: "graduationcap.fill", title: "University",
                                  value: "State University")
                        detailRow(icon: "calendar", title: "Joined",
                                  value: "Oct 10, 2025")
                    }

                    HStack(spacing: 16) {
                        statCard(title: "5", subtitle: "Projects")
                        statCard(title: "12", subtitle: "Tasks Done")
                    }

                    Spacer()

                    Button(role: .destructive) {
                        // deactivate user
                    } label: {
                        Text("Deactivate User")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.2))
                            .foregroundColor(.red)
                            .cornerRadius(16)
                    }

                }
                .padding(24)
            }
            .navigationTitle("User Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(Theme.gold)
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(Theme.mutedText)
                Text(value)
                    .foregroundColor(Theme.whiteText)
            }
            Spacer()
        }
        .padding()
        .background(Theme.surface)
        .cornerRadius(16)
    }

    func statCard(title: String, subtitle: String) -> some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.title2.bold())
                .foregroundColor(Theme.gold)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(Theme.mutedText)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Theme.surface)
        .cornerRadius(16)
    }
}

