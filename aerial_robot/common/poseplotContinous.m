function poseplotContinous(Pdata,Rdata,interval,isNED)
    arguments
        Pdata (3,:)
        Rdata (3,3,:)
        interval {mustBeInteger}
        isNED = true
    end
    if isNED
        dirstr = 'NED';
    else
        dirstr = 'SEU';
    end
    n = length(Pdata);
    frameselect = 1:interval:n;
    nselect = length(frameselect);
    Pdata = Pdata(:,frameselect);
    Rdata = Rdata(:,:,frameselect);

    pp = poseplot(eye(3), zeros(1,3),"NED");
    axis vis3d
    box on
    grid on
    for i =1:nselect
        R = Rdata(:,:,i);
        P = Pdata(:,i);
        pp.Orientation = R;
        pp.Position = P;
        drawnow;
    end
end
