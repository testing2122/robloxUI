local dd = {};
local ts = game:GetService("TweenService");

local function createdropitem(txt, parent)
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(1, 0, 0, 35);
    btn.Text = txt;
    btn.TextColor3 = Color3.new(1, 1, 1);
    btn.TextXAlignment = Enum.TextXAlignment.Left;
    btn.TextSize = 14;
    btn.Font = Enum.Font.Gotham;
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
    btn.AutoButtonColor = false;
    
    local padding = Instance.new("UIPadding");
    padding.PaddingLeft = UDim.new(0, 10);
    padding.Parent = btn;
    
    local hover = Instance.new("Frame");
    hover.Size = UDim2.new(1, 0, 1, 0);
    hover.BackgroundColor3 = Color3.fromRGB(89, 0, 179);
    hover.BackgroundTransparency = 1;
    hover.Parent = btn;
    
    btn.MouseEnter:Connect(function()
        ts:Create(hover, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play();
    end);
    
    btn.MouseLeave:Connect(function()
        ts:Create(hover, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play();
    end);
    
    btn.Parent = parent;
    return btn;
end;

function dd:init(btn)
    local list = Instance.new("Frame");
    list.Name = "droplist";
    list.Size = UDim2.new(1, 0, 0, 0);
    list.Position = UDim2.new(0, 0, 1, 5);
    list.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
    list.ClipsDescendants = true;
    list.Visible = false;
    list.ZIndex = 10;
    list.Parent = btn;
    
    local corner = Instance.new("UICorner");
    corner.CornerRadius = UDim.new(0, 4);
    corner.Parent = list;
    
    local ull = Instance.new("UIListLayout");
    ull.Padding = UDim.new(0, 2);
    ull.Parent = list;
    
    local models = {
        {name = "OpenRouter", price = "Not Set"},
        {name = "DeepSeek V3", price = "$0.00"},
        {name = "Claude-3", price = "$3.00"},
        {name = "GPT-4", price = "$2.00"}
    };
    
    for _, m in models do
        local itm = createdropitem(m.name .. " - " .. m.price, list);
        itm.MouseButton1Click:Connect(function()
            btn.Text = m.name;
            list.Visible = false;
        end);
    end;
    
    btn.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible;
        local goal = {
            Size = list.Visible and UDim2.new(1, 0, 0, #models * 37) or UDim2.new(1, 0, 0, 0)
        };
        ts:Create(list, TweenInfo.new(0.3), goal):Play();
    end);
end;

return dd; 
