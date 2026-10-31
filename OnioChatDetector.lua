-- 🌸 OnioChatDetector | OnioScripts
-- Detector independiente de anuncios de huevos.

local TextChatService = game:GetService("TextChatService")

local PRIORITY = {
    divine = 1,
    eternal = 2,
    secret = 3
}

local seen = {}

local function inspectMessage(message)
    if not message or typeof(message.Text) ~= "string" then
        return
    end

    local text = message.Text

    local rarity, egg, zone = string.match(
        text,
        "[Aa]n?%s+(%a+)%s+(.+)%s+[Ee]gg%s+spawned%s+in%s+(.+)[!%.]?$"
    )

    if not rarity then
        return
    end

    local normalized = string.lower(rarity)

    if not PRIORITY[normalized] then
        return
    end

    local key = string.lower(text)

    if seen[key] then
        return
    end

    seen[key] = true

    print("🌸 ONIO ANNOUNCEMENT DETECTED")
    print("Rarity: " .. rarity)
    print("Egg: " .. egg .. " Egg")
    print("Zone: " .. zone)
    print("Priority: " .. PRIORITY[normalized])
end

print("🌸 OnioChatDetector started")
print("Waiting for Divine, Eternal and Secret announcements...")

TextChatService.MessageReceived:Connect(inspectMessage)
