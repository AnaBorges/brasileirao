//
//  detalheJogoViewModel.swift
//  brasileirao
//
//  Created by Ana Julia on 3/11/20.
//  Copyright © 2020 Ana Julia. All rights reserved.
//

import Foundation

protocol DetalheJogoViewModelProtocol: class{
    
    var lances: [LanceALanceModel] { get }
    var ficha: FichaModel? { get }
    var jogoSelecionado: JogoModel? { get }
    init(apiClient: APIClient, jogo: JogoModel)
    
}

protocol DetalheJogoViewModelDelegate: class {
    func mostrarFichaJogo()
    func mostrarLanceALance()
    func exibirErro(msg: String)
}

class DetalheJogoViewModel : DetalheJogoViewModelProtocol{
    //var idJogo: Int = 1
    var lances: [LanceALanceModel] = []
    var ficha: FichaModel?
    var jogoSelecionado: JogoModel?

    private let apiClient : APIClient

    weak var delegate: DetalheJogoViewModelDelegate?

    required init(apiClient: APIClient, jogo: JogoModel) {
        self.apiClient = apiClient
        self.jogoSelecionado = jogo
        consultaLances()
        
    }

    func consultaFicha() {
        guard let jogoSelecionado = jogoSelecionado else {
            delegate?.exibirErro(msg: "Jogo não encontrado")
            return
        }
        
        let route = AppRoute.ficha(jogo: jogoSelecionado.id)
        
        apiClient.request(route: route) { (data, error) in
            if let error = error {
                self.delegate?.exibirErro(msg: error.localizedDescription)
                return
            }
            
            guard let data = data else {
                self.delegate?.exibirErro(msg: "Nenhum dado")
                return
            }
            
            do{
                let ficha = try JSONDecoder().decode(FichaModel.self, from: data)
                self.ficha = ficha
                
                DispatchQueue.main.async {
                    self.delegate?.mostrarFichaJogo()
                }
                
            } catch {
                self.delegate?.exibirErro(msg: error.localizedDescription)
            }
        }
    }

    func consultaLances() {
        guard let jogoSelecionado = jogoSelecionado else {
           delegate?.exibirErro(msg: "Jogo não encontrado")
           return
        }
               
        let route = AppRoute.lances(jogo: jogoSelecionado.id)

        apiClient.request(route: route) { (data, error) in
            if let error = error {
                self.delegate?.exibirErro(msg: error.localizedDescription)
                return
            }

            guard let data = data else {
                self.delegate?.exibirErro(msg: "Nenhum dado")
                return
            }
            
            do{
                let lance = try JSONDecoder().decode([LanceALanceModel].self, from: data)
                self.lances = lance

                DispatchQueue.main.async {
                    self.delegate?.mostrarLanceALance()
                }

            }catch{
                self.delegate?.exibirErro(msg: error.localizedDescription)
            }
        }
    }

}
