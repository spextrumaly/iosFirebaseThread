//
//  ViewController.swift
//  DemoDatabase
//
//  Created by Spextrum on 7/2/2562 BE.
//  Copyright © 2562 Spextrum. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref:DatabaseReference?
    var handle:DatabaseHandle?
    var postData = ["Item1", "Item2", "Item3"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        ref = Database.database().reference()
        ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            if let posts = snapshot.value as? [AnyHashable: String] {
                //Do not cast print it directly may be score is Int not string
                let title = posts["title"]
                self.postData.insert(title ?? "", at: 0)
                self.tableView.reloadData()
            }
        })
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
