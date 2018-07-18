////
////  MusicSelection.swift
////  RapApp
////
////  Created by Michael Hayashi on 7/18/18.
////  Copyright © 2018 Michael Hayashi. All rights reserved.
////
//
////
////  User.swift
////  Makestagram
////
////  Created by Robert Keller on 7/4/18.
////  Copyright © 2018 RKIV. All rights reserved.
////
//
//import Foundation
//
////class User: NSObject {
//class MusicSelection: NSObject{
//
////    let uid: String
////    let username: String
////    var isFollowed: Bool = false
//    let musicSelected: String
//
////    private static var _current: User?
////
////    static var current: User {
////        guard let currentUser = _current else {
////            fatalError("Error: current user doesn't exist")
////        }
////
////        return currentUser
////    }
//
//
////    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false){
////        if writeToUserDefaults{
////            let data = NSKeyedArchiver.archivedData(withRootObject: user)
////
////            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
////        }
////        _current = user
////    }
//
//    static func setCurrent(_ musicSelected: MusicSelection, writeToUserDefaults: Bool = false){
//        if writeToUserDefaults{
//            let data = NSKeyedArchiver.archivedData(withRootObject: musicSelected)
//            UserDefaults.standard.set(data, forKey: "musicSelected")
//        }
//    }
//
//    init(musicSelected: String){
//        self.musicSelected = musicSelected
//    }
//
////    init(uid: String, username: String){
////        self.uid = uid
////        self.username = username
////        super.init()
////    }
////
////    init?(snapshot: DataSnapshot){
////        guard let dict = snapshot.value as? [String : Any],
////            let username = dict["username"] as? String
////            else { return nil }
////
////        self.uid = snapshot.key
////        self.username = username
////
////        super.init()
////    }
////
////    required init?(coder aDecoder: NSCoder) {
////        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
////            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
////            else { return nil }
////
////        self.uid = uid
////        self.username = username
////    }
//
//    required init?(coder aDecoder: NSCoder) {
//        guard let musicSelected = aDecoder.decodeObject(forKey: "musicSelected") as? String else {return nil}
//        self.musicSelected = musicSelected
//    }
//}
//
////extension User: NSCoding {
////    func encode(with aCoder: NSCoder) {
////        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
////        aCoder.encode(username, forKey: Constants.UserDefaults.username)
////    }
////
////}
//
//
//
//extension MusicSelection: NSCoding{
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(musicSelected, forKey: "musicSelected")
//    }
//}
//
