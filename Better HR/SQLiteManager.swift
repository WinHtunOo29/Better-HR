//
//  SQLiteManager.swift
//  Better HR
//
//  Created by Win Htun Oo on 22/03/2024.
//

import UIKit
import FMDB

class SQLiteManager {

    static let shared = SQLiteManager()

    private let databaseFileName = "betterhr.sqlite"
    private var databasePath: String!

    private var database: FMDatabase!

    private init() {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        databasePath = documentDirectory.appending("/\(databaseFileName)")

        database = FMDatabase(path: databasePath)

        if !database.open() {
            print("Unable to open database")
        } else {
            createTable()
        }
    }

    private func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS items (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, releaseDate TEXT)"
        do {
            try database.executeUpdate(createTableQuery, values: nil)
        } catch {
            print("Error creating table: \(error.localizedDescription)")
        }
    }

    func addItem(names: [String], releaseDates: [String]) {
        guard names.count == releaseDates.count else {
            print("Error: Names and releaseDates arrays must have the same number of elements.")
            return
        }

        let insertQuery = "INSERT INTO items (name, releaseDate) VALUES (?, ?)"
        do {
            let values = zip(names, releaseDates).map { [$0, $1] }
            for value in values {
                try database.executeUpdate(insertQuery, values: value)
            }
            print("Items added successfully.")
        } catch {
            print("Error adding items: \(error.localizedDescription)")
        }
    }

    func fetchItems() -> (names: [String], releaseDates: [String]) {
        var names = [String]()
        var releaseDates = [String]()
        
        let selectQuery = "SELECT name, releaseDate FROM items"
        do {
            let resultSet = try database.executeQuery(selectQuery, values: nil)
            while resultSet.next() {
                if let name = resultSet.string(forColumn: "name"),
                   let releaseDate = resultSet.string(forColumn: "releaseDate") {
                    names.append(name)
                    releaseDates.append(releaseDate)
                }
            }
        } catch {
            print("Error fetching items: \(error.localizedDescription)")
        }
        
        return (names, releaseDates)
    }

    func deleteAllItems() {
        let deleteQuery = "DELETE FROM items"
        do {
            try database.executeUpdate(deleteQuery, values: nil)
            print("All items deleted successfully.")
        } catch {
            print("Error deleting items: \(error.localizedDescription)")
        }
    }
}
