SMODS.Atlas({
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95,
})

--[[ template joker
SMODS.Joker{ 
	key = "template",
	name = "Template",
	rarity = 1,
	cost = 4,
	
	atlas = "jokers",
	pos = {x = 0, y = 0},
	
	discovered = true,
	
	config = { extra = {  } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	
	calculate = function(self, card, context)
		
	end,
	
	attributes = {  }
}
]]--

-- == COMMONS == --

SMODS.Joker{
	key = "vial",
	name = "Vial",
	rarity = 1,
	cost = 4,
	
	atlas = "jokers",
	pos = {x = 1, y = 0},
	
	artist = "imiam_idiot",
	
	discovered = true,
	
	config = { extra = { mult = 0, mult_gain = 10 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.mult ~= 0 then
			return {
                mult = card.ability.extra.mult
			}
		end
		
		if context.remove_playing_cards and not context.blueprint then
			if context.removed then
				for k,v in pairs(context.removed) do
					if v.config.center.key == "m_glass" then
						SMODS.scale_card(card, {
							ref_table = card.ability.extra,
							ref_value = "mult",
							scalar_value = "mult_gain",
						})
					end
				end
			end
		end
	end,
	
	attributes = { "mult", "scaling", "enhancements" }
}

SMODS.Joker{
	key = "sleeping_witch",
	name = "Sleeping Witch",
	rarity = 1,
	cost = 6,
	
	atlas = "jokers",
	pos = {x = 2, y = 0},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { mult = 0, mult_gain = 6, wake_interval = 6, cur_round = 0 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.wake_interval } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
                mult = card.ability.extra.mult
			}
		end
		
		if context.initial_scoring_step and not context.blueprint then
			card.ability.extra.cur_round = card.ability.extra.cur_round + 1
			if card.ability.extra.cur_round >= card.ability.extra.wake_interval then
				card.ability.extra.mult = -6
				return {
					message = "I SEE YOU!", -- TODO: localize these
					colour = G.C.RED
				}
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "mult_gain",
					scaling_message = {
						message = "Sleeping...",
						colour = G.C.FILTER
					}
				})
			end
		end
		
		if context.after then
			if card.ability.extra.mult == -6 then
				card.ability.extra.mult = 0
				card.ability.extra.cur_round = 0
			end
		end
	end,
	
	attributes = { "mult", "scaling", "reset" }
}

SMODS.Joker{
	key = "doll_eyes",
	name = "Doll's Eyes",
	rarity = 1,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 4, y = 0},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { mult = 20, active = false, checked = false, text = "Inactive" } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.text } }
	end,
	
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.discards_used == 0 end
			juice_card_until(card, eval, true)
		end
		
		if context.pre_discard and not context.blueprint and not card.ability.extra.active and not card.ability.extra.checked then
			card.ability.extra.checked = true
			
			for k,v in pairs(context.full_hand) do
				if v.ability.effect ~= "Base" then
					card.ability.extra.active = true
					card.ability.extra.text = "Active"
					
					return {
						message = 'Active!', -- TODO: find general localize string for this
						colour = G.C.FILTER,
					}
				end
			end
		end
		
		if context.joker_main and card.ability.extra.active then
			return {
                mult = card.ability.extra.mult
			}
		end
		
		if context.end_of_round and context.main_eval then
			card.ability.extra.checked = false
			card.ability.extra.active = false
			card.ability.extra.text = "Inactive"
		end
	end,
	
	attributes = { "mult", "discard" }
}

SMODS.Joker{ 
	key = "pathetic_flames",
	name = "Pathetic Flames",
	rarity = 1,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 1, y = 1},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { chips = 0, chips_bonus = 20, max_hand_level = 1, } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips, card.ability.extra.chips_bonus, card.ability.extra.max_hand_level } }
	end,
	
	calculate = function(self, card, context)
		if context.before and not context.blueprint and G.GAME.hands[context.scoring_name].level <= card.ability.extra.max_hand_level then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "chips",
				scalar_value = "chips_bonus",
				scaling_message = {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			})
		end
		if context.joker_main then
			if card.ability.extra.chips ~= 0 then
				return {
					chips = card.ability.extra.chips
				}
			end
		end
	end,
	
	attributes = { "chips", "scaling" }
}

