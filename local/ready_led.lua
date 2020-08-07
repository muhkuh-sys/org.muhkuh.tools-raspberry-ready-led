local argparse = require 'argparse'
local socket = require 'socket'

local tParser = argparse('ready_led', 'Switch the ready LED on or off.')
tParser:flag('-o --off')
  :description('Switch the LED off. The default is to switch it on.')
  :default(false)
  :target('fSwitchOff')
tParser:option('-c --chip')
  :description('Use the GPIO with CHIP_ID. The default is /dev/gpiochip0 .')
  :argname('<CHIP_ID>')
  :default('/dev/gpiochip0')
  :target('strGpioChip')
tParser:option('-g --gpio')
  :description('Use GPIO with index IDX. The default index is 21.')
  :argname('<IDX>')
  :default(21)
  :convert(tonumber)
  :target('uiGpioIndex')
local tArgs = tParser:parse()

-- Invert the fSwitchOff value to get the GPIO value.
local fGpioValue = not tArgs.fSwitchOff

local GPIO = require('periphery').GPIO
local gpio_out = GPIO(tArgs.strGpioChip, tArgs.uiGpioIndex, "out")
gpio_out:write(fGpioValue)

-- Wait for a signal.
local function fnEndless()
  while true do
    socket.sleep(3600)
  end
end
pcall(fnEndless)

-- Looks like this will not be reached anymore.
gpio_out:close()
