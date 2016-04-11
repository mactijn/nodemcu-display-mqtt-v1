local console = {
    font = require 'font_6x8',
    driver = nil,
    char_width = 6,
    chars_per_line = 21,
    col_offset = 0
}

-- sets character position
function console:pos(col, page)

    col = col % self.chars_per_line
    self.driver:set_column(self.col_offset + (col * self.char_width))
    self.driver:set_page(page % self.driver.pages)
end


function console:clear()
    self:pos(0,0)
	for i=0, self.driver.pages * self.chars_per_line do
	  self:write_char(' ')
	  tmr.wdclr()
	end
    self:pos(0,0)
end


function console:write_char(charname)
    if self.font[charname] == nil then return end
	for i, data in ipairs(self.font[charname]) do self.driver:data(data) end
    tmr.wdclr()
end


function console:write(word)
	for char in word:gmatch('.') do
	  self:write_char(char)
	end
end


function console:alert()
    self.driver:invert(1)
    tmr.alarm(1, 500, tmr.ALARM_SINGLE, function()
        self.driver:invert(0)
    end)
end

function console:init(driver)
    self.chars_per_line = (driver.cols - (driver.cols % self.char_width)) / self.char_width
    self.col_offset = ((128 - driver.cols) + (driver.cols - (self.chars_per_line * self.char_width))) / 2

    print(string.format("console: init chars_per_line=%i col_offset=0x%02X", self.chars_per_line, self.col_offset))

    driver:set_mem_addr_mode(0x00)
    driver:set_column_address(self.col_offset, self.col_offset + (self.chars_per_line * self.char_width) - 1)
    self.driver = driver

    self:pos(0,0)

    print("console: init done")
end


return function(driver)
    console:init(driver)
    return console
end
