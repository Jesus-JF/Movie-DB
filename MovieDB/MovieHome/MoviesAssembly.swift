//
//  MoviesAssembly.swift
//  MovieDB
//
//  Created by Jhonatan Chavez  on 6/10/24.
//

import Foundation

class MoviesAssembly {
    static func build() -> ScreenOneVC {
        let moviesRouter = MoviesRouter()
        let moviesUseCase = MoviesUseCase()
        
        let moviesViewModel = MoviesViewModel(moviesRouter: moviesRouter, moviesUseCase: moviesUseCase)
        
        let screenOneVC = ScreenOneVC(viewModel: moviesViewModel)
        moviesRouter.viewController = screenOneVC
        moviesViewModel.delegate = screenOneVC
        
        return screenOneVC
    }
}
