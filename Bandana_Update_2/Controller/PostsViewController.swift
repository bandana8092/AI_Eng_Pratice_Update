//
//  PostsViewController.swift
//  Bandana_Update_2
//
//  Created by Rakesh Nangunoori on 03/02/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class PostsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var postsTableView: UITableView!
    var spinner: UIActivityIndicatorView!
    var refreshControl = UIRefreshControl()
    var pageCount = 1
    var totalPage = 1
    var selectedCount = 0
    var postModel = [PostsModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib.init(nibName: "PostsTableViewCell", bundle: nil)
//        self.postsTableView.register(nib, forCellReuseIdentifier: "PostsTableViewCell")
        self.postsTableView.tableFooterView = UIView()
        refreshControl.attributedTitle = NSAttributedString(string: "fetching data")
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        self.postsTableView.addSubview(refreshControl)
        spinner = self.setUpSpinner(style: .medium)
        self.title = "Selected Posts Count : \(selectedCount)"
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        guard Reachability.isConnectedToNetwork() else {
           showAlert(title: "Please check internet")
          return
        }
        self.showActivityIndicator(destination: .center, spinner: spinner)
        fetchMoreData()
    }
    func getPosts(complitionHandeler: @escaping()->Void) {
        ServiceManager.shared.getDetailsFromServer(url: base_url, pageCount: pageCount, total: totalPage) { (response, responseStatus) in
            switch responseStatus {
            case .succes:
                let posts = response?["hits"] as? [Any]
                self.totalPage = response?["nbPages"] as? Int ?? 0
                let intialResult = PostsModel.getDicFromServerArray(array: posts as? [[String: Any]] ?? [["": ""]])
                self.postModel = self.pageCount == 1 ? intialResult : self.postModel + intialResult
                complitionHandeler()
            case .badResponse:
                print("")
            case .error:
                 print("")
            }
        }
    }
    func fetchMoreData() {
        getPosts { [weak self] in
            DispatchQueue.main.async {
                self?.hideActivityIndicator(spinner: self!.spinner)
                if (self?.refreshControl.isRefreshing)!{
                    self?.refreshControl.endRefreshing()
                }
                self?.postsTableView.reloadData()
            }
        }
    }
    @objc func refreshAction() {
        guard Reachability.isConnectedToNetwork() else {
           showAlert(title: "Please check internet")
          return
        }
        selectedCount = 0
        self.title = "Selected Posts Count : \(selectedCount)"
        pageCount = 1
        fetchMoreData()
    }
//MARK:- UI
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PostsTableViewCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PostsTableViewCell
        if cell == nil {
        let arrNib = Bundle.main.loadNibNamed("PostsTableViewCell", owner: self, options: nil)
        cell =  arrNib?.first as? PostsTableViewCell
        }
        cell!.updateCell(postModel: self.postModel, indexPath: indexPath)
        cell!.selectionStyle = .none
        return cell!
     }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postModel[indexPath.row].switchStatus = !postModel[indexPath.row].switchStatus
        let indexPath = IndexPath.init(row: indexPath.row, section: 0)
        self.postsTableView.reloadRows(at: [indexPath], with: .none)
        self.selectedCount = postModel.filter{$0.switchStatus == true}.count
        self.title = "Selected Posts Count : \(selectedCount)"
      }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == postModel.count - 1{
            if totalPage > pageCount{
                pageCount += 1
                postsTableView.tableFooterView = spinner
                showActivityIndicator(destination: .bottom, spinner: spinner)
                fetchMoreData()
            }
        }
    } }
