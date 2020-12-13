//
//  ViewController.swift
//  cmpe131
//
//  Created by Nemanja Rajic on 12/5/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signInButotn: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet var myTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpElements()
        if #available(iOS 13.0, *) {
                // Always adopt a light interface style.
                overrideUserInterfaceStyle = .light
            }
        //for messaging
        //myTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
       // myTable.delegate = self
        //myTable.dataSource = self
    }
    
    func setUpElements(){
        Utilities.fillButton(button: signInButotn)
        Utilities.fillButton(button: createAccountButton)
    }
    /*
    //for messaging
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
        cell.textLabel?.text = "John Smith"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Show chat messages
        let vc = ChatViewController()
        vc.title = "Chat"
        navigationController?.pushViewController(vc, animated: true)
        
    }
*/
}

