%==== Script to generate a .nc valid from the IASI cropped value ====
clc
close all
clear all

%%===Read the values from NC files from IASI complet image lon, lat, column=====
lon=ncread('IASI_metopb_L2_NH3_20160101_V2.1_AM_GLOBAL.nc','longitude');
lat=ncread('IASI_metopb_L2_NH3_20160101_V2.1_AM_GLOBAL.nc','latitude');
column=ncread('IASI_metopb_L2_NH3_20160101_V2.1_AM_GLOBAL.nc','column');

%% This part evaluate the domain to create a new domain cropped by Dcol domain
j=1;
for i=1:653109
    if (lat(i)<=13.27)&&(lat(i)>=-4.55)&&(lon(i)>=-79.9)&&(lon(i)<=-65.94)
        CNH3(j,1)=column(i);
        lati(j)=lat(i);
        long(j)=lon(i);
        j=j+1
    end
end

dx=0.09;    % distance between each strip on the grid
lon=[-79.8:dx:-65.94];
lat=[-4.55:dx:13.27];
[X,Y]=meshgrid(lon,lat);
 
for i=1:155
    plot(X(:,i),Y(:,i),'k','linewidth',0.2)
    hold on
end
    
for j=1:199
    plot(X(j,:),Y(j,:),'k','linewidth',0.2)
    hold on
end
hold on 
plot(long,lati,'*')

%% Creat polygones from the points of IASI
dr=0.15;

len=length(long);
corner_latitudes=zeros(4,len);
corner_longitudes=zeros(4,len);
for i=1:len
LA=long(i)+dr;
LB=long(i)-dr;
LC=lati(i)+dr;
LD=lati(i)-dr;
corner_latitudes(1,i)=LC;
corner_latitudes(2,i)=LD;
corner_latitudes(3,i)=LD;
corner_latitudes(4,i)=LC;
corner_longitudes(1,i)=LB;
corner_longitudes(2,i)=LB;
corner_longitudes(3,i)=LA;
corner_longitudes(4,i)=LA;
end
hold on
for i=1:length(corner_latitudes(1,:))
    i
    poly_IASI(i) = polyshape(corner_longitudes(1:4,i),corner_latitudes(1:4,i));
    hold on
end
plot(poly_IASI)


%% ===Create the .nc ====
nombre='IASIcropped.nc';
ncid = netcdf.create(nombre,'CLOBBER');
%% === Global Attributes===
Global=netcdf.getConstant('NC_GLOBAL');
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'source','Generated from EAFIT')
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'title','Cropped values IASI for Dcol')
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'institution','Universidad EAFIT')
netcdf.putAtt(ncid,netcdf.getConstant('NC_GLOBAL'),'Conventions','CF-1.5')
%=== Dimensions===
dlon=netcdf.defDim(ncid,'lon',length(lati));
dlat=netcdf.defDim(ncid,'lat',length(long));

%=== Variables===
%==Longitude
varlon = netcdf.defVar(ncid,'lon','NC_DOUBLE',dlon); % Create Variable
netcdf.putAtt(ncid,varlon,'standard_name','longitude'); %Attributes
netcdf.putAtt(ncid,varlon,'units','degrees_east');
netcdf.putAtt(ncid,varlon,'long_name','longitude');
netcdf.putAtt(ncid,varlon,'west_bound',-80);
netcdf.putAtt(ncid,varlon,'east_bound',-66);
netcdf.putAtt(ncid,varlon,'bounds','lon_bounds');
%==Latitude
varlat = netcdf.defVar(ncid,'lat','NC_DOUBLE',dlat); % Create Variable
netcdf.putAtt(ncid,varlat,'standard_name','latitude'); %Attributes
netcdf.putAtt(ncid,varlat,'units','degrees_north');
netcdf.putAtt(ncid,varlat,'long_name','latitude');
netcdf.putAtt(ncid,varlat,'south_bound',-4.5);
netcdf.putAtt(ncid,varlat,'north_bound',13.2);
netcdf.putAtt(ncid,varlat,'bounds','lat_bounds');


%==NH3 column IASI
NH3_column_IASI = netcdf.defVar(ncid,'nh3_column_IASI','NC_DOUBLE',dlon); % Create Variable
netcdf.putAtt(ncid,NH3_column_IASI,'long_name','NH3 column IASI');%Attributes
netcdf.putAtt(ncid,NH3_column_IASI,'units','NA');


netcdf.endDef(ncid)
% %==Asing values to de variables==
netcdf.putVar(ncid,varlon,long');
netcdf.putVar(ncid,varlat,lati);
netcdf.putVar(ncid,NH3_column_IASI,CNH3);

netcdf.close(ncid);
ncdisp('IASIcropped.nc')
