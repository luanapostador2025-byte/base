-- Table to represent Game actions and its associated functions
Game = {
    Events = {
        TALK = 0,
        MAGIC_EFFECT = 1,
        HUD_CLICK = 2,
        HOTKEY_SHORTCUT_PRESS = 3,
        TEXT_MESSAGE = 4,
        MODAL_WINDOW = 5,
        CUSTOM_MODAL_WINDOW_BUTTON_CLICK = 6,
        IMBUEMENT_DATA = 7,
        IMBUEMENT_OPEN_WINDOW = 8, -- 15.10+
        QUEST_LOG = 9,
        QUEST_LINES = 10,
        DISTANCE_SHOOT_EFFECT = 11,
        PARTY_HUNT = 12,
        LABEL = 13,
        OPEN_STASH = 14,
        HUD_DRAG = 15,
        STORE_CATEGORIES = 16,
        STORE_OFFERS = 17,
        OPEN_DAILY_REWARD = 18,
        DAILY_REWARD_DAYS_DATA = 19,
        ALARM = 20,
        TASK_HUNTING_DATA = 21
    },
    RegisteredEvents = {},
    CallbacksCount = 0
}

--- Turn the player in a specified direction.
-- This function is a wrapper around the external function gameTurn.
-- @param direction (number) - The direction to turn the player, refer the parameter as Enums.Directions
function Game.turn(direction)
    gameTurn(direction)
end

--- Send a message or perform a certain type of talk action.
-- This function is a wrapper around the external function gameTalk.
-- @param message (string) - The message to send or the talk action to perform.
-- @param type (number) - The type of talk action to perform, if applicable. Refer the parameter as Enums.TalkTypes
function Game.talk(message, type)
    gameTalk(message, type)
end

--- Send a message to a specific channelId.
-- This function is a wrapper around the external function gameTalkChannel.
-- To get history of openned channels use Game.getChannelsHistory
-- @param message (string) - The message to be sent.
-- @param channelId (number) - The id of channel.
function Game.talkChannel(message, channelId)
    gameTalkChannel(message, channelId)
end

--- Send a private message to a specific player by name.
-- This function is a wrapper around the external function gameTalkPrivate.
-- @param message (string) - The message to be sent.
-- @param receiver (string) - The player name.
function Game.talkPrivate(message, receiver)
    gameTalkPrivate(message, receiver)
end

--- Open a specific channel by id. For now, if you need to get the id of a specific channel, you can open it in-game and use the function Game.getChannelsHistory.
--- This function is a wrapper around the external function gameOpenChannel.
--- @param channelId (number) - The id of channel to be opened.
--- @return True if the action was sent to server, or false if the action failed to be sent.
function Game.openChannel(channelId)
    return gameOpenChannel(channelId)
end

--- Move the player in a specified direction.
-- This function is a wrapper around the external function gameWalk.
-- @param direction (string) - The direction to move the player. Refer the parameter as Enums.Directions
function Game.walk(direction)
    gameWalk(direction)
end

--- Attack a specified creature.
-- This function is a wrapper around the external function gameAttack.
-- @param creatureId (number) - The ID of the creature to attack.
function Game.attack(creatureId)
    gameAttack(creatureId)
end

--- Follow a specified creature.
--- This function is a wrapper around the external function gameFollow.
--- @param creatureId (number) - The ID of the creature to follow.
function Game.follow(creatureId)
    gameFollow(creatureId)
end

--- Get item count of specified ID by Tier.
--- If the itemTier parameter value is not provided or is 0, the function will return the total count of items without tier.
-- This function is a wrapper around the external function gameGetItemCount.
-- @param itemId (number) - The ID of item.
-- @param itemTier (number) - The tier of item. This parameter is optional.
function Game.getItemCount(itemId, itemTier)
    itemTier = itemTier or 0
	return gameGetItemCount(itemId, itemTier)
end

--- Get all items stored on player inventory.
-- This function is a wrapper around the external function gameGetInventoryItems.
-- @return a table containing all available inventory items, every item follow this format: {id=0,count=0,tier=0}
function Game.getInventoryItems()
	return gameGetInventoryItems()
