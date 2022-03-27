//
//  ViewController.swift
//  SearchBarExample
//
//  Created by Jiaying Xie on 3/26/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    var namesArray = ["Ashish", "Ashley", "Mark", "John", "Mike", "Marrisa", "Mary"]
    var copyArray = ["Ashish", "Ashley", "Mark", "John", "Mike", "Marrisa", "Mary"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = namesArray[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 获取搜索框的文本，如果不为空的话进行48行及以后的。
        
        // 直接拿searchText的数据
        // let text = searchBar.text!
        // guard !text.isEmpty
        
        
        // 直接拿searchText的数据就行，!searchText.isEmpty，老师的是拿了searchBar，再从中拿text
        guard !searchBar.text!.isEmpty else { // if the searchBar.text is not empty proceed, else restore original array
            // 这一步是为了当搜索框为空的时候，把namesArray恢复成原来的数据
            namesArray = copyArray
            tblView.reloadData()
            return
        }
        
        namesArray = copyArray.filter({ name in
            name.lowercased().contains(searchBar.text!.lowercased())
        })
        
        tblView.reloadData()
    }

}

