//
//  CGSSGlobal.swift
//  DereGuide
//
//  Created by zzk on 16/6/28.
//  Copyright © 2016年 zzk. All rights reserved.
//

import UIKit
import Reachability

struct Config {
    static let iAPRemoveADProductIDs: Set<String> = ["dereguide_small_tips", "dereguide_medium_tips"]
    static let bundleID = "com.zzk.cgssguide"
    static let unityVersion = "5.4.5p1"
    
    static let cloudKitDebug = true
    static let maxNumberOfStoredUnits = 100
    static let maxCharactersOfMessage = 200
    
    #if DEBUG
    static let cloudKitFetchLimits = 5
    #else
    static let cloudKitFetchLimits = 20
    #endif
    
    static let appName = NSLocalizedString("DereGuide", comment: "")
}

struct NotificationCategory {
    static let birthday = "Birthday"
}

struct Path {
    static let cache = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    static let document = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    static let library = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    static let home = NSHomeDirectory()
    
    // include the last "/"
    static let temporary = NSTemporaryDirectory()
}

struct Screen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    // 当前屏幕1坐标的像素点数量
    static var scale: CGFloat {
        return UIScreen.main.scale
    }
    
    // FIXME: do not use these two, because in multi-task mode shortSide or longSide does not make sense.
    static let shortSide = min(width, height)
    static let longSide = max(width, height)
}

struct Font {
    static let title: UIFont! = UIFont.systemFont(ofSize: 16)
    static let content: UIFont! = UIFont.systemFont(ofSize: 14)
    static func number(of size: CGFloat) -> UIFont! {
        return UIFont.init(name: "menlo", size: size)
    }
    static func courier(of size: CGFloat) -> UIFont! {
        return UIFont.init(name: "Courier New", size: size)
    }
}

struct Color {
    // 常用颜色
    public static let vocal = UIColor.init(red: 1.0 * 236 / 255, green: 1.0 * 87 / 255, blue: 1.0 * 105 / 255, alpha: 1)
    public static let dance = UIColor.init(red: 1.0 * 89 / 255, green: 1.0 * 187 / 255, blue: 1.0 * 219 / 255, alpha: 1)
    public static let visual = UIColor.init(red: 1.0 * 254 / 255, green: 1.0 * 154 / 255, blue: 1.0 * 66 / 255, alpha: 1)
    public static let life = UIColor.init(red: 1.0 * 75 / 255, green: 1.0 * 202 / 255, blue: 1.0 * 137 / 255, alpha: 1)
    
    public static let debut = UIColor.init(red: 1.0 * 138 / 255, green: 1.0 * 206 / 255, blue: 1.0 * 233 / 255, alpha: 1)
    public static let regular = UIColor.init(red: 1.0 * 253 / 255, green: 1.0 * 164 / 255, blue: 1.0 * 40 / 255, alpha: 1)
    public static let pro = UIColor.init(red: 1.0 * 254 / 255, green: 1.0 * 183 / 255, blue: 1.0 * 194 / 255, alpha: 1)
    public static let master = UIColor.init(red: 1.0 * 147 / 255, green: 1.0 * 236 / 255, blue: 1.0 * 148 / 255, alpha: 1)
    public static let masterPlus = UIColor.init(red: 1.0 * 255 / 255, green: 1.0 * 253 / 255, blue: 1.0 * 114 / 255, alpha: 1)
    
    public static let cute = UIColor.init(red: 1.0 * 248 / 255, green: 1.0 * 24 / 255, blue: 1.0 * 117 / 255, alpha: 1)
    public static let cool = UIColor.init(red: 1.0 * 42 / 255, green: 1.0 * 113 / 255, blue: 1.0 * 247 / 255, alpha: 1)
    public static let passion = UIColor.init(red: 1.0 * 250 / 255, green: 1.0 * 168 / 255, blue: 1.0 * 57 / 255, alpha: 1)
    
