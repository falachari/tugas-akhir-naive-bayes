clc; clear all; close all;
tic
% Pemrosesan awal ditunjukkan pada variabel a,b,c,d.
% Proses ekstraksi fitur ditunjukkan pada variabel e,f,g,h,i.
%% Proses ekstraksi fitur data latih 
for data=1:16
a=imread(['D:\Tugas Kuliah\Semester 8\Tugas Akhir\data\Data Citra Crop\data latih copy\l',num2str(data),'.jpg']);
b=rgb2gray(a);
c=medfilt2(b,[9 9]);
d=adapthisteq(c);
e=mean(mean(d));
f=std2(d);
g=entropy(d);
d1=double(d);
h=skewness(skewness(d1));
i=kurtosis(kurtosis(d1));
m=[e f g h i];
matrikslatih(data,1:5)=m(1,:);
end
% Menampilkan nilai ekstraksi fitur data latih
matrikslatih

%% Proses ekstraksi fitur data uji 
for data=1:14 
    a=imread(['D:\Tugas Kuliah\Semester 8\Tugas Akhir\data\Data Citra Crop\data uji copy\u', num2str(data),'.jpg']); 
    b=rgb2gray(a);
    c=medfilt2(b,[3 3]);
    d=adapthisteq(c); 
    e=mean(mean(d)); 
    f=std2(d); 
    g=entropy(d); 
    d1=double(d);
    h=skewness(skewness(d1)); 
    i=kurtosis(kurtosis(d1)); 
    m=[e f g h i]; 
    matriksuji(data,1:5)=m(1,:); 
end
% Menampilkan nilai ekstraksi fitur data uji
matriksuji

%% Data latih dan data uji 
fiturA = matrikslatih(:,1); 
fiturB = matrikslatih(:,2); 
fiturC = matrikslatih(:,3); 
fiturD = matrikslatih(:,4); 
fiturE = matrikslatih(:,5); 
% Membuat kelas untuk data latih
for i=1:8
    kelasl(2*i-1)=1;
    kelasl(2*i)=2;
end
kelas=kelasl';

datauji_fiturA = matriksuji(:,1); 
datauji_fiturB = matriksuji(:,2); 
datauji_fiturC = matriksuji(:,3); 
datauji_fiturD = matriksuji(:,4);
datauji_fiturE = matriksuji(:,5); 
% Membuat kelas untuk data uji
for i=1:7
    kelasu(2*i-1)=1;
    kelasu(2*i)=2;
end
kelasuji=kelasu';

jumlah_datalatih = 16;
jumlah_datauji = 14;

%% Proses pelatihan
data_uji = [datauji_fiturA, datauji_fiturB, datauji_fiturC, datauji_fiturD, datauji_fiturE]; 
data_latih = [fiturA, fiturB, fiturC, fiturD, fiturE];
kelas_latih = kelas;
model = fitcnb(data_latih, kelas_latih);
kelas_latih_hasil = model.predict(data_latih);
% Menampilkan kelas awal dan kelas hasil
hasil_latih = [kelas_latih, kelas_latih_hasil]

% % Perhitungan akurasi blewah belum matang
% jum=0;
% for i=1:2:15
%     if kelas_latih(i)==kelas_latih_hasil(i) 
%         jum=jum+1;
%     end
% end
% benarbelummatang=jum
% prosentase_latih_belummatang=(benarbelummatang/8)*100
% 
% % Perhitungan akurasi blewah matang
% jum=0;
% for i=2:2:16
%     if kelas_latih(i)==kelas_latih_hasil(i) 
%         jum=jum+1;
%     end
% end
% benarmatang=jum
% prosentase_latih_matang=(benarmatang/8)*100

% Perhitungan akurasi data latih secara keseluruhan
jum=0;
for i=1:16
    if kelas_latih(i)==kelas_latih_hasil(i) 
        jum=jum+1;
    end
end
benar_latih=jum
prosentase_latih=(benar_latih/16)*100

%% Proses Pengujian
kelas_uji_hasil = model.predict(data_uji);
kelas_uji = kelasuji(1:14,:);
% Menampilkan kelas awal dan kelas hasil
hasil_uji = [kelas_uji, kelas_uji_hasil]

% % Perhitungan akurasi blewah belum matang
% jum=0;
% for i=1:2:13
%     if kelas_uji(i)==kelas_uji_hasil(i) 
%         jum=jum+1;
%     end
% end
% benarujibelummatang=jum
% prosentase_uji_belummatang=(benarujibelummatang/7)*100
% 
% % Perhitungan akurasi blewah matang
% jum=0;
% for i=2:2:14
%     if kelas_uji(i)==kelas_uji_hasil(i) 
%         jum=jum+1;
%     end
% end
% benarujimatang=jum 
% prosentase_uji_matang=(benarujimatang/7)*100

% Perhitungan akurasi data uji secara keseluruhan
jum=0;
for i=1:14
    if kelas_uji(i)==kelas_uji_hasil(i) 
        jum=jum+1;
    end
end
benar_uji=jum
prosentase_uji=(benar_uji/14)*100
toc