require 'muhkuh_cli_init'
local argparse = require 'argparse'

local tParser = argparse('ready_led', 'Switch the ready LED on or off.')
tParser:flag('-o --off')
  :description('Switch the LED off. The default is to switch it on.')
  :default(false)
  :target('fSwitchOff')
tParser:option('-g --gpio')
  :description('Use GPIO with index IDX. The default index is 21.')
  :argname('<IDX>')
  :default(21)
  :convert(tonumber)
  :target('uiGpioIndex')
local tArgs = tParser:parse()

local fGpioValue = not tArgs.fSwitchOff
local uiGpioIndex = tArgs.uiGpioIndex

local GPIO = require('periphery').GPIO
local gpio_out = GPIO(uiGpioIndex, "out")
gpio_out:write(fGpioValue)
gpio_out:close()
