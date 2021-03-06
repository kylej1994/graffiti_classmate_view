//
//  APITests.swift
//  Graffiti
//
//  Created by Amanda Aizuss on 2/6/17.
//  Copyright © 2017 Amanda Aizuss. All rights reserved.
//

import XCTest
import CoreLocation

class ApiTests: XCTestCase {
    let session = MockSessionManager()
    let auth = MockAuth()
    var api: API!
    
    override func setUp() {
        super.setUp()
        
        api = API(manager: session, auth: auth)
    }
    
    //MARK: User Call Tests
    func testGetUser() {
        api.getUser(userid: 1234) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/user/1234")
        
        XCTAssertEqual(session.lastMethod, .get)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testUpdateUser() {
        let user = User(id: 1234, username: "username", name: "name", email: "email", bio: "bio")
        
        api.updateUser(user: user) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/user/1234")
        
        XCTAssertEqual(session.lastMethod, .put)
        XCTAssertEqual(session.lastParameters?["userid"] as! Int, 1234)
        XCTAssertEqual(session.lastParameters?["username"] as! String, "username")
        XCTAssertEqual(session.lastParameters?["name"] as! String, "name")
        XCTAssertEqual(session.lastParameters?["email"] as! String, "email")
        XCTAssertEqual(session.lastParameters?["bio"] as! String, "bio")
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testLogin() {
        api.login() { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/user/login")
        
        XCTAssertEqual(session.lastMethod, .get)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testGetUserPosts() {
        api.getUserPosts(userid: 1234) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/user/1234/posts")
        
        XCTAssertEqual(session.lastMethod, .get)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    //MARK: Post Call Tests
    
    func testCreatePost() {
        let location = CLLocation.init(latitude: 10.0, longitude: 10.0)
        let post = Post(location: location, text: "this is a post")
        
        api.createPost(post: post!) { (_) in }
        
        let url = session.lastURL as? String
        let locationParam = session.lastParameters?["location"] as! [String : Double]
        
        XCTAssertEqual(url, "/post")
        XCTAssertEqual(session.lastMethod, .post)
        XCTAssertEqual(session.lastParameters?["text"] as! String, "this is a post")
        XCTAssertEqual(session.lastParameters?["type"] as! Int, 0)
        XCTAssertEqual(locationParam["latitude"], 10.0)
        XCTAssertEqual(locationParam["longitude"], 10.0)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testDeletePost() {
        api.deletePost(postid: 1234) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/post/1234")
        
        XCTAssertEqual(session.lastMethod, .delete)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testGetPost() {
        api.getPost(postid: 1234) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/post/1234")
        
        XCTAssertEqual(session.lastMethod, .get)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testGetPostsByLocation() {
        let location: [String : Double] = [
            "longitude": 10,
            "latitude": 10
        ]
        api.getPosts(longitude: location["longitude"]!, latitude: location["latitude"]!) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/post")
        
        XCTAssertEqual(session.lastMethod, .get)
        XCTAssertEqual(session.lastParameters as! [String : Double], location)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
    func testVoteOnPost() {
        let vote: VoteType = .upVote
        api.voteOnPost(postid: 1234, vote: vote) { (_) in }
        
        let url = session.lastURL as? String
        XCTAssertEqual(url, "/post/1234/vote")
        
        XCTAssertEqual(session.lastMethod, .put)
        XCTAssertEqual(session.lastParameters?["vote"] as! Int, vote.rawValue)
        
        let token = session.lastHeaders?["Authorization"]
        XCTAssertNotNil(token)
    }
    
}
