import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        billAmountTextField.keyboardType = .decimalPad
        tipPercentageTextField.keyboardType = .decimalPad
        
        billAmountTextField.text = nil
        tipPercentageTextField.text = nil
        tipAmountLabel.text = "0.00"
        tipPercentageSlider.value = 15.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func calculateTip(_ sender: UIButton) {
        guard let billAmount = Float(billAmountTextField.text!) else {
            return
        }
        tipAmountLabel.text = String(format: "%.2f", billAmount * 0.15)
        tipPercentageTextField.text = "15"
        tipPercentageSlider.value = 15.0
    }
    
    @objc func keyboardWasShown(_ notification: NSNotification) {
        guard let info = notification.userInfo, let keyboardFrameValue = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        let keyboardFrame = keyboardFrameValue.cgRectValue
        let keyboardSize = keyboardFrame.size
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
    }
    
    @objc func keyboardWillBeHidden(_ notification: NSNotification) {
        
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        
    }
    
    @IBAction func billTipAmountEditingChanged(_ sender: UITextField) {
        guard let billAmount = Float(billAmountTextField.text!) else {
            return
        }
        guard let tipPercentage = Float(tipPercentageTextField.text!) else {
            return
        }
        
        tipAmountLabel.text = String(format: "%.2f", billAmount * tipPercentage * 0.01)
    }
    
    @IBAction func tipSliderValueChanged(_ sender: UISlider) {
        tipPercentageTextField.text = String(format: "%.0f", tipPercentageSlider.value)
        guard let billAmount = Float(billAmountTextField.text!) else {
            return
        }
        tipAmountLabel.text = String(format: "%.2f", billAmount * tipPercentageSlider.value * 0.01)
    }
}

