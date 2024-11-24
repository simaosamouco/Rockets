//
//  LaunchTableViewCell.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import UIKit

class LaunchTableViewCell: UITableViewCell, ViewCode {
    
    // MARK: - UI Components
    // Static Labels
    private let missionStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.text = "Mission:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.text = "Date/Time:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rocketStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.text = "Rocket:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let daysSinceStaticLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.text = "Days Since:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Dynamic Labels
    private let missionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rocketLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let daysSinceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let missionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let checkmarkView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Code
    func addViews() {
        contentView.addSubview(missionImageView)
        contentView.addSubview(missionStaticLabel)
        contentView.addSubview(missionLabel)
        contentView.addSubview(dateStaticLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(rocketStaticLabel)
        contentView.addSubview(rocketLabel)
        contentView.addSubview(daysSinceStaticLabel)
        contentView.addSubview(daysSinceLabel)
        contentView.addSubview(checkmarkView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            missionImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            missionImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            missionImageView.widthAnchor.constraint(equalToConstant: 25),
            missionImageView.heightAnchor.constraint(equalToConstant: 25),
            
            missionStaticLabel.leadingAnchor.constraint(equalTo: missionImageView.trailingAnchor, constant: 8),
            missionStaticLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            
            missionLabel.leadingAnchor.constraint(equalTo: missionStaticLabel.trailingAnchor, constant: 8),
            missionLabel.trailingAnchor.constraint(equalTo: checkmarkView.leadingAnchor, constant: -16),
            missionLabel.centerYAnchor.constraint(equalTo: missionStaticLabel.centerYAnchor),
            
            dateStaticLabel.leadingAnchor.constraint(equalTo: missionStaticLabel.leadingAnchor),
            dateStaticLabel.topAnchor.constraint(equalTo: missionStaticLabel.bottomAnchor, constant: 8),
            
            dateLabel.leadingAnchor.constraint(equalTo: dateStaticLabel.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: checkmarkView.leadingAnchor, constant: -16),
            dateLabel.centerYAnchor.constraint(equalTo: dateStaticLabel.centerYAnchor),
            
            rocketStaticLabel.leadingAnchor.constraint(equalTo: missionStaticLabel.leadingAnchor),
            rocketStaticLabel.topAnchor.constraint(equalTo: dateStaticLabel.bottomAnchor, constant: 8),
            
            rocketLabel.leadingAnchor.constraint(equalTo: rocketStaticLabel.trailingAnchor, constant: 8),
            rocketLabel.trailingAnchor.constraint(equalTo: checkmarkView.leadingAnchor, constant: -16),
            rocketLabel.centerYAnchor.constraint(equalTo: rocketStaticLabel.centerYAnchor),
            
            daysSinceStaticLabel.leadingAnchor.constraint(equalTo: missionStaticLabel.leadingAnchor),
            daysSinceStaticLabel.topAnchor.constraint(equalTo: rocketStaticLabel.bottomAnchor, constant: 8),
            daysSinceStaticLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            daysSinceLabel.leadingAnchor.constraint(equalTo: daysSinceStaticLabel.trailingAnchor, constant: 8),
            daysSinceLabel.trailingAnchor.constraint(equalTo: checkmarkView.leadingAnchor, constant: -16),
            daysSinceLabel.centerYAnchor.constraint(equalTo: daysSinceStaticLabel.centerYAnchor),
            
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkmarkView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkView.heightAnchor.constraint(equalToConstant: 24),
            
            checkmarkView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            checkmarkView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            checkmarkView.widthAnchor.constraint(equalToConstant: 24),
            checkmarkView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func addStyling() {
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    // MARK: - Configure Cell
    func configure(launch: Launch, image: UIImage) {
        missionLabel.text = launch.name
        rocketLabel.text = launch.rocket
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        dateLabel.text = formatter.string(from: launch.dateLocal)
        daysSinceStaticLabel.text = launch.dateLocal.isInTheFuture ? "Days until launch:" : "Days since launch:"
        daysSinceLabel.text = launch.dateLocal.isInTheFuture ? "-\(launch.dateLocal.daysSince)" : " +\(launch.dateLocal.daysSince)"
        
        missionImageView.image = image
        if let success = launch.wasSuccessful {
            checkmarkView.image = success ? UIImage(systemName: "checkmark") : UIImage(systemName: "xmark")!
            checkmarkView.tintColor = success ? .green : .red
        } else {
            checkmarkView.image = UIImage(systemName: "questionmark")!
            checkmarkView.tintColor = .black
        }
    }
    
}
