//
//  ProfileView.swift
//  ScentMatchView
//
//  Created by Najla adel alabdullah on 11/09/1446 AH.
//

import SwiftUI
import CloudKit

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Image("BG").resizable().scaledToFill().ignoresSafeArea()

                VStack {
                    // ✅ Back + Edit Button
                    HStack {
                        Button(action: { presentationMode.wrappedValue.dismiss() }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        
                        Button(action: {
                            if viewModel.isEditing { viewModel.saveProfileData() }
                            viewModel.isEditing.toggle()
                        }) {
                            Image(systemName: viewModel.isEditing ? "checkmark" : "pencil")
                                .font(.system(size: 24))
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 25)
                    }
                    .padding(.horizontal)
                    .padding(.top, -60)

                    // ✅ Profile Header (Editable Image)
                    ProfileHeader(viewModel: viewModel)

                    // ✅ Editable Profile Details
                    if let user = viewModel.user {
                        ProfileDetails(user: user, viewModel: viewModel, isEditing: viewModel.isEditing)
                    }

                    // ✅ Delete Account Button
                    DeleteAccountButton()
                }
            }
            .navigationBarHidden(true)
        }
    }
}


// ✅ Profile Header (Handles Profile Image)
struct ProfileHeader: View {
    @ObservedObject var viewModel: ProfileViewModel
    @State private var showImagePicker = false

    var body: some View {
        HStack(spacing: 12) {
            Button(action: { showImagePicker = true }) {
                if let image = viewModel.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                }
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(selectedImage: $viewModel.selectedImage)
            }

            Text(viewModel.user?.fullName ?? "Unknown User")
                .font(.title)
                .foregroundColor(.white)
                .bold()
            
            Spacer()
        }
        .padding()
    }
}

// ✅ Profile Details (Editable Fields)
struct ProfileDetails: View {
    var user: UserModel
    @ObservedObject var viewModel: ProfileViewModel
    var isEditing: Bool

    @State private var selectedDate: Date = Date()

    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 20) {
                // ✅ Gender Picker
                if isEditing {
                    Picker("Gender", selection: Binding(get: {
                        user.gender ?? "Female"
                    }, set: { viewModel.user?.gender = $0 })) {
                        Text("Female").tag("Female")
                        Text("Male").tag("Male")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                } else {
                    ProfileRow(icon: "person.fill", title: user.gender ?? "Not Set")
                }

                // ✅ Date Picker for Birthday
                if isEditing {
                    DatePicker("", selection: Binding(get: {
                        if let birthdayString = user.birthday,
                           let date = DateFormatter.defaultFormatter.date(from: birthdayString) {
                            return date
                        } else {
                            return Date()
                        }
                    }, set: { newDate in
                        viewModel.user?.birthday = DateFormatter.defaultFormatter.string(from: newDate)
                    }), displayedComponents: .date)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
                } else {
                    ProfileRow(icon: "calendar", title: user.birthday ?? "Not Set")
                }
            }

            // ✅ Phone Field
            if isEditing {
                EditableProfileRow(icon: "phone.fill", placeholder: "Phone",
                                   text: Binding(get: { user.phone ?? "" },
                                                 set: { viewModel.user?.phone = $0 }))
            } else {
                ProfileRow(icon: "phone.fill", title: user.phone ?? "Not Set")
            }

            // ✅ Email (Fixed)
            ProfileRow(icon: "envelope.fill", title: user.email, isUnderlined: true)

            // ✅ Appearance (Fixed)
            ProfileRow(icon: "sun.max.fill", title: "Appearance")

            // ✅ Customer Service (Fixed)
            ProfileRow(icon: "headphones", title: "Customer Service")
        }
        .padding()
    }
}


// ✅ Editable Profile Row (For Gender, Birthday, Phone)
struct EditableProfileRow: View {
    var icon: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
            TextField(placeholder, text: $text)
                .foregroundColor(.white)
                .font(.title2)
            Spacer()
        }
        .padding()
        .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
    }
}

// ✅ Profile Row Component
struct ProfileRow: View {
    var icon: String
    var title: String
    var isUnderlined: Bool = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.title2)
            Text(title)
                .foregroundColor(.white)
                .font(.title2)
                .underline(isUnderlined)
            Spacer()
        }
        .padding()
        .overlay(Rectangle().stroke(Color.white.opacity(0.2), lineWidth: 1))
    }
}

// ✅ Delete Account Button
struct DeleteAccountButton: View {
    var body: some View {
        Button(action: {
            print("Delete Account")
        }) {
            Text("Delete My Account")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(red: 0.4, green: 0.1, blue: 0.15))
                .cornerRadius(10)
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
    }
}

// ✅ Date Formatter Extension
extension DateFormatter {
    static let defaultFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
}

#Preview {
    ProfileView()
}
