# NASAApp

## Architecture

The project is base on MVVM architecture using RxSwift frameworks

## Project Structure

1. TestHelper/Recoder
    - Used for testing PublishSubjects
    
    
2. STYLEGUIDE/StyleGuide
    - provide generic function the access fonts and color used throughout the application
    - Used because its much more easy to revamp application if all ui style are group in one place
3. CustomClass/OfflineImageCacher
    - Single with a custom URLCache object initialize against a folder directory
    - Allow caching for images
    - Used to provide fast image loading, and also allow downloaded image to be displayed if no internet present
    - Improvement: need to add clear cache functionality if app is experiencing memory issue
4. CustomClass/LoadMoreView
    - a simple loadmore view using uiactivityIndicatorview
5. CustomClass/CustomImageView
    - UIImageView subclass which enable downloading image from url and work together with OfflineImageCacher
6. Approuter/Approuter
    - A simple class to manage routing throughout the application
7. NasaItemServiceProtocol
  - Protocol to NasaItems request (fetchItem, fetch large image from collection url)
8. NASAItemsManageable
  - Protocol for ViewModel managing NasaItems
9. NASAItemViewModelProtocol
  - Protocol for ViewModel conforming to NasaItem Object
 10. NASAappEnums
  - Enums shared thoughout the application
  11. APiManager
  - Class with contains base functions for perform urlsession request and return appropriate response (success/failure)
  12. NasaItemService
  - Class that conforms to the NasaItemServiceProtocol
  13. NasaAppEndpoints
  - Class contains all endpoints url used in the app
  14. NasaItem
  - class contains Codable object use to map response for fecthItem into appropriate objects
  - Improvement: Should have been able to provide basic cache for faster loading at application start
  - Improvement: May be i should have use dabase instead
15. SCREEN/..
  - Contains the UIViewController, together with their viewModel , UITableViewCell, tableview cell viewModels
  
  
### None issues:
  - the Loadmore animation need improvements