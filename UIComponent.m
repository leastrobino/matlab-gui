%
%  UIComponent.m
%
%  Created by Léa Strobino.
%  Copyright 2017. All rights reserved.
%

classdef UIComponent < dynamicprops
  
  properties (Constant, Hidden)
    ClassVersion = '1.2';
  end
  
  properties (SetAccess = private)
    Type
  end
  
  properties
    Tag
  end
  
  properties (Access = private)
    handle %#ok<*CPROP>
    wrapper
  end
  
  methods (Static)
    
    function this = Axes(varargin)
      d = {'HandleVisibility','off',...
        'Units','pixels'};
      this = axes(d{:},varargin{:});
    end
    
    function this = Button(varargin)
      o.Callback = [];
      o.Enable = 'on';
      o.Icon = [];
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.String = '';
      o.Tag = '';
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('button',o);
      this.handle = this.javacomponent('javax.swing.JButton',o.String,o.Icon);
      this.addProperty('Callback',[],@setCallback,[],o.Callback);
      this.addProperty('Enable',[],@setEnable,[],o.Enable);
      this.addProperty('Icon',o.Icon,@setIcon);
      this.addProperty('String',o.String,@setString);
    end
    
    function this = CheckBox(varargin)
      o.Callback = [];
      o.Enable = 'on';
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.String = '';
      o.Tag = '';
      o.Value = false;
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('checkbox',o);
      this.handle = this.javacomponent('javax.swing.JCheckBox',o.String);
      this.handle.Selected = logical(o.Value);
      this.addProperty('Callback',[],@setCallback,[],o.Callback);
      this.addProperty('Enable',[],@setEnable,[],o.Enable);
      this.addProperty('String',o.String,@setString);
      this.addProperty('Value',o.Value,@setValue,@getValue);
    end
    
    function this = ComboBox(varargin)
      o.Callback = [];
      o.Enable = 'on';
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.String = {''};
      o.Tag = '';
      o.Value = 1;
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      o.String = reshape(o.String,1,[]);
      this = UIComponent('combobox',o);
      this.handle = this.javacomponent('javax.swing.JComboBox',o.String);
      this.handle.SelectedIndex = o.Value-1;
      this.addProperty('Callback',[],@setCallback,[],o.Callback);
      this.addProperty('Enable',[],@setEnable,[],o.Enable);
      this.addProperty('String',o.String,@setString);
      this.addProperty('Value',o.Value,@setValue,@getValue);
    end
    
    function this = ContextMenu(varargin)
      d = {'CreateFcn',[],...
        'HandleVisibility','off'};
      this = uicontextmenu(d{:},varargin{:});
    end
    
    function this = Dial(varargin)
      UIComponent.loadJFreeChart();
      o.BackgroundColor = [1 1 1];
      o.ForegroundColor = [0 0 0];
      o.IndicatorAngle = -90;
      o.IndicatorNumberFormat = '0';
      o.Min = -180;
      o.Max = 179;
      o.MinorTickSpacing = 5;
      o.MajorTickSpacing = 30;
      o.NeedleColor = [1 0 0];
      o.NumberFormat = o.IndicatorNumberFormat;
      o.Parent = [];
      o.Position = [20 20 150 150];
      o.StartAngle = o.Min;
      o.StopAngle = o.Max;
      o.Tag = '';
      o.Value = 0;
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      dataset = javaObjectEDT('org.jfree.data.general.DefaultValueDataset',o.Value);
      dial = javaObjectEDT('org.jfree.chart.plot.dial.DialPlot',dataset);
      dial.setView(0,0,1,1);
      frame = javaObjectEDT('org.jfree.chart.plot.dial.StandardDialFrame');
      dial.setDialFrame(frame);
      scale = javaObjectEDT('org.jfree.chart.plot.dial.StandardDialScale');
      scale.setTickRadius(.9);
      scale.setTickLabelOffset(.2);
      scale.setTickLabelFont(java.awt.Font('Dialog',0,16));
      dial.addScale(0,scale);
      valueIndicator = javaObjectEDT('org.jfree.chart.plot.dial.DialValueIndicator',0);
      valueIndicator.setRadius(.3);
      valueIndicator.setFont(java.awt.Font('Dialog',1,24));
      valueIndicator.setTextAnchor(org.jfree.ui.TextAnchor.CENTER);
      valueIndicator.setValueAnchor(org.jfree.ui.RectangleAnchor.CENTER);
      dial.addLayer(valueIndicator);
      needle = javaObjectEDT('org.jfree.chart.plot.dial.DialPointer$Pin',0);
      dial.addLayer(needle);
      cap = javaObjectEDT('org.jfree.chart.plot.dial.DialCap');
      cap.setRadius(.05);
      dial.setCap(cap);
      this = UIComponent('dial',o);
      this.handle.dataset = dataset;
      this.handle.dial = dial;
      this.handle.frame = frame;
      this.handle.scale = scale;
      this.handle.valueIndicator = valueIndicator;
      this.handle.needle = needle;
      this.handle.cap = cap;
      this.addProperty('BackgroundColor',[],@setBackgroundColor,[],o.BackgroundColor);
      this.addProperty('ForegroundColor',[],@setForegroundColor,[],o.ForegroundColor);
      this.addProperty('IndicatorAngle',[],@setIndicatorAngle,[],o.IndicatorAngle);
      this.addProperty('IndicatorNumberFormat',[],@setIndicatorNumberFormat,[],o.IndicatorNumberFormat);
      this.addProperty('Min',[],@setMin,[],o.Min);
      this.addProperty('Max',[],@setMax,[],o.Max);
      this.addProperty('MinorTickSpacing',o.MinorTickSpacing,@setMinorTickSpacing);
      this.addProperty('MajorTickSpacing',[],@setMajorTickSpacing,[],o.MajorTickSpacing);
      this.MinorTickSpacing = o.MinorTickSpacing;
      this.addProperty('NeedleColor',[],@setNeedleColor,[],o.NeedleColor);
      this.addProperty('NumberFormat',[],@setNumberFormat,[],o.NumberFormat);
      this.addProperty('StartAngle',o.StartAngle,@setStartAngle);
      this.addProperty('StopAngle',[],@setStopAngle,[],o.StopAngle);
      this.StartAngle = o.StartAngle;
      this.addProperty('Value',o.Value,@setValue);
      chart = javaObjectEDT('org.jfree.chart.JFreeChart',dial);
      this.handle.chartPanel = this.javacomponent('org.jfree.chart.ChartPanel',chart);
      this.handle.chartPanel.setPopupMenu([]);
    end
    
    function this = Figure(varargin)
      Icon = [];
      Size = [1024 768];
      i = find(strcmpi(varargin(1:2:end),'Icon'));
      if ~isempty(i)
        Icon = varargin{2*i(end)};
        varargin([2*i-1 2*i]) = [];
      end
      i = find(strcmpi(varargin(1:2:end),'Size'));
      if ~isempty(i)
        Size = varargin{2*i(end)};
        varargin([2*i-1 2*i]) = [];
      end
      s = get(0,'ScreenSize');
      d = {'CreateFcn',[],...
        'Color',UIComponent.getBackgroundColor(),...
        'DockControls','off',...
        'HandleVisibility','off',...
        'IntegerHandle','off',...
        'KeyPressFcn','return',...
        'MenuBar','none',...
        'NumberTitle','off',...
        'Position',[(s(3:4)-Size)/2 Size],...
        'Resize','off',...
        'Toolbar','none',...
        'Visible','off',...
        'WindowStyle','normal'};
      this = figure(d{:},varargin{:});
      if ~isempty(Icon)
        warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
        this.JavaFrame.setFigureIcon(Icon);
      end
    end
    
    function this = Label(varargin)
      o.Color = [0 0 0];
      o.FontName = UIComponent.getFontName();
      o.FontSize = UIComponent.getFontSize('java');
      o.FontStyle = 'plain';
      o.HorizontalAlignment = 'left';
      o.Icon = [];
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.String = '';
      o.Tag = '';
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('label',o);
      this.handle = this.javacomponent('javax.swing.JLabel',o.String,o.Icon,javax.swing.JLabel.LEFT);
      this.handle.Font = java.awt.Font(o.FontName,java.awt.Font.PLAIN,o.FontSize);
      this.addProperty('Color',[],@setForegroundColor,[],o.Color);
      this.addProperty('FontName',o.FontName,@setFontName);
      this.addProperty('FontSize',o.FontSize,@setFontSize);
      this.addProperty('FontStyle',[],@setFontStyle,[],o.FontStyle);
      this.addProperty('HorizontalAlignment',[],@setHorizontalAlignment,[],o.HorizontalAlignment);
      this.addProperty('Icon',o.Icon,@setIcon);
      this.addProperty('String',o.String,@setString);
    end
    
    function this = Menu(varargin)
      d = {'CreateFcn',[],...
        'HandleVisibility','off'};
      this = uimenu(d{:},varargin{:});
    end
    
    function this = Panel(varargin)
      d = {'BackgroundColor',UIComponent.getBackgroundColor(),...
        'CreateFcn',[],...
        'FontName',UIComponent.getFontName(),...
        'FontSize',UIComponent.getFontSize(),...
        'HandleVisibility','off',...
        'Units','pixels'};
      this = uipanel(d{:},varargin{:});
    end
    
    function this = ProgressBar(varargin)
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.PaintLabel = 'on';
      o.Tag = '';
      o.Value = 0;
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('progressbar',o);
      this.handle = this.javacomponent('javax.swing.JProgressBar',0,100);
      this.addProperty('PaintLabel',[],@setPaintLabel,[],o.PaintLabel);
      this.addProperty('Value',[],@setValue,[],o.Value);
    end
    
    function this = RadioButton(varargin)
      d = {'BackgroundColor',UIComponent.getBackgroundColor(),...
        'FontName',UIComponent.getFontName(),...
        'FontSize',UIComponent.getFontSize(),...
        'Units','pixels'};
      this = uicontrol(d{:},varargin{:},'Style','radiobutton');
    end
    
    function this = RadioButtonGroup(varargin)
      Callback = [];
      i = find(strcmpi(varargin(1:2:end),'Callback'));
      if ~isempty(i)
        Callback = {@UIComponent.selectionChangedFcn,varargin{2*i(end)}};
        varargin([2*i-1 2*i]) = [];
      end
      d = {'BackgroundColor',UIComponent.getBackgroundColor(),...
        'BorderType','none',...
        'FontName',UIComponent.getFontName(),...
        'FontSize',UIComponent.getFontSize(),...
        'HandleVisibility','off',...
        'SelectionChangedFcn',Callback,...
        'Units','pixels'};
      this = uibuttongroup(d{:},varargin{:});
    end
    
    function this = Slider(varargin)
      o.Callback = [];
      o.Enable = 'on';
      o.Min = 0;
      o.Max = 100;
      o.MinorTickSpacing = 0;
      o.MajorTickSpacing = 10;
      o.PaintLabel = 'off';
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.Tag = '';
      o.Value = 0;
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('slider',o);
      this.handle = this.javacomponent('javax.swing.JSlider',o.Min,o.Max,o.Value);
      this.addProperty('Callback',[],@setCallback,[],o.Callback);
      this.addProperty('Enable',[],@setEnable,[],o.Enable);
      this.addProperty('Min',o.Min,@setMin);
      this.addProperty('Max',o.Max,@setMax);
      this.addProperty('MinorTickSpacing',[],@setMinorTickSpacing,[],o.MinorTickSpacing);
      this.addProperty('MajorTickSpacing',[],@setMajorTickSpacing,[],o.MajorTickSpacing);
      this.addProperty('PaintLabel',[],@setPaintLabel,[],o.PaintLabel);
      this.addProperty('Value',o.Value,@setValue,@getValue);
    end
    
    function this = Spinner(varargin)
      o.Callback = [];
      o.Enable = 'on';
      o.HorizontalAlignment = 'center';
      o.Increment = 1;
      o.Min = 0;
      o.Max = 100;
      o.NumberFormat = '0';
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.Tag = '';
      o.Value = 0;
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('spinner',o);
      model = javaObjectEDT('javax.swing.SpinnerNumberModel',o.Value,o.Min,o.Max,o.Increment);
      this.handle = this.javacomponent('javax.swing.JSpinner',model);
      this.addProperty('Callback',[],@setCallback,[],o.Callback);
      this.addProperty('Enable',[],@setEnable,[],o.Enable);
      this.addProperty('HorizontalAlignment',[],@setHorizontalAlignment,[],o.HorizontalAlignment);
      this.addProperty('Increment',o.Increment,@setIncrement);
      this.addProperty('Min',o.Min,@setMin);
      this.addProperty('Max',o.Max,@setMax);
      this.addProperty('NumberFormat',[],@setNumberFormat,[],o.NumberFormat);
      this.addProperty('Value',[],@setValue,@getValue,o.Value);
    end
    
    function this = TextField(varargin)
      o.Callback = [];
      o.Enable = 'on';
      o.HorizontalAlignment = 'center';
      o.Parent = [];
      o.Position = [20 20 60 20];
      o.Tag = '';
      o.Value = '';
      o.Visible = 'on';
      for i = 1:2:nargin
        if isfield(o,varargin{i})
          o.(varargin{i}) = varargin{i+1};
        else
          UIComponent.errorInvalidProperty(varargin{i});
        end
      end
      if isempty(o.Parent)
        o.Parent = gcf();
      end
      this = UIComponent('textfield',o);
      this.handle = this.javacomponent('javax.swing.JTextField',o.Value);
      this.addProperty('Callback',[],@setCallback,[],o.Callback);
      this.addProperty('Enable',[],@setEnable,[],o.Enable);
      this.addProperty('HorizontalAlignment',[],@setHorizontalAlignment,[],o.HorizontalAlignment);
      this.addProperty('Value',o.Value,@setValue,@getValue);
    end
    
    function i = createIcon(icon)
      if ~isa(icon,'sun.awt.image.ToolkitImage')
        if ischar(icon)
          d = regexp(icon,'^data:([^;]*)?(;charset=([^;]*))?;base64,(.*)$','tokens','once');
          if ~isempty(d)
            icon = org.apache.commons.codec.binary.Base64.decodeBase64(uint8(d{3}));
          end
        else
          if isa(icon,'double')
            icon = uint8(255*icon);
          elseif ~isa(icon,'uint8')
            error('MATLAB:UndefinedFunction',...
              'No method ''createIcon'' with matching signature found for class ''UIComponent''.');
          end
          s = size(icon);
          R = icon(:,:,1)';
          G = icon(:,:,2)';
          B = icon(:,:,3)';
          d = [B(:),G(:),R(:),R(:)+255]';
          icon = java.awt.image.MemoryImageSource(s(2),s(1),typecast(d(:),'uint32'),0,s(2));
          icon = java.awt.Toolkit.getDefaultToolkit().createImage(icon);
        end
      end
      i = javaObjectEDT('javax.swing.ImageIcon',icon);
    end
    
    function c = getBackgroundColor()
      persistent color
      if isempty(color)
        c = javax.swing.UIManager.getColor('Panel.background');
        color = [c.getRed() c.getGreen() c.getBlue()]/255;
        mlock();
      end
      c = color;
    end
    
    function d = getDependencies()
      persistent dependencies
      if isempty(dependencies)
        d = [fileparts(mfilename('fullpath')) filesep];
        javacomponent = which('-all','javacomponentdoc_helper');
        dependencies = {javacomponent{1};[d 'jcommon-1.0.23.jar'];[d 'jfreechart-1.0.19.jar']};
        mlock();
      end
      d = dependencies;
    end
    
    function n = getFontName()
      persistent name
      if isempty(name)
        font = javax.swing.UIManager.getFont('Label.font');
        name = char(font.getName());
        mlock();
      end
      n = name;
    end
    
    function s = getFontSize(system)
      persistent size
      if isempty(size)
        font = javax.swing.UIManager.getFont('Label.font');
        size(1) = font.getSize();
        if ispc
          if java.awt.Toolkit.getDefaultToolkit().getDesktopProperty('win.xpstyle.themeActive')
            size(2) = 9;
          else
            size(2) = 8;
          end
        else
          size(2) = size(1);
        end
        mlock();
      end
      if nargin && strcmpi(system,'java')
        s = size(1);
      else
        s = size(2);
      end
    end
    
    function j = getJFrame(figure)
      if nargin == 0
        figure = gcf();
      end
      warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
      figure.Visible = 'on';
      drawnow();
      j = handle(javax.swing.SwingUtilities.getWindowAncestor(figure.JavaFrame.getAxisComponent()),'CallbackProperties');
    end
    
    function j = getJPanel(figure)
      if nargin == 0
        figure = gcf();
      end
      warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
      j = handle(figure.JavaFrame.getFigurePanelContainer(),'CallbackProperties');
    end
    
    function d = getUserDirectory()
      if ispc
        [~,d] = system('echo %HOMESHARE%\');
        if strcmp(d,['%HOMESHARE%\' 10])
          [~,d] = system('echo %USERPROFILE%\');
        end
      else
        [~,d] = system('echo $HOME/');
      end
      d = strtrim(d);
    end
    
    function loadJFreeChart()
      persistent loaded
      if isempty(loaded)
        mlock();
        UIComponent.addToClassPath('jcommon-1.0.23.jar','jfreechart-1.0.19.jar');
        loaded = true;
      end
    end
    
  end
  
  methods
    
    function this = UIComponent(type,args)
      s = dbstack(1);
      if isempty(s) || isempty(regexp(s(1).name,'^UIComponent.','once'))
        error('UIComponent:MissingObject',...
          'Missing object name.\nUsage: UIComponent.<ObjectName>(...)');
      end
      this.Type = type;
      this.addProperty('Parent',args.Parent,@setParent);
      this.addProperty('Position',args.Position,@setPosition);
      this.addProperty('Visible',args.Visible,@setVisible);
      this.Tag = args.Tag;
    end
    
    function value = get(this,property)
      if iscell(property)
        value = property;
        for i = 1:numel(property)
          value{i} = this.(property{i});
        end
      else
        value = this.(property);
      end
    end
    
    function set(this,property,value,varargin)
      varargin = [{property},{value},varargin];
      for i = 1:2:numel(varargin)
        this.(varargin{i}) = varargin{i+1};
      end
    end
    
  end
  
  methods (Access = private)
    
    function addProperty(this,property,value,setMethod,getMethod,newValue)
      p = addprop(this,property);
      if nargin > 2
        this.(property) = value;
      end
      if nargin > 3 && ~isempty(setMethod)
        p.SetMethod = setMethod;
      end
      if nargin > 4 && ~isempty(getMethod)
        p.GetMethod = getMethod;
      end
      if nargin > 5
        this.(property) = newValue;
      end
    end
    
    function setBackgroundColor(this,value)
      this.checkHandle();
      c = java.awt.Color(value(1),value(2),value(3));
      this.handle.dial.setBackground(javaObjectEDT('org.jfree.chart.plot.dial.DialBackground',c));
      this.handle.valueIndicator.setBackgroundPaint(c);
      this.handle.valueIndicator.setOutlinePaint(c);
      this.BackgroundColor = value;
    end
    
    function setCallback(this,value)
      this.checkHandle();
      if isempty(value)
        c = [];
        value = [];
      else
        c = @this.callbackFcn;
      end
      switch this.Type
        case 'slider'
          this.handle.KeyReleasedCallback = c;
          this.handle.MouseReleasedCallback = c;
        case 'spinner'
          this.handle.StateChangedCallback = c;
        otherwise
          this.handle.ActionPerformedCallback = c;
      end
      this.Callback = value;
    end
    
    function setEnable(this,value)
      this.checkHandle();
      if strcmpi(value,'on')
        this.handle.Enabled = 1;
        this.Enable = 'on';
      elseif strcmpi(value,'off')
        this.handle.Enabled = 0;
        this.Enable = 'off';
      else
        this.errorInvalidEnumValueOnOff();
      end
    end
    
    function setFontName(this,value)
      this.checkHandle();
      this.handle.Font = java.awt.Font(value,this.handle.Font.getStyle(),this.handle.Font.getSize());
      this.FontName = this.handle.Font.getName();
    end
    
    function setFontSize(this,value)
      this.checkHandle();
      value = double(value);
      this.handle.Font = this.handle.Font.deriveFont(value);
      this.FontSize = value;
    end
    
    function setFontStyle(this,value)
      this.checkHandle();
      value = lower(value);
      switch value
        case 'bold'
          s = java.awt.Font.BOLD;
        case 'italic'
          s = java.awt.Font.ITALIC;
        case {'bolditalic','italicbold'}
          s = java.awt.Font.BOLD+java.awt.Font.ITALIC;
          value = 'bolditalic';
        otherwise
          s = java.awt.Font.PLAIN;
          value = 'plain';
      end
      this.handle.Font = this.handle.Font.deriveFont(int32(s));
      this.FontStyle = value;
    end
    
    function setForegroundColor(this,value)
      this.checkHandle();
      c = java.awt.Color(value(1),value(2),value(3));
      switch this.Type
        case 'dial'
          this.handle.frame.setBackgroundPaint(c);
          this.handle.frame.setForegroundPaint(c);
          this.handle.scale.setMajorTickPaint(c);
          this.handle.scale.setMinorTickPaint(c);
          this.handle.scale.setTickLabelPaint(c);
          this.handle.valueIndicator.setPaint(c);
          this.ForegroundColor = value;
        case 'label'
          this.handle.Foreground = c;
          this.Color = value;
      end
    end
    
    function setHorizontalAlignment(this,value)
      this.checkHandle();
      value = lower(value);
      switch value
        case 'center'
          h = javax.swing.JLabel.CENTER;
        case 'right'
          h = javax.swing.JLabel.RIGHT;
        otherwise
          h = javax.swing.JLabel.LEFT;
          value = 'left';
      end
      switch this.Type
        case 'spinner'
          this.handle.Editor.getTextField().setHorizontalAlignment(h);
        otherwise
          this.handle.HorizontalAlignment = h;
      end
      this.HorizontalAlignment = value;
    end
    
    function setIcon(this,value)
      this.checkHandle();
      this.handle.Icon = value;
      this.Icon = value;
    end
    
    function setIncrement(this,value)
      this.checkHandle();
      this.handle.Model.setStepSize(java.lang.Double(value));
      this.Increment = value;
    end
    
    function setIndicatorAngle(this,value)
      this.checkHandle();
      this.handle.valueIndicator.setAngle(value);
      this.IndicatorAngle = value;
    end
    
    function setIndicatorNumberFormat(this,value)
      this.checkHandle();
      this.handle.valueIndicator.setNumberFormat(java.text.DecimalFormat(value));
      this.IndicatorNumberFormat = value;
    end
    
    function setMajorTickSpacing(this,value)
      this.checkHandle();
      switch this.Type
        case 'dial'
          this.handle.scale.setMajorTickIncrement(value);
          this.handle.scale.setMinorTickCount(round(value/this.MinorTickSpacing-1));
        case 'slider'
          this.handle.MajorTickSpacing = value;
      end
      this.MajorTickSpacing = value;
    end
    
    function setMax(this,value)
      this.checkHandle();
      switch this.Type
        case 'dial'
          this.handle.scale.setUpperBound(value);
        case 'slider'
          this.handle.Maximum = value;
        case 'spinner'
          this.handle.Model.setMaximum(java.lang.Double(value));
      end
      this.Max = value;
    end
    
    function setMin(this,value)
      this.checkHandle();
      switch this.Type
        case 'dial'
          this.handle.scale.setLowerBound(value);
        case 'slider'
          this.handle.Minimum = value;
        case 'spinner'
          this.handle.Model.setMinimum(java.lang.Double(value));
      end
      this.Min = value;
    end
    
    function setMinorTickSpacing(this,value)
      this.checkHandle();
      switch this.Type
        case 'dial'
          this.handle.scale.setMinorTickCount(round(this.MajorTickSpacing/value-1));
        case 'slider'
          this.handle.MinorTickSpacing = value;
      end
      this.MinorTickSpacing = value;
    end
    
    function setNeedleColor(this,value)
      this.checkHandle();
      c = java.awt.Color(value(1),value(2),value(3));
      this.handle.needle.setPaint(c);
      this.handle.cap.setFillPaint(c);
      this.handle.cap.setOutlinePaint(c);
      this.NeedleColor = value;
    end
    
    function setNumberFormat(this,value)
      this.checkHandle();
      switch this.Type
        case 'dial'
          this.handle.scale.setTickLabelFormatter(java.text.DecimalFormat(value));
        case 'spinner'
          c = this.handle.StateChangedCallback;
          v = this.handle.Value;
          this.handle.StateChangedCallback = [];
          this.handle.Value = rand();
          this.handle.Editor.getFormat().applyPattern(value);
          this.handle.Value = v;
          this.handle.StateChangedCallback = c;
      end
      this.NumberFormat = value;
    end
    
    function setPaintLabel(this,value)
      this.checkHandle();
      if strcmpi(value,'on')
        if strcmp(this.Type,'progressbar')
          this.handle.StringPainted = 1;
        else
          this.handle.PaintLabels = 1;
        end
        this.PaintLabel = 'on';
      elseif strcmpi(value,'off')
        if strcmp(this.Type,'progressbar')
          this.handle.StringPainted = 0;
        else
          this.handle.PaintLabels = 0;
        end
        this.PaintLabel = 'off';
      else
        this.errorInvalidEnumValueOnOff();
      end
    end
    
    function setParent(this,value)
      this.wrapper.Parent = value;
      this.Parent = value;
    end
    
    function setPosition(this,value)
      this.wrapper.Position = value;
      this.Position = value;
    end
    
    function setStartAngle(this,value)
      this.checkHandle();
      this.handle.scale.setStartAngle(value);
      this.handle.scale.setExtent(this.StopAngle-value);
      this.StartAngle = value;
    end
    
    function setStopAngle(this,value)
      this.checkHandle();
      this.handle.scale.setExtent(value-this.StartAngle);
      this.StopAngle = value;
    end
    
    function setString(this,value)
      this.checkHandle();
      switch this.Type
        case 'combobox'
          value = reshape(value,1,[]);
          c = this.handle.ActionPerformedCallback;
          this.handle.ActionPerformedCallback = [];
          this.handle.removeAllItems();
          for i = 1:numel(value)
            this.handle.addItem(value{i});
          end
          this.handle.ActionPerformedCallback = c;
        otherwise
          this.handle.Text = value;
      end
      this.String = value;
    end
    
    function value = getValue(this)
      this.checkHandle();
      switch this.Type
        case 'checkbox'
          value = this.handle.Selected;
        case 'combobox'
          value = this.handle.SelectedIndex+1;
        case 'textfield'
          value = this.handle.Text;
        otherwise
          value = this.handle.Value;
      end
    end
    
    function setValue(this,value)
      this.checkHandle();
      switch this.Type
        case 'checkbox'
          this.handle.Selected = logical(value);
        case 'combobox'
          this.handle.SelectedIndex = value-1;
        case 'dial'
          this.handle.dataset.setValue(java.lang.Double(value));
        case 'progressbar'
          this.handle.Value = 100*value;
        case 'textfield'
          this.handle.Text = value;
        otherwise
          this.handle.Value = value;
      end
      this.Value = value;
    end
    
    function setVisible(this,value)
      this.wrapper.Visible = value;
      this.Visible = value;
    end
    
    function callbackFcn(this,varargin)
      if iscell(this.Callback)
        feval(this.Callback{1},this,this.Callback{2:end});
      else
        feval(this.Callback,this);
      end
    end
    
    function checkHandle(this)
      if ~ishandle(this.wrapper)
        e = MException('MATLAB:class:InvalidHandle','Invalid or deleted object.');
        throwAsCaller(e);
      end
    end
    
    function h = javacomponent(this,varargin)
      persistent javacomponent
      if isempty(javacomponent)
        d = which('-all','javacomponentdoc_helper');
        d = cd(fileparts(d{1}));
        javacomponent = @javacomponentdoc_helper;
        cd(d);
        mlock();
      end
      [h,this.wrapper] = javacomponent(varargin,this.Position,this.Parent);
      this.wrapper.Visible = this.Visible;
    end
    
  end
  
  methods (Static, Access = private)
    
    function addToClassPath(varargin)
      clm = com.mathworks.jmi.ClassLoaderManager.getClassLoaderManager();
      classPath = clm.getClassPath();
      if ~isempty(classPath)
        classPath = cell(classPath)';
      end
      d = repmat({[fileparts(mfilename('fullpath')) filesep]},1,nargin);
      jar = cellfun(@horzcat,d,varargin,'UniformOutput',false);
      clm.setClassPath([classPath,jar]);
      com.mathworks.jmi.OpaqueJavaInterface.enableClassReloading(1);
      clear('java');
    end
    
    function errorInvalidEnumValueOnOff()
      e = MException('MATLAB:datatypes:InvalidEnumValue',...
        'Invalid enum value. Use one of these values: ''on'' | ''off''.');
      throwAsCaller(e);
    end
    
    function errorInvalidProperty(property)
      s = dbstack(1);
      e = MException('MATLAB:hg:InvalidProperty',...
        'There is no %s property on the %s class.',property,s(1).name);
      throwAsCaller(e);
    end
    
    function errorInvalidValue(value)
      e = MException('MATLAB:datatypes:InvalidEnumValue',...
        'Invalid value: %s.',value);
      throwAsCaller(e);
    end
    
    function selectionChangedFcn(h,d,f)
      e.OldValue = 0;
      e.NewValue = 0;
      e.EventName = d.EventName;
      c = flip(findobj(h,'Style','radiobutton'));
      if ~isempty(d.OldValue)
        e.OldValue = find(c == d.OldValue);
      end
      if ~isempty(d.NewValue)
        e.NewValue = find(c == d.NewValue);
      end
      if iscell(f)
        feval(f{1},h,d,e,f{2:end});
      else
        feval(f,h,d,e);
      end
    end
    
  end
  
end
