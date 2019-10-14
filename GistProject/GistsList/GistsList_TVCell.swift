//
//  GistsList_TVCell.swift
//  GistProject
//
//  Created by Stanislav on 26/09/2019.
//  Copyright © 2019 Stanislav. All rights reserved.
//

import UIKit
import Imaginary

class GistsList_TVCell: UITableViewCell {

//    @IBOutlet weak var ownerAvatarImageView: UIImageView!
//    @IBOutlet weak var ownerUserName: UILabel!
//    @IBOutlet weak var gistName: UILabel!
    @IBOutlet weak var ownerUserName: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var ownerAvatarImageView: UIImageView!
    
    var data : GistsList_Model? {
        didSet {
            if let cellData = data {
                if let userName = self.ownerUserName {
                    userName.text = cellData.userName
                }
                if let postDate = self.postDate {
                    let onDateFormater = DateFormatter()
                    onDateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                    
                    let toDateFormater = DateFormatter()
                    toDateFormater.dateFormat = "dd.MM.yyyy"
                    
                    var date : String = ""
                    if let newDate = onDateFormater.date(from: cellData.postDate) {
                        date = toDateFormater.string(from: newDate)
                    }
                    postDate.text = "Дата поста: \(date)"
                }
                if let avatar = self.ownerAvatarImageView {
                    let imageUrl = URL(string: cellData.userAvatarURL)
                    if let url = imageUrl {
                        avatar.setImage(url: url)
                    }
                    
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func prepareForReuse() {
//        self.prepareForReuse()
//        self.ownerAvatarImageView.image = nil
//        self.gistName.text = ""
//        self.ownerUserName.text = ""
//        self.data = nil
//    }

}
