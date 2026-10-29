SinOsc chord[5] => Gain master => dac;
SndBuf hihat => Gain hihatGain => dac;
0.3 => hihatGain.gain;

me.dir() + "audio/hihat_01.wav" => hihat.read;
hihat.samples() => hihat.pos;

100.0 => float bpm;
60.0 / bpm => float beat;

fun void playChord(int root, string quality, float lenght)
{
    0.3 => master.gain;
    Std.mtof(root) => chord[0].freq;
    Std.mtof(root + 7) => chord[2].freq;
    if (quality == "min9")
    {
        Std.mtof(root + 3) => chord[1].freq;
        Std.mtof(root + 10) => chord[3].freq;
        Std.mtof(root + 14) => chord[4].freq;
    }
    else if (quality == "dom13")
    {
        Std.mtof(root + 4) => chord[1].freq;
        Std.mtof(root + 10) => chord[3].freq;
        Std.mtof(root + 21) => chord[4].freq;
    }
    else if (quality == "maj9")
    {
        Std.mtof(root + 4) => chord[1].freq;
        Std.mtof(root + 11) => chord[3].freq;
        Std.mtof(root + 14) => chord[4].freq;
    }
    else if (quality == "dim7")
    {
        Std.mtof(root + 3) => chord[1].freq;
        Std.mtof(root + 6) => chord[2].freq;
        Std.mtof(root + 9) => chord[3].freq;
        Std.mtof(root + 12) => chord[4].freq;
    }
    lenght::second => now;
    0 => master.gain;
}

fun void rest(float lenght)
{
    0.0 => master.gain;
    lenght::second => now;
    0.3 => master.gain;
}

fun void hihatPattern()
{
    while (true)
    {
        0 => hihat.pos;
        (beat * 0.25)::second => now;
    }
}

spork ~ hihatPattern();

while (true)
{
    playChord(62, "min9", beat * 0.25);
    playChord(62, "min9", beat * 0.25);
    //rest(0.01);
    playChord(62, "min9", beat * 0.25);
    rest(0.5);
    playChord(62, "min9", beat * 0.75);
    rest(0.01);
    playChord(62, "min9", beat * 0.25);
    rest(1.0);
    playChord(67, "dom13", beat * 0.75);
    rest(0.01);
    playChord(67, "dom13", beat * 0.25);
    rest(0.5);
    playChord(67, "dom13", beat * 0.75);
    rest(0.01);
    playChord(67, "dom13", beat * 0.25);
    rest(1.0);
    playChord(60, "maj9", beat * 2.0);
    rest(0.01);
    playChord(60, "maj9", beat);
    rest(0.01);
    playChord(61, "dim7", beat);
    rest(0.01);
    playChord(60, "maj9", beat);
}
