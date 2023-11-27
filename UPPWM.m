clc

Nf = 5000; %number of frames
fc = 1000; %carrier frequency
fm = 50; %signal
MI = 0.9; %modulation index
theta1 = 0;
theta2 = pi;

%time series
t=linspace(0,0.04,Nf);
ct = carr1(fc,t); %carrier time-domain signal
mt = m(MI,fm,theta1,t); %modulation function time series1
mt1 = m1(MI,fm,theta2,t); %modulation function time series2
ht = h(ct,mt); %pwm signal time series
ht1 = h1(ct,mt1); %pwm signal time series

writeobj = VideoWriter('UPPWM','Uncompressed AVI');
open(writeobj);

fig1=figure('Renderer', 'painters', 'Position', [280 80 900 600]);
subplot(3,1,1);
title('Unipolar PWM Generation For H bridge');
subtitle('Developed by Dr.M.Kaliamoorthy')
set(gca,'XLim',[0 0.04], 'Ylim',[-1.25 1.25], 'Color','k');
curve=animatedline('LineWidth',2,'Color',"w");
curve0=animatedline('LineWidth',2,'Color',"c", 'Marker', '.', 'MarkerSize', 20);
curve2=animatedline('LineWidth',2,'Color',"w", 'Marker', '.', 'MarkerSize', 20);
curve1=animatedline('LineWidth',2,'Color',"c");
curve5=animatedline('LineWidth',2,'Color',"r");
curve6=animatedline('LineWidth',2,'Color',"r", 'Marker', '.', 'MarkerSize', 20);


subplot(3,1,2)
title('Blue Colored Reference Wave > Carrier Wave');
subtitle('PWM For One Pair of diagonally Opposite Switches')
curve3=animatedline('LineWidth',2,'Color',"g");
set(gca,'XLim',[0 0.04], 'Ylim',[-0.25 1.25], 'Color','k');

    
subplot(3,1,3)
title('Red Colored Reference Wave > Carrier Wave');
subtitle('PWM For other Pair of diagonally Opposite Switches')
curve4=animatedline('LineWidth',2,'Color',"g");
set(gca,'XLim',[0 0.04], 'Ylim',[-0.25 1.25], 'Color','k');

for i=1:3:length(t)
    clearpoints(curve0)
    clearpoints(curve2)
    clearpoints(curve6)
    addpoints(curve,t(i),ct(i));
    addpoints(curve2,t(i),ct(i));
    addpoints(curve1,t(i),mt(i));
    addpoints(curve0,t(i),mt(i));
    addpoints(curve5,t(i),mt1(i));
    addpoints(curve6,t(i),mt1(i));

    addpoints(curve3,t(i),ht(i));
    addpoints(curve4,t(i),ht1(i));
    drawnow
    currFrame=getframe(fig1);
    writeVideo(writeobj, currFrame)
   
end
close(writeobj)

%plot(t,ct)
%functions
function d= carr1(f,t) %carrier
   d = (1/pi)*acos(cos(2*pi*f*t));
end

function e= m(MI,f,theta1,t) %modulation function1
  e=(MI*sin(2*pi*f*t + theta1) + 0);
end

function g= m1(MI,f,theta2,t) %modulation function2
  g=(MI*sin(2*pi*f*t + theta2) + 0);
end

function f= h(ct,mt) %PWM switching function
  f=heaviside(mt-ct);
end

function k= h1(ct,mt1) %PWM switching function
  k=heaviside(mt1-ct);
end

%parameters

