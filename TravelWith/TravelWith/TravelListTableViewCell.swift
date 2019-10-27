//
//  TravelListTableViewCell.swift
//  TravelWith
//
//  Created by 정연희 on 22/10/2019.
//  Copyright © 2019 yeonheey. All rights reserved.
//

import UIKit

class TravelListTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    //MARK: IBOutlet
    @IBOutlet weak var travelTitle: UILabel!
    @IBOutlet weak var travelLength: UILabel!
    @IBOutlet weak var countOfMember: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
