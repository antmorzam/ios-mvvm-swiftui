//
//  FormView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 1/3/24.
//

import Foundation
import SwiftUI

enum FormAlert {
    case error, success
}

struct ContactFormView: View {
    
    @StateObject private var viewModel = ContactFormViewModel(dataManager: CoreDataManager.shared)
    @State private var isDatePickerPresented = false
    @State private var isTimePickerPresented = false
    @State private var showAlert = false
    @State private var formAlert: FormAlert = .error
    
    var body: some View {
        VStack {
            Form() {
                Section(header: Text("contact_form")
                    .font(.title)){}
                
                Section("name_data") {
                    TextField("name", text: $viewModel.formData.name)
                    TextField("surname", text: $viewModel.formData.surname)
                }
                
                Section("contact_data") {
                    TextField("email", text: $viewModel.formData.email)
                    TextField("phone_no", text: $viewModel.formData.phone)
                        .keyboardType(.phonePad)
                }
                Section("time_data") {
                    Text(dateFormatter.string(from: viewModel.formData.date))
                        .foregroundColor(.blue)
                        .onTapGesture {
                            isDatePickerPresented.toggle()
                        }
                    if isDatePickerPresented {
                        DatePicker("", selection: $viewModel.formData.date, displayedComponents: [.date])
                            .datePickerStyle(WheelDatePickerStyle())
                            .environment(\.locale, Locale(identifier: "es_ES"))
                            .environment(\.timeZone, .current)
                    }
                    Text(timeFormatter.string(from: viewModel.formData.date))
                        .foregroundColor(.blue)
                        .onTapGesture {
                            isTimePickerPresented.toggle()
                        }
                    if isTimePickerPresented {
                        DatePicker("", selection: $viewModel.formData.date, displayedComponents: [.hourAndMinute])
                            .datePickerStyle(WheelDatePickerStyle())
                            .environment(\.locale, Locale(identifier: "es_ES"))
                            .environment(\.timeZone, .current)
                    }
                }
                Section("details") {
                    ZStack(alignment: .bottomTrailing) {
                        Text("\(viewModel.formData.details.count)/200")
                            .foregroundColor(viewModel.formData.details.count == 200 ? .red : .gray)
                            .font(.caption)
                        
                        TextEditor(text: $viewModel.formData.details)
                            .multilineTextAlignment(.leading)
                            .onChange(of: viewModel.formData.details) { newValue in
                                viewModel.formData.details = String(newValue.prefix(200))
                            }
                    }
                }
                Section {
                    Button("submit") {
                        UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
                            if error != nil {
                                UIApplication.shared.applicationIconBadgeNumber = 0
                            }
                        }
                        DispatchQueue.main.async {
                            UIApplication.shared.applicationIconBadgeNumber += 1
                        }
                        checkRequiredFields()
                        showAlert = true
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
            .alert(isPresented: $showAlert) {
                switch formAlert {
                case .error:
                    return Alert(title: Text("required_field_title"),
                                 message: Text("required_field_msg"),
                                 dismissButton: .default(Text("ok")))
                case .success:
                    return Alert(title: Text("saved"),
                                 dismissButton: .default(Text("ok")))
                }
            }
        }
    }
    
    private func checkRequiredFields() {
        if !viewModel.formData.name.isEmpty && !viewModel.formData.surname.isEmpty &&
            !viewModel.formData.email.isEmpty &&
            !viewModel.formData.details.isEmpty {
            viewModel.submitForm()
            formAlert = .success
        } else {
            formAlert = .error
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateStyle = .long
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.timeStyle = .short
        return formatter
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormView()
    }
}

