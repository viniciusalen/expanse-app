//
//  ExpenseTableViewCell.swift
//  expanse
//
//  Created by Vinicius Alencar on 08/10/20.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var valueLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCellData(expense: Expense){
        self.descriptionLabel.text = expense.description
        self.valueLabel.text = String(format: "%f", expense.value)
//        self.dateLabel = expense.date
//        self.paymentLabel.text = expense.payment
        
        
        
        
    }
    

}
