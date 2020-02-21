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

Persoalan di **1C** bisa jadi persoalan yang paling *tricky* 
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTM0NjQyNTAyOCwtMTA3MzU2NTkwOSw1MT
Q2NzYyLDE4NDkwNDU5NDUsMjA5NDg1MzU5OCwxNzM2NzgwNjAy
XX0=
-->