end

--- Use an item on the ground.
-- This function is a wrapper around the external function gameUseItemOnGround.
-- It allows the use of a specified item on the ground at a particular position.
-- @param itemId (number) - The ID of the item to be used.
-- @param x (number) - The x-coordinate of the position where the item is to be used.
-- @param y (number) - The y-coordinate of the position where the item is to be used.
-- @param z (number) - The z-coordinate of the position where the item is to be used.
-- @return true if used item correctly, false otherwise.
function Game.useItemOnGround(itemId, x, y, z)
    return gameUseItemOnGround(itemId, x, y, z)
end

-- Use an item on inventory.
-- This function is a wrapper around the external function gameUseItemOnInventory.
-- It allows the use of a specified item on a specific inventory slot.
-- @param itemId (number) - The ID of the item to be used.
-- @param inventorySlot (number) - The inventory slot where the item is to be used. Refer the parameter as Enums.InventorySlots
-- @return true if used item correctly, false otherwise.
function Game.useItemOnInventory(itemId, inventorySlot)
    return gameUseItemOnInventory(itemId, inventorySlot)
end

--- Use an item from ground.
-- This function is a wrapper around the external function gameUseItemFromGround.
-- It allows the use of a item located in a specific position.
-- @param x (number) - The x-coordinate of the position where the item is located.
-- @param y (number) - The y-coordinate of the position where the item is located.
-- @param z (number) - The z-coordinate of the position where the item is located.
-- @return true if it was possible to use item, false otherwise.
function Game.useItemFromGround(x, y, z)
    return gameUseItemFromGround(x, y, z)
end

-- Get channels history of current session
-- This information will be available if you logged in with bot injected, so it can gather channels informations
-- @return table containing history of openned channels with id and name
function Game.getChannelsHistory()
    return gameGetChannelsHistory()
end

-- Answer current modal window
-- This function is a wrapper around the external function gameModalWindowAnswer.
-- @param id (number) - The ID of the modal window.
-- @param button (number) - The button id to be clicked.
-- @param choice (number) - The choice id to be selected.
-- @param closeAfterAnswer (boolean) - If should close the modal window by using default close event after modal answer. Default is true.
-- @return true if was sent successfully sent the action, if not failed
function Game.modalWindowAnswer(id, button, choice, closeAfterAnswer)
    if closeAfterAnswer == nil then closeAfterAnswer = true end
    return gameModalWindowAnswer(id, button, choice, closeAfterAnswer)
end

-- Use item with creature by id
-- This function is a wrapper around the external function gameUseItemWithCreature.
-- @return true if was sent successfully sent the action, if not failed
function Game.useItemWithCreature(id, creatureId)
    return gameUseItemWithCreature(id, creatureId)
end

-- Loot a corpse at specific map coordinate
-- This function is a wrapper around the external function gameLootCorpse.
-- @param x (number) - The x-coordinate of the map destination position.
-- @param y (number) - The y-coordinate of the map destination position.
-- @param z (number) - The z-coordinate of the map destination position.
-- @return true if was sent successfully sent the action, if not failed
function Game.lootCorpse(x, y, z)
    return gameLootCorpse(x, y, z)
end

--- Equip an item. (Can be used to de-equip too, read below)
-- This function is a wrapper around the external function gameEquipItem.
-- Equip a specific item by id and tier. You can use it to de-equip an item by passing the item id equipped.
-- @param itemId (number) - The ID of the item to be equiped.
-- @param tier (number) - The tier of item to be equiped.
function Game.equipItem(itemId, tier)
    gameEquipItem(itemId, tier)
end

--- Use an item.
-- This function is a wrapper around the external function gameUseItem.
-- It allows the use of a specified item.
-- @param itemId (number) - The ID of the item to be used.
function Game.useItem(itemId)
    gameUseItem(itemId)
end

