%JINPUTDLG Input dialog box.
%   ANSWER = JINPUTDLG(PROMPT) creates a modal dialog box that returns user
%   input for a single PROMPT in the string ANSWER.
%
%   JINPUTDLG suspends execution until the user responds.
%
%   ANSWER = JINPUTDLG(PROMPT,NAME) specifies the title for the dialog.
%
%   ANSWER = JINPUTDLG(PROMPT,NAME,DEFAULTANSWER) specifies the default
%   answer to display.
%
%   ANSWER = JINPUTDLG(PROMPT,NAME,DEFAULTANSWER,POSSIBILITIES) specifies
%   the possibilities to display. POSSIBILITIES is a cell array of strings.
%
%   See also INPUTDLG.

% Created by Léa Strobino.
% Copyright 2015. All rights reserved.

function answer = jinputdlg(prompt,dlgname,default,possibilities)

if nargin < 2
  dlgname = '';
end
if nargin < 3
  default = '';
end
if nargin < 4
  possibilities = [];
end

JOptionPane = javaObjectEDT('javax.swing.JOptionPane');
answer = JOptionPane.showInputDialog([],prompt,dlgname,javax.swing.JOptionPane.PLAIN_MESSAGE,[],possibilities,default);

end
