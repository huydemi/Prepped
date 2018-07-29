/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit

class DiaryViewController: UITableViewController {
  
  fileprivate var yearsArray = [String]()
  fileprivate var sectionedDiaryEntries = [String: [DiaryEntry]]()
  fileprivate var sortedYears = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 60.0
    tableView.register(DiaryYearTableViewHeader.self, forHeaderFooterViewReuseIdentifier: "DiaryYearTableViewHeader")
    
    sortDiaryEntriesByDate()
  }
  
  // MARK: - UITableViewDataSource

  override func numberOfSections(in tableView: UITableView) -> Int {
    return sectionedDiaryEntries.count
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let year = sortedYears[section]
    let entries = sectionedDiaryEntries[year]
    return entries!.count
  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DiaryYearTableViewHeader") as! DiaryYearTableViewHeader
    headerCell.year = sortedYears[section]
    return headerCell
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 26.0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryEntryTableViewCell
    
    let year = sortedYears[indexPath.section]
    
    if let entries = sectionedDiaryEntries[year] {
      cell.diaryEntry = entries[indexPath.row]
    }

    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let year = sortedYears[indexPath.section]
      sectionedDiaryEntries[year]?.remove(at: indexPath.row)
      
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  //MARK: - Unwind Segue Methods
  
  @IBAction func cancelToDiaryViewController(_ segue: UIStoryboardSegue) {
  }
  
  @IBAction func saveToDiaryViewController(_ segue: UIStoryboardSegue) {
    if let controller = segue.source as? AddDiaryEntryViewController,
      let diaryEntry = controller.diaryEntry {
      diaryEntries.append(diaryEntry)

      sortDiaryEntriesByDate()
      tableView.reloadData()
        
    }
  }
}

// MARK:- Date methods

extension DiaryViewController {
  fileprivate func sortDiaryEntriesByDate() {
    // sort entries by date descending
    let sortedDiaryEntries = diaryEntries.sorted { $0.date.compare($1.date as Date) == ComparisonResult.orderedDescending }
    
    // extract years for sections
    let yearsSet = Set(diaryEntries.map { $0.year })
    
    // sort years into descending sequence
    sortedYears = yearsSet.sorted(by: >)
    
    // create a dictionary for accessing years by section index
    for year in yearsSet {
      sectionedDiaryEntries[year] = sortedDiaryEntries.filter { $0.year == year }
    }
  }
}

// MARK:- Cells and headers

class DiaryEntryTableViewCell: UITableViewCell {
  @IBOutlet var dayLabel: UILabel!
  @IBOutlet var monthLabel: UILabel!
  @IBOutlet var entryLabel: UILabel!

  var diaryEntry: DiaryEntry! {
    didSet {
      dayLabel?.text = diaryEntry.day
      monthLabel?.text = diaryEntry.month
      entryLabel?.text = diaryEntry.text
    }
  }
}

class DiaryYearTableViewHeader: UITableViewHeaderFooterView {
  
  var yearLabel: UILabel!
  
  var year: String! {
    didSet {
      yearLabel.text = year
    }
  }
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  func commonInit() {
    yearLabel = UILabel()
    yearLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(yearLabel)
    
    yearLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    yearLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12.0).isActive = true
    
    yearLabel.font = UIFont.systemFont(ofSize: 17.0, weight: UIFontWeightLight)
  }
}
