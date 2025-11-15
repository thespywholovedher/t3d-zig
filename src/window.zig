const sdl3 = @import("sdl3");
const window = sdl3.video.Window;

const max_colors_palette = 256;

const screenMode = enum { fullscreen, windowed };

const bitmap_id = 0x4D24;

const bitmapState = enum {
    dead,
    alive,
    dying,
};

const bitmapAttrLoaded = 128;

const bitmapExtractMode = enum {
    cell,
    abs,
};

const bitmap = struct {};

const pixelFormat = enum(u8) {
    b8 = 8,
    b555 = 15,
    b565 = 16,
    b888 = 24,
    bA888 = 32,
};

const blitState = enum { dead, alive, dying, anim_done };

const Window = struct {
    screen_height: u16,
    screen_width: u16,
    screen_bpp: u4,

    screen_mode: screenMode,
};
