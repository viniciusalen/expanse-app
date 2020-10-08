//
//  File.swift
//  expanse
//
//  Created by Vinicius Alencar on 08/10/20.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary: [String:Any])
}


struct Expense {
    
    var value: Double
    var description: String
    var date: Date
    var payment: Bool
    
    var dictionary: [String:Any] {
        return [
            "valor": value,
            "description": description,
            "date": date,
            "payment": payment
        ]
    }
    
    
}

extension Expense: DocumentSerializable{
    
    init?(dictionary: [String:Any]) {
        guard let value = dictionary["value"] as? Double, let description = dictionary["description"] as? String, let date = dictionary["date"] as? Date else {
            return nil
            
        }
        return nil
        self.init(value: value, description: description, date: date, payment: payment)
    }
    
}
