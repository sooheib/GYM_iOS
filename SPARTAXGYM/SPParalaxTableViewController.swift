//
//  ClassesViewController.swift
//  SPARTAXGYM
//
//  Created by souheib on 3/12/17.
//  Copyright © 2017 souheib. All rights reserved.
//

import UIKit

class SPParallaxTableViewController: UITableViewController {
    
    private var cellHeight: CGFloat = 240

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("need emplementation in subclass")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        fatalError("need emplementation in subclass")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.cellHeight
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableView.visibleCells.forEach { cell in
            let parallaxCell = cell as! SPParallaxTableViewCell
            parallaxCell.parallaxOffset(self.tableView)
        }
    }

}
