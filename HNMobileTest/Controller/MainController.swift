//
//  MainController.swift
//  HNMobileTest
//
//  Created by Oscar Cuadra on 1/26/18.
//  Copyright © 2018 Oscar Cuadra. All rights reserved.
//

import UIKit
import RealmSwift

class MainController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var rowTapped = 0
   
    //The key to refresh our tableView
    var refreshControl: UIRefreshControl = UIRefreshControl()

    //Realm parameters
    var hitsList : Results<Hit>!
    var notificationToken : NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
        self.refreshControl.addTarget(self, action: #selector(MainController.refreshData), for: UIControlEvents.valueChanged)
        
        addRefreshControl()
        
        loadDataBase()
        
        let nibRow = UINib(nibName: "CustomCell", bundle: nil)
        self.tableView.register(nibRow, forCellReuseIdentifier: "customCell")
    }
    
    private func loadDataBase() {
        //Configuracion Realm
        let realm = RealmService.shared.realm
        APIClient().loadJSONData()
//        ealmResults<MyTable> list = realm.where(MyTable.class)
//            .sort("date",Sort.DESCENDING)
//            .findAll();
////        self.hitsList = realm.objects(Hit.self)
        self.hitsList = realm.objects(Hit.self).sorted(byKeyPath: "created_at", ascending: false)
        self.notificationToken = realm.observe({(notification, realm) in
            self.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //This method add our refresh function
    private func addRefreshControl() {
        //We control if the device has ios 10 or less
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = self.refreshControl
        } else {
            self.tableView.addSubview(self.refreshControl)
        }
    }

    @objc func refreshData() {
        self.loadDataBase()
//        self.tableView.reloadData
        self.refreshControl.endRefreshing()
    }
    
//    func orderAscendingDates() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
//        var elapsed: Double!
//
//        for hit in self.hitsList {
//            if let date = formatter.date(from:"2018-01-12T00:00:00.000Z") {
//
//            }
//        }
//
//
//
//        dateFormatter.dateFormat = "dd MM, yyyy"// yyyy-MM-dd"
//
//        for hit in self.hitsList {
//            let date = dateFormatter.date(from: hit.)
//            if let date = date {
//                convertedArray.append(date)
//            }
//        }
//
//        var ready = convertedArray.sorted(by: { $0.compare($1) == .orderedDescending })
    
}
extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hitsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        let item =  hitsList[indexPath.row]
        
        // create NSDate from Double (NSTimeInterval)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        if let date = formatter.date(from: item.created_at!) {
            
            let elapsed = TimeObserver.timeAgoSinceDate(date: date as NSDate, numericDates: false)
            
            let authorLabel = "\(item.author ?? "none") - \(elapsed)"
            cell.customInit(story_title: item.story_title ?? "", author: authorLabel)
        } else {
            cell.customInit(story_title: item.story_title ?? "", author: item.author ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            if (hitsList?[indexPath.row]) != nil {
                RealmService.shared.deleteObject(hitsList[indexPath.row])
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rowTapped = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WebViewController {
            destination.hits = hitsList[rowTapped]
        }
    }
}
