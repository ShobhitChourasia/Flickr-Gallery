//
//  CustomViewController.swift
//  Flickr-Gallery
//
//  Created by Shobhit on 22/05/21.
//


import UIKit

open class CustomViewController<View: UIView>: UIViewController {

    // MARK: - Properties
    public var customView: View {
        view as! View
    }

    // MARK: - Life Cycle
    override open func loadView() {
        view = View(frame: UIScreen.main.bounds)
    }

}

