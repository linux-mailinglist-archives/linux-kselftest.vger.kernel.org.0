Return-Path: <linux-kselftest+bounces-13761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35280931E1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 02:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB16C1F22776
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 00:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A1F3D8E;
	Tue, 16 Jul 2024 00:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="GPlCRVLS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93E12B95
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721090774; cv=none; b=ntGVOGxeEv2vvF9fQFWBEZy5LR4z7JA2WGSiBkbN4elBCpP4LUpinsGHfxb8SIPnjg7dwIaBoKJuZSE2C8PSEn1So3okNkO2HGMb6rEzAVJt1T+s1h6+l1vlItnVjZpQk+Qb+mpXqelB01l1vl9eQ09saUsvB733slgxz/GFR44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721090774; c=relaxed/simple;
	bh=4uM0FvLy5udE+HfWQP/w0Px9dpx3wbZvNKZHLMQ7a2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SAHMEVv0Pp3S+H7zh4+S+34tT4WCuEv+LU2r0rtCl/SATbdWkJ3dsGCvPLThJGwWtrrJkPFsLvpYpGs+YtGKsdIx1j5dDflLJPHr84V4uIvH9zF57atEQYwdtlgIea8O64V2sBvEso9Ayre+gPASS88B4H7BIIs31eoRkjd4axE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=GPlCRVLS; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-65f852c82fcso23645597b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Jul 2024 17:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1721090770; x=1721695570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TD66OtDeh2iGxjhj1zv4qHDsUsV2aL1QtkjuvW+JSWU=;
        b=GPlCRVLSwC8ZDuocFpWUxrpS/MC7SXRJMG3zqnk0dKCx2OxlSR4a4V1zV+5kM9fNvw
         07rDG7Qy8rqKKZvmZIv8bOUFH1FdY2t8Su6lt5TFYKGfJu52aM4bbEonLefF+IJ9E9kd
         Q9uiswVmaBNx7T/5UgKp5VArNL9weQFafAcA+j8XIlh3xzE/ZMW2KbsDMCUHPe1R5xaV
         3R45Jh2pe+q7TWWAQ6c1sSAKdk6iumh59x0tQ2UPSkqDokOd1quAV2RCD144E3WldSO8
         2l8BvyuCzOzFsuYG2WBPSfLYN6OyDZ1TUlOAz3ppUOMiZKCAKBvQfwtjZA1vbKn75TPv
         aPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721090770; x=1721695570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TD66OtDeh2iGxjhj1zv4qHDsUsV2aL1QtkjuvW+JSWU=;
        b=gXhgdA7vIuVU8p3H3/vjVQJfRzKYOqGVN8lEX0R82LoNL/CimbjdrtIKHlanPXlDyC
         2TPdwtfLzon67Y43X+KI5jzgwjk3oZILMTgxyXk0ddLYeHxfXytiROZmps6BlGvnuK4N
         XcKi92daqDd7RYmD+IlX/HrFqrl1V6T8oNkHIdcB0MYIsMeaeEIfKSxuQ5d2ZmrXubDx
         EvN39oCbeLLO42pH1YlXnGTdUkOCFxBbZxG9pIo8JwYIoVXk2fc8pSB/sOBd5fSN6IoT
         1oCp0CSUofkipVrNa8Ia8H87qK0VheOSgPrvFEX+z4ejt7MKBJBi40Hu9DmO2zikpzJt
         Nbxg==
X-Forwarded-Encrypted: i=1; AJvYcCWtbkwQqKsws5hOlM9yirBcqOUD2SrIBvylIgx8vdlO3xdBsN6R5lkp87IhzT73aXtkjckTyLM4D0T6WHVGA2G57h7NFMbK2Nj+9H/YYVD/
X-Gm-Message-State: AOJu0YxSbcbTkvcYmxXqkwYioEX2VJUXzQOkEzwqfiuMbIOWiuAxYuRM
	hY4/oPyyEkiyE2++lvrgNjPxx200hUm51UWwDBHSGE6MUxlKDofuT2Ekw7uema6limPMzSGYfM8
	pGJzRCQMiXCnRbmnTHuWyh5n+K5jGt8LaetI7Mw==
X-Google-Smtp-Source: AGHT+IH2/Rko98brgCuBjHJl2Gx5ElpjIF+OOpCL1/BI2lJd+gA1z6MJ0fwOhu2NUVrUxOY5J6MQlr1Xw34lVNgzmNs=
X-Received: by 2002:a81:7c06:0:b0:64a:5f5a:b38c with SMTP id
 00721157ae682-66381bbc211mr7303107b3.26.1721090770201; Mon, 15 Jul 2024
 17:46:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715221126.487345-2-vadorovsky@gmail.com>
