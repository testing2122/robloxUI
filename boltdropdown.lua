local dd = {};
local ts = game:GetService("TweenService");

local function createdropitem(txt, parent)
    local btn = Instance.new("TextButton");
    btn.Size = UDim2.new(1, 0, 0, 30);
    btn.Text = txt;
    btn.TextColor3 = Color3.new(1, 1, 1);
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
    list.Parent = btn;
    
    local ull = Instance.new("UIListLayout");
    ull.Parent = list;
    
    local models = {
        "GPT-4 Turbo",
        "Claude-3",
        "Gemini Pro",
        "LLaMA-2"
    };
    
    for _, m in models do
        local itm = createdropitem(m, list);
        itm.MouseButton1Click:Connect(function()
            btn.Text = m;
            list.Visible = false;
        end);
    end;
    
    btn.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible;
        local goal = {
            Size = list.Visible and UDim2.new(1, 0, 0, #models * 30) or UDim2.new(1, 0, 0, 0)
        };
        ts:Create(list, TweenInfo.new(0.3), goal):Play();
    end);
end;

return dd; 
