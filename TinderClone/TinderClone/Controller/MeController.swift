//
//  MeController.swift
//  TinderClone
//
//  Created by Richard Price on 09/03/2021.
//

import UIKit

class MeController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var models = [MeSections]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setupTableView()
        
    }
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(MeTableViewCustomCell.self, forCellReuseIdentifier: MeTableViewCustomCell.identifier)
        table.register(MeTableControllerHeader.self, forHeaderFooterViewReuseIdentifier: MeTableControllerHeader.identifier)
        return table
    }()
    
    private func observeData() {
        
        //IMPLEMENT LATER GET USER INFO
        
    }
    private func setupTableView() {
        title = "Me"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        configure()
    }
    
    private func configure() {
   
        models.append(MeSections(title: "General", options: [
            MeModel(title: "Welcome", icon: UIImage(systemName: "house"), iconBackGroundColor: .systemBlue) {
                print("1st cell tapped")
            },
            MeModel(title: "testong123@gmail.com", icon: UIImage(systemName: "pencil"), iconBackGroundColor: .systemGreen) {

            },
            MeModel(title: "Choose Wallpaper", icon: UIImage(systemName: "pencil.circle"), iconBackGroundColor: .systemTeal) {

            }

        ]))
        //NEW SECTION
        models.append(MeSections(title: "Apps", options: [
            MeModel(title: "Log Out", icon: UIImage(systemName: "xmark.circle"), iconBackGroundColor: .systemRed) {
                Api.User.LogOut {
                    let loginController = SignInController()
                    let navController = UINavigationController(rootViewController: loginController)
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true, completion: nil)
                }
            }
        ]))
        //NEW SECTION
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MeTableViewCustomCell.identifier, for: indexPath) as? MeTableViewCustomCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MeTableControllerHeader.identifier)
        return header
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 100 : 0
    }

}
