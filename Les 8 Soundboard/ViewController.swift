//
//  ViewController.swift
//  Les 8 Soundboard
//
//  Created by Bryan on 5/18/17.
//  Copyright © 2017 KO. All rights reserved.
//

import UIKit
import AVFoundation   //37th

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {    //32nd
    
    
    @IBOutlet weak var tableView: UITableView!    //29th
    
    var sounds: [Sound] = []   //30th
    
    var audioPlayer : AVAudioPlayer? //38th
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.dataSource = self   //31st
        tableView.delegate = self
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {   //33rd
        getSounds()
        tableView.reloadData()
    }
    
    func getSounds() {   //32nd
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            sounds = try context.fetch(Sound.fetchRequest()) as! [Sound]
            print(sounds)
        } catch {
            print("shit dont work")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sounds.count       //34th
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {    //35th
        let cell = UITableViewCell()
        let sound = sounds[indexPath.row]
        
        cell.textLabel?.text = sound.name!
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //36th
        let sound = sounds[indexPath.row]
        do {
            audioPlayer = try AVAudioPlayer(data: sound.audio! as Data)  //39th
        } catch {}
        audioPlayer?.play()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {    //40th
        if editingStyle == .delete {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let sound = sounds[indexPath.row]
            
            context.delete(sound)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                sounds = try context.fetch(Sound.fetchRequest())
            } catch {}
            tableView.reloadData()
            
        }
    }
    
    
}






// 1st embed navigation controller yellow circle embed in

// add bar button item add. system style add   2nd

// control drag from plus button to other view controller 3rd

//search and add navigation item to 2nd view controller and drag under vc scene 4th



// add sound view controller  5th

// create new cocoa touch view controller for code.  click yellow circle on storyboard and connect custom class to addsoundvc 6th



//24th create entity. make sure codegen is set to class definition . audio set to binary data. store to external record file
