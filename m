Return-Path: <linux-kselftest+bounces-16203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6631495DC6B
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33C9B20971
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Aug 2024 07:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0D01547C0;
	Sat, 24 Aug 2024 07:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Ey8XxJ6Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4614E2F5
	for <linux-kselftest@vger.kernel.org>; Sat, 24 Aug 2024 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724484145; cv=none; b=dnSPNNDjmD1QGZKwtkuqwxNQVvYWOS9/7y+bPOp2K3/qmIPFyd8zCPxTQqKKuoGJW8ZhhrzXhDI5b6yjyyhukL7DVNdl3/igO6gpCiAAoYMzbUBIRvBpRj85aE4xi+b9VXCmcwtb/4Khn8FwuiHlZ1PS02ObGRwtpg8cdFEFduo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724484145; c=relaxed/simple;
	bh=OStfsJg52TgOodEuPCI04XC30uKxNi9BjiHLIAblgbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIveVj1Ht7y+q/RmdeHwqTFKjbaQUkK2300U1RqtrbqVmGfL05uyjUH/Odj/tHGBOfxbvIwc4YApm4C/6dwDskC7KnSH/t0zgNqyFy5xDum6A9Pwq4kKyM83EJ07mLAQLYiybik9BX7cyqG0EPywGKP2AE3AJ7j3W9xuvZ/9puo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Ey8XxJ6Q; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b8f13f28fbso23578247b3.1
        for <linux-kselftest@vger.kernel.org>; Sat, 24 Aug 2024 00:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1724484142; x=1725088942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVsalfG8grE5RGhDxTKtFqtbQowxlW8KEY/SQtljHg4=;
        b=Ey8XxJ6QjNRNhNCycoIGUGY6n2P8NGEUiJGhtrC7d6hKPOzBgm77JvRovs6OOHnglp
         iMUwhwW45StyOvwpXAZGmVCsvuy8E7Mk1QHKPLEK0/3BtlAa3vGpI21uvPhR7483DUoT
         KxqKmPLZz83PMYiRgO3ACDFq7u5dzp5YSQwIvCGiGQTzTEhLh+zYUc0HOiPVABIgmQ5w
         0zH3H4hsNYvGikRUkk64jP7P8khBNB4YAFTKcA01W4oUHhHgc6z62ZELOOfyDVNfpC4F
         VvbG1ZFHqYpAwBnnFnRVNM4pUTowxFplm/lZXnLmAnc6WSvA2fugQhfK5hoXOIiAin0H
         ECfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724484142; x=1725088942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVsalfG8grE5RGhDxTKtFqtbQowxlW8KEY/SQtljHg4=;
        b=Zylj+c/0kmLiVRJZSj+/Sb7NpeJCvay9yuxxitnEEgC4p+nt2WgpPPo0tUPhfGDomo
         tC6kXQ3abfI5DjWruVehf1mmp6wK4jL7AXzbpvOH3VD+QUEL4NjsLc1YXl0oT3e24T65
         zTPCQpe1g/QBYKLqmCfWjXcm2NhV63hfFsg+bmjSIi54ZusXf0mUjgS9F7by4vI615wg
         EuFM/cyQlPjuXhaK9+ehZOSTNcOSx8pzhmXcz16W7p2O+byQVCF9GPgdcG817YZ6aa4c
         QtqYPIMuWFlyxxtDcfaalu+9e/L9mOxiepeUJ6OTBvColXsW8afZPPT7EdZp2CbeVqk5
         TXwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA/gy+s5kLR+6dN77GOkptLw8ozB8XF4UfF2A7MXYKpvieGvcWm7BtLzR2MVjQ2ysKwYgXaGa4h/1XUj9mLXE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoAThELu6maa3C1c7FrPrcgQykCqYMBH7mJvzERrgDxllY04Aq
	v+Bpvdczq81HLL2B2tXldEOkGxRHV1dVnUj2L8iw6Fmn3cbvrq/qZH3/2HqDYkyHfvQ78/sATtx
	mGHIwtPxHweBxumiKimxidd9n6RlKZnlouBcJbg==
