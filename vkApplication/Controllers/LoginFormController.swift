//
//  LoginFormController.swift
//  Weather
//
//  Created by Timur Sasin on 17/01/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

import UIKit
import VK_ios_sdk

class LoginFormController: UIViewController, VKSdkDelegate, VKSdkUIDelegate {

    let appId = "6350686"
    var scope: [String]? = nil
    var token: String? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)       
        
        VKSdk.initialize(withAppId: appId).register(self)
        VKSdk.instance().uiDelegate = self
        
        VKSdk.wakeUpSession(scope) { (state: VKAuthorizationState, error) in
            if state == VKAuthorizationState.authorized {
                self.performSegue(withIdentifier: "launchSegue", sender: self)
            }
        }
    }
    
    @IBAction func launchButtonPressed(_ sender: UIButton) {
        scope = [VK_PER_NOTIFY, VK_PER_FRIENDS, VK_PER_PHOTOS, VK_PER_AUDIO, VK_PER_VIDEO, VK_PER_DOCS, VK_PER_NOTES, VK_PER_PAGES, VK_PER_STATUS, VK_PER_WALL, VK_PER_GROUPS, VK_PER_MESSAGES, VK_PER_NOTIFICATIONS, VK_PER_STATS, VK_PER_ADS, VK_PER_OFFLINE, VK_PER_EMAIL, VK_PER_MARKET]
        VKSdk.authorize(scope)
    }    
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        if (self.presentedViewController != nil) {
            self.dismiss(animated: true, completion: {
                print("hide current modal controller if presents")
                self.navigationController?.topViewController?.present(controller, animated: true, completion: {
                    print("SFSafariViewController opened to login through a browser")
                })
            })
        } else {
            self.navigationController?.topViewController?.present(controller, animated: true, completion: {
                print("SFSafariViewController opened to login through a browser")
            })
        }
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        let vkCvC = VKCaptchaViewController.captchaControllerWithError(captchaError)
        vkCvC?.present(in: self.navigationController?.topViewController)
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if (result.token != nil) {
            self.performSegue(withIdentifier: "launchSegue", sender: self)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
