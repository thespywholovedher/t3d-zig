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
    return (b & 31) + (@as(u11, (g & 63)) << 5) + (@as(u16, (r & 31)) << 11);
}

// Build a 24 bit color value in 8.8.8 format (true color)
inline fn rgb24bit(_: u8, r: u8, g: u8, b: u8) u24 {
    return ((b) + (@as(u16, g) << 8) + (@as(u24, r) << 16));
}

// Build a 32 bit color value in 8.8.8.8 format (true color + alpha) ARGB
inline fn rgb32bit(a: u8, r: u8, g: u8, b: u8) u32 {
    return ((b) + (@as(u16, g) << 8) + (@as(u24, r) << 16) + (@as(u32, a) << 24));
}

const std = @import("std");

const R_MAX = 31;
const G_555_MAX = 31;
const G_565_MAX = 63;
const B_MAX = 31;

test "rgb to 555 conversion" {
    const red = rgb16bit555(R_MAX, 0, 0); // Max Red
    try std.testing.expectEqual(@as(u16, 0b0_11111_00000_00000), red);

    const green = rgb16bit555(0, G_555_MAX, 0);
    try std.testing.expectEqual(@as(u16, 0b0_00000_11111_00000), green);

    const blue = rgb16bit555(0, 0, B_MAX);
    try std.testing.expectEqual(@as(u16, 0b0_00000_00000_11111), blue);

    const black = rgb16bit555(0, 0, 0);
    try std.testing.expectEqual(@as(u16, 0b0_00000_00000_00000), black);

    const white = rgb16bit555(R_MAX, G_555_MAX, B_MAX);
    try std.testing.expectEqual(@as(u16, 0b0_11111_11111_11111), white);

    const rust_orange = rgb16bit555(22, 8, 1);
    try std.testing.expectEqual(@as(u16, 0b0_10110_01000_00001), rust_orange);
}

test "rgb to 565 conversion" {
    const red = rgb16bit565(R_MAX, 0, 0);
    try std.testing.expectEqual(0b11111_000000_00000, red);

    const green = rgb16bit565(0, G_565_MAX, 0);
    try std.testing.expectEqual(0b00000_111111_00000, green);

    const blue = rgb16bit565(0, 0, B_MAX);
    try std.testing.expectEqual(0b00000_000000_11111, blue);

    const black = rgb16bit555(0, 0, 0);
    try std.testing.expectEqual(0b00000_000000_00000, black);

    const white = rgb16bit565(R_MAX, G_565_MAX, B_MAX);
    try std.testing.expectEqual(0b11111_111111_11111, white);

    const rust_orange = rgb16bit555(22, 8, 1);
    try std.testing.expectEqual(0b01011_001000_00001, rust_orange);
}

test "rgb to 24 bit" {
    const red = rgb24bit(0, 0xFF, 0, 0);
    try std.testing.expectEqual(0xFF0000, red);

    const green = rgb24bit(0, 0, 255, 0);
    try std.testing.expectEqual(0x00FF00, green);

    const blue = rgb24bit(0, 0, 0, 0xFF);
    try std.testing.expectEqual(0x0000FF, blue);

    const black = rgb24bit(0, 0, 0, 0);
    try std.testing.expectEqual(0x000000, black);

    const white = rgb24bit(0, 0xFF, 0xFF, 0xFF);
    try std.testing.expectEqual(0xFFFFFF, white);

    const rust_orange = rgb24bit(0, 0xC4, 0x55, 0x08);
    try std.testing.expectEqual(0xC45508, rust_orange);
}
