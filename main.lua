-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- 示範如何在App中顯示Popup Webview
-- Author: Zack Lin
-- Time: 2015/3/16

_SCREEN = {
	WIDTH = display.viewableContentWidth,
	HEIGHT = display.viewableContentHeight
}

_SCREEN.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}

local widget = require( "widget" )
display.setStatusBar( display.HiddenStatusBar )

--==============================================================================
--顯示UI
--==============================================================================
local background = display.newImageRect(  "background.png", 320, 480 )
background.x = _SCREEN.CENTER.X
background.y = _SCREEN.CENTER.Y

local logo = display.newImage( "logo.png",20 , 20)
logo.anchorX = 0
logo.anchorY = 0

local bottomBar = display.newImage( "bottomBar.png" , 0 , 436)
bottomBar.anchorX =0
bottomBar.anchorY = 0
bottomBar.isVisible = false

local closeBtn = display.newImage( "backButton.png" , 286 , 448 )
closeBtn.anchorX = 0
closeBtn.anchorY = 0
closeBtn.isVisible = false

local myButton = widget.newButton{
	left = _SCREEN.CENTER.X - 100,
	top = _SCREEN.CENTER.Y - 50,
	width = 200,
	height = 100,
	label = "Open WebPage",
}

--==============================================================================
--宣告事件偵聽器
--==============================================================================

local options = {
	--背景是否為不透明
	hasBackground = false,
	--是否支援Android裝置的Back鍵關閉
	autoCancel = true,
}

local function  handleButtonEvent( evt )
	local phase = evt.phase
	if "ended" == phase then
		local url = "http://www.gamer.com.tw"
		--顯示跳出式的WebView視窗，參數分別為x,y,width,height,網址,以及參數
		local webView = native.showWebPopup( 0 , 0 , 320 , 436 , url ,options)
		bottomBar.isVisible = true
		closeBtn.isVisible = true
	end
end

function  closeBtn:tap( evt )
	bottomBar.isVisible = false
	closeBtn.isVisible = false
	native.cancelWebPopup()
end

--==============================================================================
--將UI加入偵聽器
--==============================================================================

myButton:addEventListener( "touch", handleButtonEvent )
closeBtn:addEventListener( "tap", closeBtn )