-- Forge convert dusts action
-- This function is a wrapper around the external function gameForgeConvertDust.
-- @return true if was successfully sent the action to server, otherwise false
function Game.forgeConvertDust()
    return gameForgeConvertDust()
end

-- Forge convert slivers action
-- This function is a wrapper around the external function gameForgeConvertSlivers.
-- @return true if was successfully sent the action to server, otherwise false
function Game.forgeConvertSlivers()
    return gameForgeConvertSlivers()
end

-- Forge increase dust limit action
-- This function is a wrapper around the external function gameForgeIncreaseLimit.
-- @return true if was successfully sent the action to server, otherwise false
function Game.forgeIncreaseLimit()
    return gameForgeIncreaseLimit()
end

-- Write text to a window
-- This function is a wrapper around the external function gameWriteTextWindow.
-- Note: you need to open a text window before writing the text. Additionally, this function automatically closes the window after writing by simulating the ESCAPE key. This function sends the text directly to the server to be written, it is not dependent on the game interface. It is important to have the text window open before using this function.
-- @param text (string) - The text to be written.
function Game.writeTextWindow(text)
    gameWriteTextWindow(text)
end

-- Apply imbuement.
-- This function is a wrapper around the external function gameApplyImbuement.
-- @param slot (number) - The slot of the item to clear the imbuement. The slot value starts at 0. Example: slot 0, 1, 2.
-- @param imbuementId (number) - The ID of the imbuement to be applied.
-- @param isProtected (boolean) - If should increase success rate for imbuement. This argument can be ignored in version 15.10 or newer.
-- @return true if was successfully sent the action to server, otherwise false
function Game.applyImbuement(slot, imbuementId, isProtected)
    if not isProtected then
        isProtected = false -- 15.10+ optional
    end
    return gameApplyImbuement(slot, imbuementId, isProtected)
end

-- Apply imbuement on Imbue Scroll.
-- This function is a wrapper around the external function gameApplyImbuementOnScroll.
-- Only available for version 15.10 or newer.
-- @param imbuementId (number) - The ID of the imbuement to be applied.
-- @return true if was successfully sent the action to server, otherwise false
function Game.applyImbuementOnScroll(imbuementId)
    return gameApplyImbuementOnScroll(imbuementId)
end

-- Clear imbuement
-- This function is a wrapper around the external function gameClearImbuement.
-- @param slot (number) - The slot of the item to clear the imbuement. The slot value starts at 0. Example: slot 0, 1, 2.
-- @return true if was successfully sent the action to server, otherwise false
function Game.clearImbuement(slot)
    return gameClearImbuement(slot)
end

-- Close imbuement window
-- This function is a wrapper around the external function gameCloseImbuementWindow.
-- @return true if was successfully sent the action to server, otherwise false
function Game.closeImbuementWindow()
    return gameCloseImbuementWindow()
end

-- Trigger ZeroBot native auto loot function (located on Tools -> More... -> Auto Loot)
-- This function is a wrapper around the external function gameAutoLoot.
function Game.autoLoot()
    gameAutoLoot()
end

-- Request the quest log from the server. You should use Game.Events.QUEST_LOG event to get the response.
-- This function is a wrapper around the external function gameRequestQuestLog.
-- @return true if was successfully sent the action to server, otherwise false
function Game.requestQuestLog()
    return gameRequestQuestLog()
end

-- Request the quest lines from the server. You should use Game.Events.QUEST_LINES event to get the response.
-- This function is a wrapper around the external function gameRequestQuestLines.
-- @param questId (number) - The ID of the quest to request the lines.
-- @return true if was successfully sent the action to server, otherwise false
function Game.requestQuestLines(questId)
    return gameRequestQuestLines(questId)
end

-- Retrieve specific item from stash. It's important to refer all data from Game.Events.OPEN_STASH event.
-- To use this function you need to open stash and trigger Game.Events.OPEN_STASH event first.
-- This function is a wrapper around the external function gameStashRetrieve.
-- @param itemId (number) - The ID of the item to be retrieved.
-- @param itemCount (number) - The count of the item to be retrieved.
-- @return true if was successfully sent the action to server, or nil if the item/counting is invalid, otherwise false.
function Game.stashRetrieve(itemId, itemCount)
    return gameStashRetrieve(itemId, itemCount)
