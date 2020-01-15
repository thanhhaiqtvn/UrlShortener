//
//  UrlShortenerInteractor.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation
import UIKit // for UIApplication

class UrlShortenerInteractor: UrlShortenerInteractorInputProtocol {
    
    weak var output: UrlShortenerInteractorOutputProtocol?
    
    private let coreDataManager: CoreDataManager

    init(coreDatamanager: CoreDataManager) {
        self.coreDataManager = coreDatamanager
    }
    
    //MARK: Adopt UrlShortenerInteractorInputProtocol
    func retrieveUrlShortenerList() {
        let urlList = coreDataManager.fetch(ofType: URLEntity.self)
        output?.didRetrieveUrlShortenerList(urlShortenerList: urlList)
    }
    
    func shortenURL(withUrl url: String) {
        if verifyUrl(urlString:url) != false{
            guard let apiEndpoint = URL(string: "http://tinyurl.com/api-create.php?url=\(url)")else {
                self.output?.shortenURLFailed(withMessage: "Error: doesn't seem to be a valid URL")
                return
            }
            do {
                let shortURL = try String(contentsOf: apiEndpoint, encoding: String.Encoding.ascii)

                // create new URL
                var newData = [String: Any]()

                newData[UrlKey.idObject.rawValue] = UUID().uuidString
                newData[UrlKey.dateCreated.rawValue] = self.getCurrentDate()
                newData[UrlKey.url.rawValue] = url
                newData[UrlKey.urlShorten.rawValue] = shortURL

                //save a new URL
                self.saveURLShorten(withData: newData)

            } catch let Error {
                self.output?.shortenURLFailed(withMessage: Error.localizedDescription)
            }
        } else{
            self.output?.shortenURLFailed(withMessage: "\(url) doesn't seem to be a valid URL or is blank")
        }
    }
    
    func deleteURL(withId id: String) {
        coreDataManager.deleteSingleObj(URLEntity.entityName(), With: id)
        output?.didDeleteURL(withMessage: AppDefine.DEL_URL_SUCCESS)
    }
}

//MARK: privates
extension UrlShortenerInteractor {
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd.MM.yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
    
    private func saveURLShorten(withData data: [String : Any]) {
        guard let ret = coreDataManager.create(ofType: URLEntity.self, withData: data) else {
            output?.shortenURLFailed(withMessage: AppDefine.INT_URL_ERROR)
            return
        }

        output?.shortenURLSuccess(urlShortener: ret)
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        self.output?.shortenURLFailed(withMessage: AppDefine.URL_ERR_1)
        return false
    }
}
