local mod_path = "" .. SMODS.current_mod.path

if not Mesmalatro then -- cryptid did it, so can i
	Mesmalatro = {}
end

Mesmalatro.mod_path = mod_path

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
    post_trigger = true,
}

SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 34,
	py = 34
})

assert(SMODS.load_file('credits.lua'))()
assert(SMODS.load_file('content/jokers.lua'))()
assert(SMODS.load_file('content/editions.lua'))()
