
Touching the screen will cause a new detonation, or just wait for the next one to occur.

Use the slider to change parameters to tailor the explosion properties.  You can generate code that should easily compile at any time.

Switch parameters and try changing the acceleration, lifetime, scales, combing methods, etc.Sample

There is a spreading cone that is defined for each method of combing.  You can control how wide that cone is, and which direction it points. In some modes, the cone for each emitter gets pointed away from a specified point.  If the emitter shape configuration shows a circle then placing the relative point at the center of the circle causes each cone to point away from the center. That is highly artistic.  Similar, this works for points inside of rectangle, heart, and ellipse shapes.

While combing, make it a point to touch near the shape borders, corners, inside, and outside.

Note that when you select to comb towards a point or away from a point, we zero out any X and Y accelerations to avoid initial confusion.  You can add in X and Y acceleration again if desired.

When you have tailored an effect as desired, just press the Generate Code button.  You will be able to view and scroll through the generated code immediately.  But the really cool thing is that the generated code is immediately available in the Pasteboard.   To get the code to your development computer, just paste it into a text to yourself, or email it, etc.

Even though you can choose shapes and emoji patterns in FindFirework, code is not generated for setting the emoji pattern or choosing the shape.   Choosing those things will almost surely be tailored by a developer for specific use cases.  Code for those things are easy enough to glean from the readme.

There are saved configurations to start from if desired.  Press the Sweet Spots button to see a list.

You should be running the FindFirework app on an iPad as we didn't tailor it for the iPhone.

A pinch will change some of the shape sizes.

One fun thing about using this Swift Package is that you get to call  an API named “detonate” 🧨 🤯 🥳

Press the samples button to see how we quickly coupled some effects to this apps own objects on the screen.  We even used our own code generation tool to develop that sample code.

These effect can help users quickly notice certain areas of the screen.  The effects work well when transitioning something into view, or out of view.  Or these effects can highlight borders on the screen for fun effects, and for as long as desired. For example, try pressing our Sample button and particularly notice the effect when you press Sample 5.  The slider border at the bottom is highlighted with some flame like effects.  Those flames will last forever, or until you do something else.  Those flames can be any combination of colored emoji, of any size, and they can last a short time or a long time.

Eventually, you might search https://github.com/MichaelKucinski to see if there are any other Swift Packages the FindFireworks tool plays well with.
