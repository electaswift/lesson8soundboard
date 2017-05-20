//
//  AddSoundViewController.swift
//  Les 8 Soundboard
//
//  Created by Bryan on 5/19/17.
//  Copyright © 2017 KO. All rights reserved.
//

import UIKit    //this import is stuff yo uuse to work with visual stuff on screen
import AVFoundation    //11th  import is bringing in library of code apple has already written. this one is what apple wrote to allow us to record

class AddSoundViewController: UIViewController {
    
    
    
    @IBOutlet weak var playLabel: UIButton!    //20th
    
    @IBOutlet weak var recordLabel: UIButton! //7th
    
    
    @IBOutlet weak var addLabel: UIButton!   //21st
    
    @IBOutlet weak var soundName: UITextField!  //8th
    
    
    var audioRecorder : AVAudioRecorder? = nil    //9th
    
    var audioPlayer : AVAudioPlayer?    //16th
    
    var audioURL : URL?    //18th
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()   //11th
        
        playLabel.isEnabled = false    //22nd
        
        addLabel.isEnabled = false //26th
        
    }
    
    
    func setupRecorder() {  //10th
        do{    //10.5th
            let session = AVAudioSession.sharedInstance()   //13th Create audio session
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord) //for the session, want to be able to play audio and record
            try session.overrideOutputAudioPort(.speaker)   //want it to play through phones speakers
            try session.setActive(true)
            
            
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!   //14th Create URL for audio file. this step gets us the path to the documents directory in the sandbox. this gives us back an array and we want the first
            let pathComponents = [basePath, "audio.m4a"]      //name for file and attach it ... onto what...
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)!   //the fuck?
            
            //15th Create settings for the audio recorder below
            
            var settings : [String: Double] = [:]
            settings[AVFormatIDKey] = Double(kAudioFormatMPEG4AAC)
            settings[AVSampleRateKey] = 44100.0
            settings[AVNumberOfChannelsKey] = 2.0
            
            
            
            
            try audioRecorder = AVAudioRecorder(url: audioURL!, settings: settings)                //12th   Create AudioRecorder object. url needs some place for file to be saved. settings is for quality etc
            audioRecorder!.prepareToRecord()     // 14th
        } catch let error as NSError {          // hold option over the different things above to see what kind of error it could be. here we used NSError so we can be specific about what to do if it is NSError
            print(error)
        }
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func recordTapped(_ sender: Any) {     //15th
        if audioRecorder!.isRecording == true {
            audioRecorder?.stop()                          //audioRecorder is object of a class AVAudioRecorder that has a method called stop()
            
            recordLabel.setTitle("Record", for: .normal)
            
            playLabel.isEnabled = true  //23rd
            
            addLabel.isEnabled = true //27th
            
        } else {
            audioRecorder?.record()
            
            
            recordLabel.setTitle("Stop", for: .normal)
            
        }
    }
    
    
    
    
    @IBAction func playTapped(_ sender: Any) {    //9th
        do {        //20th
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)      //17th, 19th
            audioPlayer!.play()
        } catch {}
        
    }
    
    
    
    
    @IBAction func addTapped(_ sender: Any) {    //10th
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext   //25th
        
        let sound = Sound(context: context)
        sound.name = soundName.text
        sound.audio = NSData(contentsOf: audioURL!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
         navigationController!.popViewController(animated: true)   //28th
        
        
        
    }
    
    
}
