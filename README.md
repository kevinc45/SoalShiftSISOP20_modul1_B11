# SoalShiftSISOP20_modul1_B11
## Kelompok
 - Achmad Sofyan Pratama (05111840000061)
 - Kevin Christian Hadinata (05111840000066)

# Pembahasan Soal 1
>Whits adalah seorang mahasiswa teknik informatika. Dia mendapatkan tugas praktikum
untuk membuat laporan berdasarkan data yang ada pada file “Sample-Superstore.tsv”.
Namun dia tidak dapat menyelesaikan tugas tersebut. Laporan yang diminta berupa :  
a. Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling
sedikit  
b. Tampilkan 2 negara bagian (state) yang memiliki keuntungan (profit) paling
sedikit berdasarkan hasil poin a  
c. Tampilkan 10 produk (product name) yang memiliki keuntungan (profit) paling
sedikit berdasarkan 2 negara bagian (state) hasil poin b  
Whits memohon kepada kalian yang sudah jago mengolah data untuk mengerjakan
laporan tersebut.  
*Gunakan Awk dan Command pendukung

## Files


## Solution!
Wah, Whits. Kamu kasihan sekali. Mari saya bantu~  
Dengan Awk, masalahmu akan dapat terselesaikan!

**1A**
>Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit

Hmm, dengan data yang banyak, tentunya kalkulator akan kurang efektif, bukan?  
Jadi, bagaimana kalau kita menggunakan Awk dengan *script* seperti ini

```bash
A=$(awk -F '	' '{
if ($13 != "Region")
	column[$13] += $21	
}
END{
	for (x in column){
		print column[x] " " x}
}' Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 1)
```

Yuk, bantu Whits menelusuri *script* ini satu persatu!

```bash
A=$(awk -F '	' '
```
*"Loh, kok ada petik satu yang isinya kosongan?" tanya Whits.*
 
Bukan kosongan, Whits. Petik satu tersebut berisi **TAB** sebagai *Field Separator*. 
  