SMODS.Joker{ 
	key = "dense_theory_book",
	name = "Dense Theory Book",
	rarity = 1,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 0, y = 1},
	
	discovered = true,
	
	blueprint_compat = false,
	
	artist = "imiam_idiot",
	
	config = { extra = { scales = 0, threshold = 7, scaling_gain = 1 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.scales, card.ability.extra.threshold } }
	end,
	
	calculate = function(self, card, context)
		if context.scaling_card then
			if context.card ~= card then -- if not theory book
				if context.scalar > 0 then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "scales",
						scalar_value = "scaling_gain",
					})
					
					if card.ability.extra.scales >= card.ability.extra.threshold then
						--sendDebugMessage("theory threshold reached", "MesmaDebug") -- im losing my motherfuckin mind
						card.ability.extra.scales = 0
						
						G.E_MANAGER:add_event(Event({
							func = function()
								--sendDebugMessage("event beginning", "MesmaDebug")
								if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
									--sendDebugMessage("spot open, creating consumable", "MesmaDebug")
									card.ability.extra.scales = 0 -- why does this not reset mid trigger
									
									G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
								
									local new_card = SMODS.create_card( { set = "Spectral" } )
									new_card:add_to_deck()
									G.consumeables:emplace(new_card)
									--sendDebugMessage("created consumable", "MesmaDebug")
								
									G.GAME.consumeable_buffer = 0
									--sendDebugMessage("buffer cleared", "MesmaDebug")
									
									return { -- NOTE TO SELF: event functions NEED to return shit otherwise they loop infinitely
										message = localize('k_reset'), -- i blame localthunk
										colour = G.C.RED,
									}
								end
							end,
						}))
					end
				end
			end
		end
	end,
	
	attributes = { "scaling", "generation", "spectral" }
}

SMODS.Joker{ 
	key = "squash",
	name = "Squash",
	rarity = 1,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 3, y = 0},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	blueprint_compat = false,
	
	config = { extra = { bonus = 2 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.bonus } }
	end,
	
	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint then
			SMODS.scale_card(card, {
				ref_table = card.ability,
				ref_value = "extra_value",
				scalar_table = card.ability.extra,
				scalar_value = "bonus",
				scaling_message = {
					message = localize("k_val_up"),
					colour = G.C.MONEY,
				}
			})
			card:set_cost()
		end
	end,
	
	attributes = { "food", "sell_value", "scaling", "economy", "consumable" }
}

SMODS.Joker{ 
	key = "covered_mirror",
	name = "Covered Mirror",
	rarity = 1,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 2, y = 1},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { mult = 2, count = 0 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.count * card.ability.extra.mult } }
	end,
	
	calculate = function(self, card, context)
		if context.discard and not context.blueprint then
			if context.other_card:is_face() then
				card.ability.extra.count = card.ability.extra.count + 1
				
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS
				}
			end
		end
		
		if context.joker_main and card.ability.extra.count ~= 0 then
			return {
				mult = card.ability.extra.mult * card.ability.extra.count
			}
		end
		
		if context.end_of_round and context.main_eval and not context.blueprint then
			card.ability.extra.count = 0
			
			return {
				message = localize('k_reset'),
				colour = G.C.RED,
			}
		end
	end,
	
	attributes = { "mult", "discard", "face" }
}

SMODS.Joker{ 
	key = "piano",
	name = "Piano",
	rarity = 1,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 0, y = 5},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { mult = 3, count = 0 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult * card.ability.extra.count } }
	end,
	
	update = function(self, card, front)
		if G.STAGE == G.STAGES.RUN and G.hand then
			card.ability.extra.count = 0
			for _, v in ipairs(G.hand.cards) do
				if v.debuff then
					card.ability.extra.count = card.ability.extra.count + 1
				end
			end
		end
	end,
	
	calculate = function(self, card, context)
		if context.joker_main and card.ability.extra.count ~= 0 then
			return {
				mult = card.ability.extra.mult * card.ability.extra.count
			}
		end
	end,
	
	attributes = { "mult", "debuff", "hands" }
}

