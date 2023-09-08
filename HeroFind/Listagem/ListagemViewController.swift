//
//  ListagemViewController.swift
//  HeroFind
//
//  Created by user on 29/08/23.
//

import UIKit

class ListagemViewController: UIViewController {
    
    private var heros: [Hero] = []
    
    private let apiManager : APIManager = APIManager.shared
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCollectionViewCell.self
                                , forCellWithReuseIdentifier: CustomCollectionViewCell.identificador)
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        let imageView = UIImageView(image: UIImage(named: "logo_hero_find.png"))
        
        self.navigationItem.titleView = imageView
        
        addViewsInHierarchy()
        
        setupConstrains()
        
        fetchRemoteHeros()
    }
    
    private func addViewsInHierarchy() {
        self.view.addSubview(collectionView)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    private func setupConstrains() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -0),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -0)
        ])
    }
    
    private func fetchRemoteHeros() {
        apiManager.fetchRemote { [weak self] heros in
            if let heros = heros {
                self?.heros = heros
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            } else {
                // Trate o erro de alguma forma, por exemplo, exibindo uma mensagem de erro para o usuário.
            }
        }
    }
}

extension ListagemViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.heros.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identificador, for: indexPath) as? CustomCollectionViewCell else {
            fatalError("Falha")
        }
        
        let hero = self.heros[indexPath.row]
        
        cell.configure(with: hero)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hero = self.heros[indexPath.row]
        
        print("Selecionou : \(hero.name)")
        
        let storyboard = UIStoryboard(name: "Detalhe", bundle: Bundle(for: DetalheViewController.self))
        let detailViewController = storyboard.instantiateViewController(withIdentifier: "Detalhe") as! DetalheViewController
        
        detailViewController.hero = hero
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension ListagemViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeWidth = (self.view.frame.width / 2) - 26
        let sizeHeight: Double = 200
        
        return CGSize(width: sizeWidth, height: sizeHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
