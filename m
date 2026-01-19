Return-Path: <linux-kselftest+bounces-49329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB75D39F69
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 08:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19A3B30141F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 07:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0829B76F;
	Mon, 19 Jan 2026 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3AwHdM9S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3802D9EC8
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768806605; cv=pass; b=XFF5TCdFVsvbLzLrfwQ1GG3HnkFLNr7qfwNotAaU1PYzpM7HHyacy0czhXZieB6En9BlIVgo/nMgFLAnhZ7/ihmA5a51kd0+2R3/T/waIQMUdEwC7xogGunZu/0Att/UoPaKRx1ebLUJu2UYgM6ZZQ3Ry/UMReGE9cOUiWYxlc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768806605; c=relaxed/simple;
	bh=YJwOWfVQh6yINS7Lz5VgxA74qayNw8Y1qBWGFgOYt6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3ivqsxT7jclEtXguCBjJIy/0eTdbih92AKLNvIR83ZI9kfCxWcpAnSvyqTOL9irWg1sRBubziyXs2LqNmGJAjla2v3RoDIzE0URj9fVtLJA9WbMux3ivxiDRCvRu7NZT/Fomokuq8CFLmjR6Q5tAcj1WNBN8b/hPsQpoObo9BM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3AwHdM9S; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47ee76e8656so44973905e9.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 23:10:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768806601; cv=none;
        d=google.com; s=arc-20240605;
        b=gvV5fRiWz4x9pdcAGptO4lGjxjVF7JcQiVZVZ85ZEHhlK1wn5z/+4zxZYhzf+afClD
         b0Up8urVyeyqshwpRUYI0zsP1qk5Z9OBcTbKb5CYUCAIYmZkPoAfg4D70/wmjXW/Xcpn
         wI8cbHFT+pXjJq4npIpUfwMLsosImTOfCFo7SV5vMohEiDZgyxHl9p2YzMdPqjs6I0uE
         Pm1fg70u2pG36mIeaTZNO9ejxt1pCOic7FiiqXX2E0IJRbqesv20KDOvYd9ORPiNRsJk
         aed/PITEK5NBtZi5r6dCfua5jUga9TVzMLjVUPFw8/jsk4W1PAeFItnHK2l4j/w1X+S8
         KKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iFTd4aSly82RgEwowK2RHq9aNVUAosb6nM34vajjf00=;
        fh=NoWt+1YRKlyt83nWNo4cO0LoC3VIbBAi4H6FiYcb78c=;
        b=k+6b6nNeMAkHx1FK/I2tNeKgZStiBUhM+q5+1dMWxUJrS66a3I0CK209YIw9DiNEz2
         /DYpHDri1TFgRLxtQS6CpzZ9zL59gml8q0QIiXAUFJ++o1mDlfZ/WZzW/Kdq9wa+TOhT
         p2Cx4R27w/kPa4SoydqC21oS2AkSXtYP+kD0A88uarV4lXZwrqE0JpiBnXEHWMBjI3Zc
         7gQ8QBkw9+84owhBLnXF8VnSk+0iu7ZZbo8JuwUIehPc46KiPDxe5Y/RVrbcKzDCvhlb
         XdGsk87oorltoZ+hKbHQqph8sXpGfaXx/QgQAp/X7a4C+BKYUR8+vgpSkXe7YeLA9GcS
         qYew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768806601; x=1769411401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFTd4aSly82RgEwowK2RHq9aNVUAosb6nM34vajjf00=;
        b=3AwHdM9SQBPWk24WbtxVxJDBxvgSBTYeb5ab6fKXayV2EfTBnsBkQkNET8m3okqMkN
         xIBKLSk9zkCDpHgl+HKmW0kRVtM6p3UMIruwJrHTBVWgshLaa62L0vff6Lv4YYCIEMDw
         vo+JFIkv8MIVexMnvYdYmWkhu/Bj0PK7v16MTd0C2a0ZKFI29eq2Jf+LTZl+87giVbDQ
         IvOvrOgYzBdzKUIysgwbWflqi6Vju3zu5fE8DCHgBXTbA2No6jrpZc8hA3Fm/QWaToUH
         IyXyz8ghHnfS6x9Vxmgp8SzJVtVtcL13RXpZfzQfzXJrGCh8ciVuzVLEaIlGoa62D7Mv
         iZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768806601; x=1769411401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFTd4aSly82RgEwowK2RHq9aNVUAosb6nM34vajjf00=;
        b=BWc5b/0qIVYf04IS3cbR4uQxCh6C/2jP8Hpl+cyeJ7ln2kMnZ3Sg7foKJrm0enrR/d
         VtveF1fVD3KiFtI5nmqmklRhZI7XFYCuJlLaInSmZJ7cm/9Nk8PLrevqzUco2LjXUPOK
         K2lSVvuKHlVvohGItWGrTDX/m2otVymW9mEY4BHBK1PSqpYLPle/WNLqFilue/u0u1v5
         DiNTq8kyfGjxKTxCsYJfRNIMZnH6uCgaZ1fBpaLgCanV21W2IspIYoMQFTMRA/rnQGDh
         lz5GezquCXIFxwIJu/qkwmhZp6KyLsWSbl71uvM9XPNhXG3fIaUbkUIKa1DNTnS/62DP
         Ee9g==
