//
//  UIViewController+ErrorView.swift
//  ErrorHandlerMVVM
//
//  Created by Fernando García Fernández on 7/3/17.
//  Copyright © 2017 Fernando García Fernández. All rights reserved.
//

public extension UIViewController {
    
    public func createGreyOverlayView() -> UIView {
        let viewToReturn = UIView()
        
        viewToReturn.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.7)
        viewToReturn.tag = 500
        viewToReturn.translatesAutoresizingMaskIntoConstraints = false
        
        return viewToReturn
    }
    
    func createMessageOverlayView() -> UIView {
        let messageOverlayView = UIView()
        messageOverlayView.translatesAutoresizingMaskIntoConstraints = false
        
        messageOverlayView.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.8)
        messageOverlayView.layer.cornerRadius = 10
        
        return messageOverlayView
    }
    
    func createErrorLabelView() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = UIFont(name: "Avenir-Medium", size: 18)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }
    
    func createErrorImageView(myImage: UIImage!) -> UIImageView {
        let messageOverlayImageView = UIImageView(image: myImage)
        messageOverlayImageView.translatesAutoresizingMaskIntoConstraints = false
        return messageOverlayImageView
    }
    
    func showGenericError(message: String) {
        print("1")
        showGenericError(message: message, image:UIImage(named: "generic_error")!)
    }
    
    func showGenericError(message: String, imageName: String) {
        if let image = UIImage(named: imageName) {
            showGenericError(message: message, image: image)
        }
        else {
            showGenericError(message: message)
        }
    }
    
    func showGenericError(message: String, image: UIImage) {
        print("2")
        guard !message.isEmpty else {
            return
        }
        
        
        
        let regex = try? NSRegularExpression(pattern: "<.*?>",options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, message.characters.count)
        let htmlLessString :String = regex!.stringByReplacingMatches(in: message,
                                                                             options: NSRegularExpression.MatchingOptions(),
                                                                             range:range ,
                                                                             withTemplate: "")
        
        
        hideGenericError()
        
        let myView = self.navigationController?.view!
        
        // Creating and setting up the grey background
        let greyOverlayView = createGreyOverlayView()
        
        // Creating and setting up the error message box
        let messageOverlayView = createMessageOverlayView()
        
        // Creating and setting up the error message
        let messageOverlayViewLabel = createErrorLabelView()
        messageOverlayViewLabel.text = htmlLessString
        
        // Creating and setting up the imageview
        let messageOverlayImageView = createErrorImageView(myImage: image)
        
        // Adding these views to superview
        messageOverlayView.addSubview(messageOverlayImageView)
        messageOverlayView.addSubview(messageOverlayViewLabel)
        greyOverlayView.addSubview(messageOverlayView)
        print("3")
        myView!.addSubview(greyOverlayView)
        print("4")
        // Setting up constraints for grey background
        let greyOverlayViewLeftConstraint = NSLayoutConstraint(
            item: greyOverlayView,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1,
            constant: 0
        )
        let greyOverlayViewRightConstraint = NSLayoutConstraint(
            item: greyOverlayView,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: 0
        )
        let greyOverlayViewTopConstraint = NSLayoutConstraint(
            item: greyOverlayView,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 0
        )
        let greyOverlayViewBottomConstraint = NSLayoutConstraint(
            item: greyOverlayView,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: myView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 0
        )
        let greyOverlayConstraints = [greyOverlayViewLeftConstraint,greyOverlayViewRightConstraint,greyOverlayViewTopConstraint,greyOverlayViewBottomConstraint]
        myView!.addConstraints(greyOverlayConstraints)
        NSLayoutConstraint.activate(greyOverlayConstraints)
        
        // Setting up constraints for error message box
        let messageOverlayViewLeftConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: greyOverlayView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1,
            constant: 20
        )
        let messageOverlayViewRightConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: greyOverlayView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: -20
        )
        let messageOverlayViewCenterXConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: greyOverlayView,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0
        )
        let messageOverlayViewCenterYConstraint = NSLayoutConstraint(
            item: messageOverlayView,
            attribute: NSLayoutAttribute.centerY,
            relatedBy: NSLayoutRelation.equal,
            toItem: greyOverlayView,
            attribute: NSLayoutAttribute.centerY,
            multiplier: 1,
            constant: 0
        )
        let messageOverlayViewConstraints = [messageOverlayViewLeftConstraint, messageOverlayViewRightConstraint, messageOverlayViewCenterXConstraint, messageOverlayViewCenterYConstraint]
        greyOverlayView.addConstraints(messageOverlayViewConstraints)
        NSLayoutConstraint.activate(messageOverlayViewConstraints)
        // sizeToFit of the label, here we calculate the height of the (potentially) multilined error label
        messageOverlayViewLabel.sizeToFit()
        
        // Setting up constraints for the icon of the message box
        let messageOverlayImageViewTopConstraint = NSLayoutConstraint(
            item: messageOverlayImageView,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.top,
            multiplier: 1,
            constant: 30
        )
        let messageOverlayImageViewCenterConstraint = NSLayoutConstraint(
            item: messageOverlayImageView,
            attribute: NSLayoutAttribute.centerX,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.centerX,
            multiplier: 1,
            constant: 0
        )
        let messageOverlayImageViewConstraints = [messageOverlayImageViewTopConstraint, messageOverlayImageViewCenterConstraint]
        messageOverlayView.addConstraints(messageOverlayImageViewConstraints)
        NSLayoutConstraint.activate(messageOverlayImageViewConstraints)
        
        // Setting up constraints for the icon with itself (aspect ratio and width/height)
        let messageOverlayImageViewHeightConstraint = NSLayoutConstraint(
            item: messageOverlayImageView,
            attribute: NSLayoutAttribute.height,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayImageView,
            attribute: NSLayoutAttribute.height,
            multiplier: 0,
            constant: 64
        )
        let messageOverlayImageViewRatioConstraint = NSLayoutConstraint( // This way the aspect ratio of the image won't be modified without need of redraw the image itself
            item: messageOverlayImageView,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayImageView,
            attribute: NSLayoutAttribute.height,
            multiplier: image.size.width/image.size.height,
            constant: 0
        )
        messageOverlayImageView.addConstraint(messageOverlayImageViewRatioConstraint)
        messageOverlayImageView.addConstraint(messageOverlayImageViewHeightConstraint)
        NSLayoutConstraint.activate([messageOverlayImageViewRatioConstraint])
        
        // Setting up constraints for the error label
        let messageOverlayViewTextViewTopConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.top,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayImageView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: 10
        )
        let messageOverlayViewTextViewBottomConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.bottom,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.bottom,
            multiplier: 1,
            constant: -30
        )
        let messageOverlayViewTextViewLeftConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.left,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.left,
            multiplier: 1,
            constant: 30
        )
        let messageOverlayViewTextViewRightConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.right,
            relatedBy: NSLayoutRelation.equal,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.right,
            multiplier: 1,
            constant: -30
        )
        let messageOverlayViewTextViewMaxWidthConstraint = NSLayoutConstraint(
            item: messageOverlayViewLabel,
            attribute: NSLayoutAttribute.width,
            relatedBy: NSLayoutRelation.lessThanOrEqual,
            toItem: messageOverlayView,
            attribute: NSLayoutAttribute.width,
            multiplier: 1,
            constant: -60
        )
        let messageOverlayViewTextViewConstraints = [messageOverlayViewTextViewTopConstraint, messageOverlayViewTextViewBottomConstraint, messageOverlayViewTextViewLeftConstraint, messageOverlayViewTextViewRightConstraint, messageOverlayViewTextViewMaxWidthConstraint]
        messageOverlayView.addConstraints(messageOverlayViewTextViewConstraints)
        NSLayoutConstraint.activate(messageOverlayViewTextViewConstraints)
        
        // Redistribute elements using the constraints
        view.setNeedsLayout()
        
        // Gesture recognizer: hide error on tap
        let removeSelector : Selector = #selector(UIViewController.hideGenericError)
        let tapGesture = UITapGestureRecognizer(target: self, action: removeSelector)
        greyOverlayView.addGestureRecognizer(tapGesture)
    }
    
    func hideGenericError() {
        if let viewWithTag = self.navigationController?.view!.viewWithTag(500){
            viewWithTag.removeFromSuperview()
        }
    }
}