X-Google-Smtp-Source: AGHT+IEVBoQ80HNOho+LZux6lbfvXl8vt0fCx9AYG0zW1m1SHhNoA2/84+JhvXA8lXkPyPOtHR5BM1lzqViGPT9r19k=
X-Received: by 2002:a05:690c:768c:b0:6b2:7bd8:d7a4 with SMTP id
 00721157ae682-6c629fd7875mr51388347b3.41.1724484142200; Sat, 24 Aug 2024
 00:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819153656.28807-2-vadorovsky@protonmail.com>
In-Reply-To: <20240819153656.28807-2-vadorovsky@protonmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 24 Aug 2024 02:22:11 -0500
Message-ID: <CALNs47sa3RfbeGoT+_MUcZUAv=Wn2t0o1L-9v1D7jWp6NVicGg@mail.gmail.com>
Subject: Re: [PATCH RESEND v5] rust: str: Use `core::CStr`, remove the custom
 `CStr` implementation
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
	Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Asahi Lina <lina@asahilina.net>, Danilo Krummrich <dakr@redhat.com>, Tiago Lam <tiagolam@gmail.com>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Tejun Heo <tj@kernel.org>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 10:39=E2=80=AFAM Michal Rostecki <vadorovsky@gmail.=
com> wrote:
>
> From: Michal Rostecki <vadorovsky@gmail.com>

You don't need this since the email already shows it is already from
you :) Aiui this is only needed when forwarding a patch for someone
else, or if you use a different commit email for some reason.

> `CStr` became a part of `core` library in Rust 1.75. This change replaces
> the custom `CStr` implementation with the one from `core`.

The diff in `kernel/str.rs` is really difficult to read and review
since the new parts get interleaved with the removed lines. Could you
split this into a couple patches? Probably roughly the five described
below:

1. Add all the new things `CStrExt`, `CStrDisplay`, and their implementatio=
ns.
2. Add `CStrExt` to the prelude (Alice's suggestion)
3. Update existing uses of our `CStr` to instead use `core::CStr`
4. Remove our current `CStr`
5. Change any docs for `CString` or `c_str!`, as relevant

Just remember that things should build after each patch.

> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 0ba77276ae7e..79a50ab59af0 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -56,13 +56,15 @@ macro_rules! kunit_assert {
>                 break 'out;
>             }
>
> -            static FILE: &'static $crate::str::CStr =3D $crate::c_str!($=
file);
> +            static FILE: &'static core::ffi::CStr =3D $file;
>             static LINE: i32 =3D core::line!() as i32 - $diff;
> -            static CONDITION: &'static $crate::str::CStr =3D $crate::c_s=
tr!(stringify!($condition));
> +            static CONDITION: &'static core::ffi::CStr =3D $crate::c_str=
!(stringify!($condition));

This change and the associated invocation changes can be dropped since
we are keeping `c_str`. It's cleaner to be able to call macros with
"standard strings" rather than c"c strings" where possible.

> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index bb8d4f41475b..97a298a44b96 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs

(I removed most of the `-` lines for my review below)

