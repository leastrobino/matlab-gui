%JWARNDLG Warning dialog box.
%   JWARNDLG(WARNSTRING,DLGNAME) creates a warning dialog box which displays
%   WARNSTRING in a window named DLGNAME.  A pushbutton labeled OK must be
%   pressed to make the warning box disappear.
%
%   Examples:
%       jwarndlg('This is a warning string.','My Warn Dialog');
%
%   See also WARNDLG.

% Created by Léa Strobino.
% Copyright 2015. All rights reserved.

function jwarndlg(warnstring,dlgname)

if nargin < 2
  dlgname = 'Warning';
end

JOptionPane = javaObjectEDT('javax.swing.JOptionPane');
JOptionPane.showMessageDialog([],warnstring,dlgname,javax.swing.JOptionPane.WARNING_MESSAGE);

end
