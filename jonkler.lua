--- STEAMODDED HEADER
--- MOD_NAME: Epic Joker!!!!!! :O
--- MOD_ID: yes
--- PREFIX: peak
--- MOD_AUTHOR: [Jevonn]
--- MOD_DESCRIPTION: Peak Balatro Joker concept
--- BADGE_COLOUR: 968a74
--- BADGE_TEXT_COLOUR: 6076cc
--- DEPENDENCIES: []
--- VERSION: 1

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 32,
	py = 32,
}):register()
SMODS.Atlas({
	key = "aaa",
	path = "joker.png",
	px = 71,
	py = 95,
}):register()

SMODS.Joker{
	name = "Peak Steamodded Gaming",
	key = "abcdefghijklmnopqrstuvwxyz",
	pos = { x = 0, y = 0 },
	blueprint_compat = true,
	config = { extra = { mod = 1, mult = 1 } },
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.mod, card.ability.extra.mult },
		}
	end,
	atlas = "aaa",
	loc_txt = {
        	name = 'Peak Steamodded Gaming',
       		text = {
        		"{X:mult,C:white} X#1# {} Mult for each",
			"{C:attention}Steamodded Mod",
			"that failed to load",
        		"{C:inactive}(Currently {X:mult,C:white} X#2# {C:inactive} Mult)"
        	}
    	},
	rarity = 2,
	cost = 2,
	update = function(self, card, front)
		local value = 0
		for _, v in ipairs(SMODS.mod_list) do
			if not v.can_load and not v.disabled then 
				value = value + 1
			end
		end
		card.ability.extra.mult = 1 + (card.ability.extra.mod * value)
	end,
	calculate = function(self, card, context)
		if
			context.cardarea == G.jokers
			and card.ability.extra.mult > 1
			and not context.before
			and not context.after
		then
			return {
				message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.mult } }),
				Xmult_mod = card.ability.extra.mult,
				colour = G.C.MULT,
			}
		end
	end,
}
if JokerDisplay then
	JokerDisplay.Definitions["j_peak_abcdefghijklmnopqrstuvwxyz"] = {
		text = {
			{
				border_nodes = {
					{ text = "X" },
					{ ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "exp" },
				},
			},
		},
	}
end
if (SMODS.Mods["Cryptid"] or {}).can_load then
    Cryptid.memepack[#Cryptid.memepack + 1] = "j_peak_abcdefghijklmnopqrstuvwxyz"
end