Dilansir dari jawaban Alaa Ali dalam salah satu
jawaban di situs [askubuntu.com](https://askubuntu.com/a/342850), 
> Awk adalah bahasa yang berguna untuk manipulasi file data, *text retrieval*, dan *processing*

Penulisan Awk diikuti dengan **-F** menandakan bahwa kamu ingin mengolah data terkait dengan menghilangkan *Field Separator* berupa **TAB**
  
  
Lanjut,
```bash
{
if ($13 != "Region")
	column[$13] += $21	
}
```
*"Wah, kok bisa array-nya diisi String?"*  

Bisa dong, Whits! Nih, kata Sasikala di situs [The Geek Stuff](https://www.thegeekstuff.com/2010/03/awk-arrays-explained-with-5-practical-examples/),
>Awk mendukung *associative array*. *Associative arrays* sama seperti *array* tradisional namun berisikan *strings* sebagai *index* alih-alih menggunakan angka. 

Jadi, di kolom ke-13 yang berisi *"Region"* kita akan mencari *region* dengan *string* yang berbeda. Dalam hal ini, ada *Central*, *West*, *East*, dan *South*.  
  
  Karena kita ingin membandingkan *region* mana yang punya *profit* paling sedikit, maka untuk setiap *array region*, kita tambahkan *profit* yang mereka dapatkan di kolom ke-21 yang merupakan kolom *profit*.

```bash}
{
	for (x in column){
		print column[x] " " x}
}' Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 1)
```
*"Pasti ini untuk nge-print hasilnya, kan?"*  
  
Benar sekali, Whits! Dengan menuliskan *file* (*Sample-Superstore.csv*), kita memberikan perintah kepada *script* Awk untuk mengakses *file* tersebut.  

Penggunaan 
```bash
sort -g -k 1
```
digunakan untuk mengurutkan *output* dari *script* yang kita jalankan.

*"Apa, tuh, -g -k dan 1?"*
  
Nah, pasti bingung, kan? Jadi, -g -k -1 merupakan *parameter* dari *sorting*-nya sendiri. Nah, kata Anwar dalam jawabannya di [askubuntu.com](https://askubuntu.com/a/840802),
> -g berarti general-numeric-sort. Artinya, mengurutkan secara numerikal, mengkonversi *prefix* dari tiap baris menjadi *long double-precision floating point number*

Sementara **-k -1** artinya mengurutkan berdasarkan *value* yang terdapat di kolom pertama *output*

Lalu, bagaimana dengan
```bash
grep -o -P '(?<=[0-9.] ).*'
```
Menurut situs [explainshell.com](https://explainshell.com/),
>-o, --only-matching  
Print hanya bagian yang cocok dan tidak kosong dari baris yang sesuai, dengan masing-masing bagian terpisah dalam *output line*.  

>-P, --perl-regexp  
Menafsirkan pola sebagai ekspresi reguler Perl (dikelompokkan dalam grup tertentu)  
  
Sementara itu, *parameter* yang tertulis di dalamnya, digunakan untuk menghilangkan angka-angka yang berada di bagian depan *output line*.


Terakhir,
```bash
head -n 1
```
Opsi -n setelah *head* menandakan bahwa *head* akan mencetak sejumlah *line(s)*. Sementara itu, angka 1 menandakan banyaknya *line head* yang dicetak. Karena diminta hanya 1 wilayah bagian (*region*), maka digunakan angka 1.

<br/>
  
<br/>  
  
**1B**  

1B menggunakan *script* Awk yang hampir mirip dengan **1A**. Bedanya, Whits diminta untuk mencetak 2 negara bagian (*state*) dengan *profit* paling sedikit berdasarkan wilayah bagian (*region*) yang di dapat dari *output* **1A**.

```bash
B=$(awk -F '	' '{
if ($11 != "State" && $13 == a)
	column[$11] += $21	
}
END{
	for (x in column){
		print column[x] " " x}
}' a="$A" Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 2)
```
Mirip, kan?  
Karena *output* dari **1A** telah dimasukkan ke dalam variabel A dan merupakan nilai dalam *bash*, maka kita butuh untuk memanggilnya dalam bentuk Awk sebelum dapat digunakan kembali.  
Hal tersebut terlihat melalui adanya
```bash
a="$A"
```  
sebelum *Sample-Superstore.tsv*.

*Script* **1B** menggunakan *'if'* yang mirip dengan **1A**.  
```bash
{
if ($11 != "State" && $13 == a)
	column[$11] += $21	
}
```
Seperti yang sudah Whits mengerti sebelumnya, **$11** berisikan *Strings* dari kolom *State*. Agar efektif, kita cukup menggunakan *output* dari **1A** saja dalam kondisi *'if*. Oleh karena itu, kita menggunakan
```bash
$13 == a
```  
  
Dalam *output*-nya, **1B** butuh untuk mencetak 2 negara bagian (*state*) dengan *profit* terkecil. Nah, makanya kita menggunakan
```bash
head -n 2
```
di akhir *script*.  

<br/>
  
<br/>  
  
**1C**  

Persoalan di **1C** bisa jadi persoalan yang paling *tricky* diantara ketiga persoalan nomor 1. Karena *output* **1B** yang ada 2, kita tidak dapat asal menggunakan 'sama dengan' ( == ) seperti yang kita gunakan di **1B**  
  
Coba cek dulu nih, *script*-nya:
```bash
C=$(awk -F '	' '{

split(b,y,"\n")

if ($17 != "Product Name" && ($11 == y[1] || $11 == y[2]))
	column[$17] += $21
}
END{
	for (x in column){
		print column[x] " " x}
}' b="$B" Sample-Superstore.tsv | sort -g -k 1 | grep -o -P '(?<=[0-9.] ).*' | head -n 10)
```  
  
Yap, kita menggunakan fungsi baru yang disebut *split*
```bash
split (b,y,"\n")
```
merupakan fungsi untuk memisahkan *output* **1B** dalam variabel **b** menjadi 2 *value* yang berbeda.
**y** di fungsi ini menandakan *value* **B** yang akan dimasukkan ke dalam *array* **y** dimulai dari **y[1]**.
Sementara **"\n"**, menandakan bahwa *output* dari **1B** dipisahkan dengan *\n* atau *newline*.

# Pembahasan Soal 2
>Pada suatu siang, laptop Randolf dan Afairuzr dibajak oleh seseorang dan kehilangan data-data penting. Untuk mencegah kejadian yang sama terulang kembali mereka meminta bantuan kepada Whits karena dia adalah seorang yang punya banyak ide.  
>
>Whits memikirkan sebuah ide namun dia meminta bantuan kalian kembali agar ide tersebut cepat diselesaikan. Idenya adalah kalian  
>
>( A ) membuat sebuah script bash yang dapat menghasilkan password secara acak sebanyak 28 karakter yang terdapat huruf besar, huruf kecil, dan angka.    
> ( B ) Password acak tersebut disimpan pada file berekstensi .txt dengan nama berdasarkan argumen yang diinputkan dan HANYA berupa alphabet.  
> ( C ) Kemudian supaya file .txt tersebut tidak mudah diketahui maka nama filenya akan dienkripsi dengan menggunakan konversi huruf (string manipulation) yang disesuaikan dengan jam(0-23) dibuatnya file tersebut dengan program terpisah dengan (misal: password.txt dibuat pada jam 01.28 maka namanya berubah menjadi qbttxpse.txt dengan perintah ‘bash soal2_enkripsi.sh password.txt’. Karena p adalah huruf ke 16 dan file dibuat pada jam 1 maka 16+1=17 dan huruf ke 17 adalah q dan begitu pula seterusnya. Apabila melebihi z, akan kembali ke a, contoh: huruf w dengan jam 5.28, maka akan menjadi huruf b.)  
>( D ) jangan lupa untuk membuat dekripsinya supaya nama file bisa kembali.  
  
>HINT: enkripsi yang digunakan adalah caesar cipher.
*Gunakan Bash Script

## Files

## Solution!

#!/bin/bash
```
A=$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 ; echo '')
B=$(echo $1 | tr -dc A-Za-z)
y=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
z=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
x=$(('date +%H'))
newB=$(echo $B | tr "${z:0:26}${y:0:26}" "${z:$x:26}${y:$x:26}")
echo $A>$newB.txt
```
yang variabel A, dia bikin inputan random berisi alphanumerik
apa itu alphanumeric? 
ialah  Dalam tata letak yang dirancang untuk pengguna bahasa Inggris, karakter Alphanumeric terdiri dari kumpulan 26 karakter alfabet gabungan, A hingga Z, dan 10 angka Arab, 0 hingga 9 urandom gitu. 

pake > ae

iku simbol e fleksibel

opo lek gak deloken gotek e noel lho

Kode kelompok e opo si noel


wah lali

takok samsu

piye

Tinggal 3c


piye" wkwk

piye soff

Mbb Baru tangi + jumatan


Pancet


Tak ndengok ngone noel iki


Jam 3 tak usahakan marii


wes dihide gotek e noel wkwk

lek uwes langsung upload di repo ku yo

Yup


Invite boy


opo usernamemu

Sofyanfyan


sampun

eh sof lanjutno readme.md buat sg nomer 2 bek 3 e poo

aku kape kerjo iki

lek wes zip en terus kirim ke email penguji e

Nomer 2 gak ngerti ce


Tak bacot ae gpp ta?


Wkwk


tak jelasno singkat yo

Yup


#!/bin/bash

A=$(cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 28 ; echo '')
B=$(echo $1 | tr -dc A-Za-z)
y=abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz
z=ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ
x=$((`date +%H`))
newB=$(echo $B | tr "${z:0:26}${y:0:26}" "${z:$x:26}${y:$x:26}")
echo $A>$newB.txt

yang variabel A, dia bikin inputan random berisi alphanumerik

fungsinya emang /dev/urandom gitu, cario di internet

B nya buat generate nama file berdasarkan inputan

misal bash soal2.sh password

nah "password" nya itu di passing pakai $1

jadi untuk inputannya bisa diambil dengan $1

nah y sama z itu fungsinya buat dictionary aja isinya a-z kecil sama a-z besar itu nantinya yang buat digeser di variabel "newB"

x itu variabel untuk dapet jam sekarang

%H itu untuk dapet jam berapa sekarang formatnya 24 jam jadi value-nya dari 0-23

newB itu untuk menggeser value variabel B sesuai dengan x

setelah itu isinya dimasukkan ke txt lewat echo yang paling bawah




#Soal Nomer 3 
1 tahun telah berlalu sejak pencampakan hati Kusuma. Akankah sang pujaan hati
kembali ke naungan Kusuma? Memang tiada maaf bagi Elen. Tapi apa daya hati yang
sudah hancur, Kusuma masih terguncang akan sikap Elen. Melihat kesedihan Kusuma,
kalian mencoba menghibur Kusuma dengan mengirimkan gambar kucing. [a] Maka dari
itu, kalian mencoba membuat script untuk mendownload 28 gambar dari
"https://loremflickr.com/320/240/cat" menggunakan command wget dan menyimpan file
dengan nama "pdkt_kusuma_NO" (contoh: pdkt_kusuma_1, pdkt_kusuma_2,
pdkt_kusuma_3) serta jangan lupa untuk menyimpan log messages wget kedalam
sebuah file "wget.log". Karena kalian gak suka ribet, kalian membuat penjadwalan untuk

menjalankan script download gambar tersebut. Namun, script download tersebut hanya
berjalan[b] setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu Karena
gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda
antara satu dengan yang lain. Gambar yang berbeda tersebut, akan kalian kirim ke
Kusuma supaya hatinya kembali ceria. Setelah semua gambar telah dikirim, kalian akan
selalu menghibur Kusuma, jadi gambar yang telah terkirim tadi akan kalian simpan
kedalam folder /kenangan dan kalian bisa mendownload gambar baru lagi. [c] Maka dari
itu buatlah sebuah script untuk mengidentifikasi gambar yang identik dari keseluruhan
gambar yang terdownload tadi. Bila terindikasi sebagai gambar yang identik, maka
sisakan 1 gambar dan pindahkan sisa file identik tersebut ke dalam folder ./duplicate
dengan format filename "duplicate_nomor" (contoh : duplicate_200, duplicate_201).
Setelah itu lakukan pemindahan semua gambar yang tersisa kedalam folder ./kenangan
dengan format filename "kenangan_nomor" (contoh: kenangan_252, kenangan_253).
Setelah tidak ada gambar di current directory, maka lakukan backup seluruh log menjadi
ekstensi ".log.bak". Hint : Gunakan wget.log untuk membuat location.log yang isinya
merupakan hasil dari grep "Location".
*Gunakan Bash, Awk dan Crontab

##3a Nah Pertama-tama harus membuat bash terlebih dahulu untuk memasukkan gambar dari link "https://loremflickr.com/320/240/cat"
```
for ((i=1; i<=28; i=i+1))
do
wget -O pdkt_kusuma_$i https://loremflickr.com/320/240/cat -a wget.log
done
```

disini saya menggunakan looping dengan variabel i , proggram ini akan melakukkan looping sebanyak 28 kali dan sembari melakukan download gambar yang ada di link tersebut kemuadian saya memasnggil fungsi (-o) untuk output file biar bisa rename namanya kemudian (-a) bertujuan untuk append ke dalam wget.log 

##3b kemudian crontabnya sendiri berjalan setiap 8 jam dimulai dari jam 6.05 setiap hari kecuali hari Sabtu maka : 
``` 
5 6-23/8 * * 1-5,7 bash home/fyan/Sisop/nomer3.sh

```
##3c kemudian kita Karena gambar yang didownload dari link tersebut bersifat random, maka ada kemungkinan
gambar yang terdownload itu identik. Supaya gambar yang identik tidak dikira Kusuma
sebagai spam, maka diperlukan sebuah script untuk memindahkan salah satu gambar
identik. Setelah memilah gambar yang identik, maka dihasilkan gambar yang berbeda antara satu dengan yang lain

Pada proggram ini membuat file Locaton.log yang isinya url tiap gambar yang telah  didownload
proses selanjutnya menghitung apakah ada gambar yang lebih dari satu . apabila ada duplicate maka url location nya sama dan akan di pindah ke direktori duplicate dan memindah kan gambar lainya ke direktori kenangan lalu proses selanjutnya membuat backup tiap copyan file dengan list nama .log 
``` 
#!/bin/bash
cat wget.log | grep Location: > location.log

mkdir duplicate
mkdir kenangan

awk '{ i++
        print i ";" $2
}' location.log | awk -F ';' '{
counter[$2]++
if (counter[$2] > 1) {
 aws = "mv pdkt_kusuma_"$1 " duplicate/duplicate_"$1
}

else {
 aws = "mv pdkt_kusuma_"$1 " kenangan/kenangan_"$1
}
system(aws)

}'
ls *.log | awk '{
        aws  = "cp " $0 " $0 ".bak"
        system(aws)
}'
``` 

