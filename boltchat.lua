local chat = {};
local ts = game:GetService("TweenService");
local plrs = game:GetService("Players");

local function createmsg(txt, isuser, parent)
    local msg = Instance.new("Frame");
    msg.Size = UDim2.new(0.9, 0, 0, 50);
    msg.Position = UDim2.new(isuser and 0.05 or 0.05, 0, 0, 0);
    msg.BackgroundColor3 = isuser and Color3.fromRGB(89, 0, 179) or Color3.fromRGB(30, 30, 30);
    msg.BackgroundTransparency = 0.3;
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
    content.TextXAlignment = isuser and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left;
    content.BackgroundTransparency = 1;
    content.Parent = msg;
    
    return msg;
end;

function chat:init(chatbox)
    local msgs = Instance.new("ScrollingFrame");
    msgs.Name = "messages";
    msgs.Size = UDim2.new(0.9, 0, 0.8, 0);
    msgs.Position = UDim2.new(0.05, 0, 0.08, 0);
    msgs.BackgroundTransparency = 1;
    msgs.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    msgs.CanvasSize = UDim2.new(0, 0, 0, 0);
    msgs.ScrollBarThickness = 4;
    msgs.Parent = chatbox;
    
    local ull = Instance.new("UIListLayout");
    ull.Padding = UDim.new(0, 10);
    ull.Parent = msgs;
    
    local codepanel = Instance.new("Frame");
    codepanel.Name = "codepanel";
    codepanel.Size = UDim2.new(0, 0, 1, 0);
    codepanel.Position = UDim2.new(1, 0, 0, 0);
    codepanel.BackgroundColor3 = Color3.fromRGB(15, 15, 15);
    codepanel.Visible = false;
    codepanel.Parent = chatbox;
    
    local codetitle = Instance.new("TextLabel");
    codetitle.Size = UDim2.new(1, 0, 0.05, 0);
    codetitle.Text = "Code";
    codetitle.TextColor3 = Color3.new(1, 1, 1);
    codetitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    codetitle.Parent = codepanel;
    
    local codecontent = Instance.new("ScrollingFrame");
    codecontent.Size = UDim2.new(1, 0, 0.95, 0);
    codecontent.Position = UDim2.new(0, 0, 0.05, 0);
    codecontent.BackgroundTransparency = 1;
    codecontent.AutomaticCanvasSize = Enum.AutomaticSize.Y;
    codecontent.CanvasSize = UDim2.new(0, 0, 0, 0);
    codecontent.ScrollBarThickness = 4;
    codecontent.Parent = codepanel;
    
    local codetext = Instance.new("TextLabel");
    codetext.Size = UDim2.new(0.95, 0, 0, 0);
    codetext.Position = UDim2.new(0.025, 0, 0, 0);
    codetext.TextColor3 = Color3.new(1, 1, 1);
    codetext.TextWrapped = true;
    codetext.TextXAlignment = Enum.TextXAlignment.Left;
    codetext.TextYAlignment = Enum.TextYAlignment.Top;
    codetext.BackgroundTransparency = 1;
    codetext.AutomaticSize = Enum.AutomaticSize.Y;
    codetext.Parent = codecontent;
    
    local input = chatbox:FindFirstChild("inputframe"):FindFirstChild("input");
    
    input.FocusLost:Connect(function(enter)
        if not enter then return; end;
        
        local txt = input.Text;
        if txt == "" then return; end;
        
        local msg = createmsg(txt, true, msgs);
        
        if txt:find("```") then
            codepanel.Visible = true;
            local code = txt:match("```(.-)```");
            if code then
                codetext.Text = code;
            end;
            
            local goal = {
                Size = UDim2.new(0.4, 0, 1, 0)
            };
            ts:Create(codepanel, TweenInfo.new(0.3), goal):Play();
            
            local goal2 = {
                Size = UDim2.new(0.6, 0, 0.8, 0)
            };
            ts:Create(msgs, TweenInfo.new(0.3), goal2):Play();
        else
            local resp = createmsg("This is a sample response from the AI assistant.", false, msgs);
            task.wait(0.1);
            msgs.CanvasPosition = Vector2.new(0, msgs.CanvasSize.Y.Offset);
        end;
        
        input.Text = "";
    end);
end;

return chat; 
