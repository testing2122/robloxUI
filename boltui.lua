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
    
    local pos = 0;
    local con;
    con = rs.RenderStepped:Connect(function()
        if not frm or not frm.Parent then con:Disconnect(); return; end;
        pos = (pos + 1) % 400;
        outline.Transparency = math.sin(pos / 100);
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
    main.Parent = gui;
    
    local header = Instance.new("Frame");
    header.Name = "header";
    header.Size = UDim2.new(1, 0, 0.08, 0);
    header.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
    header.Parent = main;
    
    local title = Instance.new("TextLabel");
    title.Name = "title";
    title.Size = UDim2.new(1, 0, 1, 0);
    title.Text = "Good " .. gettime();
    title.TextColor3 = Color3.new(1, 1, 1);
    title.TextSize = 24;
    title.Font = Enum.Font.GothamBold;
    title.TextXAlignment = Enum.TextXAlignment.Center;
    title.BackgroundTransparency = 1;
    title.Parent = header;
    
    local sidebar = Instance.new("Frame");
    sidebar.Name = "sidebar";
    sidebar.Size = UDim2.new(0.25, 0, 1, 0);
    sidebar.BackgroundColor3 = Color3.fromRGB(22, 22, 22);
    sidebar.Parent = main;
    
    local newchat = Instance.new("TextButton");
    newchat.Name = "newChat";
    newchat.Size = UDim2.new(0.9, 0, 0.05, 0);
    newchat.Position = UDim2.new(0.05, 0, 0.02, 0);
    newchat.Text = "Start new chat";
    newchat.TextColor3 = Color3.new(1, 1, 1);
    newchat.TextXAlignment = Enum.TextXAlignment.Center;
    newchat.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    newchat.Parent = sidebar;
    
    local impbtn = Instance.new("TextButton");
    impbtn.Name = "importChat";
    impbtn.Size = UDim2.new(0.9, 0, 0.05, 0);
    impbtn.Position = UDim2.new(0.05, 0, 0.93, 0);
    impbtn.Text = "Import Chat";
    impbtn.TextColor3 = Color3.new(1, 1, 1);
    impbtn.TextXAlignment = Enum.TextXAlignment.Center;
    impbtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    impbtn.Parent = sidebar;
    
    local chatbox = Instance.new("Frame");
    chatbox.Name = "chatbox";
    chatbox.Size = UDim2.new(0.75, 0, 0.92, 0);
    chatbox.Position = UDim2.new(0.25, 0, 0.08, 0);
    chatbox.BackgroundColor3 = Color3.fromRGB(22, 22, 22);
    chatbox.Parent = main;
    
    local dropdown = Instance.new("TextButton");
    dropdown.Name = "dropdown";
    dropdown.Size = UDim2.new(0.9, 0, 0.05, 0);
    dropdown.Position = UDim2.new(0.05, 0, 0.02, 0);
    dropdown.Text = "Select Model";
    dropdown.TextColor3 = Color3.new(1, 1, 1);
    dropdown.TextXAlignment = Enum.TextXAlignment.Center;
    dropdown.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    dropdown.Parent = chatbox;
    
    local inputframe = Instance.new("Frame");
    inputframe.Name = "inputframe";
    inputframe.Size = UDim2.new(0.9, 0, 0.08, 0);
    inputframe.Position = UDim2.new(0.05, 0, 0.9, 0);
    inputframe.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
    inputframe.Parent = chatbox;
    
    local input = Instance.new("TextBox");
    input.Name = "input";
    input.Size = UDim2.new(0.98, 0, 0.9, 0);
    input.Position = UDim2.new(0.01, 0, 0.05, 0);
    input.Text = "How can Bolt help you today?";
    input.TextColor3 = Color3.new(1, 1, 1);
    input.BackgroundTransparency = 1;
    input.Parent = inputframe;
    
    animoutline(main);
    animoutline(sidebar);
    animoutline(chatbox);
    animoutline(inputframe);
    
    impbtn.MouseButton1Click:Connect(function()
        local files = listfiles("workspace");
    end);
    
    return gui;
end;

return bui; 
