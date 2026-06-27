-- ============================================
-- BOT COMPLETO - CONFIGURAÇÃO FÁCIL
-- ============================================
-- Bot baseado na estrutura CaveBot existente
-- Integra: Auto-Heal, Auto-Attack, Navegação por Waypoints
-- ============================================

-- ============================================
-- CONFIGURAÇÕES DO SEU SERVIDOR
-- ============================================
CONFIG = {
    -- POSIÇÃO INICIAL (Coloque as coordenadas do seu personagem)
    startPos = {x = 0, y = 0, z = 0},  -- ALTERE AQUI: x, y, z da sua posição inicial
    
    -- CONFIGURAÇÕES DE HEALING
    heal = {
        minMana = 100,          -- Mana mínima antes de usar spell de cura
        healthPercent = 70,     -- Porcentagem de HP para usar healing
        spellName = "exura",    -- Nome da spell de cura (ex: "exura", "exura gran", "exura vita")
        spellWords = "exura"    -- Palavras da spell (caso precise)
    },
    
    -- CONFIGURAÇÕES DE ATAQUE
    attack = {
        enabled = true,         -- Ativar/desativar auto-attack
        targetDistance = 4,     -- Distância máxima para atacar
        prioritizeLowHp = true, -- Priorizar criaturas com menos HP
        minHealthPercent = 30   -- Só atacar se a criatura tiver menos que X% de HP
    },
    
    -- WAYPOINTS DA ROTA DE HUNT
    -- Adicione suas waypoints aqui seguindo o formato:
    -- {x = valor, y = valor, z = valor, type = Enums.WaypointType.WAYPOINT_TYPE_STAND}
    waypoints = {
        -- Exemplo (ALTERE COM AS COORDENADAS DO SEU HUNT):
        -- {x = 100, y = 100, z = 7, type = Enums.WaypointType.WAYPOINT_TYPE_STAND},
        -- {x = 105, y = 100, z = 7, type = Enums.WaypointType.WAYPOINT_TYPE_STAND},
        -- {x = 105, y = 105, z = 7, type = Enums.WaypointType.WAYPOINT_TYPE_STAND},
        -- {x = 100, y = 105, z = 7, type = Enums.WaypointType.WAYPOINT_TYPE_STAND},
    },
    
    -- CREATURES PARA ATACAR (Lista de nomes)
    targetList = {
        "rotworm",
        "cyclops",
        "dragon",
        -- Adicione mais creatures aqui
    },
    
    -- CREATURES PARA IGNORAR
    ignoreList = {
        "player",
        "npc",
        -- Adicione mais creatures aqui
    }
}

-- ============================================
-- VARIÁVEIS INTERNAS
-- ============================================
local lastHealTime = 0
local HEAL_DELAY = 1000  -- Delay entre heals em ms
local lastAttackTime = 0
local ATTACK_DELAY = 500 -- Delay entre ataques em ms

-- ============================================
-- FUNÇÕES AUXILIARES
-- ============================================

--- Verifica se o jogador está em condições de usar healing
local function canUseHeal()
    local healthPercent = Player.getHealthPercent()
    local mana = Player.getMana()
    
    if healthPercent <= CONFIG.heal.healthPercent and mana >= CONFIG.heal.minMana then
        return true
    end
    return false
end

--- Usa a spell de cura configurada
local function useHeal()
    local currentTime = os.time() * 1000
    
    if currentTime - lastHealTime >= HEAL_DELAY then
        local spellId = Spells.getIdByName(CONFIG.heal.spellName)
        
        if spellId ~= -1 and not Spells.isInCooldown(spellId) then
            Game.talk("exevo " .. CONFIG.heal.spellWords)
            lastHealTime = currentTime
            return true
        end
    end
    return false
end

--- Encontra o melhor alvo na lista de creatures visíveis
local function findBestTarget()
    local creatures = Creature.getList() -- Função externa que deve retornar lista de creatures
    
    if not creatures or #creatures == 0 then
        return nil
    end
    
    local bestTarget = nil
    local bestTargetHp = 100
    
    for _, creatureId in ipairs(creatures) do
        local creature = Creature.new(creatureId)
        local name = creature:getName()
        
        if name then
            name = name:lower()
            
            -- Verifica se está na lista de ignorar
            local shouldIgnore = false
            for _, ignoreName in ipairs(CONFIG.ignoreList) do
                if name:find(ignoreName:lower()) then
                    shouldIgnore = true
                    break
                end
            end
            
            if not shouldIgnore then
                -- Verifica se está na lista de alvos (se a lista não estiver vazia)
                local isTarget = #CONFIG.targetList == 0
                if not isTarget then
                    for _, targetName in ipairs(CONFIG.targetList) do
                        if name:find(targetName:lower()) then
                            isTarget = true
                            break
                        end
                    end
                end
                
                if isTarget then
                    local healthPercent = creature:getHealthPercent()
                    local position = creature:getPosition()
                    local playerPos = Self.getPosition()
                    
                    -- Calcula distância (simplificado)
                    local distance = math.sqrt(
                        math.pow(position.x - playerPos.x, 2) + 
                        math.pow(position.y - playerPos.y, 2)
                    )
                    
                    if distance <= CONFIG.attack.targetDistance then
                        if CONFIG.attack.prioritizeLowHp and healthPercent < bestTargetHp then
                            bestTarget = creatureId
                            bestTargetHp = healthPercent
                        elseif not bestTarget then
                            bestTarget = creatureId
                            bestTargetHp = healthPercent
                        end
                    end
                end
            end
        end
    end
    
    return bestTarget
