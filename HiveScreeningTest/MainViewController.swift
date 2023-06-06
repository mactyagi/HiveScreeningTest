//
//  ViewController.swift
//  HiveScreeningTest
//
//  Created by Manu on 06/06/23.
//

import UIKit

class MainViewController: UIViewController, UISearchControllerDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: - properties
    lazy var searchController = UISearchController()
    var results = [Page](){
        didSet{
            self.tableView.reloadData()
        }
    }
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
    }
    
    func UISetup(){
        title = "Wekipedia"
        activityIndicator.hidesWhenStopped = true
        searchController.delegate = self
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
    }
    
    func fetchData(searchString: String){
        activityIndicator.startAnimating()
        results = []
        NetworkManager().fetchData(searchString: searchString) { data, isError in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                if isError{
                    return
                }else{
                    self.results = (data?.query.pages.values.reversed())!
                }
            }
        }
    }
}



//MARK: - tableView Delegate and Data Source
extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.setup(page: results[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if results.count > 0{
            return "Results"
        }
        return nil
    }
    
    
}


    //MARK: - search bar delegate
extension MainViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            fetchData(searchString: searchText)
    }
}

