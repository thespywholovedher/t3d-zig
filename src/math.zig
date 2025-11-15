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
inline fn rgb16bit555(r: u5, g: u5, b: u5) u16 {
    return (b & 31) + (@as(u10, (g & 31)) << 5) + (@as(u15, (r & 31)) << 10);
}

// Build a 16 bit color value in 5.6.5 format (green dominate mode).
inline fn rgb16bit565(r: u5, g: u6, b: u5) u16 {
    return (b & 31) + ((g & 63) << 5) + ((r & 31) << 10);
}

inline fn rgb24bit(_: u8, r: u8, g: u8, b: u8) u24 {
    return ((b) + (@as(u16, g) << 8) + @as(u24, r) << 16);
}

const std = @import("std");

test "rgb to 555 conversion" {
    const red = rgb16bit555(31, 0, 0); // Max Red
    try std.testing.expectEqual(@as(u16, 0b0_11111_00000_00000), red);

    const green = rgb16bit555(0, 31, 0);
    try std.testing.expectEqual(@as(u16, 0b0_00000_11111_00000), green);

    const blue = rgb16bit555(0, 0, 31);
    try std.testing.expectEqual(@as(u16, 0b0_00000_00000_11111), blue);

    const black = rgb16bit555(0, 0, 0);
    try std.testing.expectEqual(@as(u16, 0b0_00000_00000_00000), black);

    const white = rgb16bit555(31, 31, 31);
    try std.testing.expectEqual(@as(u16, 0b0_11111_11111_11111), white);

    const rust_orange = rgb16bit555(22, 8, 1);
    try std.testing.expectEqual(@as(u16, 0b0_10110_01000_00001), rust_orange);
}

test "rgb to 24 bit" {
    const red = rgb24bit(0, 0xFF, 0x00, 0x00);
    try std.testing.expectEqual(@as(u24, 0xFF0000), red);
}
