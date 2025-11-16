const PI = 3.141592654;
const PI2 = 6.283185307;
const HALF_PI = 1.570796327;
const FOURTH_PI = 0.785398163;
const PI_INV = 0.318309886;

const FIX_POINT_16_SHIFT = 16;
const FIX_POINT_16_MAG = 65536;
const FIX_POINT_DECI_PART_MASK = 0x0000ffff;
const FIX_POINT_WHOLE_PART_MASK = 0xffff0000;
const FIX_POINT_ROUND_UP = 0x00008000;

// Builds a 16-bit color value in 5.5.5 format (1-bit alpha mode).
pub inline fn rgb16bit555(r: u5, g: u5, b: u5) u16 {
    return (b & 31) + (@as(u10, (g & 31)) << 5) + (@as(u15, (r & 31)) << 10);
}

// Build a 16 bit color value in 5.6.5 format (green dominate mode).
pub inline fn rgb16bit565(r: u5, g: u6, b: u5) u16 {
    return (b & 31) + (@as(u11, (g & 63)) << 5) + (@as(u16, (r & 31)) << 11);
}

// Build a 24 bit color value in 8.8.8 format (true color)
pub inline fn rgb24bit(_: u8, r: u8, g: u8, b: u8) u24 {
    return ((b) + (@as(u16, g) << 8) + (@as(u24, r) << 16));
}

// Build a 32 bit color value in 8.8.8.8 format (true color + alpha) ARGB
pub inline fn rgb32bit(a: u8, r: u8, g: u8, b: u8) u32 {
    return ((b) + (@as(u16, g) << 8) + (@as(u24, r) << 16) + (@as(u32, a) << 24));
}

// bit manipulation through bit masking
pub inline fn setBit(word: anytype, bit_flag: @TypeOf(word.*)) void {
    word.* |= bit_flag;
}

pub inline fn resetBit(word: anytype, bit_flag: @TypeOf(word)) void {
    word.* &= ~bit_flag;
}

pub inline fn min(a: anytype, b: @TypeOf(a)) @TypeOf(a) {
    return if (a < b) a else b;
}

pub inline fn max(comptime T: type, a: T, b: T) T {
    return if (a > b) b else a;
}

pub inline fn swap(a: anytype, b: @TypeOf(a), temp: @TypeOf(a)) @TypeOf(a) {
    temp = a;
    a = b;
    b = temp;
}

pub inline fn degToRad(ang: f32) f32 {
    return ang * PI / 180;
}

pub inline fn radToDeg(rads: f32) f32 {
    return rads * 180 / PI;
}
