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
    var time: Date
    var details: String
}

class ContactFormViewModel: ObservableObject {
    @Published var formData: FormData = FormData(name: "",
                                                 surname: "",
                                                 email: "",
                                                 phone: "",
                                                 date: Date(),
                                                 time: Date(),
                                                 details: "")
    @Published var successSubmit: Bool = false
    
    func submitForm() {
        let issue = Issue(context: CoreDataManager.shared.viewContext)
        issue.name = formData.name
        issue.surname = formData.surname
        issue.email = formData.email
        issue.phone = formData.phone
        issue.date = formData.date
        issue.time = formData.time
        issue.details = formData.details
        
        successSubmit = CoreDataManager.shared.saveIssue()
    }
}
