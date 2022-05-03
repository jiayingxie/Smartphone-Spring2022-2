//
//  StringExtension.swift
//  Final
//
//  Created by Jiaying Xie on 5/2/22.
//

import Foundation
extension String {

    var isPositiveNumber: Bool {

        let positiveNumberRegEx = "^[1-9][0-9]*$"

        let positiveNumberTest = NSPredicate(format:"SELF MATCHES %@", positiveNumberRegEx)

        return positiveNumberTest.evaluate(with: self)

    }

}
