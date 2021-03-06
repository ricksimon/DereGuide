//
//  CharInfoViewController.swift
//  DereGuide
//
//  Created by zzk on 16/8/18.
//  Copyright © 2016年 zzk. All rights reserved.
//

import UIKit
import ZKDrawerController

class CharInfoViewController: BaseModelTableViewController, CharFilterSortControllerDelegate, ZKDrawerControllerDelegate {
    
    var charList: [CGSSChar]!
    var filter: CGSSCharFilter {
        set {
            CGSSSorterFilterManager.default.charFilter = newValue
        }
        get {
            return CGSSSorterFilterManager.default.charFilter
        }
    }
    var sorter: CGSSSorter {
        set {
            CGSSSorterFilterManager.default.charSorter = newValue
        }
        get {
            return CGSSSorterFilterManager.default.charSorter
        }
    }
    
    var filterVC: CharFilterSortController!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            navigationItem.titleView = searchBarWrapper
        } else {
            navigationItem.titleView = searchBar
        }
        searchBar.placeholder = NSLocalizedString("日文名/罗马音/CV", comment: "角色信息页面")
    
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: #imageLiteral(resourceName: "798-filter-toolbar"), style: .plain, target: self, action: #selector(filterAction))
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .stop, target: self, action: #selector(cancelAction))
//
        tableView.separatorStyle = .none
        self.tableView.register(CharInfoTableViewCell.self, forCellReuseIdentifier: "CharCell")
        let backItem = UIBarButtonItem.init(image: UIImage.init(named: "765-arrow-left-toolbar"), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backItem
        
        filterVC = CharFilterSortController()
        filterVC.filter = self.filter
        filterVC.sorter = self.sorter
        filterVC.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(setNeedsReloadData), name: .favoriteCharasChanged, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // 根据设定的筛选和排序方法重新展现数据
    override func updateUI() {
        filter.searchText = searchBar.text ?? ""
        self.charList = filter.filter(CGSSDAO.shared.charDict.allValues as! [CGSSChar])
        sorter.sortList(&self.charList!)
        tableView.reloadData()
        // 滑至tableView的顶部 暂时不需要
        // tableView.scrollToRowAtIndexPath(IndexPath.init(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
    }
    
    override func reloadData() {
        updateUI()
    }
    
    override func checkUpdate() {
        check([.card, .master])
    }
    
    @objc func filterAction() {
        drawerController?.show(.right, animated: true)
    }
    
    func cancelAction() {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        updateUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let drawer = drawerController
        drawer?.rightViewController = filterVC
        drawer?.defaultRightWidth = min(view.shortSide - 68, 400)
        drawer?.delegate = self
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if drawerController?.rightViewController == filterVC {
            drawerController?.defaultRightWidth = min(size.shortSide - 68, 400)
        }
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        drawerController?.rightViewController = nil
        // self.navigationController?.setToolbarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func drawerController(_ drawerVC: ZKDrawerController, didHide vc: UIViewController) {
        
    }
    
    func drawerController(_ drawerVC: ZKDrawerController, willShow vc: UIViewController) {
        filterVC.filter = self.filter
        filterVC.sorter = self.sorter
        filterVC.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharCell", for: indexPath) as! CharInfoTableViewCell
        cell.setupWith(char: charList[indexPath.row], sorter: self.sorter)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charList?.count ?? 0
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let vc = CharDetailViewController()
        vc.chara = charList[indexPath.row]
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func doneAndReturn(filter: CGSSCharFilter, sorter: CGSSSorter) {
        CGSSSorterFilterManager.default.charFilter = filter
        CGSSSorterFilterManager.default.charSorter = sorter
        CGSSSorterFilterManager.default.saveForChar()
        self.updateUI()
    }
    
}
