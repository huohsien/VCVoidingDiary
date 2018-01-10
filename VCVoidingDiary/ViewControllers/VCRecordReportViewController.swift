//
//  VCRecordReportViewController.swift
//  VCVoidingDiary
//
//  Created by victor on 10/01/2018.
//  Copyright © 2018 VHHC Studio. All rights reserved.
//

import UIKit

class VCRecordReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var voidingRecordButton: UIButton!
    @IBOutlet weak var intakeRecordButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

class VCRecordReportViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self;
        tableView.dataSource = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VCRecordReportViewController : UITableViewDelegate {
    
}

extension VCRecordReportViewController : UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath) as! VCRecordReportTableViewCell
        
        cell.timeLabel.text = "06:20";
        cell.voidingRecordButton.titleLabel?.text = "排尿：1500cc";
        cell.intakeRecordButton.titleLabel?.text = "喝水：1000cc";

        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }

}
