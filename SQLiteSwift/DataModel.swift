//
//  DataModel.swift
//  SQLiteSwift
//
//  Created by cheng way on 8/19/16.
//  Copyright © 2016 chengway. All rights reserved.
//

import Foundation
import SQLite

enum Positions: String {
    case Pitcher = "Pitcher"
    case Catcher = "Catcher"
    case FirstBase = "First Base"
    case SecondBase = "Second Base"
    case ThirdBase = "Third Base"
    case Shortstop = "Shortstop"
    case LeftField = "Left Field"
    case CenterField = "Center Field"
    case RightField = "Right field"
    case DesignatedHitter = "Designated Hitter"
}

typealias TeamData = (
    teamId: Int64?,
    city: String?,
    nickName: String?,
    abbreviation: String?
)

typealias PlayerData = (
    playerId: Int64?,
    firstName: String?,
    lastName: String?,
    number: Int?,
    teamId: Int64?,
    position: Positions?
)