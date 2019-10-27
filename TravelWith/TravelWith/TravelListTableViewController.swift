//
//  TravelListTableViewController.swift
//  TravelWith
//
//  Created by 정연희 on 20/10/2019.
//  Copyright © 2019 yeonheey. All rights reserved.
//
import UIKit

//MARK: - Dummy Data(class)
class Travel {
    var title: String
    var length: String
    var countOfMember: Int = 1
    var backgroundImage: UIImage = UIImage()
    
    init(_ title: String, _ length: String, countOfMember: Int) {
        self.title = title
        self.length = length
        self.countOfMember = countOfMember
    }
}

//MARK: - extension
extension TravelListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



//MARK: - TravelListTabelViewController
class TravelListTableViewController: UITableViewController {
    
    //MARK: Properties
    var upcomingTravels: [Travel] = [Travel("유럽 일주", "2020.10.10. - 2020.11.30.", countOfMember: 5), Travel("혼자서 처음으로 도전하는 배낭여행", "2019.12.01. - 2019.12.15.", countOfMember: 100), Travel("엄마와 하와이!", "2020.01.23. - 2020.01.30.", countOfMember: 2), Travel("친구들이랑 가는 2박 3일 가평여행", "2019.10.29. - 2010.10.31.", countOfMember: 13) ]
    
    var pastTravels: [Travel] = [Travel("동생이랑 떠나는 홍콩🎡", "2018.10.10. - 2020.11.30.", countOfMember: 2), Travel("부산으로 떠나요~!", "2017.12.01. - 2019.12.15.", countOfMember: 7) ]
    
    var backgroundImageOfCells: [UIImage] = [#imageLiteral(resourceName: "travelImage2"), #imageLiteral(resourceName: "travelImage14"), #imageLiteral(resourceName: "travelImage7"), #imageLiteral(resourceName: "travelImage9"), #imageLiteral(resourceName: "travelImage5"), #imageLiteral(resourceName: "travelImage13"), #imageLiteral(resourceName: "travelImage3"), #imageLiteral(resourceName: "travelImage4"), #imageLiteral(resourceName: "travelImage10"), #imageLiteral(resourceName: "travelImage1"), #imageLiteral(resourceName: "travelImage11"), #imageLiteral(resourceName: "travelImage6"), #imageLiteral(resourceName: "travelImage8"), #imageLiteral(resourceName: "travelImage12")]
    
    var upcomingTravelIs: Bool = true
    var searchBarIsActive: Bool = true
    
    var filteredTravels = [Travel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //MARK: IBOutlet
    @IBOutlet weak var choosingTravelTypeSegmentation: UISegmentedControl!
    
    
    //MARK:- Methods
    //MARK: Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "여행 검색"
        
    }
    
    //MARK: Custom Methods
    //MARK: SearchController Methods
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func filterContentForSearchText(_ searchText: String) {
        //해당 여행 섹션에서 여행의 title로 여행 검색 가능
        if upcomingTravelIs {
        filteredTravels = upcomingTravels.filter({(travel: Travel) -> Bool in return travel.title.lowercased().contains(searchText.lowercased())})
        } else {
            filteredTravels = pastTravels.filter({(travel: Travel) -> Bool in return travel.title.lowercased().contains(searchText.lowercased())})
        }
        tableView.reloadData()
    }
    
//    func updateViewFromSearchButtonClicked() {
//        if searchBarIsActive {
//            navigationItem.searchController = searchController
//            definesPresentationContext = true
//        } else {
//            navigationItem.searchController = nil
//        }
//    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredTravels.count
        }
        
        return upcomingTravelIs ? upcomingTravels.count : pastTravels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "travelCell", for: indexPath) as! TravelListTableViewCell
        
        let travel: Travel
        if isFiltering() {
            travel = filteredTravels[indexPath.row]
        } else {
            travel = upcomingTravelIs ? upcomingTravels[indexPath.row] : pastTravels[indexPath.row]
        }
        
        cell.travelTitle?.text = travel.title
        cell.travelLength?.text = travel.length
        cell.countOfMember?.text = "\(travel.countOfMember)"
        //배경 연하게 처리하는 기능 추가 후에 셀에 넣어 주기
        cell.backgroundImage?.image = backgroundImageOfCells[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = self.view.bounds.height / 4 - 20
        return cellHeight
    }
    
    
    //MARK: IBAction
    @IBAction func touchSearchButton(_ sender: UIBarButtonItem) {
        print("you touched search Button")
        
        if searchBarIsActive {
            searchBarIsActive = false
        } else {
            searchBarIsActive = true
        }
        print(searchBarIsActive)
        //updateViewFromSearchButtonClicked()
    }
    
    @IBAction func touchedSegmentation(_ sender: Any) {
        
        if choosingTravelTypeSegmentation == nil {
            return
        }
        
        if choosingTravelTypeSegmentation.selectedSegmentIndex == 0 {
            upcomingTravelIs = true
        } else if choosingTravelTypeSegmentation.selectedSegmentIndex == 1 {
            upcomingTravelIs = false
        } else {
            print(choosingTravelTypeSegmentation.selectedSegmentIndex)
        }
        self.tableView.reloadData()
    }
    
}
