//
//  DSPhotoListInfo.swift
//  DoSplash
//
//  Created by Komal on 17/10/20.
//  Copyright © 2020 Komal. All rights reserved.
//


import Foundation

class DSPhotoListInfo: Decodable {
    
    var alt_description : String?
    var blur_hash : String?
    var color : String?
    var created_at : String?
    var description : String?
    var height : Int?
    var id : String?
    var liked_by_user : Bool?
    var likes : Int?
    var promoted_at : String?
    var sponsorship : DSSponserInfo?
    var updated_at : String?
    var urls : DSURLInfo?
    var user : DSUserInfo?
    var links : DSLinkInfo?
    var width : Int?
}

class DSSponserInfo: Decodable {
    
    var tagline : String?
    var tagline_url : String?
}



class DSURLInfo: Decodable {
    
    var full : String?
    var raw : String?
    var regular : String?
    var small : String?
    var thumb : String?
}

class DSLinkInfo: Decodable {
    
    var download : String?
    var download_location : String?
    var html : String?
}

class DSUserInfo: Decodable {
    
    var bio : String?
    var first_name : String?
    var id : String?
    var instagram_username : String?
    var last_name : String?
    var links : DSUserLinkInfo?
    var location : String?
    var name : String?
    var portfolio_url : String?
    var username : String?
    var updated_at : String?
    var twitter_username : String?
    var profile_image : DSProfileImageInfo?

}

class DSUserLinkInfo: Decodable {
    
    var followers : String?
    var following : String?
    var html : String?
    var likes : String?
    var photos : String?
    var portfolio : String?
}


class DSProfileImageInfo: Decodable {
    
    var large : String?
    var medium : String?
    var small : String?
}


