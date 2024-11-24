//
//  FiltersManagerProtocol.swift
//  Rockets
//
//  Created by Simão Neves Samouco on 12/10/2024.
//

import Foundation

protocol FilterLaunchesUseCaseProtocol {
    func filterLaunches(launches: [Launch], filters: Filters) -> [Launch]
}

final class FilterLaunchesUseCase: FilterLaunchesUseCaseProtocol {

    func filterLaunches(launches: [Launch], filters: Filters) -> [Launch] {
        var filteredLaunches = launches
        
        if filters.showOnlySuccessful {
            filteredLaunches = filterSuccessful(filteredLaunches)
        }
        
        filteredLaunches = sortByType(filters.sortType, launches: filteredLaunches)

        if let startYear = filters.years?.first, let endYear = filters.years?.last {
            filteredLaunches = filterByYears(filteredLaunches, startDate: startYear, endDate: endYear)
        }
        
        return filteredLaunches
    }
   
    func filterSuccessful(_ launches: [Launch]) -> [Launch]  {
        return launches.filter { $0.wasSuccessful == true }
    }
    
    func sortByType(_ sortType: SortType, launches: [Launch]) -> [Launch] {
        return launches.sorted {
            switch sortType {
            case .ascending:
                return $0.dateLocal < $1.dateLocal
            case .descending:
                return $0.dateLocal > $1.dateLocal
            }
        }
    }

    func filterByYears(_ launches: [Launch], startDate: Date, endDate: Date) -> [Launch] {
        return launches.filter { launch in
            return launch.dateLocal.timeIntervalSince1970 >= startDate.timeIntervalSince1970 && launch.dateLocal.timeIntervalSince1970 <= endDate.timeIntervalSince1970
        }
    }
    
}