end

-- Buy a specific offer from game store. You should use Game.Events.STORE_OFFERS event to get the available offers.
-- This function is a wrapper around the external function gameStoreBuyOffer.
-- @param offerId (number) - The ID of the offer to be purchased.
-- @param offerType (number) - The type of the offer to be purchased. Refer to Enums.GameStoreOfferType.
-- @return true if was successfully sent the action to server and the offer exists and isn't disabled. Otherwise false.
function Game.storeBuyOffer(offerId, offerType)
    return gameStoreBuyOffer(offerId, offerType)
end

-- Open game store window
-- This function is a wrapper around the external function gameStoreOpen.
-- @return true if was successfully sent the action to server, otherwise false
function Game.storeOpen()
    return gameStoreOpen()
end

-- Request game store category offers
-- This function is a wrapper around the external function gameStoreRequestOffers.
-- @param categoryName (string) - The name of the category to request offers from.
-- @return true if was successfully sent the action to server and the category exists, otherwise false
function Game.storeRequestOffers(categoryName)
    return gameStoreRequestOffers(categoryName)
end

-- Get current tibia coins balance from game store. This data can be updated after a purchase or when the store window is opened.
-- This function is a wrapper around the external function gameStoreGetCoinsBalance.
-- @return number containing the current coins balance
function Game.storeGetTibiaCoinsBalance()
    return gameStoreGetCoinsBalance()
end

-- Get current transferable coins balance from game store. This data can be updated after a purchase or when the store window is opened.
-- This function is a wrapper around the external function gameStoreGetTransferableCoinsBalance.
-- @return number containing the current transferable coins balance
function Game.storeGetTransferableCoinsBalance()
    return gameStoreGetTransferableCoinsBalance()
end

--- Collect current daily reward.
--- This function is a wrapper around the external function gameCollectDailyReward.
--- IMPORTANT: about Premium rewards please, make sure you are using these functions: Player.isPremium() and Player.hasReceivedBasicData()
--- @param isFromShrine (boolean) - If the daily reward is being collected from a shrine.
--- @param itemsToPick (table) - A table containing the indexes of the items to pick from the daily reward. If the current day streak doesn't have items to pick, this parameter should be nil.
--- @return true if was successfully sent the action to server, otherwise false
function Game.collectDailyReward(isFromShrine, itemsToPick)
    return gameCollectDailyReward(itemsToPick or {}, isFromShrine)
end

--- Open daily reward window.
--- This function is a wrapper around the external function gameOpenDailyReward.
--- This will open the remote daily reward window version (the one that you click on UI button called Open reward wall), if you want to open the shrine version you can use the shrine item from map.
--- @return true if was successfully sent the action to server, otherwise false
function Game.openDailyReward()
    return gameOpenDailyReward()
end

