local ssd1306_i2c = {
    addr = 0x3c,
    cols = 128,
    pages = 8,

    presets = {
        -- cols, pages, display_offset, display_start_line, enable_segment_remap,
        -- com_scan_direction, com_sequential, com_lr_remap, contrast, invert
        wemos_64x48 = { 64, 6, 0, 63, 1, 1, 0, 1, 127, 0 }
    }
}


-- protocol functions

function ssd1306_i2c:write_i2c(reg_addr, reg_val)
	i2c.start(0)
	i2c.address(0, self.addr, i2c.TRANSMITTER)
	i2c.write(0, reg_addr)
    i2c.write(0, reg_val)
	i2c.stop(0)
end


function ssd1306_i2c:command(cmd)
    -- print(string.format("> 0x%02X", cmd))
	self:write_i2c(0x00, cmd)
end


function ssd1306_i2c:data(...)
    for i,data in ipairs{...} do
        self:write_i2c(0x40, data)
    end
end

-- command set


-- Set Lower Column Start Address for Page Addressing Mode (00h~0Fh)
-- Set Higher Column Start Address for Page Addressing Mode (10h~1Fh)
function ssd1306_i2c:set_column(addr)
    local addr_low = bit.band(addr, 0x0f)
    local addr_hi = bit.band(bit.rshift(addr, 4), 0x0f)
    self:command(addr_low)
    self:command(0x10 + addr_hi)
end

-- Set Memory Addressing Mode (20h)
-- mode = 0x00 - Horizontal addressing mode
-- mode = 0x01 - Vertical addressing mode
-- mode = 0x02 - Page addressing mode
function ssd1306_i2c:set_mem_addr_mode(mode)
    mode = bit.band(mode, 0x03)
	self:command(0x20)
	self:command(mode)
end


-- Set Column Address (21h)
function ssd1306_i2c:set_column_address(start_addr, end_addr)
    self:command(0x21)
    self:command(start_addr)
    self:command(end_addr)
end


-- Set Page Address (22h)
function ssd1306_i2c:set_page_address(start_addr, end_addr)
    self:command(0x22)
    self:command(start_addr)
    self:command(end_addr)
end


-- Set Display Start Line (40h~7Fh)
function ssd1306_i2c:set_display_start_line(lineno)
    lineno = bit.band(lineno, 0x3f)
    self:command(0x40 + lineno)
end


-- Set Contrast Control for BANK0 (81h)
function ssd1306_i2c:set_contrast(contrast)
    self:command(0x81)
	self:command(contrast)
end


-- Set Segment Re-map (A0h/A1h)
function ssd1306_i2c:enable_segment_remap(enabled)
    enabled = bit.band(enabled, 0x01)
    if enabled ~= 1 then self:command(0xa0)
    else self:command(0xa1)
    end
end


-- Entire Display ON (A4h/A5h)
function ssd1306_i2c:entire_display_on(enabled)
    enabled = bit.band(enabled, 0x01)
    if enabled == 1 then self:command(0xa4)
    else self:command(0xa5)
    end
end


-- Set Normal/Inverse Display (A6h/A7h)
function ssd1306_i2c:invert(enabled)
    enabled = bit.band(enabled, 0x01)
    if enabled ~= 1 then self:command(0xa6)
    else self:command(0xa7)
    end
end


--  Set Multiplex Ratio (A8h)
function ssd1306_i2c:set_mux_ratio(ratio)
    self:command(0xa8)
    self:command(ratio)
end


-- Set Display ON/OFF (AEh/AFh)
function ssd1306_i2c:enabled(enabled)
    enabled = bit.band(enabled, 0x01)
    if enabled ~= 1 then self:command(0xae)
    else self:command(0xaf)
    end
end


-- Set Page Start Address for Page Addressing Mode (B0h~B7h)
function ssd1306_i2c:set_page(page)
    page = bit.band(page, 0x07)
    self:command(0xb0 + page)
end


-- Set COM Output Scan Direction (C0h/C8h)
function ssd1306_i2c:set_com_scan_direction(direction)
    direction = bit.band(direction, 0x01)
    if direction ~= 1 then self:command(0xc0)
    else self:command(0xc8)
    end
end


-- Set Display Offset (D3h)
function ssd1306_i2c:set_display_offset(offset)
    self:command(0xd3)
    self:command(offset)
end


-- Set Display Clock Divide Ratio/ Oscillator Frequency (D5h)
function ssd1306_i2c:set_oscillator(divide_ratio, freq)
    divide_ratio = bit.band(divide_ratio, 0x0f)
    freq = bit.band(freq, 0x0f)
    self:command(0xd5)
    self:command(divide_ratio + bit.lshift(freq, 4))
end


-- Set Pre-charge Period (D9h)
-- TODO: not implemented


-- Set COM Pins Hardware Configuration (DAh)
function ssd1306_i2c:set_com_hardware_config(sequential, left_right_remap)
    local config = 0x02
    sequential = bit.band(sequential, 0x01)
    left_right_remap = bit.band(left_right_remap, 0x01)
    if sequential ~= 1 then config = config + 0x10 end
    if left_right_remap ~= 1 then config = config + 0x20 end
    self:command(0xda)
	self:command(config)
end


-- Set VCOMH Deselect Level (DBh)
-- TODO: not implemented


-- NOP (E3h)
function ssd1306_i2c:nop()
    self:command(0xe3)
end

function ssd1306_i2c:init_preset(addr, sda, scl, preset)
    local p = self.presets[preset]
    print(string.format("ssd1306_i2c: using preset %s", preset))
    self:init(addr, sda, scl, p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9], p[10])
end


function ssd1306_i2c:init(
    addr, sda, scl, cols, pages, display_offset,
    display_start_line, enable_segment_remap,
    com_scan_direction, com_sequential, com_lr_remap,
    contrast, invert)

    print(string.format("ssd1306_i2c: starting init addr=0x%02X sda=%i scl=%i cols=%i pages=%i", addr, sda, scl, cols, pages))

	self.addr = addr
    self.cols = ((cols - 1) % 128) + 1
    self.pages = ((pages - 1) % 8) + 1

	i2c.setup(0, sda, scl, i2c.SLOW)

    -- initial procedure
    self:set_mux_ratio(pages * 8)
    self:set_display_offset(display_offset)
    self:set_display_start_line(display_start_line)
    self:enable_segment_remap(enable_segment_remap)
    self:set_com_scan_direction(com_scan_direction)
    self:set_com_hardware_config(com_sequential, com_lr_remap)
    self:set_contrast(contrast)
    self:entire_display_on(1)
    self:invert(invert)
    self:set_oscillator(0,8)
	self:command(0x8d) -- set charge pump parameters
	self:command(0x14)
    self:enabled(1)

    local offset = (128 - self.cols) / 2
    self:set_column_address(offset, offset + (self.cols - 1))
    self:set_page_address(0, self.pages - 1)

    -- clear the full screen
    self:set_column(offset)
    self:set_page(0)
    for i=0, self.cols * self.pages do
      self:data(0x00)
      tmr.wdclr()
    end
    self:set_column(offset)
    self:set_page(0)

    print("ssd1306_i2c: init done")
end

return ssd1306_i2c
