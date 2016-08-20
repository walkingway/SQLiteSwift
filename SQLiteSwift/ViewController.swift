//
//  ViewController.swift
//  SQLiteSwift
//
//  Created by cheng way on 8/19/16.
//  Copyright © 2016 chengway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dataStore = SQLiteDataStore.sharedInstance
        do {
            try dataStore.createTables()
            setDataGood()
        } catch _ {}
        
        print("Finish")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setDataGood() {
        var swiftGG = Team(teamId: 0,
                       city: "BeiJing",
                       nickName: "Swift GG",
                       abbreviation: "SG")
        
        _ = try? TeamBridge.save(&swiftGG)
        print("\(swiftGG.teamId)")
        
        var way = Player(playerId: 0,
                         firstName: "Cheng",
                         lastName: "Way",
                         number: 32,
                         position: Positions.DesignatedHitter,
                         teamId: swiftGG.teamId)
        
        _ = try? PlayerBridge.save(&way)
        print("\(way.playerId) \(way.team?.nickName)")
    }
    
    func setDataBad() {
        let swiftGGId = try? TeamDataHelper.insert(
            TeamData(teamId: 0,
                city: "Xi'An",
                nickName: "Nuncle Way",
                abbreviation: "SWay"))
        print(swiftGGId)
        
        let wayId = try? PlayerDataHelper.insert(
            PlayerData(playerId: 0,
                firstName: "Cheng",
                lastName: "Way",
                number: 32,
                teamId: swiftGGId,
                position: Positions.DesignatedHitter
        ))
        print(wayId)
        
        let bogeyId = try? PlayerDataHelper.insert(
            PlayerData(
                playerId: 0,
                firstName: "Xander",
                lastName: "Bogarts",
                number: 2,
                teamId: swiftGGId,
                position: Positions.Shortstop
            ))
        print(bogeyId)
        
        let baltId = try? TeamDataHelper.insert(
            TeamData(
                teamId: 0,
                city: "Baltimore",
                nickName: "Orioles",
                abbreviation: "BAL"))
        print(baltId)
        
        let tampId = try? TeamDataHelper.insert(
            TeamData(
                teamId: 0,
                city: "Tampa Bay",
                nickName: "Rays",
                abbreviation: "TB"))
        print(tampId)
        
        let torId = try? TeamDataHelper.insert(
            TeamData(
                teamId: 0,
                city: "Toronto",
                nickName: "Blue Jays",
                abbreviation: "TOR"))
        print(torId)
        
        do {
            if let teams = try TeamDataHelper.findAll() {
                for team in teams {
                    print("\(team.city!) \(team.nickName)")
                    try TeamDataHelper.delete(team)
                }
            }
        } catch _ {}

    }
    
    func setPlayer() {
        
    }

}

