%JQUESTDLG Question dialog box.
%   ButtonName = JQUESTDLG(QUESTION) creates a modal dialog box. The name
%   of the button that is pressed is returned in ButtonName. The title
%   of the figure may be specified by adding a second string argument:
%
%       ButtonName = jquestdlg(QUESTION,TITLE)
%
%   JQUESTDLG suspends execution until the user responds.
%
%   The default set of buttons names for JQUESTDLG are 'Yes','No' and
%   'Cancel'. The default answer for the above calling syntax is 'Yes'.
%   This can be changed by adding a third argument which specifies the
%   default Button:
%
%       ButtonName = jquestdlg(QUESTION,TITLE,'No')
%
%   Up to 3 custom button names may be specified by entering
%   the button string name(s) as additional arguments to the function
%   call. If custom button names are entered, the default button
%   must be specified by adding an extra argument, DEFAULT, and
%   setting DEFAULT to the same string name as the button you want
%   to use as the default button:
%
%       ButtonName = jquestdlg(QUESTION,TITLE,BTN1,BTN2,DEFAULT);
%
%   where DEFAULT is set to BTN1. This makes BTN1 the default answer.
%   If the DEFAULT string does not match any of the button string names,
%   a warning message is displayed.
%
%   If the dialog is closed without a valid selection, the return value
%   is empty.
%
%   Example:
%
%       ButtonName = jquestdlg('What is your favorite color?',...
%         'Color Question',...
%         'Red','Green','Blue','Green');
%       switch ButtonName
%         case 'Red'
%           disp('Your favorite color is Red');
%         case 'Blue'
%           disp('Your favorite color is Blue.');
%         case 'Green'
%           disp('Your favorite color is Green.');
%       end
%
%   See also QUESTDLG.

% Created by Léa Strobino.
% Copyright 2015. All rights reserved.

function button = jquestdlg(string,dlgname,varargin)

option = javax.swing.JOptionPane.YES_NO_CANCEL_OPTION;
options = {'Yes','No','Cancel'};
default = 'Yes';
if nargin == 1
  dlgname = '';
elseif nargin == 3
  default = varargin{1};
elseif nargin == 5
  option = javax.swing.JOptionPane.YES_NO_OPTION;
  options = varargin(1:2);
  default = varargin{3};
elseif nargin == 6
  options = varargin(1:3);
  default = varargin{4};
end

if ~any(strcmp(options,default))
  warning(message('MATLAB:questdlg:StringMismatch'));
end

JOptionPane = javaObjectEDT('javax.swing.JOptionPane');
button = JOptionPane.showOptionDialog([],string,dlgname,option,javax.swing.JOptionPane.QUESTION_MESSAGE,[],options,default);

if button == -1
  button = [];
else
  button = options{button+1};
end

end
