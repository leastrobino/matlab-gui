%JERRORDLG Error dialog box.
%   JERRORDLG(ERRORSTRING,DLGNAME) creates an error dialog box which displays
%   ERRORSTRING in a window named DLGNAME.  A pushbutton labeled OK must be
%   pressed to make the error box disappear.
%
%   Example:
%       jerrordlg('This is an error string.','My Error Dialog');
%
%   See also ERRORDLG.

% Created by Léa Strobino.
% Copyright 2015. All rights reserved.

function jerrordlg(errorstring,dlgname)

if nargin < 2
  dlgname = 'Error';
end

JOptionPane = javaObjectEDT('javax.swing.JOptionPane');
JOptionPane.showMessageDialog([],errorstring,dlgname,javax.swing.JOptionPane.ERROR_MESSAGE);

end
