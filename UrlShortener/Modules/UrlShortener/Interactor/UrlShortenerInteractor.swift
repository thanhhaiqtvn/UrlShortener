//
//  UrlShortenerInteractor.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation
import UIKit // for UIApplication

class UrlShortenerInteractor: UrlShortenerInteractorInput {
    
    var urlEntity:UrlEntity?
    weak var urlShortenerPresenter:UrlShortenerInteractorOutput?
        
    init(entity:UrlEntity) {
        self.urlEntity = entity
    }
    
    // Adopt UrlShortenerInteractorInput
    func getDataStore() {

    }
    
    func shortenURL(url:String) {
        if verifyUrl(urlString:url) != false{
            guard let apiEndpoint = URL(string: "http://tinyurl.com/api-create.php?url=\(url)")else {                self.urlShortenerPresenter?.urlShortenerFail(error:"Error: doesn't seem to be a valid URL")
                return
            }
            do {
                let shortURL = try String(contentsOf: apiEndpoint, encoding: String.Encoding.ascii)

                self.urlShortenerPresenter?.urlShortenerSuccess(with: shortURL)
            } catch let Error{                self.urlShortenerPresenter?.urlShortenerFail(error:Error.localizedDescription)
            }
        }else{            self.urlShortenerPresenter?.urlShortenerFail(error:"\(url) doesn't seem to be a valid URL or is blank")
        }
    }
    
    private func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        self.urlShortenerPresenter?.validateError(error: "validate error!!!")
        return false
    }
    
}
