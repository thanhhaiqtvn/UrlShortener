//
//  UrlShortenerVC.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

class UrlShortenerVC: UIViewController, UrlShortenerView {
    
    @IBOutlet weak var tfUrl: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier = "UrlShortenerVC"
    
    var urlShortenerPresenter:UrlShortenerPresenterProtocol?
    
    var urlModel: UrlEntity = UrlEntity()
    
    override func viewWillAppear(_ animated: Bool) {
        urlModel = UrlEntity()
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.urlShortenerPresenter?.getListUrl()
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //setupUI
        self.setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func urlShortAction(_ sender: Any) {
        self.urlShortenerPresenter?.didUrlShortener(url: tfUrl.text!)
    }
    
    //MARK:- Adopt UrlShortenerView
    func validateError(error: String) {
        self.showMessage(message: error)
    }
    
    func urlShortenerFail(error: String) {
        self.showMessage(message: error)
    }
    
    func urlShortenerSuccess(with urlShorted: String) {
        var tempUrl = Url()
        tempUrl.dateCreated = self.getCurrentDate()
        tempUrl.url = tfUrl.text!
        tempUrl.urlShorten = urlShorted

        urlModel.urls.append(tempUrl)

        // sync data
        urlModel = UrlEntity()
        
        self.showMessage(message: "successful")
        
        //clear text
        tfUrl.text = ""

        //reload tableview
        self.tableView.reloadData()
    }

}

//MARK: - Privates
extension UrlShortenerVC {
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
    
    private func setupUI() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "right-circled.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
         button.frame = CGRect(x: CGFloat(tfUrl
            .frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.urlShortAction), for: .touchUpInside)
        tfUrl.rightView = button
        tfUrl.rightViewMode = .always
    }
    
    private func showMessage(message:String) {
        let ErrorMessageAlert = UIAlertController(title:"Message", message: message, preferredStyle: UIAlertController.Style.alert)
        ErrorMessageAlert.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
        self.present(ErrorMessageAlert, animated: true, completion: nil)
        print("Error:\(message)")
    }
    
    private func openUrlInBrowser(with urlStr:String) {
        if let url = URL(string: "\(urlStr)"), !url.absoluteString.isEmpty {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        // or outside scope use this
        guard let url = URL(string: "\(urlStr)"), !url.absoluteString.isEmpty else {
           return
        }
         UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

//MARK: - UITableViewDataSource
extension UrlShortenerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urlModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "UrlShortenerCell"
        var cell: UrlShortenerCell! = tableView.dequeueReusableCell(withIdentifier: identifier) as? UrlShortenerCell
        if cell == nil {
            tableView.register(UINib(nibName: "UrlShortenerCell", bundle: nil), forCellReuseIdentifier: identifier)
            cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? UrlShortenerCell
        }
        
        cell.lblDateCreated.text = "\(urlModel.urls[indexPath.row].dateCreated)"
        cell.lblUrl.text = urlModel.urls[indexPath.row].url
        cell.lblUrlShorten.text = urlModel.urls[indexPath.row].urlShorten
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension UrlShortenerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openUrlInBrowser(with: urlModel.urls[indexPath.row].urlShorten)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            urlModel.urls.remove(at: indexPath.row)
            urlModel = UrlEntity()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
