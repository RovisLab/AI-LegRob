clear all
clc

% leg FR

data_in_fr_h = readtable('torque_FR0_simple_07.csv');
data_in_fr_t = readtable('torque_FR1_simple_11.csv');
data_in_fr_c = readtable('torque_FR2_simple_minus13.csv');

fr_h_com = table2array(data_in_fr_h(:,1));
fr_h_p = table2array(data_in_fr_h(:,2));
fr_h_w = table2array(data_in_fr_h(:,3));
fr_h_a = table2array(data_in_fr_h(:,4));

fr_t_com = table2array(data_in_fr_t(:,1));
fr_t_p = table2array(data_in_fr_t(:,2));
fr_t_w = table2array(data_in_fr_t(:,3));
fr_t_a = table2array(data_in_fr_t(:,4));

fr_c_com = table2array(data_in_fr_c(:,1));
fr_c_p = table2array(data_in_fr_c(:,2));
fr_c_w = table2array(data_in_fr_c(:,3));
fr_c_a = table2array(data_in_fr_c(:,4));


plot(fr_h_com)
hold on
grid on
plot(fr_h_p)
figure
plot(fr_t_com)
hold on
grid on
plot(fr_t_p)
figure
plot(fr_c_com)
hold on
grid on
plot(fr_c_p)


save matdate.mat