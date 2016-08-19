//
//  SQLiteDataStore.swift
//  SQLiteSwift
//
//  Created by cheng way on 8/19/16.
//  Copyright © 2016 chengway. All rights reserved.
//

import Foundation
import SQLite

enum DataAccessError: ErrorType {
    case Datastore_Connection_Error
    case Insert_Error
    case Delete_Error
    case Search_Error
    case Nil_In_Data
}

class SQLiteDataStore {
    static let sharedInstance = SQLiteDataStore()
    let BBDB: Connection?
    
    private init() {
        var path = "BaseballDB.sqlite"
        
        if let dirs:[NSString] = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as [NSString] {
            let dir = dirs[0]
            path = dir.stringByAppendingPathComponent("db.sqlite")
            print(path)
        }
        
        do {
            BBDB = try Connection(path)
        } catch _ {
            BBDB = nil
        }
    }
    
    func createTables() throws {
        do {
            try TeamDataHelper.createTable()
            try PlayerDataHelper.createTable()
        } catch {
            throw DataAccessError.Datastore_Connection_Error
        }
    }
}