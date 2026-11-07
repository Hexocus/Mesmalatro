local decs = {
	descriptions = {
		Joker = {
			j_mesm_vial = {
				name = "Vial",
				text = {
					"This Joker gains {C:mult}+#2#{} Mult",
					"for every {C:attention}Glass Card{}",
					"that is destroyed",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
				}
			},
			j_mesm_sleeping_witch = {
				name = "Sleeping Witch",
				text = {
					"This Joker gains {C:mult}+#2#{} Mult",
					"for every played hand",
					"Every {C:attention}#3#{} hands.",
					"Mult is set to {C:mult}-6{}",
					"{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult)"
				}
			},
			j_mesm_doll_eyes = {
				name = "Doll's Eyes",
				text = {
					"If the {C:attention}first discarded hand{}",
					"of each round contains an",
					"{C:attention}Enhanced{} card, this Joker",
					"gains {C:mult}+#1#{} Mult for the round",
					"{C:inactive}(Currently {C:attention}#2#{}{C:inactive}){}"
				}
			},
			j_mesm_pathetic_flames = {
				name = "Pathetic Flames",
				text = {
					"This Joker gains {C:chips}+#2#{} chips",
					"if played poker hand is",
					"level {C:attention}#3# or less{}",
					"{C:inactive}(Currently{} {C:chips}+#1#{}{C:inactive}){}"
				}
			},
			j_mesm_dense_theory_book = {
				name = "Dense Theory Book",
				text = {
					"Creates a {C:spectral}Spectral Card{}",
					"when another Joker",
					"{C:attention}scales{} #2# times",
					"{C:inactive}(Must have room) (#1#/#2#){}"
				}
			},
			j_mesm_squash = {
				name = "Squash",
				text = {
					"This Joker gains {C:money}$#1#{}",
					"of sell value",
					"when a {C:attention}consumable{}",
					"is used"
				}
			},
			j_mesm_covered_mirror = {
				name = "Covered Mirror",
				text = {
					"{C:mult}+#1#{} Mult for each",
					"discarded {C:attention}face{} card",
					"in this round",
					"{C:inactive}(Currently{} {C:mult}+#2#{}{C:inactive}){}" -- worst string
				}
			},
			j_mesm_piano = {
				name = "Piano",
				text = {
					"{C:mult}+#1#{} Mult for each",
					"{C:attention}debuffed{} card",
					"held in hand",
					"{C:inactive}(Currently{} {C:mult}+#2#{}{C:inactive}){}" -- worst string
				}
			},
			j_mesm_buddy = {
				name = "'Buddy'",
				text = {
					"Creates a {C:tarot}Tarot Card",
					"if played poker hand is",
					"level {C:attention}#1# or less{}",
					"{C:inactive,s:0.75}(Once per round, must have room){}"
				}
			},
			j_mesm_little_birdie = {
				name = "Little Birdie",
				text = {
					"Earn {C:money}$#1#{} at end of round",
					"Increase payout by {C:money}$#2#{}",
					"at end of round",
					"{C:attention}Resets{} when a Joker is sold"
				}
			},
			j_mesm_a_doe = {
				name = "A Doe",
				text = {
					"{X:mult,C:white}X#1#{} Mult if played hand",
					"scores {C:attention}less than{} {C:mult}50%{} of",
					"current blind requirement"
				}
			},
			j_mesm_giant_dolls_eyes = {
				name = "Giant Doll's Eyes",
				text = {
					"This Joker gains {X:chips,C:white}X#2#{} Chips",
					"per each {C:attention}consecutive{} hand",
					"played with no {C:attention}Enhanced{}",
					"or {C:attention}Editioned{} cards",
					"{C:inactive}(Currently{} {X:chips,C:white}X#1#{}{C:inactive}){}" -- worst string
				}
			},
			j_mesm_squash_tree = {
				name = "The Squash Tree",
				text = {
					"Creates a {C:tarot}Tarot Card",
					"at end of shop",
					"if {C:attention}nothing{}",
					"was bought from shop",
					"{C:inactive}(Must have room){}"
				}
			},
			j_mesm_ritual_concoction = {
				name = "Ritual Concoction",
				text = {
					{
					"Debuffs the rightmost Joker",
					"and apply {C:dark_edition}Augmented{} to it",
					"when {C:attention}blind{} is selected"
					},
					
					{
					"After 3 rounds, {C:attention}sell{} this Joker",
					"to remove its debuff from",
					"all Jokers",
					"{C:inactive}(#1#/3){}"
					},
					
					{
					"{E:2,C:red}Self destructs{} if this Joker",
					"{C:attention}fails to debuff{} another Joker",
					"when {C:attention}blind{} is selected"
					}
				}
			},
			j_mesm_mural = {
				name = "Mural",
				text = {
					"{X:mult,C:white}X#1#{} Mult for",
					"each unique {C:attention}face{}",
					"card in played hand"
				}
			},
			j_mesm_telekinesis = {
				name = "Telekinesis",
				text = {
					"Creates a {C:spectral}Spectral Card{}",
					"when an {C:attention}Enhanced{}",
					"card is destroyed",
					"{C:inactive,s:0.75}(Once  per round, must have room){}"
				}
			},
			j_mesm_mesmer = {
				name = "Mesmer",
				text = {
					"Every {C:attention}Enhanced{} card",
					"permanently gains",
					"{C:mult}+#1#{} Mult when scored"
				}
			},
			j_mesm_malady = {
				name = "Malady",
				text = {
					"When an {C:attention}Enhanced{} card",
					"is destroyed, create {C:attention}#1#{}",
					"{C:attention}Editioned{} cop#<ies,y>1# of it"
				}
			},
			j_mesm_mirphie = {
				name = "Mirphie",
				text = {
					"Retrigger all {C:attention}Editioned{}",
					"cards and Jokers",
					"{C:attention}#1#{} time#<s>1#"
				}
			},
			j_mesm_red = {
				name = "Red",
				text = {
					"This Joker gains {X:mult,C:white}X#2#{} Mult",
					"when destroying a",
					"playing card for each",
					"{C:attention}modification{} on that card",
					"{C:inactive}(Currently{} {X:mult,C:white}X#1#{}{C:inactive}){}" -- worst string
				}
			},
		},
		
		Edition = {
			e_mesm_augmented = {
				name = "Augmented",
				text = {
					"{C:attention}Retrigger{} this",
					"card {C:attention}#1#{} time#<s>1#",
					"{C:inactive,s:0.75}no shader yet :({}"
				},
			},
		},
		
		Other = {
			augmented_tooltip = {
				name = "Augmented",
				text = {
					"{C:attention}Retrigger{} this",
					"card {C:attention}#1#{} time#<s>1#"
				},
			},
		}
	},
	
	misc = {
		labels = {
			mesm_augmented = "Augmented"
		}
	}
}

return decs