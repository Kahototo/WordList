//
//  QuestionViewController.swift
//  WordList
//
//  Created by 小西夏穂 on 2016/06/08.
//  Copyright © 2016年 小西夏穂. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    var isAnswered: Bool = false  //回答したか・次の問題に行くのかの判定
    var worryArray: [AnyObject] = []  //ユーザーデフォルトからとる配列
    var shuffledWordArray: [AnyObject] = []  //シャッフルされた配列
    var nowNumber: Int = 0  //現在の回答数
    
    let saveData = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerLabel.text = ""
    }
    
    //viewが現れた時に呼ばれる
    override func viewWillAppear(animated: Bool) {
        worryArray = saveData.arrayForKey("WORD")!
        //問題をシャッフルする
        shuffle()
        questionLabel.text = shuffledWordArray[nowNumber]["english"] as? String
    }
    
    
     func shuffle() {
        while worryArray.count > 0 {
            let index = Int(rand()) % worryArray.count
            shuffledWordArray.append(worryArray[index])
            worryArray.removeAtIndex(index)
        }
        
    }
    @IBAction func nextButtonPushed () {
        
        //回答したか
        if isAnswered {
            //次の問題へ
            nowNumber += 1
            answerLabel.text = ""
            
            //次の問題を表示するか
            if nowNumber < shuffledWordArray.count  {
               //次の問題を表示
                questionLabel.text = shuffledWordArray[nowNumber]["english"] as? String
                //isAnsweredをfalseにする
                isAnswered = false
                //ボタンのタイトルを変更する
                nextButton.setTitle("答えを表示", forState: UIControlState.Normal)
    } else {
                //これ以上表示する問題はないので、Finishビューに画面移動
                self.shouldPerformSegueWithIdentifier("toFinishView", sender: nil)
        }
            
    } else {
            //答えを表示する
            answerLabel.text = shuffledWordArray[nowNumber]["japanese"] as? String
            //isAnswerをtrueにする
            isAnswered = true
            //ボタンのタイトルを変更する
            nextButton.setTitle("次へ", forState: UIControlState.Normal)
        }
    }
    
        }
    
        // Do any additional setup after loading the view.

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */




