%
%  im2base64.m
%
%  Created by Léa Strobino.
%  Copyright 2015. All rights reserved.
%

function s = im2base64(img,mfile)
i = imfinfo(img);
s = ['data:image/' i(1).Format ';base64,'];
h = fopen(img,'r');
b = fread(h,'*uint8');
fclose(h);
s = [s org.apache.commons.codec.binary.Base64.encodeBase64(b)'];
if nargin > 1
  [p,n,e] = fileparts(mfile);
  if isempty(e)
    e = '.m';
  end
  h = fopen(fullfile(p,[n e]),'w');
  fwrite(h,['s = ''' s ''';' 10]);
  fclose(h);
end
