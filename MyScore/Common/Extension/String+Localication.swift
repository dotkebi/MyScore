//
//  String+Localication.swift
//  MyScore
//
//  Created by dotkebi on 2018. 5. 23..
//  Copyright © 2018년 dotkebi. All rights reserved.
//

import Foundation

extension String {
    var lo: String {
        return NSLocalizedString(self, comment: self)
    }
}

