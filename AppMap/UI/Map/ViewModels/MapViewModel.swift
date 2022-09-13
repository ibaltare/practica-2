
import Foundation

protocol MapViewModelProtocol {
}

final class MapViewModel {
    private weak var viewDelegate: MapViewProtocol?
    
    init(viewDelegate: MapViewProtocol){
        self.viewDelegate = viewDelegate
    }
}

extension MapViewModel: MapViewModelProtocol {
    
}
