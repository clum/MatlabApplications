%Test udp receiver
%
%Christopher Lum
%lum@uw.edu

%Version History
%01/04/24: Created

clear
clc
close all

ChangeWorkingDirectoryToThisLocation();

tic

%% User selections
udpr = dsp.UDPReceiver('LocalIPPort',31000);
udps = dsp.UDPSender('RemoteIPPort',31000);

setup(udpr); 

bytesSent = 0;
bytesReceived = 0;
dataLength = 128;

for k = 1:20
   dataSent = uint8(255*rand(1,dataLength));
   bytesSent = bytesSent + dataLength;
   udps(dataSent);
   dataReceived = udpr();
   bytesReceived = bytesReceived + length(dataReceived);
end

release(udps);
release(udpr);

disp(['Bytes sent:     ',num2str(bytesSent)]);
disp(['Bytes received: ',num2str(bytesReceived)]);

toc
disp('DONE!')