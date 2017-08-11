//
//  TableViewController.swift
//  ManiyarContacts
//
//  Created by Shadi Ghelman on 8/9/17.
//  Copyright © 2017 Shadi Ghelman. All rights reserved.
//

import UIKit
import Contacts
class TableViewController: UITableViewController,UISearchBarDelegate {
 
    var searchBool = false
    
    var resualtArray : [Contact]?
    @IBOutlet var searchContactSearchBar: UITableView!
    var contact = [Contact]()
    
     let store = CNContactStore()
    func filterContentForSearchText(searchText: String){
        resualtArray=contact.filter({ (contact) -> Bool in
            return (contact.name.lowercased().range(of: searchText.lowercased()) != nil)
            
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1294831038, green: 0.3617098331, blue: 0.6481949687, alpha: 1)
        store.requestAccess(for: .contacts) { (yesOrNo, error) in
            if yesOrNo{
                let contactStore = CNContactStore()
                let keys = [CNContactPhoneNumbersKey, CNContactFamilyNameKey, CNContactGivenNameKey,  CNContactPhoneNumbersKey]
                let request1 = CNContactFetchRequest(keysToFetch: keys  as [CNKeyDescriptor])
                
                try? contactStore.enumerateContacts(with: request1) { (contact, error) in
                   
                    
                    let contactOkay=Contact()
                    
                       contactOkay.name = contact.givenName+" " + contact.familyName
                    if contact.phoneNumbers.count > 0 {
                        let phone = contact.phoneNumbers.first?.value
                        contactOkay.number = (phone?.stringValue)!}
                    
                    self.contact.append(contactOkay)
                
                    
                }
             self.tableView.reloadData()
            }
        }

        
    }


    

    override func numberOfSections(in tableView: UITableView) -> Int {
    
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section==0 {
            
            return 1
            
        }
        if searchBool {
            return (resualtArray?.count)!
        }
        
        return contact.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section==0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath)
            return cell
        }else{
            if searchBool {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TableViewCell
                cell.nameLabel.text=resualtArray?[indexPath.row].name
                cell.numberLabel.text=resualtArray?[indexPath.row].number
                let number = (resualtArray?[indexPath.row].number)?.components(separatedBy: "-")
                if let zoj = Int((number?.last!)!){
                if zoj%2==0 {
                    
                
                    cell.contactImage.image=UIImage.init(named:"Eye")
                }else{
                    cell.contactImage.image=UIImage.init(named:"contacts")
                    
                    
                    }}
                return cell
            }else{
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TableViewCell
            cell.nameLabel.text=contact[indexPath.row].name
            
            cell.numberLabel.text=contact[indexPath.row].number
                let number = (contact[indexPath.row].number).components(separatedBy: "-")
                if let zoj = Int(number.last!){
                    
                if zoj%2==0 {
                    
                    
                    cell.contactImage.image=UIImage.init(named:"Eye")
                }else{
                    cell.contactImage.image=UIImage.init(named:"contacts")
                    
                    
                    }}
                return cell}
            
        }

        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 30))
        viewHeader.backgroundColor=#colorLiteral(red: 0.9449954033, green: 0.9451572299, blue: 0.9449852109, alpha: 1)
        let labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: viewHeader.frame.width, height: viewHeader.frame.height))
        if section==0 {
     
        labelTitle.text="عملیات اصلی"
        }
        else{
            labelTitle.text="دوستان مانیار"
            
        }
        labelTitle.font = UIFont(name: labelTitle.font.fontName, size: 13)
        labelTitle.textAlignment = .center
        labelTitle.textColor=#colorLiteral(red: 0.5371941328, green: 0.5372899175, blue: 0.5371881127, alpha: 1)
        
            viewHeader.addSubview(labelTitle)
        
    return viewHeader
        
        
    }

    
    
}
extension TableViewController{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBool=true
        filterContentForSearchText(searchText: searchText)
        tableView.reloadData()
        if searchBar.text=="" {
            searchBool=false
            tableView.reloadData()
        }
        
    }
}

