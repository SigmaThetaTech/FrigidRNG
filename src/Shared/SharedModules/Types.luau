--!strict

-- Shared types for networking payloads between client and server

export type Wear = {
	id: string,
	name: string,
}

export type Rarity = {
	id: string,
	name: string,
	color: string,
}

-- Additional helper types based on skin data sample
export type Category = {
	id: string,
	name: string,
}

export type Pattern = {
	id: string,
	name: string,
}

export type Team = {
	id: string,
	name: string,
}

export type Weapon = {
	id: string,
	name: string,
	weapon_id: number,
}

export type Style = {
	id: number,
	name: string,
	url: string?,
}

-- Full skin data as received from services/samples
export type SkinItem = {
	category: Category?,
	description: string?,
	id: string,
	image: string,
	legacy_model: boolean?,
	market_hash_name: string,
	max_float: number?,
	min_float: number?,
	name: string,
	paint_index: string?,
	pattern: Pattern?,
	rarity: Rarity?,
    phase: string?,
	skin_id: string?,
	souvenir: boolean?,
	stattrak: boolean?,
	style: Style?,
	team: Team?,
	weapon: Weapon?,
	wear: Wear?,
}

-- Mapping of market_hash_name -> price vendor map
-- Example: prices["AK-47 | Redline (Field-Tested)"] = { steam = { last_ever = 1234 } }
export type PriceVendorEntry = {
    steam: {
        last_ever: number?,
    }?,
    -- Prices sourced from CSFloat API (values in USD dollars)
    csfloat: {
        min_price: number?,
    }?,
}

export type PriceMap = { [string]: PriceVendorEntry }

-- Payload for selling an item
export type SellItemPayload = string -- market_hash_name

return {}