-- == UNCOMMONS == --

SMODS.Joker{ 
	key = "buddy",
	name = "'Buddy'",
	rarity = 2,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 3, y = 1},
	soul_pos = {x = 4, y = 1},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { max_hand_level = 1, created = false } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_hand_level } }
	end,
	
	calculate = function(self, card, context)
		if context.before and G.GAME.hands[context.scoring_name].level <= card.ability.extra.max_hand_level and not card.ability.extra.created then
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							
						local new_card = SMODS.create_card( { set = "Tarot" } )
						new_card:add_to_deck()
						G.consumeables:emplace(new_card)
							
						G.GAME.consumeable_buffer = 0
						
						card.ability.extra.created = true
		
						return true
					end
				end,
			}))
		end
		
		if context.end_of_round and context.main_eval then
			card.ability.extra.created = false
		end
	end,
	
	attributes = { "generation", "tarot" }
}

SMODS.Joker{
	key = "little_birdie",
	name = "Little Birdie",
	rarity = 2,
	cost = 6,
	
	atlas = "jokers",
	pos = {x = 0, y = 2},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { money = 2, money_gain = 2, money_start = 2 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.money, card.ability.extra.money_gain } }
	end,
	
	calculate = function(self, card, context)
		if context.modify_final_cashout then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "money",
				scalar_value = "money_gain",
			})
		end
		
		if context.selling_card and context.card.ability.set == "Joker" then
			card.ability.extra.money = card.ability.extra.money_start
			
			return {
				message = localize('k_reset'),
				colour = G.C.RED,
			}
		end
	end,
	
	calc_dollar_bonus = function(self, card)
		local bonus = card.ability.extra.money
		if bonus > 0 then return bonus end
	end,
	
	attributes = { "scaling", "economy", "reset" }
}

SMODS.Joker{
	key = "a_doe",
	name = "A Doe",
	rarity = 2,
	cost = 6,
	
	atlas = "jokers",
	pos = {x = 4, y = 2},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { xmult = 2 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	
	calculate = function(self, card, context)
		if context.final_scoring_step then
			if SMODS.calculate_round_score() < G.GAME.blind.chips * 0.5 then -- that worked?
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end
	end,
	
	attributes = { "xmult" }
}

SMODS.Joker{ 
	key = "giant_dolls_eyes",
	name = "Giant Doll's Eyes",
	rarity = 2,
	cost = 7,
	
	atlas = "jokers",
	pos = {x = 1, y = 2},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { xchips = 1, xchips_gain = 0.2, count = 0 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xchips, card.ability.extra.xchips_gain } }
	end,
	
	calculate = function(self, card, context)
		if context.before and not context.blueprint then
			local proc = false
			
			for k, v in pairs(context.scoring_hand) do
				if v.config.center ~= G.P_CENTERS.c_base or v.edition then
					proc = true
				end
			end
			
			if proc then
				card.ability.extra.xchips = 1
			
				return {
					message = localize('k_reset'),
					colour = G.C.RED,
				}
			else
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xchips",
					scalar_value = "xchips_gain",
					scaling_message = {
						message = localize('k_upgrade_ex'),
						colour = G.C.CHIPS
					}
				})
			end
		end
		
		if context.joker_main then
			if card.ability.extra.xchips ~= 1 then
				return {
					xchips = card.ability.extra.xchips
				}
			end
		end
	end,
	
	attributes = { "xchips", "scaling", "enhancements", "editions" }
}

