SMODS.Edition({
	key = "augmented",
	weight = 0, -- does not naturally occur
	shader = false,
	in_shop = false, -- does NOT naturally occur!!!
	extra_cost = 7,
	
	get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
	
	config = { retriggers = 1 },
	
	loc_vars = function(self, info_queue, center)
		return { vars = { self.config.retriggers } }
	end,
	
	calculate = function(self, card, context)
		if
			context.other_card == card
			and (
				(context.repetition and context.cardarea == G.play)
				or (context.retrigger_joker_check and not context.retrigger_joker)
			)
		then
			return {
				message = localize("k_again_ex"),
				repetitions = self.config.retriggers,
				card = card,
			}
		end
	end,
})