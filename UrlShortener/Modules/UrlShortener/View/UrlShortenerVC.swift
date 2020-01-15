//
//  UrlShortenerVC.swift
//  UrlShortener
//
//  Created by Hai Doan on 1/6/20.
//  Copyright © 2020 HaiDoan. All rights reserved.
//

import UIKit

class UrlShortenerVC: UIViewController, UrlShortenerViewProtocol {
    
    @IBOutlet weak var tfUrl: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    static let identifier = "UrlShortenerVC"
    private(set) var alertView: UIAlertController?
    
    var presenter: UrlShortenerPresenterProtocol?
    
    private var urlList = [URLEntity]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //setupUI
        self.configureUI()
        
        // load Data
        self.presenter?.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func urlShortAction(_ sender: Any) {
        if let urlTest = tfUrl.text {
            self.presenter?.onButtonShortenURL(withUrl: urlTest)
        }
    }
    
    //MARK: - Adopt UrlShortenerView
    func showUrlList(with urls: [URLEntity]) {
        self.urlList = urls
        self.tableView.reloadData()
    }
    
    func shortenURLSuccess(urlShorten: URLEntity) {
        self.urlList.append(urlShorten)
        tfUrl.text = ""
        self.showAlert(withMessage: AppDefine.INT_URL_SUCCESS, animated: true)
        self.tableView.reloadData()
    }
    
    func showAlert(withMessage message: String, animated: Bool) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertView = alert

        present(alert, animated: animated, completion: nil)
    }
}
//MARK: - Privates
extension UrlShortenerVC {
    private func configureUI() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "right-circled.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
         button.frame = CGRect(x: CGFloat(tfUrl
            .frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.urlShortAction), for: .touchUpInside)
        tfUrl.rightView = button
        tfUrl.rightViewMode = .always
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
        return urlList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UrlShortenerCell! = tableView.dequeueReusableCell(withIdentifier: UrlShortenerCell.identifier()) as? UrlShortenerCell
        if cell == nil {
            tableView.register(UINib(nibName: "UrlShortenerCell", bundle: nil), forCellReuseIdentifier: UrlShortenerCell.identifier())
            cell = tableView.dequeueReusableCell(withIdentifier: UrlShortenerCell.identifier()) as? UrlShortenerCell
        }
        
        cell.urlEntity = urlList[indexPath.row]
        
        return cell
    }
}

//MARK: - UITableViewDelegate
extension UrlShortenerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlShorten = urlList[indexPath.row].urlShorten {
            self.openUrlInBrowser(with: urlShorten)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete obj
            if  let idObject = urlList[indexPath.row].idObject {
                urlList.remove(at: indexPath.row)
                
                self.presenter?.onButtonDeleteURL(withId: idObject)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
