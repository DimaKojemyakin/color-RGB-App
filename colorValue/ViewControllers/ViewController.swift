// ViewController.swift
//  colorValue
//
//  Created by Дима Кожемякин on 29.09.2023.
//

import UIKit

// Протокол для делегата, который сохраняет цвета
protocol ColorsDelegate: AnyObject {
    func saveColors(red: Int, green: Int, blue: Int)
}

class ViewController: UIViewController, ColorsDelegate {
    weak var delegate: ColorsDelegate? // 2. Создаем слабую ссылку на делегата
    // MARK: - Outlets
    @IBOutlet var greenTF: UITextField!
    @IBOutlet var blueTF: UITextField!
    @IBOutlet var redTF: UITextField!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var blueValueLable: UILabel!
    @IBOutlet var greenValueLable: UILabel!
    @IBOutlet var redValueLable: UILabel!
    @IBOutlet var viewColorResult: UIView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    }
    
    // MARK: - Helper Methods
    
    // Настройка начального состояния интерфейса пользователя
    private func setupUI() {
        // Скрыть кнопку "Назад" на панели навигации
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        // Установить минимальные и максимальные значения для слайдеров
        redSlider.minimumValue = 0
        redSlider.maximumValue = 255
        greenSlider.minimumValue = 0
        greenSlider.maximumValue = 255
        blueSlider.minimumValue = 0
        blueSlider.maximumValue = 255
        
        // Установить начальный цвет для viewColorResult
        updateColor()
        
        // Настроить обработчики изменения текста в текстовых полях
        redTF.addTarget(self, action: #selector(textFielRedDidChange(_:)), for: .editingChanged)
        greenTF.addTarget(self, action: #selector(textFildGreenDidChange(_:)), for: .editingChanged)
        blueTF.addTarget(self, action: #selector(textFildBlueDidChange(_:)), for: .editingChanged)
        // Редактируем view
        viewColorResult.layer.cornerRadius = 30
        
    }
    
    // Обновить цвет viewColorResult на основе текущих значений слайдеров
    private func updateColor() {
        let backgroundColor = UIColor(
            red: CGFloat(redSlider.value) / 255,
            green: CGFloat(greenSlider.value) / 255,
            blue: CGFloat(blueSlider.value) / 255,
            alpha: 1
        )
        viewColorResult.backgroundColor = backgroundColor
    }
    
    func saveColors(red: Int, green: Int, blue: Int) {
        let backgroundColor = UIColor(red: CGFloat(red) / 255.0,
                                      green: CGFloat(green) / 255.0,
                                      blue: CGFloat(blue) / 255.0,
                                      alpha: 1.0)
        view.backgroundColor = backgroundColor
    }
    
    // MARK: - Actions
    
    // Обработчик изменения значения красного слайдера
    @IBAction func redSliderValueChanged(_ sender: UISlider) {
        updateColor()
        redValueLable.text = String(Int(sender.value))
        redTF.text = String(Int(sender.value))
    }
    
    // Обработчик изменения значения зеленого слайдера
    @IBAction func greenSliderValueChanged(_ sender: UISlider) {
        updateColor()
        greenValueLable.text = String(Int(sender.value))
        greenTF.text = String(Int(sender.value))
    }
    
    // Обработчик изменения значения синего слайдера
    @IBAction func blueSliderValueChanged(_ sender: UISlider) {
        updateColor()
        blueValueLable.text = String(Int(sender.value))
        blueTF.text = String(Int(sender.value))
    }
    
    // Обработчик изменения текста в красном текстовом поле
    @objc func textFielRedDidChange(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text) {
            redSlider.value = value
            updateColor()
        }
    }
    
    // Обработчик изменения текста в зеленом текстовом поле
    @objc func textFildGreenDidChange(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text) {
            greenSlider.value = value
            updateColor()
        }
    }
    
    // Обработчик изменения текста в синем текстовом поле
    @objc func textFildBlueDidChange(_ textField: UITextField) {
        if let text = textField.text, let value = Float(text) {
            blueSlider.value = value
            updateColor()
        }
    }
    
    // MARK: - ColorsDelegate
    
    // Реализация метода делегата для сохранения цветов
    
    // MARK: - Navigation
    
    // Обработчик нажатия кнопки "Готово"
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        delegate?.saveColors(red: Int(redSlider.value), green: Int(greenSlider.value), blue: Int(blueSlider.value))
        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ViewController {
            destinationVC.delegate = self as ColorsDelegate // Явное приведение типа
        }
    }
    
    
    // MARK: - Deinitialization
    
    deinit {
        // Освобождение ресурсов, отписка от наблюдателей и т.д.
        // (если необходимо)
    }
}
