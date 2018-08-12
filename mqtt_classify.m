function mqtt_classify(topicName,msg)


global myMQTT
fprintf('This message is sent at time %s\n', datestr(now))
disp('Topic :');
disp(topicName);
disp('msg : ');
disp(msg);

%audio processing
[y,fs] = audioread(strcat('t2\set_a\','murmur__201108222258.wav'));
axes('Units', 'normalized', 'Position', [0 0 1 1])
F =linspace(1,1000,2000);
   
%Generate the sectrogram and save gcf to fig
spectrogram(y,500,[],F,fs,'yaxis');
colormap gray;
fig = gcf;
 
%Configurations to turn off various features of the figure
set(fig,'Visible','off');
colorbar off;
axis off;
iptsetpref('ImshowBorder','tight');
frame = getframe(fig);
imwrite(frame.cdata,strcat('test','.png'),'png')
image = imread(strcat('test','.png'));
% y = y(:,1);
% dt = 1/fs;
% t = 0:dt:(length(y)*dt)-dt;
% %spectrogram generation
% image = spectrogram(y,256,[],[],fs,'yaxis');
% image = image(:,mod(0:len-1, numel(image(1,:))) + 1); %repeat audio to length
%classification
result = classify(convnet,image)
str = char(result(1));


publish(myMQTT,'out',str);
end