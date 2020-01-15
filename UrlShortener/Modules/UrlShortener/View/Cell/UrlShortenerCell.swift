//
//  UrlShortenerCell.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/7/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

class UrlShortenerCell: UITableViewCell {

    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var lblDateCreated: UILabel!
    @IBOutlet weak var lblUrl: UILabel!
    @IBOutlet weak var lblUrlShorten: UILabel!
    
    weak var urlEntity: URLEntity? {
        didSet {
            bindView()
        }
    }
    
    static func identifier() -> String {
        return "UrlShortenerCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewContent.layer.masksToBounds = true
        viewContent.layer.cornerRadius = 3
        
        viewContent.layer.shadowColor = UIColor.darkGray.cgColor
        viewContent.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        viewContent.layer.shadowOpacity = 1.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Binding Data
    private func bindView() {
        guard let urlEntity = urlEntity else { return }

        if let dateCreated = urlEntity.dateCreated {
            lblDateCreated.text = dateCreated
        }
        lblUrl.text = urlEntity.url
        lblUrlShorten.text = urlEntity.urlShorten
    }
    
}
