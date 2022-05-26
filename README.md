# Jobsity Challenge

## Requirements
Xcode 13.x
iOS 15+

## Running
The project only requires to use Xcode 13.x and iOS 15+, no external dependency was used. To run the project, it's only required to open the TVList.xcodeproj, select TVList target with an iOS15+ device and run.

## View
The app uses SwiftUI due to the fact that it's easy to create reusable components for scalability, also small apps can be built in a fast and simple way.

The app takes advantages of using viewModifiers to create searchable list for iOS 15+ natively.

## ViewModel
ViewModel maintains the business logic responsibility and calls the Repository layer to retrieve data ClientService.
This layer uses Combine for a reactive approach when a new data comes or an error is received, so the view can be refreshed and the correct components be displayed.

## Repository
A layer to fetch the data from client or local. This layer was created to remove the logic of fetching data and checking its results from the ViewModel. The reason to create this is to make the app even more scalable for a possible persistence layer, by having a localPersisting protocol where methods to cache the results in case the user loses network access.

## Dependencies
The app contains one local SwiftPackageManager as dependency, which is `Client`. `Client` was created along with this project to make network requests. With the use of async/await, it makes network requests, decodes using generics and throws errors. It also contains the app's endpoints.

## Unit tests
Unit tests were added to the app and the swift package manager. The whole layer of repository and remote client calls are tested. ViewModel layer isn't currently tested due to lack of time. 

## Nexts steps
If provided more time, next steps would be:
1. Implement a CI with github actions to make sure future changes don't break the app; 
2. Implemet unit tests to every layer of the app;
3. Add local persisting layer to cache results;
4. Think of best UI to be used on iPad using columns navigation view.
