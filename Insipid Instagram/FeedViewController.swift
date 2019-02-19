//
//  FeedViewController.swift
//  Insipid Instagram
//
//  Created by jeremy on 2/17/19.
//  Copyright © 2019 Jeremy Chang. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var db: Firestore!
    var posts: [QueryDocumentSnapshot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        db.collection("posts").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                self.posts = querySnapshot!.documents
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        db.collection("posts").getDocuments() {(querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                self.posts = querySnapshot!.documents
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let posts = self.posts[indexPath.row]
        
        cell.usernameLabel.text = posts["userId"] as? String
        cell.captionLabel.text = posts["caption"] as? String
        
        let url = URL(string: posts["url"] as! String)
        cell.photoView.af_setImage(withURL: url!)
        
        return cell
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
