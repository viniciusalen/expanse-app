//
//  ExpenseViewController.swift
//  expanse
//
//  Created by Vinicius Alencar on 08/10/20.
//

import UIKit
import FirebaseFirestore
import Firebase

class ExpensesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var db = Firestore.firestore()
    
    var expenseArray = [Expense]()
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let expense = expenseArray[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        cell.textLabel?.text = "\(expense.description): \(expense.value)"
        cell.detailTextLabel?.text = "\(expense.date)"
        
        
        
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadData()
        //checkForUpdates()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        db.collection("expense").getDocuments {
                Querysnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }else{
                self.expenseArray = Querysnapshot!.documents.compactMap({Expense(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    print("\n\n SUCESS to reload TableView\n\n ")
                }
            }
        }
    }
    
//    func checkForUpdates() {
//        db.collection("expense").whereField("date", isGreaterThan: Date())
//            .addSnapshotListener {
//                QuerySnapshot, error in
//
//                guard let snapshot = QuerySnapshot else {return}
//
//                snapshot.documentChanges.forEach {
//                    diff in
//
//                    if diff.type == .added {
//                        self.expenseArray.append(Expense(dictionary: diff.document.data())!)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    }
//                }
//        }
//    }
//
    
    
    @IBAction func expenseAdd(_ sender: UIBarButtonItem) {
        
        let expenseAlert = UIAlertController(title: "New Expense", message: "Enter your expense", preferredStyle: .alert)
        
        expenseAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "Value"
            textField.keyboardType = .decimalPad
        }
        expenseAlert.addTextField { (textField:UITextField) in
            textField.placeholder = "description"
            textField.keyboardType = .namePhonePad
        }
        
        expenseAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        expenseAlert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action:UIAlertAction) in
             
            if let value = expenseAlert.textFields?.first?.text,
               let description = expenseAlert.textFields?.last?.text {
                
                let newExpense = Expense(value: Double(value)!, description: description, date: Date(), payment: true)
                
                
                var ref: DocumentReference? = nil
                
                ref = self.db.collection("expense").addDocument(data: newExpense.dictionary) {
                     error in
                    if let error = error{
                        print("\n\nError adding document: \(error.localizedDescription)\n\n")
                    }else{
                        print("Documents add with ID: \(ref!.documentID)")
                    }
                }
                
            }
            
        }))
        
        self.present(expenseAlert, animated: true, completion: nil)
            
            
        
    }
    
}

