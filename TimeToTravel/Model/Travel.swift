//
//  Travel.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 04.06.2022.
//

import Foundation
import AnyCodable

struct Travel: Codable {
    let meta: AnyCodable
    let data: [Flight]
}
