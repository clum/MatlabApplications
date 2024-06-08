function [] = PlotCustomFunction(x,y,c)

t = linspace(0,2,25);
y = 0.25*t.^2 - 3;
plot(t,y)