//
//  CalculateViewController.swift
//  Tipsy
//
//  Created by админ on 25.01.2023.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctBatton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
   //создаем переменную - процент чаевых в дробном экваиваленте
    var tip = 0.1
    
    //создаем переменную - количество персон в счете(сплит)
    var numberOfPerson = 2
    
    //  создаем переменную - итоговая сумма счета
    var billTotal = 0.0
    
    //создаем переменную - итоговая сумма с каждой персоны
    var finalResult = "0.0"
    
    
    @IBAction func tipChanged(_ sender: UIButton) {
       //скрываем клавиатуру у пользователя при окончании ввода итоговой суммы счета и тапе на другие поля экрана
        billTextField.endEditing(true)
        
        // делаем все три варианта выбора процента чаевых "неактивными", затем делаем "активной" только выбранную кнопку
        zeroPctBatton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        //задаем новое значение свойству "tip", создав для этого новое св-во, содержащее название выбранной кнопки, убрав у него знак "%" , приведя к типу Double и поделив на сто
        let buttonTitle = sender.currentTitle!
        let buttonTitleMinusPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentSign)!
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        //задаем количество персон и значение соот-му лейблу splitNumberLabel
        splitNumberLabel.text = String(format: "%.f", sender.value)
        
        //меняем значение количества персон в переменной numberOfPerson
        numberOfPerson = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        //создаем новое свойство bill - значение из поля ввода итоговой суммы счета. Далее проверяем условие - если введенное значение - число, то значению итогового счета billTotal задаем значение св-ва bill, приведенное к Double. Затем через новое св-во result вычисляем итоговую сумму с каждой персоны по формуле, и приводим это значение к типу String, задав новое значение св-ву finalResult
        guard let bill = billTextField.text else { return }
        billTotal = Double(bill) ?? 0.0
            let result = billTotal * (1 + tip) / Double(numberOfPerson)
            finalResult = String(format: "%.2f", result)
        
        //создаем переход по сегвею на другой экран
        self.performSegue(withIdentifier: "showResult", sender: self)
            
    }
    
    //задаем функцию - проверка идендификатора сегвея и действие, если идендификатор верный
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "showResult" {
            
            //создаем вьюконтроллер и кастим его до нашего ResultsViewController
            //далее присваиваем значениям свойств класса ResultsViewController значения этого класса - CalculatorViewController
            
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPerson
            
        }
    
    }
    
   
   
}