In-Reply-To: <20240715221126.487345-2-vadorovsky@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Mon, 15 Jul 2024 19:45:59 -0500
Message-ID: <CALNs47t=YQX+UP_ekq_Ue=BrA4JscDbU1qNDoKFar3yUbOSZ5g@mail.gmail.com>
Subject: Re: [PATCH v3] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Martin Rodriguez Reboredo <yakoyoku@gmail.com>, 
	Manmohan Shukla <manmshuk@gmail.com>, Valentin Obst <kernel@valentinobst.de>, 
	Asahi Lina <lina@asahilina.net>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Danilo Krummrich <dakr@redhat.com>, Charalampos Mitrodimas <charmitro@posteo.net>, 
	Ben Gooding <ben.gooding.dev@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Roland Xu <mu001999@outlook.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 5:14=E2=80=AFPM Michal Rostecki <vadorovsky@gmail.c=
om> wrote:

> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 0ba77276ae7e..c08f9dddaa6f 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> [...]
>              // SAFETY: FFI call without safety requirements.
>              let kunit_test =3D unsafe { $crate::bindings::kunit_get_curr=
ent_test() };
> @@ -71,11 +71,11 @@ macro_rules! kunit_assert {
>                  //
>                  // This mimics KUnit's failed assertion format.
>                  $crate::kunit::err(format_args!(
> -                    "    # {}: ASSERTION FAILED at {FILE}:{LINE}\n",
> +                    "    # {:?}: ASSERTION FAILED at {FILE:?}:{LINE:?}\n=
",
>                      $name
>                  ));
>                  $crate::kunit::err(format_args!(
> -                    "    Expected {CONDITION} to be true, but is false\n=
"
> +                    "    Expected {CONDITION:?} to be true, but is false=
\n"
>                  ));

These aren't exactly the same: the existing `Display` impl will print
the string (hexifying invalid characters), but this will add `" ... "`
around it.

In Rust's libraries, string `Path` and `OsStr` both have a
`.display()` method that returns a wrapper type that does implement
`fmt::Display`, which can then be printed (see [1]). We could do
something similar here, via a `CStrExt` trait that goes in the prelude
and provides `.display(&self)`.

Rust itself could actually use something here too - if you're up for
it, feel free to propose an implementation via ACP (that's just an
issue template at [2]). It would probably be pretty similar to the
recent `OsStr` one. Of course it will be a while before we can use it
in the kernel, but it wouldn't hurt to get the ball rolling.

[1]: https://doc.rust-lang.org/std/path/struct.Path.html#method.display
[2]: https://github.com/rust-lang/libs-team/issues

>  /// Creates a new [`CStr`] from a string literal.
>  ///
> -/// The string literal should not contain any `NUL` bytes.
> +/// Usually, defining C-string literals directly should be preffered, bu=
t this
> +/// macro is helpful in situations when C-string literals are hard or
> +/// impossible to use, for example:
> +///
> +/// - When working with macros, which already return a Rust string liter=
al
> +///   (e.g. `stringify!`).
> +/// - When building macros, where we want to take a Rust string literal =
as an
> +///   argument (for caller's convenience), but still use it as a C-strin=
g
> +///   internally.
> +///

s/preffered/prefered

"when C-string literals are hard or impossible to use" doesn't sound
quite right - I think it is more common that you're just hiding an
implementation detail (string type) from the user of a macro. Maybe
something like:

    This isn't needed when C-string literals (`c"hello"` syntax) can be
    used directly, but can be used when a C-string version of a standard st=
ring
    literal is required (often when working with macros).

> +/// The string should not contain any `NUL` bytes.
>  ///
>  /// # Examples
>  ///
>  /// ```
> +/// # use core::ffi::CStr;
>  /// # use kernel::c_str;
> -/// # use kernel::str::CStr;
> -/// const MY_CSTR: &CStr =3D c_str!("My awesome CStr!");
> +/// const MY_CSTR: &CStr =3D c_str!(stringify!(5));
>  /// ```
>  #[macro_export]
>  macro_rules! c_str {
>      ($str:expr) =3D> {{
>          const S: &str =3D concat!($str, "\0");
> -        const C: &$crate::str::CStr =3D match $crate::str::CStr::from_by=
tes_with_nul(S.as_bytes()) {
> +        const C: &core::ffi::CStr =3D match core::ffi::CStr::from_bytes_=
with_nul(S.as_bytes()) {
>              Ok(v) =3D> v,
>              Err(_) =3D> panic!("string contains interior NUL"),
>          };

Thanks for this, will be a nice bit of code cleanup.

- Trevor

(also, v2 and v3 are appearing in different threads on lore (as they
should), but they're in the same thread as v1 in my email client - any
idea if there is a reason for this?)

