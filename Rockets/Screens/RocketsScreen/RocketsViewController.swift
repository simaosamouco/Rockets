//
//  ViewController.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 11/10/2024.
//

import UIKit
import Combine

class RocketsViewController: UIViewController, ViewCode, UITableViewDelegate  {
    
    // MARK: - Properties
    private lazy var rightBarButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
                                                      style: .plain,
                                                      target: self,
                                                      action: #selector(onTapFiltersButton))
    
    private lazy var companyTitleLabel = labelFactory.makeTitleLabel(text: "COMPANY")
    private lazy var companySummaryLabel = labelFactory.makeLabel(numberOfLines: 0)
    private lazy var launchesTitleLabel = labelFactory.makeTitleLabel(text: "LAUNCHES")

    private lazy var launchesTableView: UITableView = {
        let tb = UITableView()
        tb.backgroundColor = .clear
        tb.translatesAutoresizingMaskIntoConstraints = false
        return tb
    }()
    
    private let viewModel: any RocketsViewModelProtocol
    private var cancellables: Set<AnyCancellable> = []
    private var dataSource: UITableViewDiffableDataSource<LaunchesTableViewSections, LaunchCellViewModel>!
    private var labelFactory: LabelFactoryUseCaseProtocol
    
    // MARK: - Init / viewDidLoad
    
    init(viewModel: any RocketsViewModelProtocol, labelFactory: LabelFactoryUseCaseProtocol) {
        self.viewModel = viewModel
        self.labelFactory = labelFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.didLoad()
        setupDataSource()
        setUpViews()
    }
    
    private func setupDataSource() {
        dataSource = UITableViewDiffableDataSource<LaunchesTableViewSections,
                                                   LaunchCellViewModel>(
            tableView: launchesTableView,
            cellProvider: { (tableView: UITableView, indexPath: IndexPath, launchViewModel: LaunchCellViewModel) in
                guard let cell = self.viewModel.getLaunchCell(for: tableView,
                                                              at: indexPath) as? LaunchCell,
                      let launchViewModel = self.viewModel.launchViewModel(at: indexPath.row) else {
                    return UITableViewCell()
                }
                cell.configure(with: launchViewModel)
                return cell
            }
        )
        
        launchesTableView.dataSource = dataSource
    }
    
    // MARK: View Code
    func addViews() {
        navigationItem.rightBarButtonItem = rightBarButton
        view.addSubview(companyTitleLabel)
        view.addSubview(companySummaryLabel)
        view.addSubview(launchesTitleLabel)
        view.addSubview(launchesTableView)
        
        launchesTableView.delegate = self
        launchesTableView.register(LaunchCell.self,
                                   forCellReuseIdentifier: LaunchCell.identifier)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
        companyTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
        companyTitleLabel.heightAnchor.constraint(equalToConstant: 50),
        companyTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        
        companySummaryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
        companySummaryLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        companySummaryLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        companySummaryLabel.topAnchor.constraint(equalTo: companyTitleLabel.bottomAnchor, constant: 10),
        
        launchesTitleLabel.widthAnchor.constraint(equalToConstant: view.frame.width),
        launchesTitleLabel.heightAnchor.constraint(equalToConstant: 50),
        launchesTitleLabel.topAnchor.constraint(equalTo: companySummaryLabel.bottomAnchor, constant: 10),
        
        launchesTableView.widthAnchor.constraint(equalToConstant: view.frame.width),
        launchesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        launchesTableView.topAnchor.constraint(equalTo: launchesTitleLabel.bottomAnchor),
        launchesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func addStyling() {
        title = viewModel.title
        rightBarButton.tintColor = .black
        view.backgroundColor = .systemBackground
    }
    
    func addBindings() {
            viewModel.textPublisher
                .receive(on: RunLoop.main)
                .sink { [weak self] newText in
                    guard let self else { return }
                    self.companySummaryLabel.text = newText
                }
                .store(in: &cancellables)
            
            viewModel.launchesViewModelsPublisher
                .receive(on: RunLoop.main)
                .sink { [weak self] launches in
                    guard let self else { return }
                    
                    var snapshot = NSDiffableDataSourceSnapshot<LaunchesTableViewSections, LaunchCellViewModel>()
                    snapshot.appendSections([.main])
                    snapshot.appendItems(launches)
                    
                    self.dataSource.apply(snapshot, animatingDifferences: true)
                    
                    if !launches.isEmpty {
                        self.launchesTableView.scrollToRow(at: IndexPath(row: 0, section: 0),
                                                           at: .top,
                                                           animated: true)
                    }
                }
                .store(in: &cancellables)
        }
    
    // MARK: TableView didSelect
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let launchViewModel = viewModel.launchViewModel(at: indexPath.row) else { return }
        viewModel.onSelectLaunch(launchViewModel)
    }
    
    // MARK: Button Action
    
    @objc func onTapFiltersButton() {
        viewModel.onTapFilters()
    }
    
}
