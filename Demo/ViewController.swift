//
//  ViewController.swift
//  Demo
//
//  Created by Deheng Xu on 2019/11/26.
//

import Foundation
import UIKit

extension ViewController {

    @objc func _loadConstraintsD() {
//        self.v1
//            .align(toLeft: 5.0, of: self.view)?
//            .followCenterY(of: self.view)?
//            .setConstraintHeight(20.0)?
//            //.setConstraintWidth(20.0)
//            .ahead(5.0, of: self.objectOfReference)

        //self.objectOfReference.align(toRight: 10.0, of: self.view)?.followCenterY(of: self.view)?.setConstraintHeight(200.0)?.setConstraintWidth(200.0)?.after(5.0, of: self.v1)
    }

    @objc func _loadConstraintsE() {
        let delta = CGFloat(100.0)

        self.v1.align(toLeft: 5.0, of: self.view)?.ahead(5.0, of: self.objectOfReference)?.align(toTop: 5.0, of: self.view)?.align(toBottom: 5.0, of: self.view)

        self.objectOfReference.align(toLeft: delta, of: self.view)?.align(toTop: delta, of: self.view)?.align(toRight: delta, of: self.view)?.align(toBottom: delta, of: self.view)
    }

}
