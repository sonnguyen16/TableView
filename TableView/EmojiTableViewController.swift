//
//  EmojiTableViewController.swift
//  TableView
//
//  Created by BVU on 5/13/23.
//  Copyright © 2023 BVU. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    var emojis: [Emoji] = [
       Emoji(symbol: "😀", name: "Grinning Face",
       description: "A typical smiley face.", usage: "happiness"),
       Emoji(symbol: "😕", name: "Confused Face",
       description: "A confused, puzzled face.", usage: "unsure what to think;displeasure"),
       Emoji(symbol: "😍", name: "Heart Eyes",
       description: "A smiley face with hearts for eyes.",
       usage: "love of something; attractive"),
       Emoji(symbol: "🧑‍💻", name: "Developer",
       description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software,programming"),
       Emoji(symbol: "🐢", name: "Turtle", description:
       "A cute turtle.", usage: "something slow"),
       Emoji(symbol: "🐘", name: "Elephant", description:
       "A gray elephant.", usage: "good memory"),
       Emoji(symbol: "🍝", name: "Spaghetti",
       description: "A plate of spaghetti.", usage: "spaghetti"),
       Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
       Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
       Emoji(symbol: "📚", name: "Stack of Books",
       description: "Three colored books stacked on each other.",
       usage: "homework, studying"),
       Emoji(symbol: "💔", name: "Broken Heart",
       description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore",
       description:
       "Three blue \'z\'s.", usage: "tired, sleepiness"),
       Emoji(symbol: "🏁", name: "Checkered Flag",
       description: "A black-and-white checkered flag.", usage:
       "completion")
    ] 

    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
               "EmojiCell", for: indexPath) as! EmojiTableViewCell
           
            let emoji = emojis[indexPath.row]
          
            cell.update(with: emoji)
            cell.showsReorderControl = true
            
            return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData();
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to : IndexPath) {
        let movedEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(movedEmoji, at: to.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
                emojis.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: . automatic)
            }

    }
    
    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> UITableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            // Editing Emoji
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiTableViewController(coder: coder,
               emoji: emojiToEdit)
        } else {
            // Adding Emoji
            return AddEditEmojiTableViewController(coder: coder,
               emoji: nil)
        }
        
    }
    
    @IBAction func unwindToEmojiTableView(segue:
    UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source
               as? AddEditEmojiTableViewController,
            let emoji = sourceViewController.emoji else { return }
     
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }

    }
}


