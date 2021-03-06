//
//  CGSSEvent.swift
//  DereGuide
//
//  Created by zzk on 2016/10/9.
//  Copyright © 2016年 zzk. All rights reserved.
//

import UIKit

extension CGSSEvent {
    var eventType: CGSSEventTypes {
        return CGSSEventTypes.init(eventType: type)
    }
    
    var eventColor: UIColor {
        switch eventType {
        case CGSSEventTypes.tradition:
            return Color.tradition
        case CGSSEventTypes.kyalapon:
            return Color.kyalapon
        case CGSSEventTypes.party:
            return Color.party
        case CGSSEventTypes.groove:
            return Color.groove
        case CGSSEventTypes.rail:
            return .rail
        default:
            return Color.parade
        }
    }
    var live: CGSSLive? {
        let semaphore = DispatchSemaphore.init(value: 0)
        var result: CGSSLive?
        CGSSGameResource.shared.master.getLives(liveId: liveId) { (lives) in
            result = lives.first
            semaphore.signal()
        }
        semaphore.wait()
        return result
    }
    
    var isOnGoing: Bool {
        if Date().timeIntervalSince(endDate.toDate(format: "yyyy-MM-dd HH:mm:ss")) < 15 * 3600 {
            return true
        } else {
            return false
        }
    }
    
    var detailBannerId: Int {
        return sortId - 1
    }
    
    var detailBannerURL: URL! {
        if startDate.toDate() > Date() {
            return URL.init(string: String.init(format: "https://games.starlight-stage.jp/image/event/teaser/event_teaser_%04d.png", id))
        } else {
            if detailBannerId == 20 {
                return URL.init(string: String.init(format: "https://games.starlight-stage.jp/image/announce/header/header_event_%04d_2.png", detailBannerId))
            } else {
                return URL.init(string: String.init(format: "https://games.starlight-stage.jp/image/announce/header/header_event_%04d.png", detailBannerId))
            }
        }
    }
    
}

extension CGSSEvent {
    var hasTrendLives: Bool {
        return eventType == .parade
    }
}


class CGSSEvent: CGSSBaseModel {
    @objc dynamic var sortId: Int
    var id:Int
    var type:Int
    var startDate:String
    var endDate:String
    var name:String
    var secondHalfStartDate:String
    var liveId: Int
    var ptBorders: [Int]
    var scoreBorders: [Int]
    
    var reward:[Reward]
    
    init(sortId:Int, id:Int, type:Int, startDate:String, endDate:String, name:String, secondHalfStartDate:String, reward:[Reward], liveId: Int, ptBorders: [Int], scoreBorders: [Int]) {
        self.sortId = sortId
        self.id = id
        self.type = type
        self.startDate = startDate
        self.endDate = endDate
        self.name = name
        self.secondHalfStartDate = secondHalfStartDate
        self.reward = reward
        self.liveId = liveId
        self.ptBorders = ptBorders
        self.scoreBorders = scoreBorders
        super.init()
        
        // 内部数据错误 特殊处理
        if id == 1004 {
            self.reward[0].cardId = 300135
            self.reward[1].cardId = 200129
        }
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