end

--- Ataca o melhor alvo disponível
local function performAttack()
    if not CONFIG.attack.enabled then
        return
    end
    
    local currentTime = os.time() * 1000
    
    if currentTime - lastAttackTime >= ATTACK_DELAY then
        local targetId = findBestTarget()
        
        if targetId then
            local currentTarget = Player.getTargetId()
            
            if currentTarget ~= targetId then
                Game.attack(targetId)
                lastAttackTime = currentTime
            end
        end
    end
end

--- Configura as waypoints no CaveBot
local function setupWaypoints()
    -- Limpa waypoints existentes
    CaveBot.clearWaypoints()
    
    -- Adiciona novas waypoints da configuração
    for _, wp in ipairs(CONFIG.waypoints) do
        CaveBot.addWaypoint(wp.type or Enums.WaypointType.WAYPOINT_TYPE_STAND, 
                           wp.x, wp.y, wp.z, wp.extraData)
    end
    
    print("[BOT] " .. #CONFIG.waypoints .. " waypoints configurados.")
end

--- Inicia o cavebot
local function startCavebot()
    if #CONFIG.waypoints > 0 then
        CaveBot.setStartFromNearestWaypoint(true)
        -- O cavebot começará automaticamente após configurar as waypoints
        print("[BOT] CaveBot iniciado!")
    else
        print("[BOT] Nenhuma waypoint configurada. Adicione waypoints em CONFIG.waypoints")
    end
end

-- ============================================
-- LOOP PRINCIPAL DO BOT
-- ============================================
local function botLoop()
    -- Verifica healing
    if canUseHeal() then
        useHeal()
    end
    
    -- Verifica ataque
    performAttack()
    
    -- O CaveBot cuida da navegação automaticamente
end

-- ============================================
-- INICIALIZAÇÃO
-- ============================================
print("========================================")
print("BOT INICIADO - CONFIGURAÇÃO")
print("========================================")
print("Posição Inicial: " .. CONFIG.startPos.x .. ", " .. CONFIG.startPos.y .. ", " .. CONFIG.startPos.z)
print("Heal HP: " .. CONFIG.heal.healthPercent .. "% | Mana Mínima: " .. CONFIG.heal.minMana)
print("Spell de Cura: " .. CONFIG.heal.spellName)
print("Attack Enabled: " .. tostring(CONFIG.attack.enabled))
print("Waypoints: " .. #CONFIG.waypoints)
print("========================================")

-- Configura waypoints se houver
if #CONFIG.waypoints > 0 then
    setupWaypoints()
    startCavebot()
end

-- Registra o loop principal (depende do engine do bot)
-- Se o engine suportar eventos/timers:
if Engine and Engine.registerEvent then
    Engine.registerEvent("botLoop", botLoop, 100) -- Executa a cada 100ms
else
    -- Fallback: chama botLoop diretamente se não houver engine
    print("[BOT] Use a função botLoop() no seu loop principal ou timer")
end

-- Exporta funções para uso externo
Bot = {
    start = startCavebot,
    stop = function() CaveBot.clearWaypoints() end,
    addWaypoint = function(x, y, z, type) 
        table.insert(CONFIG.waypoints, {x = x, y = y, z = z, type = type or Enums.WaypointType.WAYPOINT_TYPE_STAND})
    end,
    setHealConfig = function(hpPercent, minMana, spellName)
        CONFIG.heal.healthPercent = hpPercent
        CONFIG.heal.minMana = minMana
        CONFIG.heal.spellName = spellName
    end,
    addTarget = function(name) 
        table.insert(CONFIG.targetList, name:lower())
    end,
    addIgnore = function(name) 
        table.insert(CONFIG.ignoreList, name:lower())
    end,
    loop = botLoop
}

print("[BOT] Bot pronto! Configure as waypoints e ajuste as settings em CONFIG.")
print("[BOT] Use Bot.start() para iniciar, Bot.loop() no seu tick principal.")
