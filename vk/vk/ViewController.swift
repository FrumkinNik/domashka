//
//  ViewController.swift
//  vk
//
//  Created by nik on 11.08.2021.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private var scrollview: UIScrollView!
    @IBOutlet private var logintextfield: UITextField!
    @IBOutlet private var passwordtextfield: UITextField!
    @IBOutlet private var loginbutton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
         
            // Жест нажатия
            let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
            // Присваиваем его UIScrollVIew
            scrollview?.addGestureRecognizer(hideKeyboardGesture)
        }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Второе — когда она пропадает
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    

    
    @IBAction private func logintouchbutton(_ sender: UIButton) {
        // Получаем текст логина
                let loginText = logintextfield.text!
                // Получаем текст-пароль
                let passwordText = passwordtextfield.text!
                
                // Проверяем, верны ли они
                if loginText == "admin" && passwordText == "123456" {
                    print("успешная авторизация")
                } else {
                    print("неуспешная авторизация")
                }

        }
    @objc func hideKeyboard() {
            self.scrollview?.endEditing(true)
        }


    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
        
        // Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollview?.contentInset = contentInsets
        scrollview?.scrollIndicatorInsets = contentInsets
    }
    
    //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollview?.contentInset = contentInsets
    }
}
