//
//  SettingsView.swift
//  Basic Expense Tracker
//
//  Created by Nguyen Nha on 6/18/26.
//

import Foundation
import SwiftUI

struct SettingsView: View {

    var body: some View {

        NavigationStack {

            List {

                Section("Preferences") {

                    NavigationLink {

                        Text("Currency Settings")
                            .navigationTitle("Currency")

                    } label: {

                        Label(
                            "Currency",
                            systemImage: "dollarsign.circle"
                        )

                    }

                }

                Section("About") {

                    HStack {

                        Text("Version")

                        Spacer()

                        Text("0.6")
                            .foregroundColor(.secondary)

                    }

                }

            }
            .navigationTitle("Settings")

        }

    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {

        SettingsView()

    }

}
