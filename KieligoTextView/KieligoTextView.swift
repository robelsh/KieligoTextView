//
//  KieligoTextView.swift
//  KieligoTextView
//
//  Created by JEZEQUEL ETIENNE on 07/01/2020.
//  Copyright © 2020 JEZEQUEL ETIENNE. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class KieligoTextView: UIView {
    
    // MARK: - Privates
    
    private let disposeBag = DisposeBag()
    
    fileprivate var textView: UITextView = UITextView()
    fileprivate var charCountLabel: UILabel = UILabel()
    
    // MARK: - IBInspectable

    @IBInspectable private var charLimit: Int = 500 {
        didSet {
            charCountLabel.text = String(charLimit)
        }
    }
    @IBInspectable private var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable private var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable private var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderWidth
        }
    }

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
}

// MARK: - TextView

extension KieligoTextView {
    
    fileprivate func setup() {
        addSubview(textView)
        addSubview(charCountLabel)
        
        charCountLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            charCountLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            charCountLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            textView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1),
            textView.bottomAnchor.constraint(equalToSystemSpacingBelow: layoutMarginsGuide.bottomAnchor, multiplier: 1),
            charCountLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: 0)
        ])
        
        // Label init
        charCountLabel.textAlignment = .right
        
        // TextView init
        textView.delegate = self
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: charCountLabel.frame.height, right: 0)
        textView.rx.text
            .orEmpty
            .map({String(self.charLimit - $0.count)})
            .bind(to: charCountLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension KieligoTextView: UITextViewDelegate {
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return (textView.text.count + text.count) < (charLimit + 1) || text == ""
    }
}

public extension KieligoTextView {
    
    func getRxTextView() -> ControlProperty<String?> {
        return textView.rx.text
    }
    
    func setLimit(_ limit: Int) {
        charLimit = limit
    }
    
    func setBorderColor(_ borderColor: UIColor) {
        self.borderColor = borderColor
    }
    
    func setBorderWidth(_ borderWidth: CGFloat) {
        self.borderWidth = borderWidth
    }
    
    func setBorderRadius(_ borderRadius: CGFloat) {
        self.borderRadius = borderRadius
    }
}
