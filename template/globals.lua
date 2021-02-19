--------------------------------------------------------------------------------
-- 
--------------------------------------------------------------------------------


-- Standard tempo divisions (of a beat in 4/4 meter)
-- whole, half, quarter (one beat), eighth, eighth triplet, sixteenth, 
-- sixteenth triplet, etc...

BEAT_WHOLE 		= 4					-- top of time sig
BEAT_HALF 		= BEAT_WHOLE / 2
BEAT 			= BEAT_WHOLE / 4	-- bottom of time sig
BEAT_8 			= BEAT_WHOLE / 8
BEAT_8T 		= BEAT_WHOLE / 12
BEAT_16 		= BEAT_WHOLE / 16
BEAT_16T 		= BEAT_WHOLE / 24
BEAT_32 		= BEAT_WHOLE / 32
BEAT_64 		= BEAT_WHOLE / 64
BEAT_128 		= BEAT_WHOLE / 128
BEAT_D 			= BEAT + BEAT_8
BEAT_8D 		= BEAT_8 + BEAT_16

-- Timing values (defined as defaults to be overwritten)

BPM 			= 120
MSPB 			= 500
MSPBS			= 125









