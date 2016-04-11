local char = {}
-- 8x6 charset
char[' '] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 }
char['!'] = { 0x00, 0x00, 0x2f, 0x00, 0x00, 0x00 }
char['"'] = { 0x00, 0x07, 0x00, 0x07, 0x00, 0x00 }
char['#'] = { 0x14, 0x7f, 0x14, 0x7f, 0x14, 0x00 }
char['$'] = { 0x24, 0x2a, 0x7f, 0x2a, 0x12, 0x00 }
char['%'] = { 0xc4, 0xc8, 0x10, 0x26, 0x46, 0x00 }
char['&'] = { 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 }
char['\''] = { 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 }
char['('] = { 0x00, 0x1c, 0x22, 0x41, 0x00, 0x00 }
char[')'] = { 0x00, 0x41, 0x22, 0x1c, 0x00, 0x00 }
char['*'] = { 0x14, 0x08, 0x3E, 0x08, 0x14, 0x00 }
char['+'] = { 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 }
char[','] = { 0x00, 0x00, 0x50, 0x30, 0x00, 0x00 }
char['-'] = { 0x10, 0x10, 0x10, 0x10, 0x10, 0x00 }
char['.'] = { 0x00, 0x60, 0x60, 0x00, 0x00, 0x00 }
char['/'] = { 0x20, 0x10, 0x08, 0x04, 0x02, 0x00 }
char['0'] = { 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 }
char['1'] = { 0x00, 0x42, 0x7F, 0x40, 0x00, 0x00 }
char['2'] = { 0x42, 0x61, 0x51, 0x49, 0x46, 0x00 }
char['3'] = { 0x21, 0x41, 0x45, 0x4B, 0x31, 0x00 }
char['4'] = { 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 }
char['5'] = { 0x27, 0x45, 0x45, 0x45, 0x39, 0x00 }
char['6'] = { 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 }
char['7'] = { 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 }
char['8'] = { 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 }
char['9'] = { 0x06, 0x49, 0x49, 0x29, 0x1E, 0x00 }
char[':'] = { 0x00, 0x36, 0x36, 0x00, 0x00, 0x00 }
char[';'] = { 0x00, 0x56, 0x36, 0x00, 0x00, 0x00 }
char['<'] = { 0x08, 0x14, 0x22, 0x41, 0x00, 0x00 }
char['='] = { 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 }
char['>'] = { 0x00, 0x41, 0x22, 0x14, 0x08, 0x00 }
char['?'] = { 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 }
char['@'] = { 0x32, 0x49, 0x59, 0x51, 0x3E, 0x00 }
char['A'] = { 0x7E, 0x11, 0x11, 0x11, 0x7E, 0x00 }
char['B'] = { 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 }
char['C'] = { 0x3E, 0x41, 0x41, 0x41, 0x22, 0x00 }
char['D'] = { 0x7F, 0x41, 0x41, 0x22, 0x1C, 0x00 }
char['E'] = { 0x7F, 0x49, 0x49, 0x49, 0x41, 0x00 }
char['F'] = { 0x7F, 0x09, 0x09, 0x09, 0x01, 0x00 }
char['G'] = { 0x3E, 0x41, 0x49, 0x49, 0x7A, 0x00 }
char['H'] = { 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 }
char['I'] = { 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 }
char['J'] = { 0x20, 0x40, 0x41, 0x3F, 0x01, 0x00 }
char['K'] = { 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 }
char['L'] = { 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 }
char['M'] = { 0x7F, 0x02, 0x0C, 0x02, 0x7F, 0x00 }
char['N'] = { 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 }
char['O'] = { 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 }
char['P'] = { 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 }
char['Q'] = { 0x3E, 0x41, 0x51, 0x21, 0x5E, 0x00 }
char['R'] = { 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 }
char['S'] = { 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 }
char['T'] = { 0x01, 0x01, 0x7F, 0x01, 0x01, 0x00 }
char['U'] = { 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 }
char['V'] = { 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 }
char['W'] = { 0x3F, 0x40, 0x38, 0x40, 0x3F, 0x00 }
char['X'] = { 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 }
char['Y'] = { 0x07, 0x08, 0x70, 0x08, 0x07, 0x00 }
char['Z'] = { 0x61, 0x51, 0x49, 0x45, 0x43, 0x00 }
char['['] = { 0x00, 0x7F, 0x41, 0x41, 0x00, 0x00 }
char['\\'] = { 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 }
char[']'] = { 0x00, 0x41, 0x41, 0x7f, 0x00, 0x00 }
char['^'] = { 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 }
char['_'] = { 0x40, 0x40, 0x40, 0x40, 0x40, 0x00 }
char['a'] = { 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 }
char['b'] = { 0x7F, 0x48, 0x44, 0x44, 0x38, 0x00 }
char['c'] = { 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 }
char['d'] = { 0x38, 0x44, 0x44, 0x48, 0x7F, 0x00 }
char['e'] = { 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 }
char['f'] = { 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 }
char['g'] = { 0x0C, 0x52, 0x52, 0x52, 0x3E, 0x00 }
char['h'] = { 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 }
char['i'] = { 0x00, 0x44, 0x7D, 0x40, 0x00, 0x00 }
char['j'] = { 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 }
char['k'] = { 0x7F, 0x10, 0x28, 0x44, 0x00, 0x00 }
char['l'] = { 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 }
char['m'] = { 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 }
char['n'] = { 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 }
char['o'] = { 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 }
char['p'] = { 0x7C, 0x14, 0x14, 0x14, 0x08, 0x00 }
char['q'] = { 0x08, 0x14, 0x14, 0x18, 0x7C, 0x00 }
char['r'] = { 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 }
char['s'] = { 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 }
char['t'] = { 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 }
char['u'] = { 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 }
char['v'] = { 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 }
char['w'] = { 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 }
char['x'] = { 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 }
char['y'] = { 0x0C, 0x50, 0x50, 0x50, 0x3C, 0x00 }
char['z'] = { 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 }
char['{'] = { 0x00, 0x08, 0x36, 0x41, 0x00, 0x00 }
char['|'] = { 0xFE, 0xCA, 0x0E, 0xFA, 0xCE, 0x00 }
char['}'] = { 0x00, 0x41, 0x36, 0x08, 0x00, 0x00 }
char['~'] = { 0x70, 0xFF, 0xB1, 0xFF, 0x70, 0x00 }

return char