//
//  Nice.swift
//  Nice
//
//  Created by 程守斌 on 2019/3/11.
//

import Foundation
import UIKit
import Device

open class Nice {
    
    //MARK: - 常量类
    open class Const {
        ///屏幕宽、高、像素大小、是否是iPhoneX系列、是否是模拟器
        public static let kScreenWidth:CGFloat = UIScreen.main.bounds.size.width
        public static let kScreenHeight:CGFloat = UIScreen.main.bounds.size.height
        public static let kPixel:CGFloat = (1.0/UIScreen.main.scale)
        public static let isiPhoneX:Bool = getIsiPhoneX()
        public static let isSimulator:Bool = getIsSimulator()
        
        private static func getIsiPhoneX() -> Bool {
            let version = Device.versionOnSimulator()
            switch version {
            case .iPhoneX,.iPhoneXR,.iPhoneXS,.iPhoneXS_Max:
                return true
            default:
                return false
            }
        }
        private static func getIsSimulator() -> Bool {
            let version = Device.version()
            switch version {
            case .simulator:
                return true
            default:
                return false
            }
        }
    }
    
    //MARK: - BaseView
    open class BaseView:UIView {
        override public init(frame: CGRect) {
            super.init(frame: frame)
            makeUI()
            makeConstraint()
            makeEvent()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        //创建UI 子类需override
        open func makeUI(){
        }
        
        //创建约束 子类需override
        open func makeConstraint(){
        }
        
        //创建事件 子类需override
        open func makeEvent() {
        }
        
        //刷新UI 子类需override
        open func refreshUI(viewModel:Any?){
        }
    }
    
    //MARK: - BaseCell
    open class BaseCell:UITableViewCell{
        open var indexPath:IndexPath?
        open var viewModel:Any?
        
        override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            self.selectionStyle = .none
            self.backgroundColor = UIColor.clear
            makeUI()
            makeConstraint()
            makeEvent()
        }
        
        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override open func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        override open func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        //创建UI 子类需override
        open func makeUI(){
        }
        
        //创建约束 子类需override
        open func makeConstraint(){
        }
        
        //创建事件 子类需override
        open func makeEvent() {
        }
        
        //刷新UI 子类需override
        open func refreshUI(viewModel:Any?) {
        }
        
        //创建cell
        public static func createCell(tableView:UITableView, indexPath:IndexPath, viewModel:Any? = nil) -> UITableViewCell{
            tableView.register(self, forCellReuseIdentifier: "\(self.className)")
            let cell:BaseCell = tableView.dequeueReusableCell(withIdentifier: "\(self.className)", for: indexPath) as! Nice.BaseCell
            cell.indexPath = indexPath
            cell.viewModel = viewModel
            cell.refreshUI(viewModel: viewModel)
            return cell
        }
    }
}

//MARK: - NSObject+extension
public extension NSObject {
    public static var className: String {
        get {
            return String(describing: self)
        }
    }
    
    public var className: String {
        return NSStringFromClass(type(of:self.self))
    }
}

//MARK: - Device+extension
public extension Device {
    
    static public func versionOnSimulator() -> Version{
        let version = Device.version()
        if version == .simulator {
            let modelIdentifier = ProcessInfo.processInfo.environment["SIMULATOR_MODEL_IDENTIFIER"] ?? ""
            return Device.getVersionOnSimulator(code: modelIdentifier)
        }else{
            return version
        }
    }
    
    static fileprivate func getVersionOnSimulator(code: String) -> Version {
        switch code {
            /*** iPhone ***/
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":     return .iPhone4S
        case "iPhone5,1", "iPhone5,2":                 return .iPhone5
        case "iPhone5,3", "iPhone5,4":                 return .iPhone5C
        case "iPhone6,1", "iPhone6,2":                 return .iPhone5S
        case "iPhone7,2":                            return .iPhone6
        case "iPhone7,1":                            return .iPhone6Plus
        case "iPhone8,1":                            return .iPhone6S
        case "iPhone8,2":                            return .iPhone6SPlus
        case "iPhone8,3", "iPhone8,4":                 return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                 return .iPhone7
        case "iPhone9,2", "iPhone9,4":                 return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":               return .iPhone8
        case "iPhone10,2", "iPhone10,5":               return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":               return .iPhoneX
        case "iPhone11,2":                           return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":               return .iPhoneXS_Max
        case "iPhone11,8":                           return .iPhoneXR
            
            
            /*** iPad ***/
        case "iPad1,1", "iPad1,2":                    return Version.iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return Version.iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return Version.iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return Version.iPad4
        case "iPad6,11", "iPad6,12":                   return Version.iPad5
        case "iPad7,5", "iPad 7,6":                    return Version.iPad6
        case "iPad4,1", "iPad4,2", "iPad4,3":           return Version.iPadAir
        case "iPad5,3", "iPad5,4":                     return Version.iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return Version.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return Version.iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return Version.iPadMini3
        case "iPad5,1", "iPad5,2":                     return Version.iPadMini4
        case "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2":  return Version.iPadPro12_9Inch
        case "iPad7,3", "iPad7,4":                       return Version.iPadPro10_5Inch
        case "iPad6,3", "iPad6,4":                       return Version.iPadPro9_7Inch
            
            /*** iPod ***/
        case "iPod1,1":                                  return .iPodTouch1Gen
        case "iPod2,1":                                  return .iPodTouch2Gen
        case "iPod3,1":                                  return .iPodTouch3Gen
        case "iPod4,1":                                  return .iPodTouch4Gen
        case "iPod5,1":                                  return .iPodTouch5Gen
        case "iPod7,1":                                  return .iPodTouch6Gen
            
            /*** Simulator ***/
        case "i386", "x86_64":                           return .simulator
            
        default:                                         return .unknown
        }
    }
}
