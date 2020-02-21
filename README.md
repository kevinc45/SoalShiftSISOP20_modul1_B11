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
Dengan AWK, masalahmu akan dapat terselesaikan!

**1A**
>Tentukan wilayah bagian (region) mana yang memiliki keuntungan (profit) paling sedikit

Hmm, dengan data yang banyak, tentunya kalkulator akan kurang efektif, bukan?  
Jadi, bagaimana kalau kita menggunakan AWK dengan *script* seperti ini

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
>AWK adalah bahasa yang berguna untuk manipulasi file data, *text retrieval*, dan *processing*

Penulisan AWK diikuti dengan **-F** menandakan bahwa kamu ingin mengolah data terkait dengan menghilangkan *Field Separator* berupa **TAB**
  
  
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

"Apa, tuh -g -k 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTc4NjgyOTIwNywtMTA3MzU2NTkwOSw1MT
Q2NzYyLDE4NDkwNDU5NDUsMjA5NDg1MzU5OCwxNzM2NzgwNjAy
XX0=
-->