//
//  EmployeeTableViewCell.swift
//  EmployeesSampleProject
//
//  Created by Artem Semavin on 28/03/2019.
//  Copyright © 2019 Semavin Artem. All rights reserved.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    var name: String? {
        set {
            nameLabel.text = newValue
        }
        get {
            return nameLabel.text
        }
    }
    
    var birthYear: String? {
        set {
            birthYearLabel.text = newValue
        }
        get {
            return birthYearLabel.text
        }
    }
    
    var salary: String? {
        set {
            salaryLabel.text = newValue
        }
        get {
            return salaryLabel.text
        }
    }
    
    // MARK: - UI
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var birthYearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.preferredFont(forTextStyle: .caption2)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var salaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        return label
    }()

    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Private
    
    private func setupView() {
        [
            nameLabel,
            birthYearLabel,
            salaryLabel,
        ].forEach { [weak contentView] in
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView?.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        nameLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        birthYearLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        salaryLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.single),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Space.double),
            
            birthYearLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            birthYearLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Space.double),

            contentView.rightAnchor.constraint(equalTo: salaryLabel.rightAnchor, constant: Space.double),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: birthYearLabel.bottomAnchor,
                                                constant: Space.single),

            salaryLabel.leftAnchor.constraint(greaterThanOrEqualTo: nameLabel.rightAnchor,
                                              constant: Space.single),
            salaryLabel.leftAnchor.constraint(greaterThanOrEqualTo: birthYearLabel.rightAnchor,
                                              constant: Space.single),
            salaryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
}


