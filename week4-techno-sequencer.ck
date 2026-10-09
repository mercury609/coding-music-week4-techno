// Coding Music Fundamentals - Week 4 Session 3
// Techno sequencer using SndBuf and the modulo operator
// Requires the course-provided audio/ folder next to this file:
//   me.dir() + "audio/kick.wav"
//   me.dir() + "audio/snare.wav"
//   me.dir() + "audio/hihat.wav"

SndBuf kick => Gain master => dac;
SndBuf snare => master;
SndBuf hihat => master;

me.dir() + "audio/kick.wav" => kick.read;
me.dir() + "audio/snare.wav" => snare.read;
me.dir() + "audio/hihat.wav" => hihat.read;

// park play heads at the end so nothing plays immediately
kick.samples() => kick.pos;
snare.samples() => snare.pos;
hihat.samples() => hihat.pos;

0 => int counter;

while (true)
{
    counter % 8 => int beat;

    // kick on beats 0 and 4
    if (beat == 0 || beat == 4)
    {
        0 => kick.pos;
    }

    // snare on beat 2, slight random rate
    if (beat == 2)
    {
        Math.random2f(0.9, 1.1) => snare.rate;
        0 => snare.pos;
    }

    // accelerating snare fill on beat 6
    if (beat == 6)
    {
        for (0 => int i; i < 4; i++)
        {
            Math.random2f(0.9, 1.1) => snare.rate;
            0 => snare.pos;
            (120 - i * 25)::ms => now;
        }
    }

    // reversed hihat on beat 7: play head at the end, negative rate
    if (beat == 7)
    {
        hihat.samples() => hihat.pos;
        -1.0 * Math.random2f(0.9, 1.1) => hihat.rate;
    }

    250::ms => now;
    counter++;
}
