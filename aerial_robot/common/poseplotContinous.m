function poseplotContinous(Pdata,Rdata,vdata,omegadata,interval,isNED)
    arguments
        Pdata (3,:)
        Rdata (3,3,:)
        vdata (3,:)
        omegadata (3,:)
        interval {mustBeInteger}
        isNED = true
    end
    if isNED
        dirstr = "NED";
    else
        dirstr = "SEU";
    end
    n = length(Pdata);
    frameselect = 1:interval:n;
    nselect = length(frameselect);
    Pdata = Pdata(:,frameselect);
    Rdata = Rdata(:,:,frameselect);
    vdata = vdata(:,frameselect);
    omegadata = omegadata(:,frameselect);

    pp = poseplot(eye(3), zeros(1,3),dirstr);
    hold on
    vvec = quiver3(0,0,0,1,1,-1);
    omegavec=quiver3(0,0,0,1,1,1);
    vvec.Color = [1,0,0];
    vvec.LineWidth = 2; 
    vvec.AutoScale = 2;
    omegavec.Color = [0,0,1];
    omegavec.LineWidth = 2;
    omegavec.AutoScale = 2;
    axis vis3d
    box on
    grid on
    pause('on');
    for i =1:nselect
        R = Rdata(:,:,i); 
        P = Pdata(:,i);
        v = R' * vdata(:,i);
        omega = R * omegadata(:,i);

        pp.Orientation = R;
        pp.Position = P;

        vvec.XData = P(1);
        vvec.YData = P(2);
        vvec.ZData = P(3);
        vvec.UData = v(1);
        vvec.VData = v(2);
        vvec.WData = v(3);
        omegavec.XData = P(1);
        omegavec.YData = P(2);
        omegavec.ZData = P(3);
        omegavec.UData = omega(1);
        omegavec.VData = omega(2);
        omegavec.WData = omega(3);

        drawnow;
        pause(1/1000);
    end
end
