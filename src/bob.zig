const state = enum { alive, dying, anim_done };

const maxFrames = 64;
const maxAnimations = 16;

const attributes = enum {
    single_frame,
    multi_frame,
    multi_anim,
    anim_one_shot,
    visible,
    bounce,
    wraparound,
    loaded,
    clone,
};