X-Forwarded-Encrypted: i=1; AJvYcCUe0o7MI8nnaGxO523OTISHj+lJ3hD7llNRV+QV5jITxtngK2aD/CjOU0x+1WN/LPvTiMuwuC+Y31PMvOX7TBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymwRjfP9pH+1V61W3ubug88yyglqsETrGnEOVx2JlnWNWE+hYN
	j1wte6FOXemHqPzKjssz118geleXWC4UfKXqlm13MpkwUq6M/jPxvsYp9NPmPLXzfCPcIigTVHh
	YdUH+pCAXsk2BRFm95+09MkcsDbTRcd/BZBPdt3s5
X-Gm-Gg: AY/fxX58e32Fg2xbb1pTw/p80G38VSw9Ic+mt7ZZY4tnbYWuzDkmNpvEsKNoC/yrL6B
	cSWxq72CctZhCTkoDZ8C0Hfa8bkp7srV1IccBIxDzt3LHXHdfo4mehIdCuhZAo3sVUyfmC3D7L3
	OZ2UTiioN4xg7JpLJUEciLoYH+Ffxry2dTaAnugEhxzcGRO0RxVX4gcQ3oE+QOxCAS9J2YDE6+5
	TffMwe2yVVEoTEcXsuX8Gr6EUerx+SJ2P4skIYhJ9EGEXLIhOhv2fyAuXoj5gScMJTTRw==
X-Received: by 2002:a05:600c:628c:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-4801e30b6ffmr105306995e9.11.1768806600416; Sun, 18 Jan 2026
 23:10:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112170919.1888584-1-gary@kernel.org> <20260112170919.1888584-3-gary@kernel.org>
In-Reply-To: <20260112170919.1888584-3-gary@kernel.org>
From: David Gow <davidgow@google.com>
Date: Mon, 19 Jan 2026 15:09:47 +0800
X-Gm-Features: AZwV_Qgf9RpPPaXzLi3y89CtdVCbOwbBBQEnweE0QN8rZgQIzFtAYxv4u2rXIHM
Message-ID: <CABVgOS=f2CdEyrMbQiPc5Jehc0GCzPdv1a790VDFcJ7CtZzYfg@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] rust: macros: use `quote!` from vendored crate
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Tamir Duberstein <tamird@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-modules@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000254f2a0648b86124"

