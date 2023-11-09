function plotrotmv(R,v,i)
plotVec(R(:,:,i));
hold on;
plotVec(R(:,:,i)*v(:,i));
end