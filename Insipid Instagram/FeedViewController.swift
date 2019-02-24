//
//  FeedViewController.swift
//  Insipid Instagram
//
//  Created by jeremy on 2/17/19.
//  Copyright © 2019 Jeremy Chang. All rights reserved.
//

import UIKit
import Firebase
import MessageInputBar

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {

    @IBOutlet var tableView: UITableView!
    var db: Firestore!
    var posts: [QueryDocumentSnapshot] = []
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .interactive
        
        commentBar.inputTextView.placeholder = "Add a comment..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self

        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)

        
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
    
    @objc func keyboardWillBeHidden(note: Notification) {
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
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
    
    override var inputAccessoryView: UIView? {
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool {
        return showsCommentBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let post = posts[section]
        let comments = post.data()["comments"] as? [String] ?? []
        return comments.count + 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let posts = self.posts[indexPath.row]
        let comments = posts["comments"] as? [String] ?? []
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
            let imageUrl = URL(string: posts["url"] as! String)!
            
            cell.usernameLabel.text = posts["userId"] as? String
            cell.captionLabel.text = posts["caption"] as? String
            // cell.photoView.af_setImage(withURL: imageUrl)
            
            cell.photoView.af_setImage(withURL: imageUrl, placeholderImage: UIImage(named: "image_placeholder"), completion: { (response) in
                cell.photoView.image = response.result.value
            })
            
            return cell
        } else if indexPath.row == comments.count + 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            
            cell.commentLabel.text = comments[indexPath.row - 1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let comments = post["comments"] as? [String] ?? []
        if indexPath.row == comments.count + 1 {
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        } else {
            showsCommentBar = false
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }
        
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
