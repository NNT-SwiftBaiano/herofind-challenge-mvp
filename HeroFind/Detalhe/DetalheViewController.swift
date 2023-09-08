import UIKit

class DetalheViewController: UIViewController {
    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var heroName: UILabel!
    
    @IBOutlet weak var heroDescricao: UILabel!
    
    var hero: Hero!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heroImageView.layer.masksToBounds = true
        heroImageView.contentMode = .scaleAspectFill
        heroImageView.backgroundColor = .blue
        
        configure(with: hero)
    }

    func configure(with hero: Hero) {
        heroName.text = hero.name
        if(hero.description.isEmpty) {
            heroDescricao.text = "Sem Descrição"
        } else {
            heroDescricao.text = hero.description
        }
        heroImageView.download(from: hero.imageURL)
    }
    
}
