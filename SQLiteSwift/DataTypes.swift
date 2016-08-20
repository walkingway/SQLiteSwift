//
//  DataTypes.swift
//  SQLiteSwift
//
//  Created by cheng way on 8/20/16.
//  Copyright © 2016 chengway. All rights reserved.
//

import Foundation

struct Team {
    var teamId: Int64?
    var city: String?
    var nickName: String?
    var abbreviation: String?
    
    init(teamId: Int64?, city: String?, nickName: String?, abbreviation: String?) {
        self.teamId = teamId
        self.city = city
        self.nickName = nickName
        self.abbreviation = abbreviation
    }
}

struct Player {
    var playerId: Int64?
    var firstName: String?
    var lastName: String?
    var number: Int?
    var position: Positions?
    var team: Team?
    var teamId: Int64? {
        didSet {
            if let t = try? TeamBridge.retrieve(teamId!) {
                team = t
            }
        }
    }
    
    init(playerId: Int64?, firstName: String?, lastName: String?, number: Int?, position: Positions?, teamId: Int64?) {
        self.playerId = playerId
        self.firstName = firstName
        self.lastName = lastName
        self.number = number
        self.position = position
        self.teamId = teamId
        if let id = self.teamId {
            if let t  = try? TeamBridge.retrieve(id) {
                team = t
            }
        }
    }
}

struct TeamBridge {
    
    static func save(inout team: Team) throws {
        let teamData = toTeamData(team)
        let id = try TeamDataHelper.insert(teamData)
        team.teamId = id
    }
    
    static func delete(team: Team) throws {
        let teamData = toTeamData(team)
        try TeamDataHelper.delete(teamData)
    }
    
    static func retrieve(id: Int64) throws -> Team? {
        if let t = try TeamDataHelper.find(id) {
            return toTeam(t)
        }
        return nil
    }
    
    static func toTeamData(team: Team) -> TeamData {
        return TeamData(teamId: team.teamId,
                        city: team.city,
                        nickName: team.nickName,
                        abbreviation: team.abbreviation)
    }
    
    static func toTeam(teamData: TeamData) -> Team {
        return Team(teamId: teamData.teamId,
                    city: teamData.city,
                    nickName: teamData.nickName,
                    abbreviation: teamData.abbreviation)
    }
}

struct PlayerBridge {
    
    static func save(inout player: Player) throws {
        let playerData = toPlayerData(player)
        let id = try PlayerDataHelper.insert(playerData)
        player.playerId = id
    }
    
    static func delete(player: Player) throws {
        let playerData = toPlayerData(player)
        try PlayerDataHelper.delete(playerData)
    }
    
    static func retrieve(id: Int64) throws -> Player? {
        if let p = try PlayerDataHelper.find(id) {
            return toPlayer(p)
        }
        return nil
    }
    
    static func toPlayerData(player: Player) -> PlayerData {
        return PlayerData(playerId: player.playerId,
                          firstName: player.firstName,
                          lastName: player.lastName,
                          number: player.number,
                          teamId: player.teamId,
                          position: player.position)
    }
    
    
    static func toPlayer(playerData: PlayerData) -> Player {
        return Player(playerId: playerData.playerId, firstName: playerData.firstName, lastName: playerData.lastName, number: playerData.number, position: playerData.position, teamId: playerData.teamId)
    }
}