%
%  app.m
%
%  Created by NAME on YYYY.MM.DD.
%  Copyright YYYY COMPANY. All rights reserved.
%

classdef app < handle
  
  properties (Access = private)
    h
    s
    d
  end
  
  methods
    
    function this = app()
      
      % Default data
      this.d.appdir = [fileparts(mfilename('fullpath')) filesep];
      this.d.path = UIComponent.getUserDirectory();
      
      % Main window
      this.h.window = UIComponent.Figure(...
        'CloseRequestFcn',@this.closeRequestFcn,...
        'Name','',...
        'Size',[1024 768]);
      
      % Timer
      this.h.timer = timer(...
        'ExecutionMode','FixedRate',...
        'Name',[mfilename '::appTimer'],...
        'Period',1/25,...
        'TimerFcn',@this.timerFcn);
      
      start(this.h.timer);
      this.h.window.Visible = 'on';
      
    end
    
  end
  
  methods (Access = private)
    
    function closeRequestFcn(this,~,~)
      try %#ok<TRYNC>
        this.h.window.Visible = 'off';
      end
      stop(this.h.timer);
      delete(this.h.timer);
      close(this.h.window,'force');
    end
    
    function timerFcn(this,~,~)
    end
    
  end
  
end
