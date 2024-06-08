function [] = PlotCustomFunctionUIAxes(x,y,c,uiaxes)

t = linspace(0,2,25);
y = 0.25*t.^2 - 3;
plot(uiaxes,t,y)