    public static let parade = UIColor.init(red: 1.0 * 22 / 255, green: 1.0 * 87 / 255, blue: 1.0 * 250 / 255, alpha: 1)
    public static let kyalapon = UIColor.init(red: 1.0 * 252 / 255, green: 1.0 * 60 / 255, blue: 1.0 * 169 / 255, alpha: 1)
    public static let groove = UIColor.init(red: 1.0 * 238 / 255, green: 1.0 * 175 / 255, blue: 1.0 * 50 / 255, alpha: 1)

    public static let party = UIColor.init(red: 1.0 * 89 / 255, green: 1.0 * 192 / 255, blue: 1.0 * 50 / 255, alpha: 1)
    public static let tradition = UIColor.init(red: 1.0 * 113 / 255, green: 1.0 * 80 / 255, blue: 1.0 * 69 / 255, alpha: 1)
    
    public static let normalGacha = UIColor.init(red: 1.0 * 253 / 255, green: 1.0 * 186 / 255, blue: 1.0 * 80 / 255, alpha: 1)
    public static let limitedGacha = UIColor.init(red: 1.0 * 236 / 255, green: 1.0 * 103 / 255, blue: 1.0 * 105 / 255, alpha: 1)
    public static let cinFesGacha = UIColor.init(red: 1.0 * 25 / 255, green: 1.0 * 154 / 255, blue: 1.0 * 218 / 255, alpha: 1)
    
    public static let allType = UIColor.darkGray

    public static let bpmShift = UIColor.init(red: 1.0 * 131 / 255, green: 1.0 * 108 / 255, blue: 1.0 * 251 / 255, alpha: 1)
    
    static let separator = UIColor.init(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
}

public class CGSSGlobal {
    
    // 当前屏幕的宽度和高度常量
    public static let width = UIScreen.main.bounds.width
    public static let height = UIScreen.main.bounds.height
    // 当前屏幕1坐标的像素点数量
    public static let scale = UIScreen.main.scale

    // 用于GridView的字体
    public static let numberFont = UIFont.init(name: "menlo", size: 14)
    public static let alphabetFont = UIFont.systemFont(ofSize: 14)
    
    public static let spreadImageWidth: CGFloat = 1280
    public static let spreadImageHeight: CGFloat = 824
    
    static let rarityToStirng: [String] = ["", "N", "N+", "R", "R+", "SR", "SR+", "SSR", "SSR+"]
    
    static let maxPotentialTotal = 25
    static let maxPotentialSingle = 10
    
    // 传入0-99999的rate 判断是否触发
    static func isProc(rate: Int) -> Bool {
        let ran = arc4random_uniform(100000)
        if rate > Int(ran) {
            return true
        } else {
            return false
        }
    }
    
    static let appid = "1131934691"
    
    // 时区转换
    static func getDateFrom(oldDate: NSDate, timeZone: NSTimeZone) -> NSDate {
        let inv = timeZone.secondsFromGMT(for: oldDate as Date)
        let timeInv = TimeInterval(inv)
        let newDate = oldDate.addingTimeInterval(timeInv)
        return newDate
        
    }
    
    static func isWifi() -> Bool {
        if let reachability = Reachability() {
            if reachability.connection == .wifi {
                return true
            }
        }
        return false
    }
    
    static func isMobileNet() -> Bool {
        if let reachability = Reachability() {
            if reachability.connection == .cellular {
                return true
            }
        }
        return false
    }
    
    static var languageType: LanguageType {
        if let code = Locale.preferredLanguages.first {
            return LanguageType(identifier: code)
        } else {
            return .en
        }
    }
    
    // max = 15928 + 500 + 500 + 220 
    // ceil(0.5 × max × 1.3) * 10
    static let defaultSupportAppeal = 111470
    
}

enum LanguageType {
    case en
    case cn
    case tw
    case ja
    case other
    init(identifier: String) {
        switch identifier {
        case let x where x.hasPrefix("en"):
            self = .en
        case let x where x.hasPrefix("zh-Hans"):
            self = .cn
        case let x where x.hasPrefix("zh-Hant"):
            self = .tw
        case let x where x.hasPrefix("ja"):
            self = .ja
        default:
            self = .other
        }
    }
}

