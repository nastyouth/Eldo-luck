//
//  Quote.swift
//  Eldo Luck
//
//  Created by Анастасия on 15.05.2020.
//  Copyright © 2020 Анастасия. All rights reserved.
//

import Foundation
import RealmSwift

class Quote: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var text: String = ""
}
