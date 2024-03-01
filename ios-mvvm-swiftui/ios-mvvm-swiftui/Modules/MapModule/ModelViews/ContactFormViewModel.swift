//
//  ContactFormViewModel.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 1/3/24.
//

import Foundation
import CoreData

struct FormData {
    var name: String
    var surname: String
    var email: String
    var phone: String
    var date: Date
    var details: String
}

class ContactFormViewModel: ObservableObject {
    @Published var successSubmit: Bool = false
    @Published var formData: FormData = FormData(name: "",
                                                 surname: "",
                                                 email: "",
                                                 phone: "",
                                                 date: Date(),
                                                 details: "")
    let dataManager: DataManager
    
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    func submitForm() {
        let issue = Issue(context: dataManager.viewContext)
        issue.name = formData.name
        issue.surname = formData.surname
        issue.email = formData.email
        issue.phone = formData.phone
        issue.date = formData.date
        issue.details = formData.details
        
        successSubmit = dataManager.saveContext()
    }
}
