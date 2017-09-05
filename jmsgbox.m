%JMSGBOX Message box.
%   JMSGBOX(MESSAGE) creates a message box.
%
%   JMSGBOX(MESSAGE,TITLE) specifies the title of the message box.
%
%   Example:
%       jmsgbox('String','Title');
%
%   See also MSGBOX.

% Created by Léa Strobino.
% Copyright 2015. All rights reserved.

function jmsgbox(string,dlgname)

if nargin < 2
  dlgname = '';
end

JOptionPane = javaObjectEDT('javax.swing.JOptionPane');
JOptionPane.showMessageDialog([],string,dlgname,javax.swing.JOptionPane.INFORMATION_MESSAGE);

end
