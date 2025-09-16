local SellActions = {}

function SellActions.quickSellByColor(hex: string)
    print("[QuickSell] color:", hex)
end

function SellActions.sellSkin(skin: any)
    print("[Sell]", skin.id, skin.name, skin.price)
end

return SellActions


