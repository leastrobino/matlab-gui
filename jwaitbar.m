%JWAITBAR Display Java progress bar.
%   H = JWAITBAR(X,'message','title')
%   creates and displays a progress bar of fractional length X.
%   The handle to the progress bar figure is returned in H.
%   X should be between 0 and 1.
%
%   JWAITBAR(X,H) will set the length of the bar in progress bar H
%   to the fractional length X.
%
%   JWAITBAR(X,H,'message') will update the message text in
%   the progress bar figure, in addition to setting the fractional
%   length to X.
%
%   JWAITBAR is typically used inside a FOR loop that performs a
%   lengthy computation.
%
%   Example:
%       h = jwaitbar(0,'Please wait...');
%       for i=1:1000,
%           % computation here %
%           jwaitbar(i/1000,h)
%       end
%
%   See also WAITBAR.

% Created by Léa Strobino.
% Copyright 2017. All rights reserved.

function h = jwaitbar(x,varargin)

e = isempty(x);
x = 100*min([max([x,0]),1]);

try
  
  d = varargin{1}.UserData;
  if ~e
    d.JProgressBar.Value = x(1);
  end
  if nargin > 2
    d.JLabel.Text = varargin{2};
  end
  
catch
  
  if nargin > 1
    if ischar(varargin{1})
      label = varargin{1};
    else
      error(message('MATLAB:waitbar:InvalidSecondInput'));
    end
  else
    label = '';
  end
  if nargin > 2
    name = char(varargin{2});
  else
    name = '';
  end
  if nargin > 3
    stringPainted = logical(varargin{3});
  else
    stringPainted = true;
  end
  
  c = javax.swing.UIManager.getColor('Panel.background');
  s = get(0,'ScreenSize');
  w = [360 75];
  
  h = figure(...
    'CreateFcn',[],...
    'Color',[c.getRed() c.getGreen() c.getBlue()]/255,...
    'DockControls','off',...
    'HandleVisibility','off',...
    'IntegerHandle','off',...
    'MenuBar','none',...
    'Name',name,...
    'NumberTitle','off',...
    'Position',[(s(3:4)-w)/2 w],...
    'Resize','off',...
    'Tag',mfilename,...
    'Toolbar','none',...
    'Visible','off',...
    'WindowStyle','normal');
  
  d.JLabel = javacomponent({'javax.swing.JLabel',label,javax.swing.JLabel.CENTER},[19 45 324 18],h);
  
  d.JProgressBar = javacomponent({'javax.swing.JProgressBar',0,100},[19 15 324 18],h);
  d.JProgressBar.Value = x(1);
  d.JProgressBar.StringPainted = stringPainted;
  
  h.UserData = d;
  h.Visible = 'on';
  drawnow();
  
end
