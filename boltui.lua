local bui = {};
local ts = game:GetService("TweenService");
local plrs = game:GetService("Players");
local rs = game:GetService("RunService");
local uis = game:GetService("UserInputService");

local function gettime()
    local hr = os.date("*t").hour;
    if hr >= 5 and hr < 12 then return "morning";
    elseif hr >= 12 and hr < 18 then return "afternoon";
    else return "night"; end;
end;

local function animoutline(frm)
    local outline = Instance.new("UIStroke", frm);
    outline.Color = Color3.fromRGB(89, 0, 179);
    outline.Thickness = 1;
    outline.Transparency = 0.7;
    
    local pos = 0;
    local con;
    con = rs.RenderStepped:Connect(function()
        if not frm or not frm.Parent then con:Disconnect(); return; end;
        pos = (pos + 1) % 400;
        outline.Transparency = 0.7 + math.sin(pos / 100) * 0.3;
    end);
end;

function bui:init()
    local gui = Instance.new("ScreenGui");
    gui.Name = "boltUI";
    gui.Parent = game:GetService("CoreGui");
    
    local main = Instance.new("Frame");
    main.Name = "main";
    main.Size = UDim2.new(0.8, 0, 0.8, 0);
    main.Position = UDim2.new(0.1, 0, 0.1, 0);
    main.BackgroundColor3 = Color3.fromRGB(18, 18, 18);
    main.ClipsDescendants = true;
    main.Parent = gui;
    
    local grad = Instance.new("UIGradient");
    grad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(89, 0, 179)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(30, 30, 30)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 18, 18))
    });
    grad.Rotation = 45;
    grad.Parent = main;
    
    local title = Instance.new("TextLabel");
    title.Name = "title";
    title.Size = UDim2.new(1, 0, 0.1, 0);
    title.Text = "Good " .. gettime();
    title.TextColor3 = Color3.new(1, 1, 1);
    title.TextSize = 32;
    title.Font = Enum.Font.GothamBold;
    title.BackgroundTransparency = 1;
    title.Parent = main;
    
    local subtitle = Instance.new("TextLabel");
    subtitle.Size = UDim2.new(1, 0, 0.05, 0);
    subtitle.Position = UDim2.new(0, 0, 0.1, 0);
    subtitle.Text = "Bring ideas to life in seconds or get help on existing projects.";
    subtitle.TextColor3 = Color3.fromRGB(180, 180, 180);
    subtitle.TextSize = 14;
    subtitle.Font = Enum.Font.Gotham;
    subtitle.BackgroundTransparency = 1;
    subtitle.Parent = main;
    
    local sidebar = Instance.new("Frame");
    sidebar.Name = "sidebar";
    sidebar.Size = UDim2.new(0.2, 0, 1, 0);
    sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 22);
    sidebar.Parent = main;
    
    local newchat = Instance.new("TextButton");
    newchat.Name = "newChat";
    newchat.Size = UDim2.new(0.9, 0, 0.05, 0);
    newchat.Position = UDim2.new(0.05, 0, 0.02, 0);
    newchat.Text = "Start new chat";
    newchat.TextColor3 = Color3.new(1, 1, 1);
    newchat.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
    newchat.AutoButtonColor = false;
    newchat.Parent = sidebar;
    
    local chatbox = Instance.new("Frame");
    chatbox.Name = "chatbox";
    chatbox.Size = UDim2.new(0.8, 0, 0.9, 0);
    chatbox.Position = UDim2.new(0.2, 0, 0.1, 0);
    chatbox.BackgroundColor3 = Color3.fromRGB(22, 22, 22);
    chatbox.Parent = main;
    
    local input = Instance.new("TextBox");
    input.Name = "input";
    input.Size = UDim2.new(0.9, 0, 0.1, 0);
    input.Position = UDim2.new(0.05, 0, 0.85, 0);
    input.Text = "How can I help you today?";
    input.TextColor3 = Color3.fromRGB(180, 180, 180);
    input.TextXAlignment = Enum.TextXAlignment.Left;
    input.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
    input.ClearTextOnFocus = true;
    input.Parent = chatbox;
    
    local inputicons = Instance.new("Frame");
    inputicons.Size = UDim2.new(0.15, 0, 1, 0);
    inputicons.Position = UDim2.new(0.85, 0, 0, 0);
    inputicons.BackgroundTransparency = 1;
    inputicons.Parent = input;
    
    local sendbtn = Instance.new("ImageButton");
    sendbtn.Size = UDim2.new(0.3, 0, 0.6, 0);
    sendbtn.Position = UDim2.new(0.7, 0, 0.2, 0);
    sendbtn.BackgroundColor3 = Color3.fromRGB(89, 0, 179);
    sendbtn.Parent = inputicons;
    
    local dropdown = Instance.new("TextButton");
    dropdown.Name = "dropdown";
    dropdown.Size = UDim2.new(0.3, 0, 0.05, 0);
    dropdown.Position = UDim2.new(0.05, 0, 0.02, 0);
    dropdown.Text = "Select Model";
    dropdown.TextColor3 = Color3.new(1, 1, 1);
    dropdown.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
    dropdown.AutoButtonColor = false;
    dropdown.Parent = chatbox;
    
    local impbtn = Instance.new("TextButton");
    impbtn.Name = "importChat";
    impbtn.Size = UDim2.new(0.9, 0, 0.05, 0);
    impbtn.Position = UDim2.new(0.05, 0, 0.93, 0);
    impbtn.Text = "Import Chat";
    impbtn.TextColor3 = Color3.new(1, 1, 1);
    impbtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
    impbtn.AutoButtonColor = false;
    impbtn.Parent = sidebar;
    
    animoutline(main);
    animoutline(chatbox);
    animoutline(input);
    animoutline(dropdown);
    animoutline(newchat);
    animoutline(impbtn);
    
    impbtn.MouseButton1Click:Connect(function()
        local files = listfiles("workspace");
    end);
    
    return gui;
end;

return bui; 
