//
//  Objects.swift
//  SimpleTableView
//
//  Created by SunyQin on 3/4/16.
//  Copyright © 2016 Suny Qin. All rights reserved.
//

import Foundation
import Survata


public class SurveyDebugOption: SurveyOption, SurveyDebugOptionProtocol {
    public var preview: String?
    public var zipcode: String?
    public var testing: Bool?
    public var sendZipcode: Bool = true
    
    public override var json: [String: AnyObject] {
        var option = super.json
        option["preview"] = preview
        option["testing"] = testing
        return option
    }
}

struct Respondent {
    var age: Int?
    let countryCode: String
    let deviceType: String
    let dmaCode: Int
    var gender: Int?
    let metroCode: Int
    let operatingSystem: String
    var panelistId: String?
    let postalCode: Int
    let region: String
    let uuid: String
    let webBrowser: String
    
    init(json: [String: AnyObject]) {
        age = json["age"] as? Int
        countryCode = json["countryCode"] as! String
        deviceType = json["deviceType"] as! String
        dmaCode = json["dma_code"] as! Int
        gender = json["gender"] as? Int
        metroCode = json["metroCode"] as! Int
        operatingSystem = json["operatingSystem"] as! String
        panelistId = json["panelistId"] as? String
        postalCode = json["postalCode"] as! Int
        region = json["region"] as! String
        uuid = json["uuid"] as! String
        webBrowser = json["webBrowser"] as! String
    }
}

struct SurveyData {
    let created: NSDate
    let publisherUuid: String
    let respondent: Respondent?
    
    init?(json: [String: AnyObject]) {
        if let valid = json["valid"] as? Int where valid == 1 {
            created = json["created"] as! NSDate
            publisherUuid = json["publisherUuid"] as! String
            if let respondentDic = json["respondent"] as? [String: AnyObject] {
                respondent = Respondent(json: respondentDic)
            }
        }
        return nil
    }
}
