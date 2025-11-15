const std = @import("std");
const t3d_zig = @import("t3d_zig");

const sdl3 = @import("sdl3");
const Window = sdl3.video.Window;

const fps = 60;
const window_title = "All your codebase are belong to us.";
const window_width = 640;
const window_height = 480;

fn createWindow() !*Window {
    return try Window.init(window_title, window_width, window_height);
}

fn closeWindow(window: *Window) !void {
    window.deinit();
}

fn gameInit(init_flags: sdl3.InitFlags) !void {
    try sdl3.init(init_flags);
}

fn gameLoop() void {}

fn gameShutdown(init_flags: sdl3.InitFlags) void {
    sdl3.shutdown();
    sdl3.quit(init_flags);
}

pub fn main() !void {
    const init_flags = sdl3.InitFlags{ .video = true };

    try gameInit(init_flags);
    defer gameShutdown(init_flags);
    const window = try sdl3.video.Window.init("All you codebase are belong to us.", window_width, window_height, .{});
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
                .key_down => {
                    const keyName = sdl3.keyboard.getKeyName(event.key_down.key.?) orelse "Unknown Key";
                    std.debug.print("{s}", .{keyName});
                },
                else => {},
            };

        gameLoop();
    }

    // Prints to stderr, ignoring potential errors.
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
    try t3d_zig.bufferedPrint();
}
