syms u
syms v
i = -2.2;
f = @(u) u-0.2;
g = @(u) sin(u)+1.4*cos(u);
f1 = @(u,v) 1.1*f(v)*cos(u);
f2 = @(u,v) 1.1*f(v)*sin(u);
f3 = @(u,v) g(v);
figure(1)
for i=-3:0.2:3
    range = [0 2*pi 0 pi];
    f4 = @(u,v) f3(u,v) + i;
    x = fsurf(f1,f2,f4,range,'facecolor',[0 0.6 0],'EdgeColor',[0 0.2 0]);
    ax = gca;
    ax.XLim = [-7 7];
    ax.YLim = [-7 7];
    ax.ZLim = [-7 7];
    title('Chapéuzinho de tratador de zoológico')
    camlight;
    pause(0.01)
end