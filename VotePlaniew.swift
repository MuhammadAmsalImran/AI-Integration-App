//
//  VotePlaniew.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//

import SwiftUI

struct VotePlanView: View {
    @State private var approved = false
    @State private var rejected = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {

                        Text("Proposed Timeline")
                            .font(.headline)
                            .foregroundColor(Theme.whiteText)

                        Text("AI has generated a project plan based on team skills and deadlines.")
                            .font(.subheadline)
                            .foregroundColor(Theme.mutedText)

                        VStack(alignment: .leading, spacing: 12) {
                            planRow(title: "Week 1–2: Research", subtitle: "Urmi Popuri")
                            planRow(title: "Week 3–4: Design", subtitle: "Muhammad Amsal Imran")
                            planRow(title: "Week 5–7: Development", subtitle: "Full Team")
                        }
                        .padding()
                        .background(Theme.surface)
                        .cornerRadius(18)

                        Text("Team Votes")
                            .font(.headline)
                            .foregroundColor(Theme.whiteText)

                        VStack(spacing: 12) {
                            voteRow(name: "Urmi Popuri", status: approved ? "Approved" : "Pending")
                            voteRow(name: "Muhammad Amsal Imran", status: rejected ? "Rejected" : "Pending")
                        }

                        HStack(spacing: 16) {
                            Button {
                                approved = true
                                rejected = false
                            } label: {
                                Label("Approve", systemImage: "hand.thumbsup.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }

                            Button {
                                rejected = true
                                approved = false
                            } label: {
                                Label("Reject", systemImage: "hand.thumbsdown.fill")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                        }
                        .padding(.top, 8)

                        Spacer()
                    }
                    .padding(24)
                }
            }
            .navigationTitle("Vote on AI Plan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func planRow(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .foregroundColor(Theme.whiteText)
            Text(subtitle)
                .font(.caption)
                .foregroundColor(Theme.mutedText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func voteRow(name: String, status: String) -> some View {
        HStack {
            Text(name)
                .foregroundColor(Theme.whiteText)
            Spacer()
            Text(status)
                .font(.caption)
                .foregroundColor(status == "Approved" ? .green : status == "Rejected" ? .red : Theme.mutedText)
        }
        .padding()
        .background(Theme.surface)
        .cornerRadius(16)
    }
}
