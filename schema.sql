-- ==========================================================
-- SKEMA DATABASE untuk Web Profile Digital
-- Jalankan skrip ini penuh di Supabase > SQL Editor > New query > Run
-- ==========================================================

-- 1. Maklumat profil utama (satu baris sahaja)
create table profil (
  id int primary key default 1,
  nama text,
  jawatan text,
  tagline text,
  bio text,
  gambar_url text,
  emel text,
  telefon text,
  constraint satu_baris check (id = 1)
);
insert into profil (id, nama, jawatan, tagline, bio, emel)
values (1, 'Wan Amirul Syahril Bin Wan Mazlan', 'Guru Pendidikan Islam Gred DG10',
'Guru Peneraju Generasi Digital KPM 2026', 'Isi bio ringkas anda di sini melalui panel admin.', '');

-- 2. Sejarah perkhidmatan (kerjaya)
create table sejarah_perkhidmatan (
  id bigint generated always as identity primary key,
  institusi text not null,
  lokasi text,
  tahun_mula int,
  tahun_tamat int, -- kosongkan (null) jika masih berkhidmat
  keterangan text,
  turutan int default 0
);
insert into sejarah_perkhidmatan (institusi, lokasi, tahun_mula, tahun_tamat, turutan) values
('SJK Sungai Jaong', 'Marudi, Sarawak', 2013, 2021, 1),
('SK Bohor Baharu', 'Bandar Bera, Pahang', 2022, null, 2);

-- 3. Perkhidmatan / khidmat yang ditawarkan
create table perkhidmatan (
  id bigint generated always as identity primary key,
  tajuk text not null,
  keterangan text,
  ikon text, -- nama emoji/ikon ringkas cth: "💻" atau "📖"
  turutan int default 0
);

-- 4. Kursus yang pernah disertai
create table kursus_disertai (
  id bigint generated always as identity primary key,
  tajuk text not null,
  penganjur text,
  tahun int,
  sijil_url text, -- pautan fail sijil dalam storage
  turutan int default 0
);

-- 5. Sijil / kelayakan yang diperolehi (selain kursus di atas)
create table sijil (
  id bigint generated always as identity primary key,
  tajuk text not null,
  pengeluar text,
  tahun int,
  fail_url text,
  turutan int default 0
);

-- 6. Kursus/bengkel yang PERNAH DIKENDALIKAN (sebagai fasilitator/penceramah)
create table kursus_dikendalikan (
  id bigint generated always as identity primary key,
  tajuk text not null,
  peranan text, -- cth: "Fasilitator", "Penceramah Jemputan"
  anjuran text,
  tarikh date,
  lokasi text,
  keterangan text,
  sijil_url text,
  gambar_urls text[], -- senarai pautan gambar (boleh lebih 1)
  turutan int default 0
);

-- ==========================================================
-- Row Level Security: semua orang boleh BACA, hanya admin log masuk boleh UBAH
-- ==========================================================
alter table profil enable row level security;
alter table sejarah_perkhidmatan enable row level security;
alter table perkhidmatan enable row level security;
alter table kursus_disertai enable row level security;
alter table sijil enable row level security;
alter table kursus_dikendalikan enable row level security;

create policy "baca_awam_profil" on profil for select using (true);
create policy "baca_awam_sejarah" on sejarah_perkhidmatan for select using (true);
create policy "baca_awam_perkhidmatan" on perkhidmatan for select using (true);
create policy "baca_awam_kursus_disertai" on kursus_disertai for select using (true);
create policy "baca_awam_sijil" on sijil for select using (true);
create policy "baca_awam_kursus_dikendalikan" on kursus_dikendalikan for select using (true);

create policy "admin_ubah_profil" on profil for all using (auth.role() = 'authenticated');
create policy "admin_ubah_sejarah" on sejarah_perkhidmatan for all using (auth.role() = 'authenticated');
create policy "admin_ubah_perkhidmatan" on perkhidmatan for all using (auth.role() = 'authenticated');
create policy "admin_ubah_kursus_disertai" on kursus_disertai for all using (auth.role() = 'authenticated');
create policy "admin_ubah_sijil" on sijil for all using (auth.role() = 'authenticated');
create policy "admin_ubah_kursus_dikendalikan" on kursus_dikendalikan for all using (auth.role() = 'authenticated');

-- ==========================================================
-- Storage buckets untuk fail sijil & gambar (jalankan bahagian ini juga)
-- ==========================================================
insert into storage.buckets (id, name, public) values ('sijil', 'sijil', true);
insert into storage.buckets (id, name, public) values ('gambar', 'gambar', true);

create policy "baca_awam_storage_sijil" on storage.objects for select using (bucket_id = 'sijil');
create policy "baca_awam_storage_gambar" on storage.objects for select using (bucket_id = 'gambar');
create policy "admin_upload_sijil" on storage.objects for insert with check (bucket_id = 'sijil' and auth.role() = 'authenticated');
create policy "admin_upload_gambar" on storage.objects for insert with check (bucket_id = 'gambar' and auth.role() = 'authenticated');
create policy "admin_padam_sijil" on storage.objects for delete using (bucket_id = 'sijil' and auth.role() = 'authenticated');
create policy "admin_padam_gambar" on storage.objects for delete using (bucket_id = 'gambar' and auth.role() = 'authenticated');
