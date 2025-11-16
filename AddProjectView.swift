//
//  AddProjectView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//

import SwiftUI

struct AddProjectView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState

    @State private var name: String = ""
    @State private var dueDate: Date = Date()
    @State private var goal: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                VStack(spacing: 24) {
                    CustomTextField(
                        title: "Project Name",
                        placeholder: "e.g. Mobile App Design",
                        text: $name
                    )

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Due Date")
                            .font(.caption)
                            .foregroundColor(Theme.mutedText)

                        DatePicker("", selection: $dueDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .tint(Theme.gold)
                            .padding()
                            .background(Theme.textFieldBackground())
                            .cornerRadius(12)
                    }

                    VStack(alignment: .leading, spacing: 6) {
                        Text("Project Goal / Description")
                            .font(.caption)
                            .foregroundColor(Theme.mutedText)

                        TextEditor(text: $goal)
                            .frame(minHeight: 120)
                            .padding(8)
                            .background(Theme.textFieldBackground())
                            .cornerRadius(12)
                            .foregroundColor(Theme.whiteText)
                    }

                    Spacer()

                    Button {
                        appState.addProject(name: name, dueDate: dueDate, goal: goal)
                        dismiss()
                    } label: {
                        Text("Create Project")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Theme.gold)
                            .cornerRadius(14)
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)

                }
                .padding(24)
            }
            .navigationTitle("New Project")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(Theme.mutedText)
                }
            }
        }
    }
}