SMODS.Joker{ 
	key = "squash_tree",
	name = "The Squash Tree",
	rarity = 2,
	cost = 6,
	
	atlas = "jokers",
	pos = {x = 0, y = 3},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { bought = false } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	
	calculate = function(self, card, context)
		if context.starting_shop then
			card.ability.extra.bought = false
		end
		
		if context.buying_card then
			card.ability.extra.bought = true
		end
		
		if context.ending_shop and not card.ability.extra.bought then
			G.E_MANAGER:add_event(Event({
				func = function()
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							
						local new_card = SMODS.create_card( { set = "Tarot" } )
						new_card:add_to_deck()
						G.consumeables:emplace(new_card)
							
						G.GAME.consumeable_buffer = 0
		
						return true
					end
				end,
			}))
		end
	end,
	
	attributes = { "generation", "tarot", "shop" }
}

SMODS.Joker{ 
	key = "ritual_concoction",
	name = "Ritual Concoction",
	rarity = 2,
	cost = 6,
	
	atlas = "jokers",
	pos = {x = 2, y = 2},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { cur_score = 0, active = false } },
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = false,
	
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS.e_mesm_augmented
		return { vars = { card.ability.extra.cur_score } }
	end,
	
	calculate = function(self, card, context)
		if context.setting_blind and not context.blueprint then
			if G.jokers and G.jokers.cards then
				local target = G.jokers.cards[#G.jokers.cards]
				if target.debuff or target.config.center.key == self.key then
					G.E_MANAGER:add_event(Event({
						func = function()
							card:start_dissolve()
							return true
						end,
					}))
				else
					SMODS.debuff_card(target, true, "ritual_debuff")
					target:set_edition("e_mesm_augmented")
				end
			end
		end
		
		if context.end_of_round and context.main_eval then
			if card.ability.extra.cur_score < 3 then
				card.ability.extra.cur_score = card.ability.extra.cur_score + 1
				if card.ability.extra.cur_score >= 3 and not card.ability.extra.active then
					card.ability.extra.active = true -- so it doesnt get spammed
					local eval = function()
						return not card.REMOVED
					end
					juice_card_until(card, eval, true)
				end
			else
				if not card.ability.extra.active then
					card.ability.extra.active = true -- so it doesnt get spammed
					local eval = function()
						return not card.REMOVED
					end
					juice_card_until(card, eval, true)
				end
			end
		end
		
		if context.selling_self and card.ability.extra.cur_score >= 3 and G.jokers and G.jokers.cards then
			for k, v in pairs(G.jokers.cards) do
				if v.ability.debuff_sources and v.ability.debuff_sources["ritual_debuff"] then
					SMODS.debuff_card(v, false, "ritual_debuff")
				end
			end
		end
	end,
	
	attributes = { "position", "joker", "debuff", "edition" }
}

SMODS.Joker{ 
	key = "mural",
	name = "Mural",
	rarity = 2,
	cost = 7,
	
	atlas = "jokers",
	pos = {x = 3, y = 2},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { xmult = 1} },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult } }
	end,
	
	calculate = function(self, card, context)
		if context.joker_main then
			local faces = {}
			local faceCount = 0
			
			for k,v in pairs(context.full_hand) do
				if v:is_face() and not faces[v:get_id()] then -- this is probably not the way to do it
					--sendDebugMessage("unique face", "MesmaDebug")
					faces[v:get_id()] = true
					faceCount = faceCount + 1 -- this is stupid
				end
			end
			
			if faceCount > 0 then
				--sendDebugMessage("faces exist", "MesmaDebug")
				return {
					xmult = card.ability.extra.xmult * faceCount
				}
			end
		end
	end,
	
	attributes = { "face", "xmult" }
}

SMODS.Joker{ 
	key = "telekinesis",
	name = "Telekinesis",
	rarity = 2,
	cost = 5,
	
	atlas = "jokers",
	pos = {x = 1, y = 3},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { created = false } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	
	calculate = function(self, card, context)
		if context.round_eval then
			card.ability.extra.created = false
		end
		
		if context.remove_playing_cards then
			if context.removed then
				for k,v in pairs(context.removed) do
					if v.config.center ~= G.P_CENTERS.c_base and not card.ability.extra.created then
						card.ability.extra.created = true
						G.E_MANAGER:add_event(Event({
							func = function()
								if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
								G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
							
								local new_card = SMODS.create_card( { set = "Spectral" } )
								new_card:add_to_deck()
								G.consumeables:emplace(new_card)
							
								G.GAME.consumeable_buffer = 0
		
								return true
								end
							end,
						}))
					end
				end
			end
		end
	end,
	
	attributes = { "generation", "spectral", "enhancements" }
}

