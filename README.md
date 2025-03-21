# Rockets

# ABOUT THE APP

This is a Swift application that consumes the SpaceX API.

The app is built using the MVVM (Model-View-ViewModel) architecture, along with other design patterns such as Dependency Injection, Coordinator, Factory, and Use Cases. It also follows a protocol-oriented implementation approach.

By following to these patterns, the app becomes loosely coupled and easier to test.


## Key Design Patterns
### Coordinator  
The `Coordinator` pattern is responsible for managing navigation. It centralizes navigation logic in a single place, relieving the `ViewModel` from handling it.

### Factory.  
The Factory pattern is used to create screens. This abstraction allows the `Coordinator` to focus on navigation without worrying about how view controllers are created or what dependencies they need. The `Coordinator` retrieves view controllers from the `Factory`, which handles their creation and dependency management. This means changes to the concrete implementation of a view controller won't affect the `Coordinator`, as it’s abstracted away from these details.

### Dependency Injection & Protocol-Oriented Approach.  
By using Dependency Injection and a protocol-oriented design, the app becomes loosely coupled. Instead of depending on concrete implementations, classes depend on protocols, making the code easier to test. For instance, mock versions of dependencies that conform to a protocol can be injected during testing.

To better manage dependencies, the app uses a `Dependency Container`. This dictionary holds all the app's dependencies. Its a dictionary where each key is associated with either a concrete instance of a type or a factory closure that creates an instance. The keys in the dictionary represent protocol types, as the objects in the app depend on protocols rather than concrete implementations. This design ensures loose coupling and flexibility in swapping out dependencies.

### Use Cases.  
Use Cases encapsulate specific functionality, further decoupling the business logic from other parts of the application. For example, the `RocketsFiltersUseCase` handles filtering logic. While the `ViewModel` is responsible for knowing which filters the user selected, it doesn't perform the filtering itself. Instead, the `ViewModel` passes the list of rockets and the selected filters to the Use Case, which returns a filtered array. This separation of concerns helps keep the `ViewModel` clean and focused on its core responsibilities.


### Tests
Some tests were written to display how a dependency injection facilitates mocking data and responses to test the correct behaviour different scenarios.

There is a `Resources` folder in the project containing JSON files with the responses from the API. This was used to develope the application with no internet access.

### Note
I am aware that some of the implementaions might be a little overkill for a small project like this.   
I tried to develop an app that could grow into something bigger and that follows the SOLID principles.

## What changed:
### Based on the comments made a few improvements were made to the code
Comments made:
1. There's no need to have a dependency container when working with the Factory design pattern.
2. Methods in the coordinator are accessible from the view model and factory.
3. Rockets TableView using `UITableViewDataSource` and `ReloadData()` to update its content.
4. A lot of UILabels being created which could be done inside a `LabelsFactory`.
5. API calls to fetch the cell image are not being cancelled when the cell is reused.
6. New instance of `JSONDecoder` being created everytime RocketsServices decodes something.


#### Solutions:
### **1: There's no need to have a dependency container when working with a Factory design pattern.**   

To fix this I removed the `DepencyContainer` file from the project and added a dictionary to the `Factory` which now contains the dependencies.   
  
Two `Factory` extension files were added, one to add (register) the dependencies into the dictionary (`Factory+Registration`) and one that holds the logic that writes and retreives values from the dependencies dictionary (`register` and `resolve`) 

Note that there is a Factory that creates a `FactoryViewControllers`. This was made thinking of a scenario in which different factories are used (a factory for each feature of the app, for example).

### **2: Methods in the coordinator are accessible from the view model and factory.**   

This was a fairly simple fix. Previously the Coordinators implemented the `Coordinator` protocol which allowed access to custom made navigation methods. Altough this method works it exposed functionality to the view model and factory.   
So to fix this I implemented a `CoreCoordinator` which provides the same custom made navigation methods and injected it into the views coordinator.   
This way the functionality is contained within the coordinator.

**Note:** Because the views coodinator now depend on the `CoreCoordinator` which takes in a `UINavigationController` it was required that the `resolve` and `register` methods accept an argument.   

### **3.** Rockets TableView using `UITableViewDataSource` and `ReloadData()` to update its content.
This was updated to so that the table view now uses `UITableViewDiffableDataSource` as a data source. This way whenever the filters are applied there is no need to reload the whole table view. Also methods from `UITableViewDataSource`no longer need to be implemented.

Note: Because I used the factory design pattern in this project I felt like creating the cell in the view controller wasn't right.   
The cell is injected with a factory label, why should the view controller know of the cell's dependencies?   
Moving the creation of the cell into the Factory was a challenge because I didn't just want to move it's creation into another place. I also wanted to preserve the `prepareForReuse` functionality, otherwise a new cell would be created everytime and it would never be reused. But by passing a reference of the table view into the method of the cell creation I managed to make this work. The `prepareForReuse` method is working fine and the cells dependencies are managed in the Factory as they should.

### 4. A lot of UILabels being created which could be done inside a LabelsFactory.
Implemented a `LabelsFactory` that allows the creation of `UILabels` with different attributes with a single line of code.   
This really cleans up a lot the views!   
This was injected into the `view` rather than the `view model` as it is a UI related dependency.

### 5. API calls to fetch the cell image are not being cancelled when the cell is reused.  
The logic around the cell was improved by adding a view model that could handle the task of fetching the image from an URL, cancel that task when preparing for the cell reuse and managing the data format for the labels.
This new implementation makes sure that the cell is cleaned up before reused, preventing data display inconsistencies.

### 6. New instance of `JSONDecoder` being created everytime RocketsServices decodes something.
The code was opimized so that certained instances were not created everytime, such as `JSONDocoder` in the `RocketsServices` and `DateFormatter` in the `LaunchCell`.


