//
//  snapsTableViewController.swift
//  SnapChat
//
//  Created by Faizan Khan on 24/02/19.
//  Copyright © 2019 Faizan Khan. All rights reserved.
//

import UIKit
import FirebaseAuth

class snapsTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    @IBAction func logOutTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    @IBAction func addSnapButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "addSnap", sender: self)
    }
    
    
    
}