> +/// Wrapper around [`CStr`] which implements [`Display`](core::fmt::Disp=
lay).
> +pub struct CStrDisplay<'a>(&'a CStr);
>
> +impl fmt::Display for CStrDisplay<'_> {
> +    /// Formats printable ASCII characters, escaping the rest.
>      ///
>      /// # Examples
>      ///
>      /// ```
> +    /// # use core::ffi::CStr;
>      /// # use kernel::c_str;
>      /// # use kernel::fmt;
> +    /// # use kernel::str::{CStrExt, CString};
> +    /// let penguin =3D c"=F0=9F=90=A7";
> +    /// let s =3D CString::try_from_fmt(fmt!("{}", penguin.display())).u=
nwrap();
> +    /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_by=
tes());
> +    ///
> +    /// let ascii =3D c"so \"cool\"";
> +    /// let s =3D CString::try_from_fmt(fmt!("{}", ascii.display())).unw=
rap();
> +    /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
>      /// ```
>      fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {

You don't need docs on the `Display` impl since that is more or less
innate. Docs should indeed be on `fn display()`, which you have.

> +/// Extensions to [`CStr`].
> +pub trait CStrExt {
> +    /// Returns an object that implements [`Display`](core::fmt::Display=
) for
> +    /// safely printing a [`CStr`] that may contain non-ASCII data, whic=
h are
> +    /// escaped.

Just split this into two sentences, e.g.

    /// Returns an object ... for safely printing a [`CStr`].
    ///
    /// If the `CStr` contains non-ASCII data, it is escaped.

> +    ///
> +    /// # Examples
>      ///
>      /// ```
> +    /// # use core::ffi::CStr;
>      /// # use kernel::c_str;
>      /// # use kernel::fmt;
> +    /// # use kernel::str::{CStrExt, CString};
> +    /// let penguin =3D c"=F0=9F=90=A7";
> +    /// let s =3D CString::try_from_fmt(fmt!("{}", penguin.display())).u=
nwrap();
> +    /// assert_eq!(s.to_bytes_with_nul(), "\\xf0\\x9f\\x90\\xa7\0".as_by=
tes());
> +    ///
> +    /// let ascii =3D c"so \"cool\"";
> +    /// let s =3D CString::try_from_fmt(fmt!("{}", ascii.display())).unw=
rap();
> +    /// assert_eq!(s.to_bytes_with_nul(), "so \"cool\"\0".as_bytes());
>      /// ```
> +    fn display(&self) -> CStrDisplay<'_>;

Nit: Could you swap the ascii and penguin examples so the easier one
is first? Also I would remove the extra quote chars `\"` since it
makes things tougher to read without demonstrating much.

> +    /// Creates a mutable [`CStr`] from a `[u8]` without performing any
> +    /// additional checks.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `bytes` *must* end with a `NUL` byte, and should only have a sin=
gle
> +    /// `NUL` byte (or the string will be truncated).
> +    unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mu=
t Self;
>  }

+1 to Alice's suggestion of removing this and leaving `DerefMut` if
that works for our usecases.

If we leave this, just copy the `# Safety` section from
`CStr::from_bytes_with_nul_unchecked` since I think this could use
some improved wording (and "or the string will be truncated" is not
accurate - any number of things could break, it doesn't just become a
shorter string).

>  /// Creates a new [`CStr`] from a string literal.
>  ///
> +/// This macro is not needed when C-string literals (`c"hello"` syntax) =
can be
> +/// used directly, but can be used when a C-string version of a standard=
 string
> +/// literal is required (often when working with macros).
> +///
> +/// The string should not contain any `NUL` bytes.

For the last line, maybe

    /// # Panics
    ///
    /// This macro panics if the string contains an interior `NUL` byte.

>  /// # Examples
>  ///
>  /// ```
> +/// # use core::ffi::CStr;
>  /// # use kernel::c_str;
> +/// const MY_CSTR: &CStr =3D c_str!(stringify!(5));
>  /// ```
>  #[macro_export]
>  macro_rules! c_str {
>      ($str:expr) =3D> {{
>          const S: &str =3D concat!($str, "\0");
> +        const C: &core::ffi::CStr =3D match core::ffi::CStr::from_bytes_=
with_nul(S.as_bytes()) {
>              Ok(v) =3D> v,
>              Err(_) =3D> panic!("string contains interior NUL"),
>          };

Thanks for the updates from last time. For what it's worth, this is
the first time an email from this series has come through for me with
no problems (not getting grouped in the same thread as all other
versions in my client) so whatever it is, do the same thing next time
:)

- Trevor

[1]: https://doc.rust-lang.org/std/ffi/struct.CStr.html#method.from_bytes_w=
ith_nul_unchecked