--000000000000254f2a0648b86124
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Jan 2026 at 01:11, Gary Guo <gary@kernel.org> wrote:
>
> From: Gary Guo <gary@garyguo.net>
>
> With `quote` crate now vendored in the kernel, we can remove our custom
> `quote!` macro implementation and just rely on that crate instead.
>
> The `quote` crate uses types from the `proc-macro2` library so we also
> update to use that, and perform conversion in the top-level lib.rs.
>
> Clippy complains about unnecessary `.to_string()` as `proc-macro2`
> provides additional `PartialEq` impl, so they are removed.
>
> Reviewed-by: Tamir Duberstein <tamird@gmail.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

Acked-by: David Gow <davidgow@google.com> # for kunit

Cheers,
-- David


-- David

>  rust/macros/concat_idents.rs |   2 +-
>  rust/macros/export.rs        |   4 +-
>  rust/macros/fmt.rs           |   4 +-
>  rust/macros/helpers.rs       |   4 +-
>  rust/macros/kunit.rs         |   5 +-
>  rust/macros/lib.rs           |  21 ++--
>  rust/macros/module.rs        |   6 +-
>  rust/macros/paste.rs         |   2 +-
>  rust/macros/quote.rs         | 182 -----------------------------------
>  rust/macros/vtable.rs        |   7 +-
>  10 files changed, 32 insertions(+), 205 deletions(-)
>  delete mode 100644 rust/macros/quote.rs
>
> diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.rs
> index 7e4b450f3a507..12cb231c3d715 100644
> --- a/rust/macros/concat_idents.rs
> +++ b/rust/macros/concat_idents.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{token_stream, Ident, TokenStream, TokenTree};
> +use proc_macro2::{token_stream, Ident, TokenStream, TokenTree};
>
>  use crate::helpers::expect_punct;
>
> diff --git a/rust/macros/export.rs b/rust/macros/export.rs
> index a08f6337d5c8d..92d9b30971929 100644
> --- a/rust/macros/export.rs
> +++ b/rust/macros/export.rs
> @@ -1,7 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> +use proc_macro2::TokenStream;
> +use quote::quote;
> +
>  use crate::helpers::function_name;
> -use proc_macro::TokenStream;
>
>  /// Please see [`crate::export`] for documentation.
>  pub(crate) fn export(_attr: TokenStream, ts: TokenStream) -> TokenStream=
 {
> diff --git a/rust/macros/fmt.rs b/rust/macros/fmt.rs
> index 2f4b9f6e22110..19f709262552b 100644
> --- a/rust/macros/fmt.rs
> +++ b/rust/macros/fmt.rs
> @@ -1,8 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{Ident, TokenStream, TokenTree};
>  use std::collections::BTreeSet;
>
> +use proc_macro2::{Ident, TokenStream, TokenTree};
> +use quote::quote_spanned;
> +
>  /// Please see [`crate::fmt`] for documentation.
>  pub(crate) fn fmt(input: TokenStream) -> TokenStream {
>      let mut input =3D input.into_iter();
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index 365d7eb499c08..13fafaba12261 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{token_stream, Group, Ident, TokenStream, TokenTree};
> +use proc_macro2::{token_stream, Group, Ident, TokenStream, TokenTree};
>
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<Strin=
g> {
>      if let Some(TokenTree::Ident(ident)) =3D it.next() {
> @@ -86,7 +86,7 @@ pub(crate) fn function_name(input: TokenStream) -> Opti=
on<Ident> {
>      let mut input =3D input.into_iter();
>      while let Some(token) =3D input.next() {
>          match token {
> -            TokenTree::Ident(i) if i.to_string() =3D=3D "fn" =3D> {
> +            TokenTree::Ident(i) if i =3D=3D "fn" =3D> {
>                  if let Some(TokenTree::Ident(i)) =3D input.next() {
>                      return Some(i);
>                  }
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index b395bb0536959..5cd6aa5eef07d 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -4,10 +4,11 @@
>  //!
>  //! Copyright (c) 2023 Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.co=
m>
>
> -use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
>  use std::collections::HashMap;
>  use std::fmt::Write;
>
> +use proc_macro2::{Delimiter, Group, TokenStream, TokenTree};
> +
>  pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenSt=
ream {
>      let attr =3D attr.to_string();
>
> @@ -59,7 +60,7 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: TokenS=
tream) -> TokenStream {
>                  }
>                  _ =3D> (),
>              },
> -            TokenTree::Ident(i) if i.to_string() =3D=3D "fn" && attribut=
es.contains_key("test") =3D> {
> +            TokenTree::Ident(i) if i =3D=3D "fn" && attributes.contains_=
key("test") =3D> {
>                  if let Some(TokenTree::Ident(test_name)) =3D body_it.nex=
t() {
>                      tests.push((test_name, attributes.remove("cfg").unwr=
ap_or_default()))
>                  }
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index b38002151871a..945982c21f703 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -11,8 +11,6 @@
>  // to avoid depending on the full `proc_macro_span` on Rust >=3D 1.88.0.
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_SPAN_FILE), feature(proc_macro_span))]
>
> -#[macro_use]
> -mod quote;
>  mod concat_idents;
>  mod export;
>  mod fmt;
> @@ -132,7 +130,7 @@
>  ///     the kernel module.
>  #[proc_macro]
>  pub fn module(ts: TokenStream) -> TokenStream {
> -    module::module(ts)
> +    module::module(ts.into()).into()
>  }
>
>  /// Declares or implements a vtable trait.
> @@ -207,7 +205,7 @@ pub fn module(ts: TokenStream) -> TokenStream {
>  /// [`kernel::error::VTABLE_DEFAULT_ERROR`]: ../kernel/error/constant.VT=
ABLE_DEFAULT_ERROR.html
>  #[proc_macro_attribute]
>  pub fn vtable(attr: TokenStream, ts: TokenStream) -> TokenStream {
> -    vtable::vtable(attr, ts)
> +    vtable::vtable(attr.into(), ts.into()).into()
>  }
>
>  /// Export a function so that C code can call it via a header file.
> @@ -230,7 +228,7 @@ pub fn vtable(attr: TokenStream, ts: TokenStream) -> =
TokenStream {
>  /// automatically exported with `EXPORT_SYMBOL_GPL`.
>  #[proc_macro_attribute]
>  pub fn export(attr: TokenStream, ts: TokenStream) -> TokenStream {
> -    export::export(attr, ts)
> +    export::export(attr.into(), ts.into()).into()
>  }
>
>  /// Like [`core::format_args!`], but automatically wraps arguments in [`=
kernel::fmt::Adapter`].
> @@ -248,7 +246,7 @@ pub fn export(attr: TokenStream, ts: TokenStream) -> =
TokenStream {
>  /// [`pr_info!`]: ../kernel/macro.pr_info.html
>  #[proc_macro]
>  pub fn fmt(input: TokenStream) -> TokenStream {
> -    fmt::fmt(input)
> +    fmt::fmt(input.into()).into()
>  }
>
>  /// Concatenate two identifiers.
> @@ -306,7 +304,7 @@ pub fn fmt(input: TokenStream) -> TokenStream {
>  /// ```
>  #[proc_macro]
>  pub fn concat_idents(ts: TokenStream) -> TokenStream {
> -    concat_idents::concat_idents(ts)
> +    concat_idents::concat_idents(ts.into()).into()
>  }
>
>  /// Paste identifiers together.
> @@ -444,9 +442,12 @@ pub fn concat_idents(ts: TokenStream) -> TokenStream=
 {
>  /// [`paste`]: https://docs.rs/paste/
>  #[proc_macro]
>  pub fn paste(input: TokenStream) -> TokenStream {
> -    let mut tokens =3D input.into_iter().collect();
> +    let mut tokens =3D proc_macro2::TokenStream::from(input).into_iter()=
.collect();
>      paste::expand(&mut tokens);
> -    tokens.into_iter().collect()
> +    tokens
> +        .into_iter()
> +        .collect::<proc_macro2::TokenStream>()
> +        .into()
>  }
>
>  /// Registers a KUnit test suite and its test cases using a user-space l=
ike syntax.
> @@ -473,5 +474,5 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  /// ```
>  #[proc_macro_attribute]
>  pub fn kunit_tests(attr: TokenStream, ts: TokenStream) -> TokenStream {
> -    kunit::kunit_tests(attr, ts)
> +    kunit::kunit_tests(attr.into(), ts.into()).into()
>  }
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 80cb9b16f5aaf..b855a2b586e18 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -1,9 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use crate::helpers::*;
> -use proc_macro::{token_stream, Delimiter, Literal, TokenStream, TokenTre=
e};
>  use std::fmt::Write;
>
> +use proc_macro2::{token_stream, Delimiter, Literal, TokenStream, TokenTr=
ee};
> +
> +use crate::helpers::*;
> +
>  fn expect_string_array(it: &mut token_stream::IntoIter) -> Vec<String> {
>      let group =3D expect_group(it);
>      assert_eq!(group.delimiter(), Delimiter::Bracket);
> diff --git a/rust/macros/paste.rs b/rust/macros/paste.rs
> index cce712d19855b..2181e312a7d32 100644
> --- a/rust/macros/paste.rs
> +++ b/rust/macros/paste.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
> +use proc_macro2::{Delimiter, Group, Ident, Spacing, Span, TokenTree};
>
>  fn concat_helper(tokens: &[TokenTree]) -> Vec<(String, Span)> {
>      let mut tokens =3D tokens.iter();
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> deleted file mode 100644
> index ddfc21577539c..0000000000000
> --- a/rust/macros/quote.rs
> +++ /dev/null
> @@ -1,182 +0,0 @@
> -// SPDX-License-Identifier: Apache-2.0 OR MIT
> -
> -use proc_macro::{TokenStream, TokenTree};
> -
> -pub(crate) trait ToTokens {
> -    fn to_tokens(&self, tokens: &mut TokenStream);
> -}
> -
> -impl<T: ToTokens> ToTokens for Option<T> {
> -    fn to_tokens(&self, tokens: &mut TokenStream) {
> -        if let Some(v) =3D self {
> -            v.to_tokens(tokens);
> -        }
> -    }
> -}
> -
> -impl ToTokens for proc_macro::Group {
> -    fn to_tokens(&self, tokens: &mut TokenStream) {
> -        tokens.extend([TokenTree::from(self.clone())]);
> -    }
> -}
> -
> -impl ToTokens for proc_macro::Ident {
> -    fn to_tokens(&self, tokens: &mut TokenStream) {
> -        tokens.extend([TokenTree::from(self.clone())]);
> -    }
> -}
> -
> -impl ToTokens for TokenTree {
> -    fn to_tokens(&self, tokens: &mut TokenStream) {
> -        tokens.extend([self.clone()]);
> -    }
> -}
> -
> -impl ToTokens for TokenStream {
> -    fn to_tokens(&self, tokens: &mut TokenStream) {
> -        tokens.extend(self.clone());
> -    }
> -}
> -
> -/// Converts tokens into [`proc_macro::TokenStream`] and performs variab=
le interpolations with
> -/// the given span.
> -///
> -/// This is a similar to the
> -/// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_sp=
anned.html) macro from the
> -/// `quote` crate but provides only just enough functionality needed by =
the current `macros` crate.
> -macro_rules! quote_spanned {
> -    ($span:expr =3D> $($tt:tt)*) =3D> {{
> -        let mut tokens =3D ::proc_macro::TokenStream::new();
> -        {
> -            #[allow(unused_variables)]
> -            let span =3D $span;
> -            quote_spanned!(@proc tokens span $($tt)*);
> -        }
> -        tokens
> -    }};
> -    (@proc $v:ident $span:ident) =3D> {};
> -    (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) =3D> {
> -        $crate::quote::ToTokens::to_tokens(&$id, &mut $v);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) =3D> {
> -        for token in $id {
> -            $crate::quote::ToTokens::to_tokens(&token, &mut $v);
> -        }
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) =3D> {
> -        #[allow(unused_mut)]
> -        let mut tokens =3D ::proc_macro::TokenStream::new();
> -        quote_spanned!(@proc tokens $span $($inner)*);
> -        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::n=
ew(
> -            ::proc_macro::Delimiter::Parenthesis,
> -            tokens,
> -        ))]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) =3D> {
> -        let mut tokens =3D ::proc_macro::TokenStream::new();
> -        quote_spanned!(@proc tokens $span $($inner)*);
> -        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::n=
ew(
> -            ::proc_macro::Delimiter::Bracket,
> -            tokens,
> -        ))]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) =3D> {
> -        let mut tokens =3D ::proc_macro::TokenStream::new();
> -        quote_spanned!(@proc tokens $span $($inner)*);
> -        $v.extend([::proc_macro::TokenTree::Group(::proc_macro::Group::n=
ew(
> -            ::proc_macro::Delimiter::Brace,
> -            tokens,
> -        ))]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident :: $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::Spacing::Joint, ::proc_macro::Spacing::=
Alone].map(|spacing| {
> -            ::proc_macro::TokenTree::Punct(::proc_macro::Punct::new(':',=
 spacing))
> -        }));
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident : $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new(':', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident , $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new(',', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident @ $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new('@', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident ! $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new('!', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident ; $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new(';', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident + $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new('+', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident =3D $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new('=3D', ::proc_macro::Spacing::Alone=
),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident # $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new('#', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident & $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Punct(
> -            ::proc_macro::Punct::new('&', ::proc_macro::Spacing::Alone),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident _ $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Ident(
> -            ::proc_macro::Ident::new("_", $span),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -    (@proc $v:ident $span:ident $id:ident $($tt:tt)*) =3D> {
> -        $v.extend([::proc_macro::TokenTree::Ident(
> -            ::proc_macro::Ident::new(stringify!($id), $span),
> -        )]);
> -        quote_spanned!(@proc $v $span $($tt)*);
> -    };
> -}
> -
> -/// Converts tokens into [`proc_macro::TokenStream`] and performs variab=
le interpolations with
> -/// mixed site span ([`Span::mixed_site()`]).
> -///
> -/// This is a similar to the [`quote!`](https://docs.rs/quote/latest/quo=
te/macro.quote.html) macro
> -/// from the `quote` crate but provides only just enough functionality n=
eeded by the current
> -/// `macros` crate.
> -///
> -/// [`Span::mixed_site()`]: https://doc.rust-lang.org/proc_macro/struct.=
Span.html#method.mixed_site
> -macro_rules! quote {
> -    ($($tt:tt)*) =3D> {
> -        quote_spanned!(::proc_macro::Span::mixed_site() =3D> $($tt)*)
> -    }
> -}
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index ee06044fcd4f3..a67d1cc81a2d3 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -1,9 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{Delimiter, Group, TokenStream, TokenTree};
>  use std::collections::HashSet;
>  use std::fmt::Write;
>
> +use proc_macro2::{Delimiter, Group, TokenStream, TokenTree};
> +
>  pub(crate) fn vtable(_attr: TokenStream, ts: TokenStream) -> TokenStream=
 {
>      let mut tokens: Vec<_> =3D ts.into_iter().collect();
>
> @@ -31,7 +32,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStrea=
m) -> TokenStream {
>      let mut consts =3D HashSet::new();
>      while let Some(token) =3D body_it.next() {
>          match token {
> -            TokenTree::Ident(ident) if ident.to_string() =3D=3D "fn" =3D=
> {
> +            TokenTree::Ident(ident) if ident =3D=3D "fn" =3D> {
>                  let fn_name =3D match body_it.next() {
>                      Some(TokenTree::Ident(ident)) =3D> ident.to_string()=
,
>                      // Possibly we've encountered a fn pointer type inst=
ead.
> @@ -39,7 +40,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStrea=
m) -> TokenStream {
>                  };
>                  functions.push(fn_name);
>              }
> -            TokenTree::Ident(ident) if ident.to_string() =3D=3D "const" =
=3D> {
> +            TokenTree::Ident(ident) if ident =3D=3D "const" =3D> {
>                  let const_name =3D match body_it.next() {
>                      Some(TokenTree::Ident(ident)) =3D> ident.to_string()=
,
>                      // Possibly we've encountered an inline const block =
instead.
> --
> 2.51.2
>

--000000000000254f2a0648b86124
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
Dxz3AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHZtY3XkWtC2
e2Idfk+0JyK7BLzzMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBo
hqjbVaHxZoT6HHUuwQcTlbgXpuVi59bQPrSwb/6Pn1t3h3SLeuUCvOYpoQjxlWy/FexsPW+nWS0I
PUmWpt6sxbIRTKPfb7cPk32XezfnA0jexucybiXzkZKTrbI7zoMOzDIWpTKYZAonB9Zzi7Dso4An
ZOtz/E3yhdR/q1MK30d5fiCS0vorEd0Oy8Jzcc7TJ2HGMzEEXiFFvVrJYJHvfYOeXE4ywAG6YWO0
x78+bXeB9vkeWHhOYKyYXuAXrnHASddEICg1QlJCHDAISMC1Wn/tjqTMTt3sDAe+dhi9V1FEGTbG
g9PxPVP4huJEMIBu/MWNMzHfiW4E7eCHVPrmtX7CFDlMik7qsgQBbO5h6EcxBamhIflfMgoISsRJ
Vyll2E5BNVwkNstMgU3WMg5yIaQcuGFgFnMTrQcaLEEFPV3cCP9pgXovYDirnB7FKNdCZNHfeBY1
HEXJ2jIPDP6nWSbYoRry0TvPgxh5ZeM5+sc1L7kY75C8U4FV3t4qdC+p7rgqfAggdvDPa5BJbTRg
KAzwyf3z7XUrYp38pXybmDnsEcRNBIOEqBXoiBxZXaKQqaY921nWAroMM/6I6CVpTnu6JEeQkoi4
IgGIEaTFPcgAjvpDQ8waLJL84EP6rbLW6dop+97BXbeO9L/fFf40kBhve6IggpJSeU9RdCQ5czGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAYQLf/BIzLow9kWqD8My
PzANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg+cmwJuYkoGn+X55QTk27Ovzh1Iuw
mleP1zpxpXl/pdcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjYw
MTE5MDcxMDAxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAIz3kwdmtwbB+HQXKz79zZTPey/kth6i/TYdGMvNZdYf3RqFGrvZ5I+nt+yDFpVsd
9drHeRYit3eTomh83tC1BP8oU6wwD3T60dN13jxzBiftSxnJMNuW84Dv+ZgnGCc9Q26Y3A0V13uJ
GrZmalBl/+dswZUpRYMK1NpoGep+8VMhjb42et/l3OQrvQY8m1IVDdOVyXYf3AL8NbUbDUYdy56i
Da1H4Q7OqUqWF3eiTy/fKiZd0yf4Z6KxwiEIoPU2vS8BmyYfB4kaHJvNdGhFQLE8w97N/UvaBfys
onviXbTPiG+DEDw/6epfUD4rTBYrJg18U7Y17SmzI2nJlcXTxw==
--000000000000254f2a0648b86124--

