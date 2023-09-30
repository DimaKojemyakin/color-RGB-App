// ViewControllerColor.swift

import UIKit

class ViewControllerColor: UIViewController, ColorsDelegate {
    
    // MARK: - Properties
    
    var redSliderValue: Float = 0
    var greenSliderValue: Float = 0
    var blueSliderValue: Float = 0
    let titleMachine = "Hello, this is your color"
    var titleText = ""
    
    weak var delegate: ColorsDelegate? // Слабая ссылка на делегата
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.onClickView()
        }
    }
    
    // MARK: - Helper Methods
    
    func onClickView() {
        for char in titleMachine {
            titleText += "\(char)"
            RunLoop.current.run(until: Date()+0.05)
            self.title = titleText
        }
    }
    
    // MARK: - ColorsDelegate
    
    func saveColors(red: Int, green: Int, blue: Int) {
        let backgroundColor = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        view.backgroundColor = backgroundColor
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController {
            destinationVC.delegate = self // Присваиваем делегату ViewControllerColor экземпляр ViewController
        }
    }
    
    // MARK: - Deinitialization
    
    deinit {
        // Освобождение ресурсов, отписка от наблюдателей и т.д.
        // (если необходимо)
    }
}