-- == RARES == --

SMODS.Joker{ 
	key = "mesmer",
	name = "Mesmer",
	rarity = 3,
	cost = 7,
	
	atlas = "jokers",
	pos = {x = 2, y = 3},
	soul_pos = {x = 0, y = 4},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { perma_mult_gain = 2 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.perma_mult_gain } }
	end,
	
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card.config.center ~= G.P_CENTERS.c_base then
				context.other_card.ability.perma_mult = context.other_card.ability.perma_bonus or 0
				context.other_card.ability.perma_mult = context.other_card.ability.perma_bonus + card.ability.extra.perma_mult_gain
				
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.MULT
				}
			end
		end
	end,
	
	attributes = { "perma_bonus", "mult", "enhancements" }
}

SMODS.Joker{ 
	key = "malady",
	name = "Malady",
	rarity = 3,
	cost = 8,
	
	atlas = "jokers",
	pos = {x = 3, y = 3},
	soul_pos = {x = 1, y = 4},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { copy_count = 2 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.copy_count } }
	end,
	
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed[1] then
			for k,v in pairs(context.removed) do
				if v.config.center ~= G.P_CENTERS.c_base then
					for i = 1, card.ability.extra.copy_count do
						G.E_MANAGER:add_event(Event({
							func = function()
								local new_card = copy_card(v, nil, nil, true)
								
								local edition = SMODS.poll_edition( { guaranteed = true, no_negative = true } )
								new_card:set_edition(edition)
								
								SMODS.add_to_deck(new_card, {  } )
								return true
							end,
						}))
					end
				end
			end
		end
	end,
	
	attributes = { "playing_card", "enhancements", "editions" }
}

SMODS.Joker{ 
	key = "mirphie",
	name = "Mirphie",
	rarity = 3,
	cost = 8,
	
	atlas = "jokers",
	pos = {x = 4, y = 3},
	soul_pos = {x = 2, y = 4},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { retrigger_count = 1 } },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retrigger_count } }
	end,
	
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card.edition then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retrigger_count,
					card = card
				}
			end
		end
		
		if context.retrigger_joker_check and not context.retrigger_joker and not (context.other_card.config and context.other_card.config.center_key == self.key) then
			if context.other_card.edition then
				return {
					message = localize("k_again_ex"),
					repetitions = card.ability.extra.retrigger_count,
					card = card
				}
			end
		end
	end,
	
	attributes = { "retrigger", "enhancements", "editions" }
}

SMODS.Joker{ 
	key = "red",
	name = "Red",
	rarity = 3,
	cost = 9,
	
	atlas = "jokers",
	pos = {x = 3, y = 4},
	soul_pos = {x = 4, y = 4},
	
	discovered = true,
	
	artist = "imiam_idiot",
	
	config = { extra = { xmult = 1, xmult_gain = 0.25} },
	
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
	end,
	
	calculate = function(self, card, context)
		if context.remove_playing_cards and context.removed[1] and not context.blueprint then
			for k,v in pairs(context.removed) do
				if v.config.center ~= G.P_CENTERS.c_base then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xmult",
						scalar_value = "xmult_gain",
					})
				end
				if v.edition then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xmult",
						scalar_value = "xmult_gain",
					})
				end
				if v.seal then
					SMODS.scale_card(card, {
						ref_table = card.ability.extra,
						ref_value = "xmult",
						scalar_value = "xmult_gain",
					})
				end
			end
		end
		
		if context.joker_main then
			if card.ability.extra.xmult ~= 1 then
				return {
					xmult = card.ability.extra.xmult
				}
			end
		end
	end,
	
	attributes = { "xmult", "scaling", "enhancements", "editions", "seals" }
}