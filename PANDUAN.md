# Panduan Setup Web Profile — Wan Amirul Syahril

Web ini ada 4 fail:
- `index.html` — laman awam (yang orang lain lihat)
- `admin.html` — panel admin untuk anda kemaskini dari telefon
- `config.js` — satu-satunya fail yang perlu anda edit (sambung ke database)
- `schema.sql` — skrip untuk setup database (jalankan sekali sahaja)

Tiada kos bulanan diperlukan untuk skala 10-30 fail (semua dalam had percuma).

---

## LANGKAH 1: Setup Database (Supabase) — 10 minit

1. Pergi ke **supabase.com** → daftar akaun percuma (boleh guna akaun Google).
2. Klik **New Project**. Isi nama projek (cth: `profil-wan-amirul`), buat kata laluan database (simpan baik-baik), pilih region **Southeast Asia (Singapore)**.
3. Tunggu ~2 minit sehingga projek siap.
4. Di sebelah kiri, klik **SQL Editor** → **New query**.
5. Buka fail `schema.sql` yang saya sediakan, salin **semua** kandungannya, tampal dalam SQL Editor, klik **Run**.
6. Anda akan nampak mesej "Success" — tables dan storage buckets sudah siap.

### Dapatkan kunci API
1. Klik ikon **Settings** (gear) di sebelah kiri → **API**.
2. Salin **Project URL** (contoh: `https://abcxyz.supabase.co`)
3. Salin **anon public key** (rentetan panjang bermula `eyJ...`)
4. Buka fail `config.js`, gantikan `SUPABASE_URL` dan `SUPABASE_ANON_KEY` dengan nilai yang disalin tadi.

### Buat akaun admin (untuk log masuk ke admin.html)
1. Di Supabase, klik **Authentication** → **Users** → **Add user** → **Create new user**.
2. Isi emel dan kata laluan anda sendiri (ini yang anda akan guna untuk log masuk ke `admin.html`).
3. Pastikan **Auto Confirm User** ditanda ✔️.

---

## LANGKAH 2: Letakkan Web di Internet (Deploy)

Cara paling mudah — **Netlify** (percuma, tiada kad kredit diperlukan):

1. Pergi ke **netlify.com** → daftar (boleh guna GitHub/Google).
2. Selepas log masuk, cari kawasan **"Deploys"** dan cari butang **"Add new site" → "Deploy manually"**.
3. **Drag & drop** keempat-empat fail (`index.html`, `admin.html`, `config.js`) ke dalam kawasan tersebut sekaligus (letak dalam satu folder dahulu, atau drag folder terus).
4. Netlify akan bagi anda URL percuma (cth: `chic-panda-123.netlify.app`) dalam beberapa saat. Web anda sudah LIVE.

> Alternatif: **Vercel** (vercel.com) berfungsi sama cara — cipta akaun, "Add New Project", drag & drop fail.

---

## LANGKAH 3: Pasang Domain Sendiri

1. Beli domain (jika belum ada) di **Exabytes**, **Namecheap**, atau **GoDaddy** (untuk `.com.my` biasanya perlu penyedia Malaysia seperti Exabytes/ MYNIC).
2. Dalam Netlify: pergi ke laman anda → **Domain settings** → **Add a domain**.
3. Masukkan nama domain anda. Netlify akan bagi arahan **DNS records** (biasanya 1 rekod jenis `A` dan/atau `CNAME`).
4. Pergi ke panel pembekal domain anda (Exabytes/Namecheap), masuk ke bahagian **DNS Management**, masukkan rekod yang Netlify bagi tadi.
5. Tunggu 15 minit – 24 jam untuk domain aktif sepenuhnya.

---

## LANGKAH 4: Cara Update Dari Telefon (Harian)

1. Buka **namadomain-anda.com/admin.html** dari browser telefon (Chrome/Safari).
2. Log masuk dengan emel & kata laluan yang anda tetapkan di Langkah 1.
3. Pilih tab berkenaan (Kursus, Sijil, Bengkel, dll), isi borang, dan untuk fail — tekan butang upload, ia akan buka **kamera atau galeri telefon terus**.
4. Tekan "Tambah" / "Simpan" — perubahan terus muncul di laman awam anda (index.html) dalam masa nyata.

💡 **Tip:** Boleh "Add to Home Screen" pautan admin.html di telefon supaya nampak macam app tersendiri.

---

## Nota Keselamatan

- Jangan kongsi kata laluan admin dengan sesiapa.
- `anon key` dalam `config.js` **selamat** untuk didedahkan secara awam (ia direka begitu) — perlindungan sebenar datang dari **Row Level Security** yang sudah ditetapkan dalam `schema.sql` (hanya anda yang log masuk boleh ubah data).
- Had percuma Supabase: 500MB storan fail & 1GB pemindahan data/bulan — lebih dari cukup untuk 10-30 fail sijil/gambar.

---

## Jika Perlu Bantuan Semasa Setup

Kembali ke perbualan ini bila-bila masa jika:
- Ada ralat semasa jalankan `schema.sql`
- Nak tambah medan/bahagian baru (cth: testimoni, penerbitan)
- Nak ubah design/warna
- Nak bantuan pasang domain khusus
