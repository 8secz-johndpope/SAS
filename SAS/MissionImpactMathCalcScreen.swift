//
//  MissionImpactMathCalcScreen.swift
//  SAS
//
//  Created by Lauren Saxton on 11/16/19.
//  Copyright © 2019 Lauren Saxton. All rights reserved.
//  For references used in general rocket knowledge see the "references.rtf" file

import UIKit

class MissionImpactMathCalcScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //BEGIN code with citation - dismiss keyboard
        // https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift
        setupToHideKeyboardOnTapOnView()
        //END code with citation - dismiss keyboard
    }

}

//BEGIN code with citation - dismiss keyboard
// https://stackoverflow.com/questions/32281651/how-to-dismiss-keyboard-when-touching-anywhere-outside-uitextfield-in-swift
extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}
//END code with citation - dismiss keyboard
