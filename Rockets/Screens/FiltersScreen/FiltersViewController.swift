//
//  FiltersViewController.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import UIKit

class FiltersViewController: UIViewController, ViewCode {
    
    // MARK: Properties
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Filters"
        lb.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var succesfulLabel: UILabel =  {
        let lb = UILabel()
        lb.text = "Show successful launches"
        lb.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var showSuccessfulSlider: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    private lazy var ascendingLabel: UILabel =  {
        let lb = UILabel()
        lb.text = "Ascending"
        lb.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var ascendingSlider: UISwitch = {
        let sw = UISwitch()
        sw.isOn = true
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(ascendingSwitchChanged), for: .valueChanged)
        return sw
    }()
    
    private lazy var descendingLabel: UILabel =  {
        let lb = UILabel()
        lb.text = "Descending"
        lb.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var descendingSlider: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.translatesAutoresizingMaskIntoConstraints = false
        sw.addTarget(self, action: #selector(descendingSwitchChanged), for: .valueChanged)
        return sw
    }()
    
    private lazy var dateStartLabel: UILabel =  {
        let lb = UILabel()
        lb.text = "Start"
        lb.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var startDatePicker: UIDatePicker = {
       let dp = UIDatePicker()
        dp.datePickerMode = .yearAndMonth
        dp.addTarget(self, action: #selector(startDatePickerValueChanged(_:)), for: .valueChanged)
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    private lazy var dateEndLabel: UILabel =  {
        let lb = UILabel()
        lb.text = "End"
        lb.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var endDatePicker: UIDatePicker = {
       let dp = UIDatePicker()
        dp.datePickerMode = .yearAndMonth
        dp.addTarget(self, action: #selector(endDatePickerValueChanged(_:)), for: .valueChanged)
        dp.translatesAutoresizingMaskIntoConstraints = false
        return dp
    }()
    
    private lazy var dateLabel: UILabel =  {
        let lb = UILabel()
        lb.text = "Filter by year"
        lb.font =  UIFont.systemFont(ofSize: 14, weight: .regular)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private lazy var dateSlider: UISwitch = {
        let sw = UISwitch()
        sw.isOn = false
        sw.addTarget(self, action: #selector(filterByYearSwitchChanged), for: .valueChanged)
        sw.translatesAutoresizingMaskIntoConstraints = false
        return sw
    }()
    
    private lazy var dismissButton: UIButton = {
        let bt = UIButton()
        bt.setTitle("Apply Filters", for: .normal)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(dissmissButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    let viewModel: any FiltersViewModelProtocol
    
    //MARK: - Init / ViewDidLoad
    
    init(viewModel: any FiltersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
   
    //MARK: - Switches actions
    
    @objc private func ascendingSwitchChanged(_ switch: UISwitch) {
        descendingSlider.setOn(!descendingSlider.isOn, animated: true)
    }
    
    @objc private func descendingSwitchChanged(_ switch: UISwitch) {
        ascendingSlider.setOn(!ascendingSlider.isOn, animated: true)
    }
    
    @objc private func filterByYearSwitchChanged(_ switch: UISwitch) {
        dateComponents(shouldDisplay: dateSlider.isOn)
    }
    
    @objc func startDatePickerValueChanged(_ sender: UIDatePicker) {
        endDatePicker.minimumDate = sender.date
    }
    
    @objc func endDatePickerValueChanged(_ sender: UIDatePicker) {
        startDatePicker.maximumDate = sender.date
    }
    
    @objc private func dissmissButtonTapped(_ switch: UISwitch) {
        viewModel.didTapApplyFilters(with: createFilters())
    }
    
    // MARK: - View Code
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(succesfulLabel)
        view.addSubview(showSuccessfulSlider)
        view.addSubview(ascendingLabel)
        view.addSubview(ascendingSlider)
        view.addSubview(descendingLabel)
        view.addSubview(descendingSlider)
        view.addSubview(dateStartLabel)
        view.addSubview(startDatePicker)
        view.addSubview(dateEndLabel)
        view.addSubview(endDatePicker)
        view.addSubview(dateLabel)
        view.addSubview(dateSlider)
        view.addSubview(dismissButton)
        
        dateComponents(shouldDisplay: false)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        succesfulLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        succesfulLabel.trailingAnchor.constraint(equalTo: showSuccessfulSlider.trailingAnchor, constant: 20),
        succesfulLabel.centerYAnchor.constraint(equalTo: showSuccessfulSlider.centerYAnchor),
        
        showSuccessfulSlider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
        showSuccessfulSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        ascendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ascendingLabel.trailingAnchor.constraint(equalTo: ascendingSlider.trailingAnchor, constant: 20),
        ascendingLabel.centerYAnchor.constraint(equalTo: ascendingSlider.centerYAnchor),
        
        ascendingSlider.topAnchor.constraint(equalTo: showSuccessfulSlider.bottomAnchor, constant: 10),
        ascendingSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        descendingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        descendingLabel.trailingAnchor.constraint(equalTo: descendingSlider.trailingAnchor, constant: 20),
        descendingLabel.centerYAnchor.constraint(equalTo: descendingSlider.centerYAnchor),
        
        descendingSlider.topAnchor.constraint(equalTo: ascendingSlider.bottomAnchor, constant: 10),
        descendingSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        dateLabel.trailingAnchor.constraint(equalTo: dateSlider.trailingAnchor, constant: 20),
        dateLabel.centerYAnchor.constraint(equalTo: dateSlider.centerYAnchor),
        
        dateSlider.topAnchor.constraint(equalTo: descendingSlider.bottomAnchor, constant: 10),
        dateSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        
        dateStartLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        dateStartLabel.trailingAnchor.constraint(equalTo: startDatePicker.trailingAnchor, constant: 20),
        dateStartLabel.centerYAnchor.constraint(equalTo: startDatePicker.centerYAnchor),

        startDatePicker.topAnchor.constraint(equalTo: dateSlider.bottomAnchor, constant: 10),
        startDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        startDatePicker.heightAnchor.constraint(equalToConstant: 120),
        startDatePicker.widthAnchor.constraint(equalToConstant: 250),
        
        dateEndLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        dateEndLabel.trailingAnchor.constraint(equalTo: endDatePicker.trailingAnchor, constant: 20),
        dateEndLabel.centerYAnchor.constraint(equalTo: endDatePicker.centerYAnchor),

        endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 10),
        endDatePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        endDatePicker.heightAnchor.constraint(equalToConstant: 120),
        endDatePicker.widthAnchor.constraint(equalToConstant: 250),
        
        dismissButton.heightAnchor.constraint(equalToConstant: 70),
        dismissButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    func addStyling() {
        view.backgroundColor = .systemBackground
        dismissButton.tintColor = .red
        dismissButton.backgroundColor = .black
        dismissButton.layer.cornerRadius = 25
        dismissButton.layer.masksToBounds = true
    }
    
    private func dateComponents(shouldDisplay: Bool) {
        dateStartLabel.isHidden = !shouldDisplay
        startDatePicker.isHidden = !shouldDisplay
        dateEndLabel.isHidden = !shouldDisplay
        endDatePicker.isHidden = !shouldDisplay
    }
    
    private func createFilters() -> Filters {
        return Filters(showOnlySuccessful: showSuccessfulSlider.isOn,
                       sortType: ascendingSlider.isOn ? .ascending : .descending,
                       years: dateSlider.isOn ? [startDatePicker.date, endDatePicker.date] : nil)
    }
   
}
