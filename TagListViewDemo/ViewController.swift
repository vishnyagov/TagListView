//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TagListViewDelegate {

    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var biggerTagListView: TagListView!
    @IBOutlet weak var biggestTagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagListView.delegate = self
        tagListView.addTag(title: "TagListView")
        tagListView.addTag(title: "TEAChart")
        tagListView.addTag(title: "To Be Removed")
        tagListView.addTag(title: "To Be Removed")
        tagListView.addTag(title: "Quark Shell")
        tagListView.removeTag("To Be Removed")
        tagListView.addTag(title: "On tap will be removed").onTap = { [weak self] tagView in
            self?.tagListView.removeTagView(tagView)
        }
        
        let tagView = tagListView.addTag(title: "gray")
        tagView.tagBackgroundColor = UIColor.gray
        tagView.onTap = { tagView in
            print("Don’t tap me!")
        }

        tagListView.insertTag(title: "This should be the third tag", at: 2)
        
        biggerTagListView.delegate = self
        biggerTagListView.textFont = UIFont.systemFont(ofSize: 15)
        biggerTagListView.shadowRadius = 2
        biggerTagListView.shadowOpacity = 0.4
        biggerTagListView.shadowColor = UIColor.black
        biggerTagListView.shadowOffset = CGSize(width: 1, height: 1)
        biggerTagListView.addTag(title: "Inboard")
        biggerTagListView.addTag(title: "Pomotodo")
        biggerTagListView.addTag(title: "Halo Word")
        biggerTagListView.alignment = .center
        
        biggestTagListView.delegate = self
        biggestTagListView.textFont = UIFont.systemFont(ofSize: 24)
        // it is also possible to add all tags in one go
        biggestTagListView.addTags(["all", "your", "tag", "are", "belong", "to", "us"])
        biggestTagListView.alignment = .right
        
        // posible create tags with from attributed text
        
        let mutableAttributeString = NSMutableAttributedString()
        
        let textAttachment = NSTextAttachment()
        textAttachment.image = #imageLiteral(resourceName: "example_image")
        let attStrWithAttachment = NSMutableAttributedString(attributedString: NSAttributedString(attachment: textAttachment))
        attStrWithAttachment.addAttributes([NSAttributedStringKey.baselineOffset: -2], range: NSRange(location: 0, length: attStrWithAttachment.length))
        
        mutableAttributeString.append(attStrWithAttachment)
        
        let attributedString = NSMutableAttributedString(string: " Attributed Text")
        attributedString.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15)], range: NSRange(location: 0, length: attributedString.length))
        attributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.green], range: NSRange(location: 0, length: 11))
        attributedString.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue], range: NSRange(location: 11, length: 5))
        
        mutableAttributeString.append(attributedString)
        
        let attributedTag = biggerTagListView.addTag(attributedTitle: mutableAttributeString)
        attributedTag.tagBackgroundColor = UIColor.white
        attributedTag.selectedBackgroundColor = UIColor.gray
        attributedTag.highlightedBackgroundColor = UIColor.gray
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: TagListViewDelegate
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag pressed: \(title), \(sender)")
        tagView.isSelected = !tagView.isSelected
    }
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        print("Tag Remove pressed: \(title), \(sender)")
        sender.removeTagView(tagView)
    }
}

