//
//  IntCounterView.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 22.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit

class IntCounterView: UIView {
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            self.captionLabel.text = title
        }
    }
    
    var count: Int? = nil {
        didSet {
            self.valueLabel.text = (count != nil) ? "\(count!)" : ""
        }
    }
    
    // MARK: - UIView Overrides

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let width = self.captionLabel.intrinsicContentSize().width + self.offsetBetweenLabels +
            self.valueLabel.intrinsicContentSize().width
        let height = max(self.captionLabel.intrinsicContentSize().height, self.valueLabel.intrinsicContentSize().height)
        return CGSizeMake(width, height)
    }
    
    // MARK: - Subviews
    
    var captionLabel: UILabel! = nil
    var valueLabel: UILabel! = nil
    
    func setup() {
        self.setupSubviews()
        self.setupLayout()
    }
    
    func setupSubviews() {
        self.captionLabel = UILabel()
        self.captionLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.captionLabel.cas_styleClass = "int-counter-caption"
        self.addSubview(self.captionLabel)
        
        self.valueLabel = UILabel()
        self.valueLabel.setTranslatesAutoresizingMaskIntoConstraints(false)        
        self.valueLabel.cas_styleClass = "int-counter-value"
        self.addSubview(self.valueLabel)
    }
    
    let offsetBetweenLabels: CGFloat = 4
    
    func setupLayout() {
        let views: [NSObject : AnyObject] = [
            "captionLabel" : self.captionLabel,
            "valueLabel" : self.valueLabel,
        ]
        
        let metrics: [NSObject : AnyObject] = [
            "offset" : self.offsetBetweenLabels,
        ]
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[captionLabel]-offset-[valueLabel]-0-|",
            options: NSLayoutFormatOptions.allZeros, metrics: metrics,views: views)
        self.addConstraints(horizontalConstraints)
        
        let captionLabelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[captionLabel]-0-|",
            options: NSLayoutFormatOptions.allZeros, metrics: metrics,views: views)
        self.addConstraints(captionLabelVerticalConstraints)
        
        let valueLabelVerticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[valueLabel]-0-|",
            options: NSLayoutFormatOptions.allZeros, metrics: metrics,views: views)
        self.addConstraints(valueLabelVerticalConstraints)
    }
    
}
