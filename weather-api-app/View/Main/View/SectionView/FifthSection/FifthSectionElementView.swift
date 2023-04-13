//
//  FifthSectionElementView.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/19.
//

import UIKit

import SnapKit

final class FifthSectionElementView: UIView {
    
    // MARK: - UI
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    
    // MARK: - Constants
    private let superviewInset = Constants.FifthSectionView.superviewInset
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpTitleLabel()
        setUpContentLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - View
extension FifthSectionElementView {
    
    private func setUpView() {
        setStyleOfView()
        addSubviews()
    }
    
    private func setStyleOfView() {
        backgroundColor = Constants.Color.mainSection
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        [titleLabel, contentLabel].forEach { addSubview($0) }
    }
    
}

// MARK: - Title Label
extension FifthSectionElementView {
    
    private func setUpTitleLabel() {
        setStyleOfTitleLabel()
        setConstraintsOfTitleLabel()
    }
    
    private func setStyleOfTitleLabel() {
        titleLabel.textAlignment = .left
        titleLabel.textColor = .white
        titleLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 15)
    }
    
    private func setConstraintsOfTitleLabel() {
        titleLabel.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(superviewInset)
        }
    }
    
    func setTitleLabel(to title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - Content Label
extension FifthSectionElementView {
    
    private func setUpContentLabel() {
        setStyleOfContentLabel()
        setConstraintsOfContentLabel()
    }
    
    private func setStyleOfContentLabel() {
        contentLabel.textAlignment = .left
        contentLabel.textColor = .white
        contentLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 35)
    }
    
    private func setConstraintsOfContentLabel() {
        contentLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(superviewInset)
            $0.centerY.equalToSuperview()
        }
    }
    
    func setContentLabel(to content: String) {
        contentLabel.text = content
    }
    
}
