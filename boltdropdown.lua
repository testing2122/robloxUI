local dd = {};
local ts = game:GetService("TweenService");

local function createdropitem(txt, parent)
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(1, 0, 0, 30);
    btn.Text = txt;
    btn.TextColor3 = Color3.new(1, 1, 1);
    btn.TextXAlignment = Enum.TextXAlignment.Center;
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    btn.Parent = parent;
    return btn;
end;

function dd:init(btn)
    local list = Instance.new("Frame");
    list.Name = "droplist";
    list.Size = UDim2.new(1, 0, 0, 0);
    list.Position = UDim2.new(0, 0, 1, 0);
    list.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
    list.ClipsDescendants = true;
    list.Visible = false;
    list.ZIndex = 10;
    list.Parent = btn;
    
    local ull = Instance.new("UIListLayout");
    ull.Parent = list;
    
    local models = {
        "GPT-4 Turbo",
        "Claude-3",
        "Gemini Pro",
        "Llama 3"
    };
    
    for _, m in pairs(models) do
        local itm = createdropitem(m, list);
        itm.MouseButton1Click:Connect(function()
            btn.Text = m;
            list.Visible = false;
        end);
    end;
    
    local arrow = Instance.new("TextLabel");
    arrow.Size = UDim2.new(0.1, 0, 1, 0);
    arrow.Position = UDim2.new(0.9, 0, 0, 0);
    arrow.Text = "▼";
    arrow.TextColor3 = Color3.new(1, 1, 1);
    arrow.BackgroundTransparency = 1;
    arrow.Parent = btn;
    
    btn.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible;
        arrow.Text = list.Visible and "▲" or "▼";
        
        local goal = {
            Size = list.Visible and UDim2.new(1, 0, 0, #models * 30) or UDim2.new(1, 0, 0, 0)
        };
        ts:Create(list, TweenInfo.new(0.3), goal):Play();
    end);
    
    uis = game:GetService("UserInputService");
    local conn;
    conn = uis.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local pos = uis:GetMouseLocation();
            local btnpos = btn.AbsolutePosition;
            local btnsize = btn.AbsoluteSize;
            local listpos = list.AbsolutePosition;
            local listsize = list.AbsoluteSize;
            
            if list.Visible and not (pos.X >= btnpos.X and pos.X <= btnpos.X + btnsize.X and
                pos.Y >= btnpos.Y and pos.Y <= btnpos.Y + btnsize.Y) and
                not (pos.X >= listpos.X and pos.X <= listpos.X + listsize.X and
                pos.Y >= listpos.Y and pos.Y <= listpos.Y + listsize.Y) then
                
                list.Visible = false;
                arrow.Text = "▼";
                local goal = {
                    Size = UDim2.new(1, 0, 0, 0)
                };
                ts:Create(list, TweenInfo.new(0.3), goal):Play();
            end;
        end;
    end);
    
    btn.Destroying:Connect(function()
        if conn then conn:Disconnect(); end;
    end);
end;

return dd; 