--- Reroll a specific hunt task list column.
--- This function is a wrapper around the external function gameHuntingTaskRerollList.
--- @param slot (number) - The column slot of the task list to reroll. From 0 to 2.
--- @return true if was successfully sent the action to server (validating if it's possible to reroll list), otherwise nil
function Game.huntingTaskRerollList(slot)
    return gameHuntingTaskRerollList(slot)
end

--- Reroll the rewards of a specific hunt task column. Remember: you should have hunting task data available, you can get it after a relogin.
--- This function is a wrapper around the external function gameHuntingTaskRerollRewards.
--- @param slot (number) - The column slot of the task list to reroll the rewards. From 0 to 2.
--- @return true if was successfully sent the action to server (validating if it's possible to reroll rewards), otherwise nil
function Game.huntingTaskRerollRewards(slot)
    return gameHuntingTaskRerollRewards(slot)
end

--- Triggers the action that shows all monsters available to select a specific one, by paying a prey wildcard's fee. By doing that the player can choose a monster by name. Remember: you should have hunting task data available, you can get it after a relogin.
--- This function is a wrapper around the external function gameHuntingTaskListAllMonsters.
--- @param slot (number) - The column slot of the task list to show all monsters. From 0 to 2.
--- @return true if was successfully sent the action to server (validating if it's possible to list all monsters), otherwise nil
function Game.huntingTaskListAllMonsters(slot)
    return gameHuntingTaskListAllMonsters(slot)
end

--- Select a specific monster in a hunt task column. Remember: you should have hunting task data available, you can get it after a relogin.
--- This function is a wrapper around the external function gameHuntingTaskSelectMonster.
--- @param slot (number) - The column slot of the task list to select the monster. From 0 to 2.
--- @param raceId (number) - The monster raceId. You can use Client.getMonsterByRaceId and hunting task event for more details.
--- @param selectMaximumAmount (boolean) - If should select the maximum amount available for the selected monster. Remember: You can only select the maximum amount option if the monster is unlocked in bestiary. This argument is optional, by default it will try to select the maximum amount.
--- @return true if was successfully sent the action to server (validating if it's possible to select the monster), otherwise nil
function Game.huntingTaskSelectMonster(slot, raceId, selectMaximumAmount)
    if selectMaximumAmount == nil then
        selectMaximumAmount = true -- by default it will try to select the maximum amount
    end

    return gameHuntingTaskSelectMonster(slot, raceId, selectMaximumAmount)
end

--- Cancel the selected monster in a hunt task column. Remember: you should have hunting task data available, you can get it after a relogin.
--- This function is a wrapper around the external function gameHuntingTaskCancel.
--- @param slot (number) - The column slot of the task list to cancel the monster selection. From 0 to 2.
--- @return true if was successfully sent the action to server (validating if it's possible to cancel the monster selection), otherwise nil
function Game.huntingTaskCancel(slot)
    return gameHuntingTaskCancel(slot)
end

--- Claim the reward of a specific hunt task column. Remember: you should have hunting task data available, you can get it after a relogin.
--- This function is a wrapper around the external function gameHuntingTaskClaim.
--- @param slot (number) - The column slot of the task list to claim the reward. From 0 to 2.
--- @return true if was successfully sent the action to server (validating if it's possible to claim the reward), otherwise nil
function Game.huntingTaskClaim(slot)
    return gameHuntingTaskClaim(slot)
end

----------------------- INTERNAL EVENTS (DON'T TOUCH) -----------------------
function Game.executeEvents(hookType, ...)
    for index, callback in pairs(Game.RegisteredEvents[hookType] or {}) do
        callback(...)
    end
end

-- Register a game event
-- Example: Game.registerEvent(Game.Events.TALK, myTalkEvent)
function Game.registerEvent(type, fn)
    if not Game.RegisteredEvents[type] then
        Game.RegisteredEvents[type] = {}
    end

    table.insert(Game.RegisteredEvents[type], fn)
    Game.CallbacksCount = Game.CallbacksCount + 1

    local callbacksCountByType = #Game.RegisteredEvents[type]
    if (callbacksCountByType == 1) then
        setCallbackByType(type, true)
    end

    if Game.CallbacksCount == 1 then
        callbacksEnabled(true)
    end
    return fn
end

-- Unregister a game event
-- Example: Game.unregisterEvent(Game.Events.TALK, myTalkEvent)
function Game.unregisterEvent(type, fn)
    local t = Game.RegisteredEvents[type] or {}
    for i, v in pairs(t) do
        if v == fn then
            table.remove(t, i)
            Game.CallbacksCount = Game.CallbacksCount - 1
        end
    end

    local callbacksCountByType = #Game.RegisteredEvents[type]
    if (callbacksCountByType == 0) then
        setCallbackByType(type, false)
    end

    if Game.CallbacksCount == 0 then
        callbacksEnabled(false)
    end
end

----------------------- INTERNAL FUNCTIONS (DON'T TOUCH) -----------------------
-- triggered when receive a message in-game
-- @param authorName - The author that said the message
-- @param authorLevel - The level of the author (generally used to identify player level on chat)
-- @param type - The type of the message, you can base it on Enums.TalkTypes
-- @param x - The x-coordinate of the map position
-- @param y - The y-coordinate of the map position
-- @param z - The z-coordinate of the map position
-- @param text - The content of the message
-- @param channelId - The id of the channel if the message is from a channel
function onInternalTalk(authorName, authorLevel, type, x, y, z, text, channelId)
    Game.executeEvents(Game.Events.TALK, authorName, authorLevel, type, x, y, z, text, channelId)
end

-- triggered when receive a magic effect in-game
-- if you are using this event in a situation with many effects, dependending of your code can affect the performance, in that case you can use sometype of delay/queue for processing
-- @param type - The ID of magic effect
-- @param x - The x-coordinate of the map position.
-- @param y - The y-coordinate of the map position.
-- @param z - The z-coordinate of the map position.
function onInternalMagicEffect(type, x, y, z)
    Game.executeEvents(Game.Events.MAGIC_EFFECT, type, x, y, z)
end

-- triggered when press any possible shortcut
-- key = code of the key pressed, modifier = is the modifier pressed (example: CTRL)
-- you can base on HotkeyManager.parseKeyCombination function on how to work with key/modifier
function onInternalHotkeyShortcutPress(key, modifier)
    Game.executeEvents(Game.Events.HOTKEY_SHORTCUT_PRESS, key, modifier)
end

-- triggered when receive a text message in-game
-- messageData param is a table containing structure following the sample:
-- {
--     "channelId": 0,
--     "messagePrimaryValue": 13048,
--     "messagePrimaryColor": 180,
--     "messageSecondaryValue": 0,
--     "x": 32424,
--     "y": 32147,
--     "z": 7,
--     "text": "A monk loses 4 hitpoints due to your attack.",
--     "messageSecondaryColor": 255,
--     "messageType": 23
-- }
--
-- messageType field you can base it on Enums.MessageTypes
-- these message types can change dependending of the client version
function onInternalTextMessage(messageData)
    Game.executeEvents(Game.Events.TEXT_MESSAGE, messageData)
end

-- triggered when receive a modal window in-game
-- modalWindowData param is a table containing structure following the sample:
-- {
--     "defaultEscapeButton": 255,
--     "defaultEnterButton": 255,
--     "priority": 0,
--     "title": "Select an option",
--     "buttons": [
--         {
--             "text": "First",
--             "id": 1
--         },
--         {
--             "text": "Second",
--             "id": 2
--         },
--         {
--             "text": "Third",
--             "id": 3
--         },
--         {
--             "text": "Fourth",
--             "id": 4
--         }
--     ],
--     "id": 1,
--     "message": "Hello",
--     "choices": []
-- }
function onInternalModalWindow(modalWindowData)
    Game.executeEvents(Game.Events.MODAL_WINDOW, modalWindowData)
end

-- triggered when receive imbuement window in-game
-- imbuementData param is a table containing structure following the sample:
-- {
--     "availableImbuements": [
--         {
--             "imbuementDescription": "Converts 3% of damage to MP with a chance of 100%.",
--             "items": [
--                 {
--                     "count": 25,
--                     "itemId": 11492
--                 }
--             ],
--             "imbuementId": 19,
--             "imbuementName": "Mana Leech",
--             "imbuementLevel": "Basic Void"
--         },
--         {
--             "imbuementDescription": "Converts 5% of damage to MP with a chance of 100%.",
--             "items": [
--                 {
--                     "count": 25,
--                     "itemId": 11492
--                 },
--                 {
--                     "count": 25,
--                     "itemId": 20200
--                 }
--             ],
--             "imbuementId": 20,
--             "imbuementName": "Mana Leech",
--             "imbuementLevel": "Intricate Void"
--         },
--         {
--             "imbuementDescription": "Converts 8% of damage to MP with a chance of 100%.",
--             "items": [
--                 {
--                     "count": 25,
--                     "itemId": 11492
--                 },
--                 {
--                     "count": 25,
--                     "itemId": 20200
--                 },
--                 {
--                     "count": 5,
--                     "itemId": 22730
--                 }
--             ],
--             "imbuementId": 21,
--             "imbuementName": "Mana Leech",
--             "imbuementLevel": "Powerful Void"
--         }
--     ],
--     "slots": 1,
--     "slotImbuements": [
--         {
--             "imbuementDescription": "Raises crit hit damage by 50% and crit hit chance by 10%.",
--             "clearPrice": 15000,
--             "imbuementPrice": 100000,
--             "imbuementId": 24,
--             "imbuementName": "Critical Hit",
--             "timeRemaining": 72000,
--             "imbuementLevel": "Powerful Strike",
--             "empty": false
--         }
--     ],
--     "itemId": 34090
-- }
function onInternalImbuementData(imbuementData)
    Game.executeEvents(Game.Events.IMBUEMENT_DATA, imbuementData)
end

-- triggered when receive imbuement window open event in-game
-- ONLY FOR TIBIA CLIENT VERSION 15.10 OR NEWER
function onInternalImbuementOpenWindow()
    Game.executeEvents(Game.Events.IMBUEMENT_OPEN_WINDOW)
end

-- triggered when receive a quest log in-game (refer state on Enums.QuestState)
-- quests param is a table containing structure following the sample:
-- {
--     "quests": [
--         {
--             "id": 5,
--             "name": "Bigfoot's Burden",
--             "state": 0
--         },
--         {
--             "id": 6,
--             "name": "Children of the Revolution (completed)",
--             "state": 0
--         }
--     ]
-- }
function onInternalQuestLog(quests)
    Game.executeEvents(Game.Events.QUEST_LOG, quests)
end

-- triggered when receive quest lines in-game
-- questId param is the ID of the quest
-- missions param is a table containing structure following the sample:
-- {
--     "missions": [
--         {
--             "name": "Circle of the Black Sphinx",
--             "missionId": 10361,
--             "description": "You defeated the rogue Lady Tenebris."
--         },
--         {
--             "name": "Bane of the Cosmic Force",
--             "missionId": 10362,
--             "description": "You calmed poor, misguided Lloyd. All he wanted was protection from the outside world. Luckily he seems to have learned his lesson... or has he?"
--         }
--     ]
-- }
function onInternalQuestLines(questId, missions)
    Game.executeEvents(Game.Events.QUEST_LINES, questId, missions)
end

-- triggered when receive a distance shoot effect in-game.
-- @param type - The type of the distance shoot effect
-- @param fromX - The x-coordinate of the map position where the effect started.
-- @param fromY - The y-coordinate of the map position where the effect started.
-- @param fromZ - The z-coordinate of the map position where the effect started.
-- @param toX - The x-coordinate of the map position where the effect ended.
-- @param toY - The y-coordinate of the map position where the effect ended.
-- @param toZ - The z-coordinate of the map position where the effect ended.
function onInternalDistanceShootEffect(type, fromX, fromY, fromZ, toX, toY, toZ)
    Game.executeEvents(Game.Events.DISTANCE_SHOOT_EFFECT, type, fromX, fromY, fromZ, toX, toY, toZ)
end

-- triggered when receive a party hunt output in-game.
-- you need the party hunt option enabled in the Engine tab.
-- @param output - The output of the party hunt
function onInternalPartyHuntOutput(output)
    Game.executeEvents(Game.Events.PARTY_HUNT, output)
end

-- triggered when cavebot reaches a label. When this event is triggered, the cavebot will be paused until the developer calls CaveBot.pause(0) to resume the cavebot.
-- @param wpId - The ID of the waypoint
-- @param label - The label name
function onInternalLabel(wpId, label)
    Game.executeEvents(Game.Events.LABEL, wpId, label)
end

-- triggered when receive a stash open event in-game.
-- @param stashData - The table stash data containing the information about the stash.
-- The table structure is as follows:
-- {
--      stashItems = {
--              { itemId = 0, count = 0 },
--              { itemId = 0, count = 0 }
--      },
--      freeSlots = 0
-- }
function onInternalOpenStash(stashData)
    Game.executeEvents(Game.Events.OPEN_STASH, stashData)
end

-- triggered when receive a click event on any HUD
-- @param id - The ID of HUD that was clicked
function onInternalHudClick(id)
    Game.executeEvents(Game.Events.HUD_CLICK, id)
end

-- triggered when receive a drag release event on any HUD
-- @param id - The ID of HUD that was dragged
-- @param x - The x-coordinate of the position where the drag was released.
-- @param y - The y-coordinate of the position where the drag was released.
function onInternalHudDrag(id, x, y)
    Game.executeEvents(Game.Events.HUD_DRAG, id, x, y)
end

-- triggered when receive store categories data
function onInternalGameStoreCategories(storeCategoriesData)
    Game.executeEvents(Game.Events.STORE_CATEGORIES, storeCategoriesData)
end

-- triggered when receive store offers data
function onInternalGameStoreOffers(storeOffersData)
    Game.executeEvents(Game.Events.STORE_OFFERS, storeOffersData)
end

-- triggered when receive daily reward open event
function onInternalOpenDailyReward(dailyRewardData)
    Game.executeEvents(Game.Events.OPEN_DAILY_REWARD, dailyRewardData)
end

-- triggered when receive daily reward days data
function onInternalDailyRewardDaysData(dailyRewardDaysData)
    Game.executeEvents(Game.Events.DAILY_REWARD_DAYS_DATA, dailyRewardDaysData)
end

-- triggered when an alarm triggers. Refer alarmType in Enums.AlarmType
function onInternalAlarm(alarmType)
    Game.executeEvents(Game.Events.ALARM, alarmType)
end

-- triggered when receive task hunting data or any update about it. Refer taskDataState in Enums.PreyTaskDataState.
-- You can use Client.getMonsterByRaceId to get more information about the monster based on the raceId.
-- All hunting task data information will only be received when: player logins or anything changes on hunting task window.
-- If the state is PREY_TASK_DATA_STATE_LOCKED, the returned data format is: {slotId=0, state=0, isPremium=false, freeRerollTimestamp=0}
-- If the state is PREY_TASK_DATA_STATE_INACTIVE, the returned data format is: {slotId=0, state=1, freeRerollTimestamp=0}
-- If the state is PREY_TASK_DATA_STATE_SELECTION, the returned data format is: {slotId=0, state=2, raceIdList={{raceId=0,isUnlocked=true}}, freeRerollTimestamp=0}
-- If the state is PREY_TASK_DATA_STATE_LIST_SELECTION, the returned data format is: {slotId=0, state=3, bestiaryList={{raceId=0,isUnlocked=false}}, freeRerollTimestamp=0}
-- If the state is PREY_TASK_DATA_STATE_ACTIVE, the returned data format is: {slotId=0, state=4, selectedRaceId=0, isSlotUpgrade=false, firstKills=0, secondKills=100, currentKills=20, rarity=1, freeRerollTimestamp=0}
-- If the state is PREY_TASK_DATA_STATE_COMPLETED, the returned data format is: {slotId=0, state=5, selectedRaceId=0, isSlotUpgrade=false, firstKills=0, secondKills=100, currentFirstKills=100, currentSecondKills=100, rarity=1, freeRerollTimestamp=0}
function onInternalTaskHuntingData(taskHuntingData)
    Game.executeEvents(Game.Events.TASK_HUNTING_DATA, taskHuntingData)
end

-- triggered when receive a click event from any button of a custom modal window
-- @param modalId - The ID of the modal window
-- @param buttonIndex - The index of the button clicked
function onInternalCustomModalButtonOnClick(modalId, buttonIndex)
    Game.executeEvents(Game.Events.CUSTOM_MODAL_WINDOW_BUTTON_CLICK, modalId, buttonIndex)
end