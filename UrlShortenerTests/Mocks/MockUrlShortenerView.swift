//
//  MockUrlShortenerView.swift
//  UrlShortenerTests
//
//  Created by Hai Doan on 1/15/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import Foundation

@testable import UrlShortener

class MockUrlShortenerView: UrlShortenerVC {
    private(set) var urlList: [URLEntity]?
    private(set) var showUrlListCalled = 0

    override func showUrlList(with urls: [URLEntity]) {
        self.urlList = urls
        self.showUrlListCalled += 1
    }

}

