//
//  SeekViewController.swift
//  BrightLife_Consumer
//
//  Created by Saumya Gautam on 04/11/22.
//

import UIKit

class SeekViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    
    var isSelectedOptionButton: Bool = false
    var cellSpacingHeight: CGFloat = 5
    var arrTableItems: [String] = []
    var selectedIndex: [Int] = []
    var seekIndexId: [Int] = []
    var selectedIndexString: String = ""
   
    
    var authVM = AuthenticationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
       authVM.getSeekList(target: self)
    }
    
    @IBAction func actionContinueButton(_ sender: Any) {
        print(selectedIndexString)
            authVM.userSeek(target: self, seeks: selectedIndexString)
    }
}

extension SeekViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTableItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedIndex.contains(indexPath.row) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionSelectedCell", for: indexPath) as! OptionSelectedCell
            cell.btnTitle.setTitle(arrTableItems[indexPath.row], for: .normal)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
            cell.btnTitle.setTitle(arrTableItems[indexPath.row], for: .normal)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex.count == 0 {
            selectedIndex.append(indexPath.row)
        } else {
            var isExist: Bool = false
            var existIndex: Int?
            for i in 0..<selectedIndex.count {
                if selectedIndex[i] == indexPath.row {
                    isExist = true
                    existIndex = i
                }
            }
            if isExist {
                selectedIndex.remove(at: existIndex!)
            } else {
                selectedIndex.append(indexPath.row)
            }
        }
        selectedIndexString = commaSeparatedList(list: selectedIndex)
        tableView.reloadData()
    }
    
    func commaSeparatedList(list: [Int]) -> String {
        var outputString: String = ""
        outputString.append(list.map{ String($0) }.joined(separator: ","))
        return outputString
    }
}




