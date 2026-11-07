Mesmalatro.Credits = {}

function Mesmalatro.Credits.gen_credit_string(credit)
	local credit_string = {n=G.UIT.R, config={align = 'tm'}, nodes={
		{n=G.UIT.R, config={align='cm', padding = 0.05}, nodes={{n=G.UIT.T, config={text = 'Art by '..credit, shadow = true, colour = G.C.UI.TEXT_LIGHT, scale = 0.25}}}}
	}}
	return credit_string
end

local Mesmalatro_create_mod_badges = SMODS.create_mod_badges
function SMODS.create_mod_badges(obj, badges)
	Mesmalatro_create_mod_badges(obj, badges)
	
	if obj and obj.artist then
		local str = Mesmalatro.Credits.gen_credit_string(obj.artist)
		table.insert(badges, str)
	end
end