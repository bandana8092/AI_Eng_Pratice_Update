//
//  PostsTableViewCell.swift
//  Bandana_Update_2
//
//  Created by Rakesh Nangunoori on 03/02/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCell(postModel: [PostsModel], indexPath: IndexPath){
        self.titleLabel.text = postModel[indexPath.row].title
        self.dateLabel.text = postModel[indexPath.row].createdDate.formatChanges(format: "dd MMM YYY")
        self.switchButton.isOn  = postModel[indexPath.row].switchStatus
        self.switchButton.isUserInteractionEnabled = false
    }
    
}
