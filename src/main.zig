const std = @import("std");
const t3d_zig = @import("t3d_zig");

const sdl3 = @import("sdl3");

const fps = 60;
const screen_width = 640;
const screen_height = 480;

pub fn main() !void {
    defer sdl3.shutdown();

    const init_flags = sdl3.InitFlags{ .video = true };
    try sdl3.init(init_flags);
    defer sdl3.quit(init_flags);

    const window = try sdl3.video.Window.init("All you codebase are belong to us.", screen_width, screen_height, .{});
    defer window.deinit();

    var fps_cap = sdl3.extras.FramerateCapper(f32){ .mode = .{ .limited = fps } };

    var quit = false;

    while (!quit) {
        const dt = fps_cap.delay();
        _ = dt;

        const surface = try window.getSurface();
        try surface.fillRect(null, surface.mapRgb(128, 30, 255));
        try window.updateSurface();

        while (sdl3.events.poll()) |event|
            switch (event) {
                .quit => quit = true,
                .terminating => quit = true,
                else => {},
            };
    }

    // Prints to stderr, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    try t3d_zig.bufferedPrint();
}
