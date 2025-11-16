const std = @import("std");
const math = @import("math.zig");
const rgb16bit555 = math.rgb16bit555;
const rgb16bit565 = math.rgb16bit565;
const rgb24bit = math.rgb24bit;

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
