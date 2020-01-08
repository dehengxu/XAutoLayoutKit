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
        let delta = CGFloat(50.0)

        _ = self.scrollView.followSize(of: self.view)?.followCenter(of: self.view)

        self.v1.removeFromSuperview()
        self.v2.removeFromSuperview()
        self.v3.removeFromSuperview()
        self.v4.removeFromSuperview()
        self.lineH.removeFromSuperview()
        self.lineV.removeFromSuperview()


        //self.v1.align(toLeft: 5.0, of: self.view)?.ahead(5.0, of: self.objectOfReference)?.align(toTop: 5.0, of: self.view)?.align(toBottom: 5.0, of: self.view)

        if let view = self.scrollView {
            //self.objectOfReference.align(toLeft: delta, of: self.view)?.align(toTop: delta, of: self.view)?.align(toRight: delta, of: self.view)?.align(toBottom: delta, of: self.view)
            self.scrollView.alwaysBounceVertical = true
            self.scrollView.alwaysBounceHorizontal = true
            self.scrollView.showsVerticalScrollIndicator = true

            var contentSize = self.scrollView.frame.size
            //contentSize.height += 100
            self.scrollView.contentSize = contentSize

            let content = UIView(frame: CGRect(x: 0, y: 50, width: contentSize.width, height: contentSize.height))

            content.isUserInteractionEnabled = false
            self.scrollView.addSubview(content)
            content.backgroundColor = .red
            //content.autoresizingMask = [.flexibleWidth, .flexibleHeight]

            self.scrollView.addSubview(self.objectOfReference)

            print("content: \(self.scrollView.contentSize)")

            // 视图依赖于 scrollview 的边界 (bottom, right)，而在 autolayout 中 scrollview 的边界依赖于 content view 的计算。所以，在 scrollview 中使用 autolayout 的方法有两种，1. 通过一个固定大小的 view 提供 scrollview 子视图的布局参考，2. scrollview 子视图的布局不依赖于 scrollview 的边界。
            self.objectOfReference.align(toLeft: delta, of: self.scrollView)?.align(toBottom: delta, of: self.scrollView)?.setConstraintSize(CGSize(width: 100, height: 100))

            // 视图的布局不依赖 scrollview的边界
            //self.objectOfReference.followSize(of: self.scroll)?.followCenter(of: self.scroll)
        }else {
            //let contentView = UIView(frame: CGRect(x: 0, y: 0, width: self.scrollView., height: <#T##CGFloat#>))
            self.objectOfReference.align(toLeft: delta, of: view)?.align(toBottom: delta, of: view)?.setConstraintSize(CGSize(width: 100, height: 100))
        }

    }

    func loadSubviewWithAutoresizeMask() {
        self.v1.removeFromSuperview()
        self.v2.removeFromSuperview()
        self.v3.removeFromSuperview()
        self.v4.removeFromSuperview()
        self.lineH.removeFromSuperview()
        self.lineV.removeFromSuperview()

        self.objectOfReference.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin, .flexibleBottomMargin]

    }

}
