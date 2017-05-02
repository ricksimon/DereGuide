//
//  GachaCardTableViewController.swift
//  CGSSGuide
//
//  Created by zzk on 2016/9/16.
//  Copyright © 2016年 zzk. All rights reserved.
//

import UIKit

class GachaCardTableViewController: BaseCardTableViewController {
    
    var _filter: CGSSCardFilter = CGSSSorterFilterManager.DefaultFilter.gacha
    var _sorter: CGSSSorter = CGSSSorterFilterManager.DefaultSorter.gacha
    
    override var filter: CGSSCardFilter {
        get {
            return _filter
        }
        set {
            _filter = newValue
        }
    }
    override var sorter: CGSSSorter {
        get {
            return _sorter
        }
        set {
            _sorter = newValue
        }
    }
    
    override var filterVC: CardFilterSortController {
        set {
            _filterVC = newValue as! GachaCardFilterSortController
        }
        get {
            return _filterVC
        }
    }
    
    lazy var _filterVC: GachaCardFilterSortController = {
        let vc = GachaCardFilterSortController()
        vc.filter = self.filter
        vc.sorter = self.sorter
        vc.delegate = self
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftItem = UIBarButtonItem.init(image: UIImage.init(named: "765-arrow-left-toolbar"), style: .plain, target: self, action: #selector(backAction))
        leftItem.width = 44
        navigationItem.leftBarButtonItem = leftItem

        self.tableView.register(GachaCardTableViewCell.self, forCellReuseIdentifier: GachaCardTableViewCell.description())
    }
    
    func backAction() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    var defaultCardList : [CGSSCard]!
    var rewardTable: [Int: Reward]!
    var hasOdds = false
    
    func setup(with pool: CGSSGachaPool) {
        if pool.hasOdds {
            defaultCardList = pool.cardList.map {
                $0.odds = pool.rewardTable[$0.id!]?.relativeOdds ?? 0
                return $0
            }
        } else {
            defaultCardList = [CGSSCard]()
        }
        rewardTable = pool.rewardTable
        hasOdds = pool.hasOdds
    }
    
    // 根据设定的筛选和排序方法重新展现数据
    override func updateUI() {
        filter.searchText = searchBar.text ?? ""
        self.cardList = filter.filter(defaultCardList)
        sorter.sortList(&self.cardList)
        
        tableView.reloadData()
        // 滑至tableView的顶部 暂时不需要
        // tableView.scrollToRowAtIndexPath(IndexPath.init(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let cardDetailVC = CardDetailViewController()
        cardDetailVC.card = cardList[indexPath.row]
        cardDetailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(cardDetailVC, animated: true)
    }
    override func doneAndReturn(filter: CGSSCardFilter, sorter: CGSSSorter) {
        self.filter = filter
        self.sorter = sorter
        updateUI()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if hasOdds {
            let cell = tableView.dequeueReusableCell(withIdentifier: GachaCardTableViewCell.description(), for: indexPath) as! GachaCardTableViewCell
            let row = indexPath.row
            let card = cardList[row]
            if let odds = rewardTable[card.id]?.relativeOdds {
                cell.setupWith(card, odds)
            } else {
                cell.setup(with: card)
            }
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
}
