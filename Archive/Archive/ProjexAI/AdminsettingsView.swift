//
//  AdminsettingsView.swift
//  ProjexAI
//
//  Created by Kartikay Goyal on 11/14/25.
//
import SwiftUI

struct AdminSettingsView: View {
    @State private var emailNotifications = false
    @State private var userVerification = true
    @State private var autoBackup = true
    @State private var supportMode = false

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.background.ignoresSafeArea()

                Form {
                    Section("Admin Settings") {
                        Toggle("Email Notifications", isOn: $emailNotifications)
                        Toggle("User Verification", isOn: $userVerification)
                        Toggle("Auto Backup (2:00 AM)", isOn: $autoBackup)
                        Toggle("Support Mode (debug info)", isOn: $supportMode)
                    }

                    Section("System Information") {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.2").foregroundColor(Theme.mutedText)
                        }
                        HStack {
                            Text("Database")
                            Spacer()
                            Text("Online").foregroundColor(.green)
                        }
                        HStack {
                            Text("Storage")
                            Spacer()
                            Text("45% Used").foregroundColor(Theme.mutedText)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Theme.background)
            }
            .navigationTitle("Admin Settings")
        }
    }
}

