local chat = {};
local ts = game:GetService("TweenService");
local plrs = game:GetService("Players");

local function createmsg(txt, isuser, parent)
    local msg = Instance.new("Frame");
    msg.Size = UDim2.new(0.9, 0, 0, 50);
    msg.Position = UDim2.new(0.05, 0, 0, 0);
    msg.BackgroundColor3 = isuser and Color3.fromRGB(89, 0, 179) or Color3.fromRGB(30, 30, 30);
    msg.Parent = parent;
    
    local name = Instance.new("TextLabel");
    name.Size = UDim2.new(1, 0, 0, 20);
    name.Text = isuser and plrs.LocalPlayer.Name or "Assistant";
    name.TextColor3 = Color3.new(1, 1, 1);
    name.TextXAlignment = isuser and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
    name.BackgroundTransparency = 1;
    name.Parent = msg;
    
    local content = Instance.new("TextLabel");
    content.Size = UDim2.new(1, 0, 1, -20);
    content.Position = UDim2.new(0, 0, 0, 20);
    content.Text = txt;
    content.TextColor3 = Color3.new(1, 1, 1);
    content.TextWrapped = true;
    content.BackgroundTransparency = 1;
    content.Parent = msg;
    
    return msg;
end;

function chat:init(chatbox)
    local msgs = Instance.new("ScrollingFrame");
    msgs.Size = UDim2.new(1, 0, 0.8, 0);
    msgs.BackgroundTransparency = 1;
    msgs.Parent = chatbox;
    
    local ull = Instance.new("UIListLayout");
    ull.Parent = msgs;
    
    local codepanel = Instance.new("Frame");
    codepanel.Size = UDim2.new(0, 0, 1, 0);
    codepanel.Position = UDim2.new(1, 0, 0, 0);
    codepanel.BackgroundColor3 = Color3.fromRGB(22, 22, 22);
    codepanel.Parent = chatbox;
    
    local input = chatbox:WaitForChild("input");
    
    input.FocusLost:Connect(function(enter)
        if not enter then return; end;
        
        local txt = input.Text;
        if txt == "" then return; end;
        
        local msg = createmsg(txt, true, msgs);
        
        if txt:find("```") then
            local goal = {
                Size = UDim2.new(0.4, 0, 1, 0)
            };
            ts:Create(codepanel, TweenInfo.new(0.3), goal):Play();
            
            local goal2 = {
                Size = UDim2.new(0.6, 0, 1, 0)
            };
            ts:Create(msgs, TweenInfo.new(0.3), goal2):Play();
        end;
        
        input.Text = "";
    end);
end;

return chat; 
