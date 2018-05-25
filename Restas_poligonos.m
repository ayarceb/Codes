% Code to operate with the polygones of LE and OMI
% example using polyshape working in Matlab2018a and polyout
% poly1 = polyshape([0 0 1 1],[0.6 0 0.4 1]);
% plot(poly1)
% poly3 = polyshape([-45.5465 -45.5219 -46.62 -46.6504],[-1.7539 -1.872 -2.1358 -2.0175]);
% hold on
% plot(poly3)
% polyout = intersect(poly1,poly2);

clear all
close all
clc
%% Part to change the 3 line for the 4 of the corner_latitudes and corner longitudes
corner_longitudes=ncread('OMI-Aura_NO2_20160327.nc','corner_longitudes');  % This first version just takes one day from the OMI Carib cropped region
corner_latitudes=ncread('OMI-Aura_NO2_20160327.nc','corner_latitudes');

aux=corner_latitudes(4,:);
aux2=corner_longitudes(4,:);

corner_latitudes(4,:)=corner_latitudes(3,:);
corner_longitudes(4,:)=corner_longitudes(3,:);

corner_latitudes(3,:)=aux;
corner_longitudes(3,:)=aux2;

%% Create array polygones OMI

parfor i=1:length(corner_latitudes(1,:))
    i
    poly_OMI(i) = polyshape(corner_longitudes(1:4,i),corner_latitudes(1:4,i));
    hold on
end
plot(poly_OMI)

%% Create array polygones LE

% dx=0.09;    % distance between each strip on the grid
% lon=[-79.8:dx:-65.94];
% lat=[-4.55:dx:13.27];
% [X,Y]=meshgrid(lon,lat);
%  
% for i=1:155
%     plot(X(:,i),Y(:,i),'k','linewidth',0.2)
%     hold on
% end
%     
% for j=1:199
%     plot(X(j,:),Y(j,:),'k','linewidth',0.2)
%     hold on
% end

%% Create array polygones array LE Dcol


% cont=1;
% for i=1:154
%    for j=1:198
%        
%       poly_LE(cont)= polyshape([lon(i) lon(i+1) lon(i+1) lon(i)],[lat(j) lat(j) lat(j+1) lat(j+1)]);
%       %plot(poly_LE(cont),'FaceColor','red','FaceAlpha',0.1) 
%       cont=cont+1;
%    end
% end
% 
% 
% 
% 
% 
% 
% 
% 


