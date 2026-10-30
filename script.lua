
-- 🌸 OnioScripts | Server Hop

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("OnioScripts")
if oldGui then oldGui:Destroy() end

-- GUI principal
local gui = Instance.new("ScreenGui")
gui.Name = "OnioScripts"
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Círculo 🌸
local circle = Instance.new("TextButton")
circle.Name = "FlowerButton"
circle.Size = UDim2.fromOffset(54, 54)
circle.AnchorPoint = Vector2.new(1, 0)
circle.Position = UDim2.new(1, -10, 0, 35)
circle.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
circle.BackgroundTransparency = 0.12
circle.Text = "🌸"
circle.TextSize = 29
circle.AutoButtonColor = false
circle.Active = true
circle.Parent = gui

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circle

local circleStroke = Instance.new("UIStroke")
circleStroke.Color = Color3.fromRGB(190, 100, 255)
circleStroke.Thickness = 1.5
circleStroke.Parent = circle

-- Panel
local panel = Instance.new("Frame")
panel.Name = "MainPanel"
panel.Size = UDim2.fromOffset(220, 142)
panel.AnchorPoint = Vector2.new(1, 0)
panel.Position = UDim2.new(1, -10, 0, 35)
panel.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
panel.BackgroundTransparency = 0.15
panel.Visible = false
panel.Active = true
panel.Parent = gui

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 10)
panelCorner.Parent = panel

local panelStroke = Instance.new("UIStroke")
panelStroke.Color = Color3.fromRGB(190, 100, 255)
panelStroke.Thickness = 1.3
panelStroke.Parent = panel

-- Encabezado
local header = Instance.new("TextLabel")
header.Size = UDim2.new(1, -38, 0, 32)
header.Position = UDim2.fromOffset(8, 3)
header.BackgroundTransparency = 1
header.Text = "🌸OnioScripts"
header.TextColor3 = Color3.fromRGB(235, 210, 255)
header.TextSize = 16
header.Font = Enum.Font.GothamBold
header.TextXAlignment = Enum.TextXAlignment.Left
header.Active = false
header.Parent = panel

-- Zona vacía para arrastrar
local dragArea = Instance.new("TextButton")
dragArea.Name = "DragArea"
dragArea.Size = UDim2.new(1, -45, 0, 12)
dragArea.Position = UDim2.fromOffset(8, 27)
dragArea.BackgroundTransparency = 1
dragArea.Text = ""
dragArea.Parent = panel

-- Minimizar
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(28, 27)
minimize.Position = UDim2.new(1, -32, 0, 4)
minimize.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
minimize.Text = "−"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBold
minimize.Parent = panel

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = minimize

-- Botón Cambio
local changeButton = Instance.new("TextButton")
changeButton.Size = UDim2.new(1, -20, 0, 36)
changeButton.Position = UDim2.fromOffset(10, 42)
changeButton.BackgroundColor3 = Color3.fromRGB(105, 55, 145)
changeButton.Text = "Cambio"
changeButton.TextColor3 = Color3.new(1, 1, 1)
changeButton.TextSize = 14
changeButton.Font = Enum.Font.GothamBold
changeButton.Parent = panel

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 7)
buttonCorner.Parent = changeButton

-- Estado
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -16, 0, 20)
status.Position = UDim2.fromOffset(8, 82)
status.BackgroundTransparency = 1
status.Text = "Listo"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextSize = 11
status.Font = Enum.Font.Gotham
status.Parent = panel

-- Pie de página
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, -10, 0, 18)
footer.Position = UDim2.new(0, 5, 1, -21)
footer.BackgroundTransparency = 1
footer.Text = "Es mi primer script no hate xd"
footer.TextColor3 = Color3.fromRGB(160, 160, 160)
footer.TextSize = 9
footer.Font = Enum.Font.Gotham
footer.Parent = panel

-- Abrir y cerrar
local function openPanel()
    panel.Position = circle.Position
    circle.Visible = false
    panel.Visible = true
end

local function closePanel()
    circle.Position = panel.Position
    panel.Visible = false
    circle.Visible = true
end

minimize.Activated:Connect(closePanel)

-- Arrastrar
local function makeDraggable(target, onTap)
    local dragging = false
    local moved = false
    local startInput
    local startPosition
    local activeInput

    target.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            moved = false
            startInput = input.Position
            startPosition = target.Position
            activeInput = input.UserInputType == Enum.UserInputType.Touch and input or nil
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or (input.UserInputType == Enum.UserInputType.Touch
                and (activeInput == nil or input == activeInput)) then

            local delta = input.Position - startInput

            if math.abs(delta.X) > 6 or math.abs(delta.Y) > 6 then
                moved = true
            end

            target.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if not dragging then return end

        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = false

            if not moved and onTap then
                onTap()
            end
        end
    end)
end

makeDraggable(circle, openPanel)
makeDraggable(dragArea, nil)

-- Server Hop
local hopping = false

local function serverHop()
    if hopping then return end

    hopping = true
    changeButton.Active = false
    changeButton.Text = "Buscando..."
    status.Text = "Buscando servidor..."

    local placeId = game.PlaceId
    local currentJobId = game.JobId
    local cursor = nil
    local candidates = {}

    local success, err = pcall(function()
        for page = 1, 5 do
            local url = "https://games.roblox.com/v1/games/"
                .. placeId
                .. "/servers/Public?sortOrder=Asc&limit=100"

            if cursor then
                url = url .. "&cursor=" .. HttpService:UrlEncode(cursor)
            end

            local response = game:HttpGet(url)
            local data = HttpService:JSONDecode(response)

            for _, server in ipairs(data.data or {}) do
                if server.id ~= currentJobId
                    and server.playing < server.maxPlayers then
                    table.insert(candidates, server.id)
                end
            end

            cursor = data.nextPageCursor
            if not cursor or #candidates >= 20 then break end
        end
    end)

    if not success then
        status.Text = "No se pudo buscar"
        changeButton.Text = "Reintentar"
        changeButton.Active = true
        hopping = false
        warn("OnioScripts server hop:", err)
        return
    end

    if #candidates == 0 then
        status.Text = "No hay servidores"
        changeButton.Text = "Reintentar"
        changeButton.Active = true
        hopping = false
        return
    end

    local targetId = candidates[math.random(1, #candidates)]
    status.Text = "Cambiando..."

    local teleportSuccess, teleportErr = pcall(function()
        TeleportService:TeleportToPlaceInstance(placeId, targetId, player)
    end)

    if not teleportSuccess then
        status.Text = "Error al cambiar"
        changeButton.Text = "Reintentar"
        changeButton.Active = true
        hopping = false
        warn("OnioScripts teleport:", teleportErr)
    end
end

changeButton.Activated:Connect(serverHop)

TeleportService.TeleportInitFailed:Connect(function(
    teleportPlayer,
    teleportResult,
    errorMessage
)
    if teleportPlayer == player then
        hopping = false
        changeButton.Active = true
        changeButton.Text = "Reintentar"
        status.Text = "Teletransporte fallido"
        warn("OnioScripts:", teleportResult, errorMessage)
    end
end)

print("🌸 OnioScripts cargado")
