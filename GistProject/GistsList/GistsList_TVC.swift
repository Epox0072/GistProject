//
//  GistsList_TVC.swift
//  GistProject
//
//  Created by Stanislav on 26/09/2019.
//  Copyright © 2019 Stanislav. All rights reserved.
//

import UIKit
import Alamofire

class GistsList_TVC: UITableViewController {
    
    let url: String = "https://api.github.com/gists/"
    var gistList : Array<GistsList_Model> = Array()
    var gistPage : Int = 1
    var gistContentPage : Int = 40
    let refreshController : UIRefreshControl = UIRefreshControl()
    var loading : Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        var title = ""
        if self.gistList.count != 0 {
            title = "Gists count \(self.gistList.count)"
        }
        self.title = title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshController.attributedTitle = NSAttributedString(string: "Обновление...")
        self.refreshController.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)
        self.tableView.addSubview(refreshController)
        
        self.loadData()
        
    }
    
    @objc func refreshData() {
        if self.loading {return}
        self.gistPage = 1
        self.gistContentPage = 40
        self.tableView.reloadData()
        self.gistList = []
        self.loadData()
        self.refreshController.endRefreshing()
    }
    
    //MARK: - Load data
    
    func loadData() {
        if self.loading {return}
        self.loading = true
        request(self.url + "public?page=\(self.gistPage)&per_page=\(self.gistContentPage)").responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    guard let dataArray = value as? Array<Dictionary<String, Any>>
                        else {return}
                    for responseGist in dataArray {
                        let gist = GistsList_Model(responseGist)
                        self.gistList.append(gist)
                    }
                    self.title = "Gist count \(self.gistList.count)"
                    self.tableView.reloadData()
                case.failure(let error):
                    print(error)
                }
        }
        self.loading = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.gistList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GistViewCell", for: indexPath) as? GistsList_TVCell {
            if (indexPath.row < gistList.count) {
                let cellData = gistList[indexPath.row]
                cell.data = cellData
            }
            return cell
        }
        
        let cell = UITableViewCell()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.row == self.gistList.count - self.gistContentPage/2) {
            if !self.loading {
                self.gistPage += 1
                self.loadData()
            }
        }
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
