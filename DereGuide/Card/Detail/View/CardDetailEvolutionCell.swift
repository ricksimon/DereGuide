//
//  CardDetailEvolutionCell.swift
//  DereGuide
//
//  Created by zzk on 2017/6/26.
//  Copyright © 2017年 zzk. All rights reserved.
//

import UIKit

class CardDetailEvolutionCell: UITableViewCell {
    
    var leftLabel: UILabel!
    
    var toIcon: CGSSCardIconView!
    
    var fromIcon: CGSSCardIconView!
    
    var arrowImageView = UIImageView(image: #imageLiteral(resourceName: "arrow-rightward").withRenderingMode(.alwaysTemplate))
    
    weak var delegate: CGSSIconViewDelegate?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        leftLabel = UILabel()
        leftLabel.textColor = UIColor.black
        leftLabel.font = UIFont.systemFont(ofSize: 16)
        leftLabel.text = NSLocalizedString("进化信息", comment: "卡片详情页")
        contentView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(10)
        }
        
        fromIcon = CGSSCardIconView()
        contentView.addSubview(fromIcon)
        fromIcon.snp.makeConstraints { (make) in
            make.top.equalTo(leftLabel.snp.bottom).offset(5)
            make.left.equalTo(10)
        }

        contentView.addSubview(arrowImageView)
        arrowImageView.tintColor = .darkGray
        arrowImageView.snp.makeConstraints { (make) in
            make.left.equalTo(fromIcon.snp.right).offset(17)
            make.centerY.equalTo(fromIcon)
        }
        
        toIcon = CGSSCardIconView()
        contentView.addSubview(toIcon)
        toIcon.snp.makeConstraints { (make) in
            make.left.equalTo(arrowImageView.snp.right).offset(17)
            make.top.equalTo(fromIcon)
            make.bottom.equalTo(-10)
        }
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardDetailEvolutionCell: CardDetailSetable {
    func setup(with card: CGSSCard) {
        if card.evolutionId == 0 {
            toIcon.cardID = card.id
            fromIcon.cardID = card.id - 1
            fromIcon.delegate = self.delegate
        } else {
            fromIcon.cardID = card.id
            toIcon.cardID = card.evolutionId
            toIcon.delegate = self.delegate
        }
    }
}
