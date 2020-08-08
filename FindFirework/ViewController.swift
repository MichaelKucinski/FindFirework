//
//  ViewController.swift
//  FindFirework
//
//  Created by Michael Kucinski on 8/5/20.
//  Copyright © 2020 Michael Kucinski. All rights reserved.
//

import UIKit
import EmojiFireworksAndExplosionsPackage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    let fireworksAndExplosionsEngine = EmojiFireworksAndExplosionsPackage()
    let fireworksAndExplosionsEngine2 = EmojiFireworksAndExplosionsPackage()

    var thisVelocity : CGFloat = 300
    var thisVelocityRange : CGFloat = 0
    var thisSpin : CGFloat = 0
    var thisSpinRange : CGFloat = 0
    var thisStartingScale : CGFloat = 1.23
    var thisStartingScaleRange : CGFloat = 0
    var thisEndingScale : CGFloat = 0
    var thisAccelerationIn_X : CGFloat = 0
    var thisAccelerationIn_Y : CGFloat = 0
    var thisCellBirthrate: CGFloat = 50
    var thisCellLifetime: CGFloat = 1
    var thisExplosionDuration : CGFloat = 0.6
    var thisTint              : UIColor = .white

    var thisVelocity2 : CGFloat = 300
    var thisVelocityRange2 : CGFloat = 0
    var thisSpin2 : CGFloat = 0
    var thisSpinRange2 : CGFloat = 0
    var thisStartingScale2 : CGFloat = 1.23
    var thisStartingScaleRange2 : CGFloat = 0
    var thisEndingScale2 : CGFloat = 0
    var thisAccelerationIn_X2 : CGFloat = 0
    var thisAccelerationIn_Y2 : CGFloat = 0
    var thisCellBirthrate2: CGFloat = 50
    var thisCellLifetime2: CGFloat = 1
    var thisExplosionDuration2 : CGFloat = 0.6
    var thisTint2              : UIColor = .white

    var parameterTableArrayOfNames = NSArray()
    var parameterTableView: UITableView!
    
    var sweetSpotsTableArrayOfNames = NSArray()
    var sweetSpotsTableView: UITableView!

    var explosionKindTableArrayOfNames = NSArray()
    var explosionKindTableView: UITableView!
    
    let countOfObjectsInExplosions = 1000 // used when creating the pool of emitters
    var useThisManyObjectsInExplosions = 400
    
    var currentOffsetAngleForCellFlowInDegrees : CGFloat = 0
    var currentOffsetAngleForCellFlowInDegrees2 : CGFloat = 0

    var combWidth : CGFloat = 0.1
    var combWidth2 : CGFloat = 0.1

    var rectangularCombRelativeAngle : CGFloat = 0
    var rectangularCombRelativeAngle2 : CGFloat = 0

    var readMeTextView = UITextView()
    
    var tempRect : CGRect = CGRect(
        x: 0,
        y: 0,
        width: 0,
        height: 0)

    
    var detonateButton = UIButton ()
    var changeShapeButton = UIButton ()
    var beginCombingButton = UIButton ()
    var generateCodeButton = UIButton ()
    var changeEmojiButton = UIButton ()
    var sweetSpotsButton = UIButton ()
    var switchParameterButton = UIButton ()
    var sampleButton = UIButton ()
    var hideALotOfThingsButton = UIButton()

    var thisIsAnIphone = true

    var generalPurposeSlider : UISlider = UISlider()
    
    public var halfScreenX = 0
    public var halfScreenY = 0
    public var fullScreenX = 0
    public var fullScreenY = 0
    public var halfScreenX_AsFloat : CGFloat = 0
    public var halfScreenY_AsFloat : CGFloat = 0
    public var fullScreenX_AsFloat : CGFloat = 0
    public var fullScreenY_AsFloat : CGFloat = 0
    let screenRect = UIScreen.main.bounds
    
    var thisTouchPoint : CGPoint = CGPoint(x:-4100,y:-4100)
    var screenCenterPoint : CGPoint = CGPoint(x:-4100,y:-4100)

    
    // Create enum type
    public enum kindOfExplosionDesired {
        case pointSource
        case rectangle
        case circle
        case ellipse
        case heart
        case line
        case randomInsideCircleOfRadius
    }
    // Assign enum
    var kindOfExplosion = kindOfExplosionDesired.pointSource
    
    var sliderValueLabel = UILabel()
    var minimumValue = UILabel()
    var maximumValue = UILabel()
    
    var helpString = "Touching the screen will cause a new detonation, or just wait for the next one to occur.\n\nUse the slider to change parameters to tailor the explosion properties.  You can generate code that should easily compile at any time.\n\nSwitch parameters and try changing the acceleration, lifetime, scales, combing methods, etc.\n\nThere is a spreading cone that is defined for each method of combing.  You can control how wide that cone is, and which direction it points. In some modes, the cone for each emitter gets pointed away from a specified point.  If the emitter shape configuration shows a circle then placing the relative point at the center of the circle causes each cone to point away from the center. That is highly artistic.  Similar, this works for points inside of rectangle, heart, and ellipse shapes.\n\nWhile combing, make it a point to touch near the shape borders, corners, inside, and outside.\n\nNote that when you select to comb towards a point or away from a point, we zero out any X and Y accelerations to avoid initial confusion.  You can add in X and Y acceleration again if desired.\n\nWhen you have tailored an effect as desired, just press the Generate Code button.  You will be able to view and scroll through the generated code immediately.  But the really cool thing is that the generated code is immediately available in the Pasteboard.   To get the code to your development computer, just paste it into a text to yourself, or email it, etc.\n\nEven though you can choose shapes and emoji patterns in FindFirework, code is not generated for setting the emoji pattern or choosing the shape.   Choosing those things will almost surely be tailored by a developer for specific use cases.  Code for those things are easy enough to glean from the readme.\n\nThere are saved configurations to start from if desired.  Press the Sweet Spots button to see a list.\n\nYou should be running the FindFirework app on an iPad as we didn't tailor it for the iPhone.\n\nA pinch will change some of the shape sizes.\n\nOne fun thing about using this Swift Package is that you get to call  an API named “detonate” 🧨 🤯 🥳\n\nPress the samples button to see how we quickly coupled some effects to this apps own objects on the screen.  We even used our own code generation tool to develop that sample code.\n\nThese effect can help users quickly notice certain areas of the screen.  The effects work well when transitioning something into view, or out of view.  Or these effects can highlight borders on the screen for fun effects, and for as long as desired. For example, try pressing our Sample button and particularly notice the effect when you press Sample 5.  The slider border at the bottom is highlighted with some flame like effects.  Those flames will last forever, or until you do something else.  Those flames can be any combination of colored emoji, of any size, and they can last a short time or a long time.\n\nEventually, you might search https://github.com/MichaelKucinski to see if there are any other Swift Packages the FindFireworks tool plays well with."

        
    override func viewDidLoad() {
        super.viewDidLoad()

        if UIDevice.current.userInterfaceIdiom == .pad {
            
            thisIsAnIphone = false
        }

        fireworksAndExplosionsEngine.viewDidLoad()
        
        fireworksAndExplosionsEngine.createPoolOfEmitters(maxCountOfEmitters: countOfObjectsInExplosions, someEmojiCharacter: "🤯") // or use any count of objects desired.  We used 125 from above
        
        for thisEmitter in fireworksAndExplosionsEngine.arrayOfEmitters { view.layer.addSublayer(thisEmitter) }
        
        fireworksAndExplosionsEngine2.viewDidLoad()
        
        fireworksAndExplosionsEngine2.createPoolOfEmitters(maxCountOfEmitters: countOfObjectsInExplosions, someEmojiCharacter: "🤯") // or use any count of objects desired.  We used 125 from above
        
        for thisEmitter in fireworksAndExplosionsEngine2.arrayOfEmitters { view.layer.addSublayer(thisEmitter) }
        
        fullScreenX = Int(screenRect.size.width)
        fullScreenY = Int(screenRect.size.height)
        
        halfScreenX = fullScreenX/2
        halfScreenY = fullScreenY/2
        halfScreenX_AsFloat = CGFloat(halfScreenX)
        halfScreenY_AsFloat = CGFloat(halfScreenY)
        fullScreenX_AsFloat = CGFloat(fullScreenX)
        fullScreenY_AsFloat = CGFloat(fullScreenY)
        
        detonateButton.frame = CGRect(x: fullScreenX - 160, y: fullScreenY - 160, width: 125, height: 125)
        detonateButton.backgroundColor =  UIColor.white
        detonateButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        detonateButton.setTitle("Detonate", for: .normal)
        detonateButton.addTarget(self, action: #selector(detonateButtonHandlingAction), for: .touchUpInside)
        detonateButton.layer.cornerRadius = 0.5 * detonateButton.bounds.size.width
        detonateButton.clipsToBounds = true
        detonateButton.layer.borderWidth = 4
        detonateButton.layer.borderColor = UIColor.cyan.cgColor
        detonateButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(detonateButton)
        detonateButton.alpha = 0
        
        changeShapeButton.frame = CGRect(x: 15, y: 30, width: 110, height: 70)
        changeShapeButton.backgroundColor =  UIColor.white
        changeShapeButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        changeShapeButton.setTitle("Change\nShape", for: .normal)
        changeShapeButton.addTarget(self, action: #selector(changeShapeButtonHandlingAction), for: .touchUpInside)
        changeShapeButton.layer.cornerRadius = 18
        changeShapeButton.clipsToBounds = true
        changeShapeButton.layer.borderWidth = 4
        changeShapeButton.layer.borderColor = UIColor.cyan.cgColor
        changeShapeButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(changeShapeButton)
        changeShapeButton.alpha = 1
        changeShapeButton.titleLabel?.numberOfLines = 0
        
        beginCombingButton.frame = CGRect(x: 15, y: 120, width: 110, height: 70)
        beginCombingButton.backgroundColor =  UIColor.white
        beginCombingButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        beginCombingButton.setTitle("Begin\nCombing", for: .normal)
        beginCombingButton.addTarget(self, action: #selector(beginCombingButtonHandlingAction), for: .touchUpInside)
        beginCombingButton.layer.cornerRadius = 18
        beginCombingButton.clipsToBounds = true
        beginCombingButton.layer.borderWidth = 4
        beginCombingButton.layer.borderColor = UIColor.cyan.cgColor
        beginCombingButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(beginCombingButton)
        beginCombingButton.alpha = 1
        beginCombingButton.titleLabel?.numberOfLines = 0
        
        generateCodeButton.frame = CGRect(x: 15, y: 210, width: 110, height: 70)
        generateCodeButton.backgroundColor =  UIColor.white
        generateCodeButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        generateCodeButton.setTitle("Generate\nCode", for: .normal)
        generateCodeButton.addTarget(self, action: #selector(generateCodeButtonHandlingAction), for: .touchUpInside)
        generateCodeButton.layer.cornerRadius = 18
        generateCodeButton.clipsToBounds = true
        generateCodeButton.layer.borderWidth = 4
        generateCodeButton.layer.borderColor = UIColor.cyan.cgColor
        generateCodeButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(generateCodeButton)
        generateCodeButton.alpha = 1
        generateCodeButton.titleLabel?.numberOfLines = 0
        
        changeEmojiButton.frame = CGRect(x: 15, y: 300, width: 110, height: 70)
        changeEmojiButton.backgroundColor =  UIColor.white
        changeEmojiButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        changeEmojiButton.setTitle("Change\nEmoji", for: .normal)
        changeEmojiButton.addTarget(self, action: #selector(changeEmojiButtonHandlingAction), for: .touchUpInside)
        changeEmojiButton.layer.cornerRadius = 18
        changeEmojiButton.clipsToBounds = true
        changeEmojiButton.layer.borderWidth = 4
        changeEmojiButton.layer.borderColor = UIColor.cyan.cgColor
        changeEmojiButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(changeEmojiButton)
        changeEmojiButton.alpha = 1
        changeEmojiButton.titleLabel?.numberOfLines = 0
        
        sweetSpotsButton.frame = CGRect(x: 15, y: 390, width: 110, height: 70)
        sweetSpotsButton.backgroundColor =  UIColor.white
        sweetSpotsButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        sweetSpotsButton.setTitle("Sweet\nSpots", for: .normal)
        sweetSpotsButton.addTarget(self, action: #selector(sweetSpotsButtonHandlingAction), for: .touchUpInside)
        sweetSpotsButton.layer.cornerRadius = 18
        sweetSpotsButton.clipsToBounds = true
        sweetSpotsButton.layer.borderWidth = 4
        sweetSpotsButton.layer.borderColor = UIColor.cyan.cgColor
        sweetSpotsButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(sweetSpotsButton)
        sweetSpotsButton.alpha = 1
        sweetSpotsButton.titleLabel?.numberOfLines = 0
        
        switchParameterButton.frame = CGRect(x: 15, y: fullScreenY_AsFloat - 300, width: 140, height: 70)
        switchParameterButton.backgroundColor =  UIColor.white
        switchParameterButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        switchParameterButton.setTitle("Switch\nParameter", for: .normal)
        switchParameterButton.addTarget(self, action: #selector(switchParameterButtonHandlingAction), for: .touchUpInside)
        switchParameterButton.layer.cornerRadius = 12
        switchParameterButton.clipsToBounds = true
        switchParameterButton.layer.borderWidth = 4
        switchParameterButton.layer.borderColor = UIColor.cyan.cgColor
        switchParameterButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(switchParameterButton)
        switchParameterButton.alpha = 1
        switchParameterButton.titleLabel?.numberOfLines = 0
        
        sampleButton.frame = CGRect(x: fullScreenX_AsFloat - 250, y: fullScreenY_AsFloat - 350, width: 140, height: 70)
        sampleButton.backgroundColor =  UIColor.white
        sampleButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 24)
        sampleButton.setTitle("Sample 1", for: .normal)
        sampleButton.addTarget(self, action: #selector(sampleButtonHandlingAction), for: .touchUpInside)
        sampleButton.layer.cornerRadius = 12
        sampleButton.clipsToBounds = true
        sampleButton.layer.borderWidth = 4
        sampleButton.layer.borderColor = UIColor.cyan.cgColor
        sampleButton.setTitleColor(UIColor.black, for: UIControl.State.normal)
        self.view.addSubview(sampleButton)
        sampleButton.alpha = 1
        
        generalPurposeSlider = UISlider(frame: CGRect(x: 50, y: fullScreenY_AsFloat - 120, width: fullScreenX_AsFloat - 100, height: 55))
        generalPurposeSlider.minimumValue = 0
        minimumValue.text = "0"
        maximumValue.text = "1000"
        generalPurposeSlider.maximumValue = 1000
        generalPurposeSlider.isContinuous = true
        generalPurposeSlider.tintColor = UIColor.blue
        generalPurposeSlider.backgroundColor = UIColor.blue
        generalPurposeSlider.value = 500
        generalPurposeSlider.layer.cornerRadius = 12
        generalPurposeSlider.clipsToBounds = true
        
        generalPurposeSlider.addTarget(self, action: #selector(generalPurposeSliderHandler),for: .valueChanged)
        generalPurposeSlider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        
        self.view.addSubview(generalPurposeSlider)
        generalPurposeSlider.alpha = 1
        
        var timer = Timer(timeInterval: 1.0/60.0, repeats: true) { _ in print("Done!") }
        
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1.0/60.0, target: self, selector: #selector(handleTimerEventTriggered), userInfo: nil, repeats: true)
        
        let heightOfSliderValueLabel : CGFloat = 50
        let widthOfSliderValueLabel  : CGFloat = 500
        
        sliderValueLabel.frame = CGRect(x: 50, y: fullScreenY_AsFloat - 200, width: widthOfSliderValueLabel, height: heightOfSliderValueLabel)
        sliderValueLabel.numberOfLines = 1
        sliderValueLabel.textAlignment = .center
        sliderValueLabel.textColor = UIColor.black
        sliderValueLabel.backgroundColor = UIColor.yellow
        sliderValueLabel.font = UIFont(name: "Arial-BoldMT", size: 32)
        sliderValueLabel.text = "Velocity"
        sliderValueLabel.layer.cornerRadius = 12
        sliderValueLabel.clipsToBounds = true
        sliderValueLabel.layer.borderWidth = 4
        sliderValueLabel.layer.borderColor = UIColor.yellow.cgColor
        self.view.addSubview(sliderValueLabel)
        sliderValueLabel.alpha = 1
        if thisIsAnIphone
        {
            sliderValueLabel.frame = CGRect(x: 15, y: fullScreenY_AsFloat - 200, width: 300, height: heightOfSliderValueLabel)
            sliderValueLabel.font = UIFont(name: "Arial-BoldMT", size: 20)
        }
        
        minimumValue.frame = CGRect(x: 50, y: fullScreenY_AsFloat - 50, width: 110, height: 40)
        minimumValue.numberOfLines = 1
        minimumValue.textAlignment = .left
        minimumValue.textColor = UIColor.white
        minimumValue.backgroundColor = UIColor.clear
        minimumValue.font = UIFont(name: "Arial-BoldMT", size: 32)
        self.view.addSubview(minimumValue)
        minimumValue.alpha = 1
        
        maximumValue.frame = CGRect(x: generalPurposeSlider.frame.width - 35, y: fullScreenY_AsFloat - 50, width: 110, height: 40)
        maximumValue.numberOfLines = 1
        maximumValue.textAlignment = .left
        maximumValue.textColor = UIColor.white
        maximumValue.backgroundColor = UIColor.clear
        maximumValue.font = UIFont(name: "Arial-BoldMT", size: 32)
        self.view.addSubview(maximumValue)
        maximumValue.alpha = 1
        
        parameterTableView = UITableView(frame: CGRect(x: fullScreenX - 260, y: 40, width: 260, height: 450))
        parameterTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        parameterTableView.dataSource = self
        parameterTableView.delegate = self
        self.view.addSubview(parameterTableView)
        parameterTableView.backgroundColor = UIColor.orange
        parameterTableView.alpha = 1
        if thisIsAnIphone
        {
            parameterTableView.alpha = 0
        }

        sweetSpotsTableView = UITableView(frame: CGRect(x: fullScreenX - 225, y: 40, width: 225, height: 450))
        sweetSpotsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        sweetSpotsTableView.dataSource = self
        sweetSpotsTableView.delegate = self
        self.view.addSubview(sweetSpotsTableView)
        sweetSpotsTableView.backgroundColor = UIColor.orange
        sweetSpotsTableView.alpha = 0

        explosionKindTableView = UITableView(frame: CGRect(x: fullScreenX - 225, y: 40, width: 225, height: 450))
        explosionKindTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        explosionKindTableView.dataSource = self
        explosionKindTableView.delegate = self
        self.view.addSubview(explosionKindTableView)
        explosionKindTableView.backgroundColor = UIColor.orange
        explosionKindTableView.alpha = 0
        
        hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - 70, y: parameterTableView.frame.origin.y + parameterTableView.frame.height, width: 70, height: 70)
        hideALotOfThingsButton.backgroundColor = UIColor.red
        hideALotOfThingsButton.titleLabel!.font = UIFont(name: "Arial-BoldMT" , size: 22)
        hideALotOfThingsButton.setTitle("X", for: .normal)
        hideALotOfThingsButton.addTarget(self, action: #selector(hideALotOfThingsButtonHandlingAction), for: .touchUpInside)
        //hideALotOfThingsButton.layer.cornerRadius = 0.5 * hideALotOfThingsButton.bounds.size.width
        hideALotOfThingsButton.clipsToBounds = true
        hideALotOfThingsButton.layer.borderWidth = 4
        hideALotOfThingsButton.layer.borderColor = UIColor.magenta.cgColor
        hideALotOfThingsButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        self.view.addSubview(hideALotOfThingsButton)
        hideALotOfThingsButton.alpha = 1
        if thisIsAnIphone
        {
            hideALotOfThingsButton.alpha = 0
        }


        currentCircleRadius = CGFloat(halfScreenX/2)
        currentHeartRadius = CGFloat(halfScreenX/40)
        
        let generalPinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(generalPinchRecognized(pinch:)))
        
        self.view .addGestureRecognizer(generalPinchGesture)
        
        generalPinchGesture.delegate = self
        
        changeEmojiButton.sendActions(for: .touchUpInside)

        readMeTextView.frame = CGRect(x: halfScreenX, y:  0, width: halfScreenX, height: halfScreenY)
        readMeTextView.textAlignment = NSTextAlignment.justified
        readMeTextView.backgroundColor = UIColor.cyan
        readMeTextView.layer.borderWidth = 1.0
        readMeTextView.font = UIFont.systemFont(ofSize: 16.0)
        readMeTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        readMeTextView.textColor = .black
        readMeTextView.text = "Stubby"
        self.view.addSubview(readMeTextView)
        readMeTextView.isEditable = false
        readMeTextView.alpha = 0
        readMeTextView.allowsEditingTextAttributes = true // allows memoji
        if thisIsAnIphone
        {
            readMeTextView.font = UIFont.systemFont(ofSize: 16.0)
        }

        detonateButton.sendActions(for: .touchUpInside)
        
        self.view.backgroundColor = .black

        screenCenterPoint = CGPoint(x:halfScreenX,y:halfScreenY)

        tempRect = CGRect(
        x: halfScreenX*3/4,
        y: halfScreenY*3/4,
        width: halfScreenX/2,
        height: halfScreenX/2)
        
        readMeTextView.alpha = 1
        readMeTextView.text = helpString
        hideALotOfThingsButton.alpha = 1
        hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)

    } // ends viewDidLoad
    
    var currentCircleRadius : CGFloat = 0
    var currentHeartRadius : CGFloat = 0
    var ellipseScaleFactor : CGFloat = 1
    
    var currentCombAngleInDegrees : CGFloat = 270
    var currentCombAngleInDegrees2 : CGFloat = 270

    var emojiPatternValue = 0
    var lastemojiPatternValue = 0

    @objc func sweetSpotsButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        if readMeTextView.alpha == 1
        {
            readMeTextView.text = "Close this ReadMe to continue"
            return
        }
        
        hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: explosionKindTableView.frame.origin.y + explosionKindTableView.frame.height, width: 70, height: 70)
        
        hideALotOfThingsButton.alpha = 1
        changeShapeButton.alpha = 1
        switchParameterButton.alpha = 1
        
        parameterTableView.alpha = 0
        sweetSpotsTableView.alpha = 1
        explosionKindTableView.alpha = 0
        self.sweetSpotsTableView.reloadData()
        
        fireworksAndExplosionsEngine2.stopCombingTheEmitters()

        var thisArrayAsText = [String]()
        
        //thisArrayAsText.append("🔴")
        thisArrayAsText.append("🟡")
        thisArrayAsText.append("🔵")
        //thisArrayAsText.append("🟢")
        //thisArrayAsText.append("🟣")
        
        fireworksAndExplosionsEngine2.alternateImageContentsWithGivenArray(
            desiredArrayAsText: thisArrayAsText)
        
        fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(thisRectangle: sweetSpotsTableView.frame, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        
        fireworksAndExplosionsEngine2.detonate(
            thisCountOfEmittersGeneratingSparks: 400,
            thisVelocity: 50,
            thisVelocityRange: 0.0,
            thisSpin: 0.0,
            thisSpinRange: 0.0,
            thisStartingScale: 0.14,
            thisEndingScale: 0.0,
            thisAccelerationIn_X: 0.0,
            thisAccelerationIn_Y: 0.0,
            thisCellBirthrate: 50.0,
            thisCellLifetime: 1.0,
            thisCellLifetimeRange: 0,
            thisExplosionDuration: 5)
        
    } // ends sweetSpotsButtonHandlingAction
    
    @objc func changeEmojiButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
                
        if emojiPatternValue > 6
        {
            emojiPatternValue = 0
        }
        
        lastemojiPatternValue = emojiPatternValue
        
        if emojiPatternValue == 0
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("🦄")
            thisArrayAsText.append("🦋")
            thisArrayAsText.append("🍎")
            
            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        if emojiPatternValue == 1
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("🤯")
            
            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        if emojiPatternValue == 2
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("⚡️")
            thisArrayAsText.append("🧨")
            thisArrayAsText.append("🐞")
            thisArrayAsText.append("🦄")
            thisArrayAsText.append("💘")
            thisArrayAsText.append("🐥")
            thisArrayAsText.append("🌞")
            thisArrayAsText.append("🍀")
            thisArrayAsText.append("🍟")
            thisArrayAsText.append("🍔")
            thisArrayAsText.append("🍒")
            thisArrayAsText.append("🍕")
            thisArrayAsText.append("🍋")
            thisArrayAsText.append("🍫")
            thisArrayAsText.append("🍰")
            thisArrayAsText.append("🍧")
            thisArrayAsText.append("🎯")
            thisArrayAsText.append("🧲")
            thisArrayAsText.append("💰")
            thisArrayAsText.append("💎")
            thisArrayAsText.append("📆")
            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        if emojiPatternValue == 3
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("⚾️")
            thisArrayAsText.append("🏀")
            thisArrayAsText.append("🏈")

            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        if emojiPatternValue == 4
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("❎")
            thisArrayAsText.append("🅾️")

            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        if emojiPatternValue == 5
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("❤️")
            thisArrayAsText.append("💙")
            thisArrayAsText.append("💛")
            thisArrayAsText.append("💜")
            thisArrayAsText.append("🧡")

            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        if emojiPatternValue == 6
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("🔴")
            thisArrayAsText.append("🟡")
            thisArrayAsText.append("🔵")
            thisArrayAsText.append("🟢")
            thisArrayAsText.append("🟣")

            fireworksAndExplosionsEngine.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)
        }
        
        detonateButton.sendActions(for: .touchUpInside)
        
        emojiPatternValue += 1

    } // changeEmojiButtonHandlingAction
    
    @objc func generateCodeButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        readMeTextView.alpha = 1
        hideALotOfThingsButton.alpha = 1
        hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
        
        // My data pump
        
        var joinedText = "// You can scroll this text to see all the generated code that corresponds to the current explosion or firework effect.\n\n// Note that we have conveniently put the generated code into your paste buffer.  Just paste (right now) into a text message, or an email, or paste with any other way you desire to get the generated code over to the computer where you use Xcode for development.\n\n// Note that fireworksAndExplosionsEngine is the name of the object here where we generate the code.  If you used a different name for the object, then change to match.\n\n// If for some reason, you arent seeing your effect, check to make sure that you have set up your emoji already with a call to alternateImageContentsWithGivenArray, and check to make sure that you have placed your emitters with a call to an API like placeEmittersOnSpecifiedCircleOrArc, placeEmittersOnSpecifiedHeart, placeEmittersOnSpecifiedLine, placeEmittersOnSpecifiedRectangle, etc.\n\n// And if for some reason, your shape if only partially drawn (or extra is drawn), then check maxCountOfEmitters in the call to createPoolOfEmitters is the same as the count for detonating, and placing, etc.  We allow some flexibility in our tool that generates code, but your code should be explicity controlling the counts used.\n\n//As a last resort, you can email me at engineermichigan@gmail.com with questions, but please try reading the documentation first."
        
        if combingInGeneralDirectionEnabled
        {
            joinedText += "\n\n// It looks like you were combing the explosion.  Here is the code to comb with the same features.\n\n"
            
            joinedText += "fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(\n"
            joinedText += "directionAngleForCellFlow: \(currentCombAngleInDegrees),\n"
            joinedText += "coneWideningFactorNormallyZero: \(combWidth))"

            /*
             fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(directionAngleForCellFlow: currentCombAngleInDegrees, coneWideningFactorNormallyZero: combWidth)
             */
        }
        if combingTowardsAPointIsEnabled
        {
            joinedText += "\n\n// It looks like you were combing the explosion.  Here is the code to comb with the same features.\n\n//Note you will need to adjust specified point as desired.\n\n//And you may want to check that thisCountOfEmittersGeneratingSparks is getting the correct desired count, which is often all the emitters in the pool.\n\n"
            joinedText += "fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(\n"
            joinedText += "thisPoint: CGPoint(x: \(thisTouchPoint.x), y: \(thisTouchPoint.y)),\n"
            joinedText += "desiredOffsetAngleForCellFlowInDegrees: \(currentOffsetAngleForCellFlowInDegrees),\n"
            joinedText += "coneWideningFactorNormallyZero: \(combWidth),\n"
            joinedText += "thisCountOfEmittersGeneratingSparks: \(useThisManyObjectsInExplosions))\n"
            
            /*
             fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
             
             */
        }
        if combingInQuadsEnabled
        {
            joinedText += "\n\n// It looks like you were combing with our quadrature effect which works well with rectangles but can be used with other shapes like the circle or heart.  Here is the code to comb with the same features.\n\n//You may want to check that thisCountOfEmittersGeneratingSparks is getting the correct desired count, which is often all the emitters in the pool.\n\n// And you will need to replace our rectangle with yours, which will likely just be some objects frame.\n\n"
            joinedText += "fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(\n"
            joinedText += "thisRectangle: CGRect(x: \(tempRect.origin.x), y: \(tempRect.origin.y), width: \(tempRect.size.width), height: \(tempRect.size.height)),\n"
            joinedText += "thisCountOfEmittersGeneratingSparks: \(useThisManyObjectsInExplosions),\n"
            joinedText += "combEmittersDesired:  true,\n"
            joinedText += "topDesiredCombingRelativeAngle: \(rectangularCombRelativeAngle),\n"
            joinedText += "topConeWideningFactorNormallyZero: \(combWidth),\n"
            joinedText += "bottomDesiredCombingRelativeAngle: \(rectangularCombRelativeAngle),\n"
            joinedText += "bottomConeWideningFactorNormallyZero: \(combWidth),\n"
            joinedText += "leftDesiredCombingRelativeAngle: \(rectangularCombRelativeAngle),\n"
            joinedText += "leftConeWideningFactorNormallyZero: \(combWidth),\n"
            joinedText += "rightDesiredCombingRelativeAngle: \(rectangularCombRelativeAngle),\n"
            joinedText += "rightConeWideningFactorNormallyZero: \(combWidth))\n"

            /*
             fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
             thisRectangle: tempRect,
             thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
             combEmittersDesired: true,
             topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
             topConeWideningFactorNormallyZero: combWidth,
             bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
             bottomConeWideningFactorNormallyZero: combWidth,
             leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
             leftConeWideningFactorNormallyZero: combWidth,
             rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
             rightConeWideningFactorNormallyZero: combWidth)             */
        }

        joinedText += "\n\n// Here is the code to detonate.\n\nfireworksAndExplosionsEngine.detonate(\nthisCountOfEmittersGeneratingSparks: \(useThisManyObjectsInExplosions),\n"
        
        joinedText += "thisVelocity: \(thisVelocity),\n"
        joinedText += "thisVelocityRange: \(thisVelocityRange),\n"
        joinedText += "thisSpin: \(thisSpin),\n"
        joinedText += "thisSpinRange: \(thisSpinRange),\n"
        joinedText += "thisStartingScale: \(thisStartingScale),\n"
        joinedText += "thisEndingScale: \(thisEndingScale),\n"
        joinedText += "thisAccelerationIn_X: \(thisAccelerationIn_X),\n"
        joinedText += "thisAccelerationIn_Y: \(thisAccelerationIn_Y),\n"
        joinedText += "thisCellBirthrate: \(thisCellBirthrate),\n"
        joinedText += "thisCellLifetime: \(thisCellLifetime),\n"
        joinedText += "thisCellLifetimeRange: 0,\n"
        joinedText += "thisExplosionDuration: \(thisExplosionDuration))"
        
        readMeTextView.text = joinedText
        
        // send to pasteboard
        UIPasteboard.general.string = joinedText
        
        fireworksAndExplosionsEngine.hideAllEmitters()
        
        var thisArrayAsText = [String]()
        
        thisArrayAsText.append("🔴")
        thisArrayAsText.append("🟡")
        thisArrayAsText.append("🔵")
        thisArrayAsText.append("🟢")
        thisArrayAsText.append("🟣")
        
        fireworksAndExplosionsEngine2.alternateImageContentsWithGivenArray(
            desiredArrayAsText: thisArrayAsText)
        
        fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedSideOfRectangle(thisSide: EmojiFireworksAndExplosionsPackage.Sides.Left, thisRectangle: readMeTextView.frame, thisCountOfEmittersGeneratingSparks : 400)

        fireworksAndExplosionsEngine2.detonate(
            thisCountOfEmittersGeneratingSparks: 400,
            thisVelocity: 0.0,
            thisVelocityRange: 900,
            thisSpin: 0.0,
            thisSpinRange: 0.0,
            thisStartingScale: 0.4,
            thisEndingScale: 0.0,
            thisAccelerationIn_X: 0.0,
            thisAccelerationIn_Y: -1660,
            thisCellBirthrate: 9,
            thisCellLifetime: 1,
            thisCellLifetimeRange: 0,
            thisExplosionDuration: 0.4)
        
    } // generateCodeButtonHandlingAction
    
    var lastCombMode = 0
    
    @objc func beginCombingButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        if readMeTextView.alpha == 1
        {
            readMeTextView.text = "Close this ReadMe to continue"
            return
        }
                        
        if !combingInGeneralDirectionEnabled && !combingTowardsAPointIsEnabled && !combingInQuadsEnabled
        {
            if lastCombMode == 0 || lastCombMode == 1
            {
                fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(directionAngleForCellFlow: currentCombAngleInDegrees, coneWideningFactorNormallyZero: combWidth)
                
                combingInGeneralDirectionEnabled = true
                
                lastCombMode = 1
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                clearAllInProgressFlags()
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
            }
            if lastCombMode == 2
            {
                combingTowardsAPointIsEnabled = true
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                                
                combingTowardsAPointIsEnabled = true
                combRelativeInProgress = false

                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                clearAllInProgressFlags()
                
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"

                currentOffsetAngleForCellFlowInDegrees = 0
                                
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
            }
            if lastCombMode == 3
            {
                combingTowardsAPointIsEnabled = true
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                combingTowardsAPointIsEnabled = true
                combRelativeInProgress = false

                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                clearAllInProgressFlags()
                
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
                
                currentOffsetAngleForCellFlowInDegrees = 180
                
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
            }
            if lastCombMode == 4
            {
                combingTowardsAPointIsEnabled = true
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                clearAllInProgressFlags()
                
                combRelativeInProgress = true
                
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "360"
                generalPurposeSlider.maximumValue = 360
                generalPurposeSlider.value = 270
                sliderValueLabel.text = "Comb Relative Angle"
                
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
            }
            if lastCombMode == 5
            {
                combingInQuadsEnabled = true
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                clearAllInProgressFlags()
                
                combRelativeInProgress = false
    
                /*
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "360"
                generalPurposeSlider.maximumValue = 360
                generalPurposeSlider.value = 270
                sliderValueLabel.text = "Comb Relative Angle"
     */
                fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                    thisRectangle: tempRect,
                    thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                    combEmittersDesired: true,
                    topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    topConeWideningFactorNormallyZero: combWidth,
                    bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    bottomConeWideningFactorNormallyZero: combWidth,
                    leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    leftConeWideningFactorNormallyZero: combWidth,
                    rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    rightConeWideningFactorNormallyZero: combWidth)
            }
        }
        else
        {
            combingInGeneralDirectionEnabled = false
            combingTowardsAPointIsEnabled = false
            combingInQuadsEnabled = false
            
            fireworksAndExplosionsEngine.stopCombingTheEmitters()

            beginCombingButton.setTitle("Begin\nCombing", for: .normal)
            
            clearAllInProgressFlags()

            velocityInProgress = true
            generalPurposeSlider.minimumValue = 0
            minimumValue.text = "0"
            maximumValue.text = "1000"
            generalPurposeSlider.maximumValue = 1000
            generalPurposeSlider.value = Float(thisVelocity)
            sliderValueLabel.text = "Velocity"
        }
        
        detonateButton.sendActions(for: .touchUpInside)
        
    } // ends beginCombingButtonHandlingAction

    @objc func changeShapeButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        if combingInQuadsEnabled
        {
            readMeTextView.alpha = 1
            readMeTextView.text = "No Shape Change allowed in this mode."
            hideALotOfThingsButton.alpha = 1
            hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
            return
        }
        
        if readMeTextView.alpha == 1
        {
            readMeTextView.text = "Close this ReadMe to continue"
            return
        }

        hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: explosionKindTableView.frame.origin.y + explosionKindTableView.frame.height, width: 70, height: 70)
        
        hideALotOfThingsButton.alpha = 1
        changeShapeButton.alpha = 0
        switchParameterButton.alpha = 1

        parameterTableView.alpha = 0
        sweetSpotsTableView.alpha = 0
        explosionKindTableView.alpha = 1
        self.explosionKindTableView.reloadData()
        
        fireworksAndExplosionsEngine.hideAllEmitters()

        fireworksAndExplosionsEngine2.stopCombingTheEmitters()
        
        var thisArrayAsText = [String]()
        
        thisArrayAsText.append("🤠")
        
        fireworksAndExplosionsEngine2.alternateImageContentsWithGivenArray(
            desiredArrayAsText: thisArrayAsText)
        
        fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(thisRectangle: explosionKindTableView.frame, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        
        fireworksAndExplosionsEngine2.detonate(
            thisCountOfEmittersGeneratingSparks: 400,
            thisVelocity: 100,
            thisVelocityRange: 0.0,
            thisSpin: 0.0,
            thisSpinRange: 0.0,
            thisStartingScale: 0.74,
            thisEndingScale: 0.0,
            thisAccelerationIn_X: 0.0,
            thisAccelerationIn_Y: 0.0,
            thisCellBirthrate: 22.0,
            thisCellLifetime: 2.0,
            thisCellLifetimeRange: 0,
            thisExplosionDuration: 0.5)
        
    } // ends changeShapeButtonHandlingAction
    
    var Sample = 1
    
    var countdownToBringBackSampleButton = 0
    
    @objc func sampleButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        readMeTextView.alpha = 0
        
        fireworksAndExplosionsEngine.hideAllEmitters()
        
        // stub
        // Sample = 7

        countdownToBringBackSampleButton = 200
        
        fireworksAndExplosionsEngine2.stopCombingTheEmitters()
        
        if Sample == 1
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: sampleButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 100,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        else if Sample == 2
        {
            countdownToBringBackSampleButton = 500

        }
        else if Sample == 3
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(thisRectangle: sampleButton.frame, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
            
            fireworksAndExplosionsEngine2.combEmittersTowardsOrAwayFromSpecifiedPoint(
                thisPoint: screenCenterPoint,
                desiredOffsetAngleForCellFlowInDegrees: 90.0,
                coneWideningFactorNormallyZero: 0.1,
                thisCountOfEmittersGeneratingSparks: 400)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300.0,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.15576323866844177,
                thisEndingScale: 0.0,
                thisAccelerationIn_X: -1773.6240844726562,
                thisAccelerationIn_Y: -400.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 1.0,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.7039615511894226)
            
            UIView.animate(withDuration: TimeInterval(1), delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction,   animations: {
                self.sampleButton.alpha = 0
            }, completion: nil)
            
            countdownToBringBackSampleButton = 200
        }
        else if Sample == 4
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: sampleButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 180.0,
                topConeWideningFactorNormallyZero: 0,
                bottomDesiredCombingRelativeAngle: 180.0,
                bottomConeWideningFactorNormallyZero: 0,
                leftDesiredCombingRelativeAngle: 180.0,
                leftConeWideningFactorNormallyZero: 0,
                rightDesiredCombingRelativeAngle: 180.0,
                rightConeWideningFactorNormallyZero: 0)
                        
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 150,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.4,
                thisEndingScale: 0.0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.5,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.05)
            
            UIView.animate(withDuration: TimeInterval(1), delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction,   animations: {
                self.sampleButton.alpha = 0
            }, completion: nil)
            
            countdownToBringBackSampleButton = 200
        }
        else if Sample == 5
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(thisRectangle: generalPurposeSlider.frame, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 30.633438110351562,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.18172377347946167,
                thisEndingScale: 0.0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 1.0,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 111111)
        }
        else if Sample == 6
        {
            var thisArrayAsText = [String]()
            
            thisArrayAsText.append("🔴")
            thisArrayAsText.append("🟡")
            thisArrayAsText.append("🔵")
            thisArrayAsText.append("🟢")
            thisArrayAsText.append("🟣")
            
            fireworksAndExplosionsEngine2.alternateImageContentsWithGivenArray(
                desiredArrayAsText: thisArrayAsText)

            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedSideOfRectangle(thisSide: EmojiFireworksAndExplosionsPackage.Sides.Left, thisRectangle: parameterTableView.frame, thisCountOfEmittersGeneratingSparks : 400)

            fireworksAndExplosionsEngine2.combAllEmittersToPointInDesiredDirectionWithDesiredCone(
                directionAngleForCellFlow: 180,
                coneWideningFactorNormallyZero: 0.0)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 100,
                thisVelocityRange: 100,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.4,
                thisEndingScale: 0.0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 2,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.2)
        }
        else if Sample == 7
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: sampleButton.frame,
                scaleFactor: 1,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0,
                topConeWideningFactorNormallyZero: 0,
                bottomDesiredCombingRelativeAngle: 0,
                bottomConeWideningFactorNormallyZero: 0,
                leftDesiredCombingRelativeAngle: 0,
                leftConeWideningFactorNormallyZero: 0,
                rightDesiredCombingRelativeAngle: 0,
                rightConeWideningFactorNormallyZero: 0)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 1000.0,
                thisVelocityRange: 200.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.1,
                thisEndingScale: 0.0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 500.0,
                thisCellLifetime: 0.1,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.2)
            
            UIView.animate(withDuration: TimeInterval(0), delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction,   animations: {
                self.sampleButton.alpha = 0
            }, completion: nil)
            
            countdownToBringBackSampleButton = 200
        }
        
        Sample += 1
        
        if Sample > 7
        {
            Sample = 1
        }
        var joinedText = "Sample "
        joinedText += "\(Sample)"
        
        sampleButton.setTitle(joinedText, for: .normal)
    }
    
    @objc func switchParameterButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        if readMeTextView.alpha == 1
        {
            readMeTextView.text = "Close this ReadMe to continue"
            return
        }

        parameterTableView.alpha = 1
        sweetSpotsTableView.alpha = 0
        explosionKindTableView.alpha = 0
        
        hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: parameterTableView.frame.origin.y + parameterTableView.frame.height, width: 70, height: 70)
        
        hideALotOfThingsButton.alpha = 1
        switchParameterButton.alpha = 0
        changeShapeButton.alpha = 1
        self.parameterTableView.reloadData()
        
        // Make it fun
        
        fireworksAndExplosionsEngine.hideAllEmitters()

        fireworksAndExplosionsEngine2.stopCombingTheEmitters()

        var thisArrayAsText = [String]()

        thisArrayAsText.append("🔴")
        //thisArrayAsText.append("🟡")
        //thisArrayAsText.append("🔵")
        thisArrayAsText.append("🟢")
        //thisArrayAsText.append("🟣")
        
        fireworksAndExplosionsEngine2.alternateImageContentsWithGivenArray(
            desiredArrayAsText: thisArrayAsText)
        
        fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(thisRectangle: parameterTableView.frame, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)

        fireworksAndExplosionsEngine2.detonate(
            thisCountOfEmittersGeneratingSparks: 400,
            thisVelocity: 50,
            thisVelocityRange: 0.0,
            thisSpin: 0.0,
            thisSpinRange: 0.0,
            thisStartingScale: 0.14,
            thisEndingScale: 0.0,
            thisAccelerationIn_X: 0.0,
            thisAccelerationIn_Y: 0.0,
            thisCellBirthrate: 50.0,
            thisCellLifetime: 1.0,
            thisCellLifetimeRange: 0,
            thisExplosionDuration: 11)

    } // ends switchParameterButtonHandlingAction
    
    @objc func detonateButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        fireworksAndExplosionsEngine.hideAllEmitters()
        
        detonationCountdown = Int(4 * (thisCellLifetime + thisExplosionDuration) * 60)
        
        lastFrameDetonateCalledIn = totalFramesSinceStarting
        
        if kindOfExplosion == kindOfExplosionDesired.pointSource
        {
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: halfScreenX, y: halfScreenY), thisCircleRadius: 0, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        }
        else if kindOfExplosion == kindOfExplosionDesired.rectangle
        {
            
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(thisRectangle: tempRect, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        }
        else if kindOfExplosion == kindOfExplosionDesired.randomInsideCircleOfRadius
        {
            fireworksAndExplosionsEngine.placeEmittersRandomlyInsideSpecifiedCircle(thisCircleCenter: CGPoint(x: halfScreenX, y: halfScreenY), thisCircleRadius: currentCircleRadius, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        }
        else if kindOfExplosion == kindOfExplosionDesired.circle
        {
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: halfScreenX, y: halfScreenY), thisCircleRadius: currentCircleRadius, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        }
        else if kindOfExplosion == kindOfExplosionDesired.ellipse
        {
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedEllipse(thisCenter: CGPoint(x: halfScreenX, y: halfScreenY), thisMajorRadius: 300, thisMinorRadius: 200, alphaAngleInDegrees: 0, omegaAngleInDegreesUsedForRotation: -40, thisScaleFactor: ellipseScaleFactor, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        }
        else if kindOfExplosion == kindOfExplosionDesired.heart
        {
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedHeart(thisHeartCenter: CGPoint(x: halfScreenX, y: halfScreenY), thisHeartScaleFactor: currentHeartRadius, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)
        }
        else if kindOfExplosion == kindOfExplosionDesired.line
        {
            let pointOne = CGPoint(x: halfScreenX, y: 150)
            let pointTwo = CGPoint(x: halfScreenX, y: halfScreenY + 150)
            
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedLine(startingPoint: pointOne, endingPoint: pointTwo, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
        }

        fireworksAndExplosionsEngine.detonate(
            thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
            thisVelocity: thisVelocity,
            thisVelocityRange: thisVelocityRange,
            thisSpin: thisSpin,
            thisSpinRange: thisSpinRange,
            thisStartingScale: thisStartingScale,
            thisEndingScale: thisEndingScale,
            thisAccelerationIn_X: thisAccelerationIn_X,
            thisAccelerationIn_Y: thisAccelerationIn_Y,
            thisCellBirthrate: thisCellBirthrate,
            thisCellLifetime: thisCellLifetime,
            thisCellLifetimeRange: 0,
            thisExplosionDuration: thisExplosionDuration)
        
    } // ends detonateButtonHandlingAction
    
    public func anyControlsBreakpoint()
    {
        detonateButton.alpha = 0
        
    } // ends anyControlsBreakpoint
    
    
    // starts handleTimer...
    @objc func handleTimerEventTriggered() {
        
        totalFramesSinceStarting += 1
        
        detonationCountdown -= 1
        
        if detonationCountdown == 0
        {
            detonateButton.sendActions(for: .touchUpInside)
        }
        
        countdownToBringBackSampleButton -= 1
        
        if countdownToBringBackSampleButton == 0
        {
            if sampleButton.alpha != 1
            {
                UIView.animate(withDuration: TimeInterval(2), delay: 0.0, options: UIView.AnimationOptions.allowUserInteraction,   animations: {
                    self.sampleButton.alpha = 1
                }, completion: nil)
                
                fireworksAndExplosionsEngine2.stopCombingTheEmitters()

                fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: sampleButton.center, thisCircleRadius: 100, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions)

                fireworksAndExplosionsEngine2.combEmittersTowardsOrAwayFromSpecifiedPoint(
                    thisPoint: sampleButton.center,
                    desiredOffsetAngleForCellFlowInDegrees: 0.0,
                    coneWideningFactorNormallyZero: 0.11422637850046158,
                    thisCountOfEmittersGeneratingSparks: 400)
                                
                fireworksAndExplosionsEngine2.detonate(
                    thisCountOfEmittersGeneratingSparks: 400,
                    thisVelocity: 146.41744995117188,
                    thisVelocityRange: 21.806854248046875,
                    thisSpin: 0.0,
                    thisSpinRange: 0.0,
                    thisStartingScale: 0.14537902176380157,
                    thisEndingScale: 0.0,
                    thisAccelerationIn_X: 0.0,
                    thisAccelerationIn_Y: 0.0,
                    thisCellBirthrate: 50.0,
                    thisCellLifetime: 1.0,
                    thisCellLifetimeRange: 0,
                    thisExplosionDuration: 1.5)
            }
        }

        if countdownToBringBackSampleButton == 499
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: changeShapeButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 480
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: beginCombingButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 460
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: generateCodeButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 440
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: changeEmojiButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 420
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: sweetSpotsButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 400
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: switchParameterButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 380
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: sliderValueLabel.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 360
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: generalPurposeSlider.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 340
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: parameterTableView.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 300,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        if countdownToBringBackSampleButton == 320
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedRectangle(
                thisRectangle: hideALotOfThingsButton.frame,
                thisCountOfEmittersGeneratingSparks: 400,
                combEmittersDesired:  true,
                topDesiredCombingRelativeAngle: 0.0,
                topConeWideningFactorNormallyZero: 0.5020768642425537,
                bottomDesiredCombingRelativeAngle: 0.0,
                bottomConeWideningFactorNormallyZero: 0.5020768642425537,
                leftDesiredCombingRelativeAngle: 0.0,
                leftConeWideningFactorNormallyZero: 0.5020768642425537,
                rightDesiredCombingRelativeAngle: 0.0,
                rightConeWideningFactorNormallyZero: 0.5020768642425537)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 100,
                thisVelocityRange: 0.0,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.10643821209669113,
                thisEndingScale: 0,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 0.0,
                thisCellBirthrate: 50.0,
                thisCellLifetime: 0.7,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 0.33069056272506714)
        }
        
        if countdownToBringBackSampleButton == 999
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: changeShapeButton.center.x + changeShapeButton.frame.width/2, y: changeShapeButton.center.y + changeShapeButton.frame.height/2), thisCircleRadius: 0, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: 400)
            
            fireworksAndExplosionsEngine2.combAllEmittersToPointInDesiredDirectionWithDesiredCone(
                directionAngleForCellFlow: -35.64702074990675,
                coneWideningFactorNormallyZero: 0.10539979487657547)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 541.0176391601562,
                thisVelocityRange: 62.3052978515625,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.15057113766670227,
                thisEndingScale: 0.09605399519205093,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 2000,
                thisCellBirthrate: 33.75648880004883,
                thisCellLifetime: 1.650254487991333,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 4.04266357421875)
        }
        if countdownToBringBackSampleButton == 900
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: beginCombingButton.center.x + beginCombingButton.frame.width/2, y: beginCombingButton.center.y + beginCombingButton.frame.height/2), thisCircleRadius: 0, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: 400)
            
            fireworksAndExplosionsEngine2.combAllEmittersToPointInDesiredDirectionWithDesiredCone(
                directionAngleForCellFlow: -35.64702074990675,
                coneWideningFactorNormallyZero: 0.10539979487657547)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 541.0176391601562,
                thisVelocityRange: 62.3052978515625,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.15057113766670227,
                thisEndingScale: 0.09605399519205093,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 2000,
                thisCellBirthrate: 33.75648880004883,
                thisCellLifetime: 1.650254487991333,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 4.04266357421875)
        }
        if countdownToBringBackSampleButton == 800
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: generateCodeButton.center.x + generateCodeButton.frame.width/2, y: generateCodeButton.center.y + generateCodeButton.frame.height/2), thisCircleRadius: 0, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: 400)
            
            fireworksAndExplosionsEngine2.combAllEmittersToPointInDesiredDirectionWithDesiredCone(
                directionAngleForCellFlow: -35.64702074990675,
                coneWideningFactorNormallyZero: 0.10539979487657547)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 541.0176391601562,
                thisVelocityRange: 62.3052978515625,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.15057113766670227,
                thisEndingScale: 0.09605399519205093,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 2000,
                thisCellBirthrate: 33.75648880004883,
                thisCellLifetime: 1.650254487991333,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 4.04266357421875)
        }
        if countdownToBringBackSampleButton == 700
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: changeEmojiButton.center.x + changeEmojiButton.frame.width/2, y: changeEmojiButton.center.y + changeEmojiButton.frame.height/2), thisCircleRadius: 0, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: 400)
            
            fireworksAndExplosionsEngine2.combAllEmittersToPointInDesiredDirectionWithDesiredCone(
                directionAngleForCellFlow: -35.64702074990675,
                coneWideningFactorNormallyZero: 0.10539979487657547)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 541.0176391601562,
                thisVelocityRange: 62.3052978515625,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.15057113766670227,
                thisEndingScale: 0.09605399519205093,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 2000,
                thisCellBirthrate: 33.75648880004883,
                thisCellLifetime: 1.650254487991333,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 4.04266357421875)
        }
        if countdownToBringBackSampleButton == 600
        {
            fireworksAndExplosionsEngine2.placeEmittersOnSpecifiedCircleOrArc(thisCircleCenter: CGPoint(x: sweetSpotsButton.center.x + sweetSpotsButton.frame.width/2, y: sweetSpotsButton.center.y + sweetSpotsButton.frame.height/2), thisCircleRadius: 0, thisCircleArcFactor: 1, offsetAngleInDegrees: 0, scaleFactor: 1, thisCountOfEmittersGeneratingSparks: 400)
            
            fireworksAndExplosionsEngine2.combAllEmittersToPointInDesiredDirectionWithDesiredCone(
                directionAngleForCellFlow: -35.64702074990675,
                coneWideningFactorNormallyZero: 0.10539979487657547)
            
            fireworksAndExplosionsEngine2.detonate(
                thisCountOfEmittersGeneratingSparks: 400,
                thisVelocity: 541.0176391601562,
                thisVelocityRange: 62.3052978515625,
                thisSpin: 0.0,
                thisSpinRange: 0.0,
                thisStartingScale: 0.15057113766670227,
                thisEndingScale: 0.09605399519205093,
                thisAccelerationIn_X: 0.0,
                thisAccelerationIn_Y: 2000,
                thisCellBirthrate: 33.75648880004883,
                thisCellLifetime: 1.650254487991333,
                thisCellLifetimeRange: 0,
                thisExplosionDuration: 4.04266357421875)
        }
    }
    
    var totalFramesSinceStarting = 0
    var lastFrameDetonateCalledIn = 0
    var samplesFromSlider = 0
    var detonationCountdown = 0
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
                case .began:
                    detonateButton.sendActions(for: .touchUpInside)
                    samplesFromSlider = 0
                    break
                // handle drag began
                case .moved:
                    break
                // handle drag moved
                case .ended:
                    // handle drag ended
                    
                    detonationCountdown  = 2 * Int(thisCellLifetime * 60) + 8
                    
                    break
                default:
                    break
            }
        }
    } // ends onSliderValChanged
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if parameterTableView.alpha == 1
        {
            // Build the latest table info
            parameterTableArrayOfNames = [
                "Adjust Velocity",
                "Adjust Velocity Range",
                "Adjust Spin",
                "Adjust Spin Range",
                "Adjust Starting Scale",
                "Adjust Ending Scale",
                "Adjust Birth Rate",
                "Adjust Lifetime",
                "Adjust Explosion Duration",
                "Adjust X Acceleration",
                "Adjust Y Acceleration",
                "Adjust Emitter Count",
                "Adjust Cone Width",
                "Comb Towards A Point",
                "Comb Away From A Point",
                "Comb Relative To A Point",
                "Comb in Specified Direction",
                "Rectangular Combing",
                "Adjust Rectangular Comb Angle",
                "Stop Combing",
                "See Help Info"
            ]
            return parameterTableArrayOfNames.count
        }
        if sweetSpotsTableView.alpha == 1
        {
            // Build the latest table info
            sweetSpotsTableArrayOfNames = [
                "Heart Spread",
                "Hose or Fountain",
                "Ring of Fire",
                "Ring of Fire2",
                "Comb Straight Away",
                "Fuzzy Circle",
                "Sheeting",
                "Dot Calm",
                "Simple Firework",
                "Long Fade any Shape",
                "Implosion",
                "Gone with the Wind",
                "Honey",
                "Ring of Fire3",
                "Rectangle Comb Away",
                "Rectangle Comb Inside",
                "Rectangle Dust",
                "Heart of Hearts"
            ]
            return sweetSpotsTableArrayOfNames.count
        }
        if explosionKindTableView.alpha == 1
        {
            // Build the latest table info
            explosionKindTableArrayOfNames = [
                "Point Source",
                "On Circle With Radius",
                "Randomly in Circle",
                "On Rectangle",
                "On Ellipse",
                "On Heart",
                "On Line",
                " ",
                " ",
                " ",
                " ",
                " "
            ]
            return explosionKindTableArrayOfNames.count
        }

        
        return 1000
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.textLabel!.font = UIFont(name: "Arial-BoldMT", size: 15.0 * 1 * 1)
        
        // see https://stackoverflow.com/questions/1998775/uitableview-cell-selected-color
        let bgColorView = UIView() // used in setting cells highlighted color
        
        
        bgColorView.backgroundColor =  UIColor.green
        
        cell.selectedBackgroundView = bgColorView
        
        if explosionKindTableView.alpha == 1
        {
            cell.textLabel!.text = "\(explosionKindTableArrayOfNames[indexPath.row])"
        }
        if parameterTableView.alpha == 1
        {
            cell.textLabel!.text = "\(parameterTableArrayOfNames[indexPath.row])"
        }
        if sweetSpotsTableView.alpha == 1
        {
            cell.textLabel!.text = "\(sweetSpotsTableArrayOfNames[indexPath.row])"
        }

        
        cell.textLabel?.textColor = UIColor.black
        
        if  indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.cyan
        }
        else
        {
            cell.backgroundColor = UIColor.yellow
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if parameterTableView.alpha == 1
        {
            if thisIsAnIphone
            {
                parameterTableView.alpha = 0
                hideALotOfThingsButton.alpha = 0
                switchParameterButton.alpha = 1
            }
            
            if indexPath.row == 0 // "Adjust Velocity"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                velocityInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1000"
                generalPurposeSlider.maximumValue = 1000
                generalPurposeSlider.value = Float(thisVelocity)
                sliderValueLabel.text = "Velocity"
                
            }
            if indexPath.row == 1 // "Adjust Velocity Range"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                velocityRangeInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1000"
                generalPurposeSlider.maximumValue = 1000
                generalPurposeSlider.value = Float(thisVelocityRange)
                sliderValueLabel.text = "Velocity Range"
            }
            if indexPath.row == 2 // "Adjust Spin"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                spinInProgress = true
                generalPurposeSlider.minimumValue = -20
                minimumValue.text = "-20"
                maximumValue.text = "20"
                generalPurposeSlider.maximumValue = 20
                generalPurposeSlider.value = Float(thisSpin)
                sliderValueLabel.text = "Spin"
            }
            if indexPath.row == 3 // "Adjust Spin Range"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                spinRangeInProgress = true
                generalPurposeSlider.minimumValue = -20
                minimumValue.text = "-20"
                maximumValue.text = "20"
                generalPurposeSlider.maximumValue = 20
                generalPurposeSlider.value = Float(thisSpinRange)
                sliderValueLabel.text = "Spin Range"
            }
            if indexPath.row == 4 // "Adjust Starting Scale"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                startingScaleInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "5"
                generalPurposeSlider.maximumValue = 5
                generalPurposeSlider.value = Float(thisStartingScale)
                sliderValueLabel.text = "Starting Scale"
            }
            if indexPath.row == 5 // "Adjust Ending Scale"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                endingScaleInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "5"
                generalPurposeSlider.maximumValue = 5
                generalPurposeSlider.value = Float(thisEndingScale)
                sliderValueLabel.text = "Ending Scale"
            }
            if indexPath.row == 6 // "Adjust Birth Rate"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                birthRateInProgress = true
                generalPurposeSlider.minimumValue = 1
                minimumValue.text = "1"
                maximumValue.text = "300"
                generalPurposeSlider.maximumValue = 300
                generalPurposeSlider.value = Float(thisCellBirthrate)
                sliderValueLabel.text = "Birth Rate"
            }
            if indexPath.row == 7 // "Adjust Lifetime"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                lifetimeInProgress = true
                generalPurposeSlider.minimumValue = 0.03
                minimumValue.text = "0.03"
                maximumValue.text = "10"
                generalPurposeSlider.maximumValue = 10
                generalPurposeSlider.value = Float(thisCellLifetime)
                sliderValueLabel.text = "Lifetime"
            }
            if indexPath.row == 8 // "Adjust Explosion Duration"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                durationInProgress = true
                generalPurposeSlider.minimumValue = 0.03
                minimumValue.text = "0.03"
                maximumValue.text = "20"
                generalPurposeSlider.maximumValue = 20
                generalPurposeSlider.value = Float(thisExplosionDuration)
                sliderValueLabel.text = "Duration"
            }
            if indexPath.row == 9 // "Adjust X Acceleration"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                X_AccelerationInProgress = true
                generalPurposeSlider.minimumValue = -1000
                minimumValue.text = "-1000"
                maximumValue.text = "1000"
                generalPurposeSlider.maximumValue = 1000
                generalPurposeSlider.value = Float(thisAccelerationIn_X)
                sliderValueLabel.text = "X Acceleration"
            }
            if indexPath.row == 10 // "Adjust Y Acceleration"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                Y_AccelerationInProgress = true
                generalPurposeSlider.minimumValue = -1000
                minimumValue.text = "-1000"
                maximumValue.text = "1000"
                generalPurposeSlider.maximumValue = 1000
                generalPurposeSlider.value = Float(thisAccelerationIn_Y)
                sliderValueLabel.text = "Y Acceleration"
            }
            if indexPath.row == 11 // "Adjust Emitter Count"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                countOfSparksInProgress = true
                generalPurposeSlider.minimumValue = 3
                minimumValue.text = "3"
                maximumValue.text = "1000"
                generalPurposeSlider.maximumValue = 1000
                generalPurposeSlider.value = Float(useThisManyObjectsInExplosions)
                sliderValueLabel.text = "Emitter Count"
            }
            if indexPath.row == 12 // "Adjust Cone Width"
            {
                anyControlsBreakpoint()
                
                if !(combingTowardsAPointIsEnabled || combingInGeneralDirectionEnabled || combingInQuadsEnabled)
                {
                    readMeTextView.alpha = 1
                    hideALotOfThingsButton.alpha = 1
                    hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
                    readMeTextView.text = "You have to select a combing method first."
                    
                    return
                }
                
                clearAllInProgressFlags()
                
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 13 // "Comb Towards A Point"
            {
                anyControlsBreakpoint()
                
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combingTowardsAPointIsEnabled = true
                lastCombMode = 2
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                clearAllInProgressFlags()
                
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
                
                currentOffsetAngleForCellFlowInDegrees = 0
                
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: CGPoint(x: halfScreenX, y: halfScreenY), desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: 0.1, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
                
                detonateButton.sendActions(for: .touchUpInside)
                
                readMeTextView.alpha = 1
                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
                readMeTextView.text = "While this mode of combing is enabled, the sparks will start out flowing TOWARDS any place you touch on the screen.  Note that to make this more interesting, we initially set the cone width to allow for a little spreading of the sparks.  You can still adjust the cone width as desired.\n\nMake sure to change to different shapes!  And try to touch near the borders of the shapes, near the center, near the screen edges, and near any vertex.\n\nTo stop this mode of combing, select another mode of combing, or press the stop combing button."
                
            }
            if indexPath.row == 14 // "Comb Away From A Point"
            {
                anyControlsBreakpoint()
                
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combingTowardsAPointIsEnabled = true
                lastCombMode = 3
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                clearAllInProgressFlags()
                
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
                
                currentOffsetAngleForCellFlowInDegrees = 180
                
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: CGPoint(x: halfScreenX, y: halfScreenY), desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: 0.1, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
                
                detonateButton.sendActions(for: .touchUpInside)
                
                readMeTextView.alpha = 1
                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
                readMeTextView.text = "While this mode of combing is enabled, the sparks will start out flowing AWAY from any place you touch on the screen.  Note that to make this more interesting, we initially set the cone width to allow for a little spreading of the sparks.  You can still adjust the cone width as desired.\n\nMake sure to change to different shapes!  And try to touch near the borders of the shapes, near the center, near the screen edges, and near any vertex.\n\nTo stop this mode of combing, select another mode of combing, or press the stop combing button."
                
            }
            if indexPath.row == 15 // "Comb Relative To A Point"
            {
                anyControlsBreakpoint()
                
                clearAllInProgressFlags()
                
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combingTowardsAPointIsEnabled = true
                lastCombMode = 4
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                combRelativeInProgress = true
                
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "360"
                generalPurposeSlider.maximumValue = 360
                generalPurposeSlider.value = 270
                sliderValueLabel.text = "Comb Relative Angle"
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                currentOffsetAngleForCellFlowInDegrees = 90
                
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: CGPoint(x: halfScreenX, y: halfScreenY), desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: 0.1, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
                
                detonateButton.sendActions(for: .touchUpInside)
                
                readMeTextView.alpha = 1
                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
                readMeTextView.text = "While this mode of combing is enabled, the sparks will flow WITH A RELATIVE ANGLE corresponding to any place you touch on the screen.  Note that to make this more interesting, we initially set the cone width to allow for a little spreading of the sparks.  You can still adjust the cone width as desired.\n\nMake sure to change to different shapes!  And try to touch near the borders of the shapes, near the center, near the screen edges, and near any vertex.\n\nTo stop this mode of combing, select another mode of combing, or press the stop combing button."
                
            }
            if indexPath.row == 16 // "Comb in Specified Direction"
            {
                anyControlsBreakpoint()
                
                combingInGeneralDirectionEnabled = true
                combingInQuadsEnabled = false
                combingTowardsAPointIsEnabled = false
                lastCombMode = 1
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                combRelativeInProgress = false
                
                fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(directionAngleForCellFlow: currentCombAngleInDegrees, coneWideningFactorNormallyZero: combWidth)
                                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                clearAllInProgressFlags()
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
                detonateButton.sendActions(for: .touchUpInside)
                
                readMeTextView.alpha = 1
                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
                readMeTextView.text = "While this mode of combing is enabled, the sparks will travel in a general direction based on the last touch point.  Note that to make this more interesting, we initially set the cone width to allow for a little spreading of the sparks.  You can still adjust the cone width as desired.\n\nMake sure to change to different shapes! To stop this mode of combing, select another mode of combing, or press the stop combing button."
                
            }
            if indexPath.row == 17 // "Rectangular Combing"
            {
                anyControlsBreakpoint()
                
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = true
                combingTowardsAPointIsEnabled = false
                combRelativeInProgress = false
                
                lastCombMode = 5
                
                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                
                // Start in rectangular shape
                kindOfExplosion = kindOfExplosionDesired.rectangle
                
                rectangularCombRelativeAngle = 0
                
                fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                    thisRectangle: tempRect,
                    thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                    combEmittersDesired: true,
                    topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    topConeWideningFactorNormallyZero: combWidth,
                    bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    bottomConeWideningFactorNormallyZero: combWidth,
                    leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    leftConeWideningFactorNormallyZero: combWidth,
                    rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    rightConeWideningFactorNormallyZero: combWidth)
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                clearAllInProgressFlags()
                combWidthInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1"
                generalPurposeSlider.maximumValue = 1
                generalPurposeSlider.value = 0.3
                sliderValueLabel.text = "Cone Width Factor"
                detonateButton.sendActions(for: .touchUpInside)
                
                readMeTextView.alpha = 1
                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
                readMeTextView.text = "We automatically changed to the rectangular shape for this type of combing.\n\nMake sure to adjust the rectangular comb angle by selecting the next entry in the table.\n\nTo stop this mode of combing, select another mode of combing, or press the stop combing button."
                
            }
            if indexPath.row == 18 // "Adjust Rectangular Comb Angle"
            {
                anyControlsBreakpoint()
                
                combingInQuadsEnabled = true
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = false
                combingInGeneralDirectionEnabled = false
                
                clearAllInProgressFlags()
                                
                rectangularAngleInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "360"
                generalPurposeSlider.maximumValue = 360
                generalPurposeSlider.value = Float(rectangularCombRelativeAngle)
                sliderValueLabel.text = "Rectangular Angle"

                thisAccelerationIn_X = 0
                thisAccelerationIn_Y = 0
                
                // Start in rectangular shape
                //kindOfExplosion = kindOfExplosionDesired.rectangle
                
                //rectangularCombRelativeAngle = 0
                
                fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                    thisRectangle: tempRect,
                    thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                    combEmittersDesired: true,
                    topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    topConeWideningFactorNormallyZero: combWidth,
                    bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    bottomConeWideningFactorNormallyZero: combWidth,
                    leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    leftConeWideningFactorNormallyZero: combWidth,
                    rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    rightConeWideningFactorNormallyZero: combWidth)
                
                beginCombingButton.setTitle("Stop\nCombing", for: .normal)
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 19 // "Stop Combing"
            {
                anyControlsBreakpoint()
                
                combingInGeneralDirectionEnabled = false
                combingTowardsAPointIsEnabled = false
                combingInQuadsEnabled = false
                
                fireworksAndExplosionsEngine.stopCombingTheEmitters()
                
                beginCombingButton.setTitle("Begin\nCombing", for: .normal)
                
                clearAllInProgressFlags()
                
                velocityInProgress = true
                generalPurposeSlider.minimumValue = 0
                minimumValue.text = "0"
                maximumValue.text = "1000"
                generalPurposeSlider.maximumValue = 1000
                generalPurposeSlider.value = Float(thisVelocity)
                sliderValueLabel.text = "Velocity"
            }
            if indexPath.row == 20 // "See Help Info"
            {
                anyControlsBreakpoint()
                                
                readMeTextView.alpha = 1
                readMeTextView.text = helpString

                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: readMeTextView.frame.origin.y + readMeTextView.frame.height, width: 70, height: 70)
            }
        }
        if sweetSpotsTableView.alpha == 1
        {
            fireworksAndExplosionsEngine.stopCombingTheEmitters()

            if thisIsAnIphone
            {
                sweetSpotsTableView.alpha = 0
                hideALotOfThingsButton.alpha = 0
                sweetSpotsButton.alpha = 1
            }
            
            if indexPath.row == 0 // "Heart Spread"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 19.730010986328125
                thisVelocityRange = 340.602294921875
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.7762201428413391
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 47.76739501953125
                thisCellBirthrate = 50.0
                thisCellLifetime = 0.8064797520637512
                thisExplosionDuration = 0.6
                useThisManyObjectsInExplosions = 400
                combingInQuadsEnabled = false
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = true
                combWidth = 0.009865005500614643
                currentOffsetAngleForCellFlowInDegrees = 180.0
                kindOfExplosion = kindOfExplosionDesired.heart
                currentCombAngleInDegrees = -77.56043798115346
                emojiPatternValue = 0
                lastCombMode = 1
            }
            if indexPath.row == 1 // "Hose or Fountain"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 541.0176391601562
                thisVelocityRange = 62.3052978515625
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.15057113766670227
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.09605399519205093
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 763.2398681640625
                thisCellBirthrate = 33.75648880004883
                thisCellLifetime = 1.650254487991333
                thisExplosionDuration = 4.04266357421875
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = true
                combingInQuadsEnabled = false
                combWidth = 0.10539979487657547
                currentOffsetAngleForCellFlowInDegrees = 180.0
                kindOfExplosion = kindOfExplosionDesired.pointSource
                currentCombAngleInDegrees = -35.64702074990675
                emojiPatternValue = 5
                lastCombMode = 1
            }
            if indexPath.row == 2 // "Ring of Fire"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 203.5306396484375
                thisVelocityRange = 186.9158935546875
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.371235728263855
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.09605399519205093
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 33.75648880004883
                thisCellLifetime = 1.650254487991333
                thisExplosionDuration = 3.036905288696289
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.10384216159582138
                currentOffsetAngleForCellFlowInDegrees = 50.467288970947266
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = -108.27995610942959
                emojiPatternValue = 1
                lastCombMode = 4
            }
            if indexPath.row == 3 // "Ring of Fire2"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 300.0
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 0.506240963935852
                thisExplosionDuration = 7.288047790527344
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.1
                currentOffsetAngleForCellFlowInDegrees = 50.467288970947266
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = -89.04515874612783
                emojiPatternValue = 0
                lastCombMode = 4
            }
            if indexPath.row == 4 // "Comb Straight Away"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 300.0
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 0.506240963935852
                thisExplosionDuration = 7.288047790527344
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.0
                currentOffsetAngleForCellFlowInDegrees = 180.0
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = -34.992020198558656
                emojiPatternValue = 0
                lastCombMode = 3
            }
            if indexPath.row == 5 // "Fuzzy Circle"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 300.0
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 0.506240963935852
                thisExplosionDuration = 7.288047790527344
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.086708202958107
                currentOffsetAngleForCellFlowInDegrees = 180.0
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = 59.03624346792648
                emojiPatternValue = 0
                lastCombMode = 3
            }
            if indexPath.row == 6 // "Sheeting"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 250.2595977783203
                thisVelocityRange = 340.602294921875
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.7762201428413391
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 3.430981397628784
                thisExplosionDuration = 0.6
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = true
                combingInQuadsEnabled = false
                combWidth = 0.0
                currentOffsetAngleForCellFlowInDegrees = 92.3364486694336
                kindOfExplosion = kindOfExplosionDesired.line
                currentCombAngleInDegrees = 4.425834036449799
                emojiPatternValue = 6
                lastCombMode = 1
            }
            if indexPath.row == 7 // "Dot Calm"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 0.0
                thisVelocityRange = 341.1214904785156
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.5425752997398376
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 32.191070556640625
                thisCellBirthrate = 3.328660488128662
                thisCellLifetime = 6.521370887756348
                thisExplosionDuration = 7.26731014251709
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.0
                currentOffsetAngleForCellFlowInDegrees = 92.3364486694336
                kindOfExplosion = kindOfExplosionDesired.line
                currentCombAngleInDegrees = -77.31961650818018
                emojiPatternValue = 6
                lastCombMode = 1
            }
            if indexPath.row == 8 // "Simple Firework"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 300.0
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.49065420031547546
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 1.038421630859375
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.0
                thisExplosionDuration = 0.029999999329447746
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.40498441457748413
                currentOffsetAngleForCellFlowInDegrees = 180.0
                kindOfExplosion = kindOfExplosionDesired.pointSource
                currentCombAngleInDegrees = -125.66066762349065
                emojiPatternValue = 0
                lastCombMode = 3
            }
            if indexPath.row == 9 // "Long Fade any Shape"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 30.633438110351562
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.18172377347946167
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.0
                thisExplosionDuration = 3.389439105987549
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.1
                currentOffsetAngleForCellFlowInDegrees = 0.0
                kindOfExplosion = kindOfExplosionDesired.rectangle
                currentCombAngleInDegrees = -61.99082329198617
                emojiPatternValue = 0
                lastCombMode = 0
            }
            if indexPath.row == 10 // "Implosion"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 146.41744995117188
                thisVelocityRange = 21.806854248046875
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.14537902176380157
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.0
                thisExplosionDuration = 3.389439105987549
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.11422637850046158
                currentOffsetAngleForCellFlowInDegrees = 0.0
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = -160.9065079995144
                emojiPatternValue = 6
                lastCombMode = 2
            }
            if indexPath.row == 11 // "Gone with the Wind"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 300.0
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.15576323866844177
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = -773.6240844726562
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.0
                thisExplosionDuration = 0.7039615511894226
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.1
                currentOffsetAngleForCellFlowInDegrees = 90.0
                kindOfExplosion = kindOfExplosionDesired.rectangle
                currentCombAngleInDegrees = -41.30861401354873
                emojiPatternValue = 0
                lastCombMode = 4
            }
            if indexPath.row == 12 // "Honey"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 19.730010986328125
                thisVelocityRange = 210.79959106445312
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.7175493240356445
                thisExplosionDuration = 7.288047790527344
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.0
                currentOffsetAngleForCellFlowInDegrees = 17.19626235961914
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = -84.28940686250037
                emojiPatternValue = 1
                lastCombMode = 4
            }
            if indexPath.row == 13 // "Ring of Fire3"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 17.653167724609375
                thisVelocityRange = 109.55348205566406
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = -536.8639526367188
                thisCellBirthrate = 50.0
                thisCellLifetime = 0.3716511130332947
                thisExplosionDuration = 7.288047790527344
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = true
                combingInGeneralDirectionEnabled = false
                combingInQuadsEnabled = false
                combWidth = 0.0
                currentOffsetAngleForCellFlowInDegrees = 17.19626235961914
                kindOfExplosion = kindOfExplosionDesired.circle
                currentCombAngleInDegrees = -159.59011716619602
                emojiPatternValue = 1
                lastCombMode = 4
            }
            if indexPath.row == 14 // "Rectangle Comb Away"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 300.0
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.0
                thisExplosionDuration = 0.6
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInQuadsEnabled = true
                combingInGeneralDirectionEnabled = false
                combWidth = 0
                currentOffsetAngleForCellFlowInDegrees = 0.0
                kindOfExplosion = kindOfExplosionDesired.rectangle
                currentCombAngleInDegrees = 270.0
                emojiPatternValue = 0
                lastCombMode = 5
                rectangularCombRelativeAngle = 0.0
            }
            if indexPath.row == 15 // "Rectangle Comb Inside"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 152.64797973632812
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 1.23
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.0
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.7693147659301758
                thisExplosionDuration = 0.33069056272506714
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInQuadsEnabled = true
                combingInGeneralDirectionEnabled = false
                combWidth = 0.022326065227389336
                currentOffsetAngleForCellFlowInDegrees = 0.0
                kindOfExplosion = kindOfExplosionDesired.rectangle
                currentCombAngleInDegrees = 270.0
                emojiPatternValue = 0
                lastCombMode = 5
                rectangularCombRelativeAngle = 180.0
            }
            if indexPath.row == 16 // "Rectangle Dust"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 657.3208618164062
                thisVelocityRange = 0.0
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.10643821209669113
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.12980270385742188
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 1.7693147659301758
                thisExplosionDuration = 0.33069056272506714
                useThisManyObjectsInExplosions = 400
                combingTowardsAPointIsEnabled = false
                combingInQuadsEnabled = true
                combingInGeneralDirectionEnabled = false
                combWidth = 0.5020768642425537
                currentOffsetAngleForCellFlowInDegrees = 0.0
                kindOfExplosion = kindOfExplosionDesired.rectangle
                currentCombAngleInDegrees = -143.76758124455299
                emojiPatternValue = 0
                lastCombMode = 5
                rectangularCombRelativeAngle = 0.0
            }
            if indexPath.row == 17 // "Heart of hearts"
            {
                anyControlsBreakpoint()
                
                thisVelocity = 166.1474609375
                thisVelocityRange = 155.76324462890625
                thisSpin = 0.0
                thisSpinRange = 0.0
                thisStartingScale = 0.610072672367096
                thisStartingScaleRange = 0.0
                thisEndingScale = 0.07528556883335114
                thisAccelerationIn_X = 0.0
                thisAccelerationIn_Y = 0.0
                thisCellBirthrate = 50.0
                thisCellLifetime = 0.7236552238464355
                thisExplosionDuration = 2.311100721359253
                useThisManyObjectsInExplosions = 55
                combingTowardsAPointIsEnabled = true
                combingInQuadsEnabled = false
                combingInGeneralDirectionEnabled = true
                combWidth = 0.12097611278295517
                currentOffsetAngleForCellFlowInDegrees = 180.0
                kindOfExplosion = kindOfExplosionDesired.heart
                currentCombAngleInDegrees = 71.1468412355809
                emojiPatternValue = 5
                lastCombMode = 3
                rectangularCombRelativeAngle = 0.0

            }

            thisTouchPoint = screenCenterPoint
            
            if combingInQuadsEnabled
            {
                fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                    thisRectangle: tempRect,
                    thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                    combEmittersDesired: true,
                    topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    topConeWideningFactorNormallyZero: combWidth,
                    bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    bottomConeWideningFactorNormallyZero: combWidth,
                    leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    leftConeWideningFactorNormallyZero: combWidth,
                    rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    rightConeWideningFactorNormallyZero: combWidth)            }
            if combingInGeneralDirectionEnabled
            {
                fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(directionAngleForCellFlow: currentCombAngleInDegrees, coneWideningFactorNormallyZero: combWidth)
            }
            if combingTowardsAPointIsEnabled
            {
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)

            }
            
            changeEmojiButton.sendActions(for: .touchUpInside)

            detonateButton.sendActions(for: .touchUpInside)
        }
        
        if explosionKindTableView.alpha == 1
        {
            if thisIsAnIphone
            {
                explosionKindTableView.alpha = 0
                hideALotOfThingsButton.alpha = 0
                changeShapeButton.alpha = 1
            }

            if indexPath.row == 0 // "Point Source"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.pointSource
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 1 // "On Circle With Radius"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.circle
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 2 // "Randomly in Circle"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.randomInsideCircleOfRadius
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 3 // "Point Source"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.rectangle
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 4 // "On Ellipse"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.ellipse
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 5 // "On Heart"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.heart
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 6 // "On Line"
            {
                anyControlsBreakpoint()
                
                kindOfExplosion = kindOfExplosionDesired.line
                
                detonateButton.sendActions(for: .touchUpInside)
            }
            if indexPath.row == 11 // "Pump my variables" oneone
            {
                anyControlsBreakpoint()
                
                var joinedText = " "
                
                joinedText += "thisVelocity = \(thisVelocity)\n"
                joinedText += "thisVelocityRange = \(thisVelocityRange)\n"
                joinedText += "thisSpin = \(thisSpin)\n"
                joinedText += "thisSpinRange = \(thisSpinRange)\n"
                joinedText += "thisStartingScale = \(thisStartingScale)\n"
                joinedText += "thisStartingScaleRange = \(thisStartingScaleRange)\n"
                joinedText += "thisEndingScale = \(thisEndingScale)\n"
                joinedText += "thisAccelerationIn_X = \(thisAccelerationIn_X)\n"
                joinedText += "thisAccelerationIn_Y = \(thisAccelerationIn_Y)\n"
                joinedText += "thisCellBirthrate = \(thisCellBirthrate)\n"
                joinedText += "thisCellLifetime = \(thisCellLifetime)\n"
                joinedText += "thisExplosionDuration = \(thisExplosionDuration)\n"
                joinedText += "useThisManyObjectsInExplosions = \(useThisManyObjectsInExplosions)\n"
                joinedText += "combingTowardsAPointIsEnabled = \(combingTowardsAPointIsEnabled)\n"
                joinedText += "combingInQuadsEnabled = \(combingInQuadsEnabled)\n"
                joinedText += "combingInGeneralDirectionEnabled = \(combingInGeneralDirectionEnabled)\n"
                joinedText += "combWidth = \(combWidth)\n"
                joinedText += "currentOffsetAngleForCellFlowInDegrees = \(currentOffsetAngleForCellFlowInDegrees)\n"
                joinedText += "kindOfExplosion = kindOfExplosionDesired.\(kindOfExplosion)\n"
                joinedText += "currentCombAngleInDegrees = \(currentCombAngleInDegrees)\n"
                joinedText += "emojiPatternValue = \(lastemojiPatternValue)\n"
                joinedText += "lastCombMode = \(lastCombMode)\n"
                joinedText += "rectangularCombRelativeAngle = \(rectangularCombRelativeAngle)\n"

                readMeTextView.text = joinedText
                
                // send to pasteboard
                UIPasteboard.general.string = joinedText
                                
            }

        }

    }
    
    func clearAllInProgressFlags()
    {
        velocityInProgress = false
        velocityRangeInProgress = false
        spinInProgress = false
        spinRangeInProgress = false
        startingScaleInProgress = false
        endingScaleInProgress = false
        birthRateInProgress = false
        lifetimeInProgress = false
        durationInProgress = false
        X_AccelerationInProgress = false
        Y_AccelerationInProgress = false
        countOfSparksInProgress = false
        combWidthInProgress = false
        combRelativeInProgress = false
        rectangularAngleInProgress = false

    } // ends clearAllInProgressFlags
    
    var velocityInProgress : Bool = true // only 1 is true
    var velocityRangeInProgress : Bool = false
    var spinInProgress : Bool = false
    var spinRangeInProgress : Bool = false
    var startingScaleInProgress : Bool = false
    var endingScaleInProgress : Bool = false
    var lifetimeInProgress : Bool = false
    var durationInProgress : Bool = false
    var X_AccelerationInProgress : Bool = false
    var Y_AccelerationInProgress : Bool = false
    var birthRateInProgress : Bool = false
    var countOfSparksInProgress : Bool = false
    var combWidthInProgress : Bool = false
    var combRelativeInProgress : Bool = false
    var rectangularAngleInProgress : Bool = false
    
    
    var combingTowardsAPointIsEnabled : Bool = false
    var combingInGeneralDirectionEnabled : Bool = false
    var combingInQuadsEnabled : Bool = false

    @objc func generalPurposeSliderHandler(sender: UISlider!)
    {
        anyControlsBreakpoint()
        
        samplesFromSlider += 1
        
        if velocityInProgress
        {
            thisVelocity = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Velocity : %.2f", generalPurposeSlider.value))
        }
        
        if velocityRangeInProgress
        {
            thisVelocityRange = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Velocity Range : %.2f", generalPurposeSlider.value))
        }
        
        if spinInProgress
        {
            thisSpin = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Spin : %.2f", generalPurposeSlider.value))
        }
        
        if spinRangeInProgress
        {
            thisSpinRange = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Spin Range : %.2f", generalPurposeSlider.value))
        }
        
        if startingScaleInProgress
        {
            thisStartingScale = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Starting Scale : %.2f", generalPurposeSlider.value))
        }
        
        if endingScaleInProgress
        {
            thisEndingScale = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Ending Scale : %.2f", generalPurposeSlider.value))
        }
        
        if birthRateInProgress
        {
            thisCellBirthrate = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Birth Rate : %.2f", generalPurposeSlider.value))
        }
        
        if lifetimeInProgress
        {
            thisCellLifetime = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Lifetime : %.2f", generalPurposeSlider.value))
        }
        
        if durationInProgress
        {
            thisExplosionDuration = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Duration : %.2f", generalPurposeSlider.value))
        }
        
        if X_AccelerationInProgress
        {
            thisAccelerationIn_X = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "X Acceleration : %.2f", generalPurposeSlider.value))
        }
        
        if Y_AccelerationInProgress
        {
            thisAccelerationIn_Y = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Y Acceleration : %.2f", generalPurposeSlider.value))
        }
        
        if countOfSparksInProgress
        {
            useThisManyObjectsInExplosions = Int(CGFloat(sender.value))
            
            sliderValueLabel.text = (String(format: "Emitter Count : %.2f", generalPurposeSlider.value))
        }
        
        if combWidthInProgress
        {
            combWidth = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Cone Width Factor : %.2f", generalPurposeSlider.value))
            
            if combingTowardsAPointIsEnabled
            {
                fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
            }
                
            else if combingInGeneralDirectionEnabled
            {
                fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(directionAngleForCellFlow: currentCombAngleInDegrees, coneWideningFactorNormallyZero: combWidth)
            }
            else if combingInQuadsEnabled
            {
                fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                    thisRectangle: tempRect,
                    thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                    combEmittersDesired: true,
                    topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    topConeWideningFactorNormallyZero: combWidth,
                    bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    bottomConeWideningFactorNormallyZero: combWidth,
                    leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    leftConeWideningFactorNormallyZero: combWidth,
                    rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                    rightConeWideningFactorNormallyZero: combWidth)
            }
        }
        
        if combRelativeInProgress
        {
            currentOffsetAngleForCellFlowInDegrees = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Relative Angle : %.2f", generalPurposeSlider.value))
            
            fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
        }
        if rectangularAngleInProgress
        {
            rectangularCombRelativeAngle = CGFloat(sender.value)
            
            sliderValueLabel.text = (String(format: "Rectangular Angle : %.2f", generalPurposeSlider.value))
            
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                thisRectangle: tempRect,
                thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                combEmittersDesired: true,
                topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                topConeWideningFactorNormallyZero: combWidth,
                bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                bottomConeWideningFactorNormallyZero: combWidth,
                leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                leftConeWideningFactorNormallyZero: combWidth,
                rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                rightConeWideningFactorNormallyZero: combWidth)
        }
        
        if samplesFromSlider % 40 == 39
        {
            detonateButton.sendActions(for: .touchUpInside)
        }
        
        if thisStartingScale < 0.01 && thisEndingScale < 0.01
        {
            thisStartingScale = 0.009
            thisEndingScale = 0.009
        }
        
    } // ends generalPurposeSliderHandler
        
    @objc func hideALotOfThingsButtonHandlingAction(sender: UIButton!) {
        
        anyControlsBreakpoint()
        
        hideALotOfThingsButton.alpha = 0
        changeShapeButton.alpha = 1
        switchParameterButton.alpha = 1
        
        fireworksAndExplosionsEngine2.hideAllEmitters()

        if thisIsAnIphone
        {
            parameterTableView.alpha = 0
        }
        else
        {
            if parameterTableView.alpha == 0 || readMeTextView.alpha == 1
            {
                parameterTableView.alpha = 1
                hideALotOfThingsButton.alpha = 1
                hideALotOfThingsButton.frame = CGRect(x: CGFloat(fullScreenX) - hideALotOfThingsButton.frame.width, y: parameterTableView.frame.origin.y + parameterTableView.frame.height, width: 70, height: 70)

                self.parameterTableView.reloadData()
            }
            else
            {
                parameterTableView.alpha = 0
                hideALotOfThingsButton.alpha = 0
            }
        }
        
        sweetSpotsTableView.alpha = 0
        explosionKindTableView.alpha = 0
        readMeTextView.alpha = 0
        
        

    }

    // handlepinch general case
    @objc func generalPinchRecognized(pinch: UIPinchGestureRecognizer)
    {
        anyControlsBreakpoint()
        
        if kindOfExplosion == kindOfExplosionDesired.circle || kindOfExplosion == kindOfExplosionDesired.randomInsideCircleOfRadius
        {
            currentCircleRadius *= pinch.scale
            pinch.scale = 1
            
            detonateButton.sendActions(for: .touchUpInside)
        }
        if kindOfExplosion == kindOfExplosionDesired.heart
        {
            currentHeartRadius *= pinch.scale
            pinch.scale = 1
            
            detonateButton.sendActions(for: .touchUpInside)
        }
        if kindOfExplosion == kindOfExplosionDesired.ellipse
        {
            ellipseScaleFactor *= pinch.scale
            pinch.scale = 1
            
            detonateButton.sendActions(for: .touchUpInside)
        }

    } // ends generalPinchRecognized


    // Detect touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        detonateButton.sendActions(for: .touchUpInside)
        
        let touch = touches.first!
        thisTouchPoint = touch.location(in: self.view)
        
        // Determine new comb angle
        
        // comb them towards the specified point
        let thisDeltaX = Int(thisTouchPoint.x) - halfScreenX
        let thisDeltaY = Int(thisTouchPoint.y) - halfScreenY
        
        currentCombAngleInDegrees = atan2(CGFloat(thisDeltaY), CGFloat(thisDeltaX))
        
        currentCombAngleInDegrees = currentCombAngleInDegrees.radiansToDegrees
                
        if combingTowardsAPointIsEnabled
        {
            fireworksAndExplosionsEngine.combEmittersTowardsOrAwayFromSpecifiedPoint(thisPoint: thisTouchPoint, desiredOffsetAngleForCellFlowInDegrees : currentOffsetAngleForCellFlowInDegrees,  coneWideningFactorNormallyZero: combWidth, thisCountOfEmittersGeneratingSparks : useThisManyObjectsInExplosions)
        }
        
        else if combingInGeneralDirectionEnabled
        {
            fireworksAndExplosionsEngine.combAllEmittersToPointInDesiredDirectionWithDesiredCone(directionAngleForCellFlow: currentCombAngleInDegrees, coneWideningFactorNormallyZero: combWidth)
        }
        else if combingInQuadsEnabled
        {
            fireworksAndExplosionsEngine.placeEmittersOnSpecifiedRectangle(
                thisRectangle: tempRect,
                thisCountOfEmittersGeneratingSparks: useThisManyObjectsInExplosions,
                combEmittersDesired: true,
                topDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                topConeWideningFactorNormallyZero: combWidth,
                bottomDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                bottomConeWideningFactorNormallyZero: combWidth,
                leftDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                leftConeWideningFactorNormallyZero: combWidth,
                rightDesiredCombingRelativeAngle: rectangularCombRelativeAngle,
                rightConeWideningFactorNormallyZero: combWidth)
        }
        else
        {
            fireworksAndExplosionsEngine.stopCombingTheEmitters()
        }
    }

}

