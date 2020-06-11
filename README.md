<!-- -*- coding: utf-8; mode: markdown -*- -->

# Microft: A Program for Managing Documents

- by Satoshi Nakagawa
- 2020-06-10

## Introduction

(1) 文献を自炊することによって、
PDF ファイルが増えてきました。
(2) さまざまな事務書類をスキャンしているうちに
収拾がつかなくなってきました。

(1) の問題の解決のためにいろいろ
ソフトを探し、
[Calibre](https://calibre-ebook.com/) を
しばらく使いました。
しかしながら Calibre はわたしの趣味にあいません ---
あまりに仰々しすぎます。
もっと軽いプログラムがほしいのです。
(2) のためには
日本語のディレクトリ名をつかって、
日本語のファイル名をつかいました。
しかし、
このような階層的なタクソノミーでは
事務書類は処理しきれません。
いちばんいいのはタグ方式です。

Microft は、ファイルを
文献ファイルとそれ以外とに分類します。

## データ構造

つぎのようなファイルがあるとします：

     20200608064751_001.pdf
     20200608064843_001.pdf
     20200609132634_001.pdf
     212228.PDF
     C-101.mp3
     

これまでは、(1) これらを Calibre に登録するか、
さもなくば、
(2) これらのファイルに適当なファイル名をつけて、
適当なディレクトリ名に入れるという作業をしていました。
その代わりに、
これらのファイルを説明するファイルを作成します。

     20200608064751_001.pdf::ps::アマゾンの領収書（タオルその他）::\
       2020-06-05::finance,receipt, amazon
     20200608064843_001.pdf::ps::サイドトレーの説明書::2020-06::\
       manual,captain stag, manual
     20200610091621_001.pdf::wk::龍谷大学出張証明書::2020-06::eriko,
     2122228.PDF::bib::A Logical Paradox by L. Carroll::carroll-paradox
     C-101.mp3::mp3::1986年のフィールドワークの録音::1986::fieldwork,ende

一つのファイルが '::'と ',' とで区切られた1行の中で説明されます。

     1:2:3:4:5a,5b,5c,...


それぞれのフィールドは次のような意味です：

 1. ファイル名（ディレクトリ名はいらない、拡張子はかならずつける）
 2. ファイルの種類（bib かそれ以外）
 3. ファイルの簡単で、わかり易い説明
 4. 日付
 5. キーワードが ',' で区切られて列挙されています
 

## Configuration


