//
//  UrlEntity.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

struct Url: PropertyReflectable {
    var dateCreated: String = ""
    var url: String = ""
    var urlShorten: String = ""
    
    init(){}
    
    init(dateCreated:String, enabled:Bool, url:String, urlShorten:String){
        self.dateCreated = dateCreated
        self.url = url
        self.urlShorten = urlShorten
    }
    
    init(_ dict: PropertyReflectable.RepresentationType){
        dateCreated = dict["dateCreated"] as! String
        url = dict["url"] as! String
        urlShorten = dict["urlShorten"] as! String
    }
    
    static var propertyCount: Int = 3
}

//extension Url {
//    var formattedTime: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "ddMMyyyy"
//        return dateFormatter.string(from: self.dateCreated)
//    }
//}

//This can be considered as a viewModel
class UrlEntity: Persistable {
    let ud: UserDefaults = UserDefaults.standard
    let persistKey: String = "MY_URL_KEY"
    var urls: [Url] = [] {
        //observer, sync with UserDefaults
        didSet{
            persist()
        }
    }
    
    private func getDatasDictRepresentation()->[PropertyReflectable.RepresentationType] {
        return urls.map {$0.propertyDictRepresentation}
    }
    
    init() {
        urls = getUrls()
    }
    
    func persist() {
        ud.set(getDatasDictRepresentation(), forKey: persistKey)
        ud.synchronize()
    }
    
    func unpersist() {
        for key in ud.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    var count: Int {
        return urls.count
    }
    
    //helper, get all datas from Userdefaults
    private func getUrls() -> [Url] {
        let array = UserDefaults.standard.array(forKey: persistKey)
        guard let alarmArray = array else{
            return [Url]()
        }
        if let dicts = alarmArray as? [PropertyReflectable.RepresentationType]{
            if dicts.first?.count == Url.propertyCount {
                return dicts.map{Url($0)}
            }
        }
        unpersist()
        return [Url]()
    }
}

