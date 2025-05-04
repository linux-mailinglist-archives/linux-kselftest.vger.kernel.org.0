Return-Path: <linux-kselftest+bounces-32282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C25AA887E
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 19:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443363B10AE
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 17:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1531EB1B7;
	Sun,  4 May 2025 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU9CJ0ap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130841E5B88;
	Sun,  4 May 2025 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379802; cv=none; b=VGlAVYWcYR3ril6OIKunPkeNoohc05b2euO+pNeI6UAI+g6zyVvBjyc/tNvYutEHND2FEevE1b3LI4MCNfvdMYDZ/ljUGIy3p6hxi+y0S2VHceWJJvUYIBs+AZbGymDgZY9Qlb2kOzOo2DXc1GtJoJiLro1Ojr/wEnCHb9io36o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379802; c=relaxed/simple;
	bh=UPZ/v/zVDaKn23W0QWjzgIyPsVG8PE2v13VVOn3wiUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZepjZVQcCZeE7009jr1WGLQQfrGC58+/ss1jVR9iR+f/HiMUVOv8Ydb92mcbjs3SGUcmorBvYnhq+W590htmNrWq+8U/vLzyVCYWZLyw/WQkZ7u0zIgt3QatKbkGZr21eSiq1eq6gjmgQJ2UmkUJmL4x6V2IhxlCBUPEUIWXbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DU9CJ0ap; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54b1095625dso4408912e87.0;
        Sun, 04 May 2025 10:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746379797; x=1746984597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqaANv92m4hTYV8OL5ZcTItvvIMVs56xMsm33zu7CQg=;
        b=DU9CJ0apLB36qxn0wy6sqBdyRxhXhlGSjwjSsiRhTM4c21TF9FF6UI5uX43YTDrzi0
         MDOoPu4MpS7hqsgD808RiLVGshfTzSMY54Jf1b0TDlqG5gK2dh+Y+pWBxAQIslz6g3hM
         QvYzikunhPs1RviUpWxA4B7v6DWev/Fx4kZZ70yE10VHlzZIFGcZBcEktOew41dDj1RD
         17jZNbqrx2/nqme/icwKsmmtXMYoNc8KtmD32amWRSAM2Fnh618v4qaLKvDnZS7iD3PM
         kJzrgYF1MYqFi+OLqiE0/WhsdYxMKgLYisaUI0s/K1XgJIORKj5K9I6R1Kjv53X6lDBl
         4aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746379797; x=1746984597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqaANv92m4hTYV8OL5ZcTItvvIMVs56xMsm33zu7CQg=;
        b=hmS4Q9o2/q+FDN6bH2hCZp0ASGnguDZnUKkOZ22UBrjjak4MrxEaf6XJDTcrHM2LNb
         fCETdBfHsWXLmAWHCutF4Vb032GmfnjLnDDHDal//iOvOPqNrPAL0sP9Nb/nWvAeEpRJ
         4JIfpeuMnrC9rzkI4hJnwmKdYVUl2mjmXcAjYPlwhDxG0J6dqMoXO5LYcPXJVh1akyLr
         r2+Nw+9X564ADeZEnUVt0FWQJ9HP8RkS230lc83KB+z9lzc8pdipdQL6UYVTVwbng9Ay
         xL48ur18hVufsTOFXbLpaBAWu9OjFnJzFRzUfKJoNde8uJncIa/Mlrhx3ROSGcvc05qh
         0FRw==
X-Forwarded-Encrypted: i=1; AJvYcCU1JR0KBqrcXswUt6gVisGL2eObEb4vL5XQB6WJb81erBSmKbE6Njdd9DzcKZtUDqRtw326Kmh0CsAwhGaY6uim@vger.kernel.org, AJvYcCV1y10PMqwVaJ2OdD0y+6dtg7M39xTF1mZ1aeHZ6BaYkbqeM9iKciRAFnHHkx2P391s4DAxBcwWQ0aBxRA=@vger.kernel.org, AJvYcCVVa3ck/Q6zeY6epsMXOXhZt/7vxfv6OhawPt6YUNtY2U9NyV0VlNm3qOMR+7KL818XYJKM9unWsFWxvOKzz2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnwbg+aamOS3ADj5+7SXNh2DrORYVd4WBrqZjljBq8VmODbq/C
	lHQtRXmVSwUODoW9oCk7GNs+OWxh5q4OZ7DEH2YrBOgW2gYbokB06JVofTfiIyxT5X5yrSgB4df
	Ybg4IkihgxL+NgZVD4nr6ntqBX94=
X-Gm-Gg: ASbGnctfZkiz/MYquHvTlwNYRGng6qNyg5Oj9i9ZRit2+3Aq9onDJFUp/uQJ3mNNqQ8
	onbLM7ZdXzqJeCZB8aJLy0sz1gh01zf35lrYmrw5bj9wJoMTlAsDZStCXZzqwBlns2p9p/XbRto
	yrDFdivAhhy6uvX4yLyu2UeB3z7M7gac0R+YFDjSsDXvkRXNCjP1w6HKE=
X-Google-Smtp-Source: AGHT+IHFwQGId/qg0kBW+KYdkOs+J3tWLMwK0WAbCd1RELh3Re9uudfVzggOVnYlLipmaOIsCQoGNE89jzqxeW1+l7o=
X-Received: by 2002:a05:651c:b25:b0:30c:719:1145 with SMTP id
 38308e7fff4ca-320c44e62d7mr27278341fa.17.1746379796945; Sun, 04 May 2025
 10:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-6-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-6-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 May 2025 13:29:19 -0400
X-Gm-Features: ATxdqUHy3xw0YS_UixKAyjECkzgBxuNPadNnJTHr2K-h1SUeIdIon-i0DKnWu9Y
Message-ID: <CAJ-ks9n7u3WkYmJCVc18c_cKod6DaB7KrA7NXbOuD3E3TYbvpQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] rust: str: take advantage of the `-> Result` support
 in KUnit `#[test]`'s
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:54=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Since now we have support for returning `-> Result`s, we can convert some
> of these tests to use the feature, and serve as a first user for it too.
>
> Thus convert them.
>
> This, in turn, simplifies them a fair bit.
>
> We keep the actual assertions we want to make as explicit ones with
> `assert*!`s.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Alice pointed this out in another thread but: one of the downsides of
returning Result is that in the event of failure the line number where
the error occurred is no longer contained in the test output. I'm =F0=9F=91=
=8E
on this change for that reason.

> ---
>  rust/kernel/str.rs | 68 ++++++++++++++++++++--------------------------
>  1 file changed, 30 insertions(+), 38 deletions(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index cf2caa2db168..8dcfb11013f2 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -576,25 +576,9 @@ macro_rules! c_str {
>  mod tests {
>      use super::*;
>
> -    struct String(CString);
> -
> -    impl String {
> -        fn from_fmt(args: fmt::Arguments<'_>) -> Self {
> -            String(CString::try_from_fmt(args).unwrap())
> -        }
> -    }
> -
> -    impl Deref for String {
> -        type Target =3D str;
> -
> -        fn deref(&self) -> &str {
> -            self.0.to_str().unwrap()
> -        }
> -    }

These changes don't depend on returning `Result` from the tests
AFAICT. Can they be in a separate patch?

> -
>      macro_rules! format {
>          ($($f:tt)*) =3D> ({
> -            &*String::from_fmt(kernel::fmt!($($f)*))
> +            CString::try_from_fmt(kernel::fmt!($($f)*))?.to_str()?
>          })
>      }
>
> @@ -613,66 +597,72 @@ macro_rules! format {
>          \\xf0\\xf1\\xf2\\xf3\\xf4\\xf5\\xf6\\xf7\\xf8\\xf9\\xfa\\xfb\\xf=
c\\xfd\\xfe\\xff";
>
>      #[test]
> -    fn test_cstr_to_str() {
> +    fn test_cstr_to_str() -> Result {
>          let good_bytes =3D b"\xf0\x9f\xa6\x80\0";
> -        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes).unwra=
p();
> -        let checked_str =3D checked_cstr.to_str().unwrap();
> +        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes)?;
> +        let checked_str =3D checked_cstr.to_str()?;
>          assert_eq!(checked_str, "=F0=9F=A6=80");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_to_str_invalid_utf8() {
> +    fn test_cstr_to_str_invalid_utf8() -> Result {
>          let bad_bytes =3D b"\xc3\x28\0";
> -        let checked_cstr =3D CStr::from_bytes_with_nul(bad_bytes).unwrap=
();
> +        let checked_cstr =3D CStr::from_bytes_with_nul(bad_bytes)?;
>          assert!(checked_cstr.to_str().is_err());
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_as_str_unchecked() {
> +    fn test_cstr_as_str_unchecked() -> Result {
>          let good_bytes =3D b"\xf0\x9f\x90\xA7\0";
> -        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes).unwra=
p();
> +        let checked_cstr =3D CStr::from_bytes_with_nul(good_bytes)?;
>          // SAFETY: The contents come from a string literal which contain=
s valid UTF-8.
>          let unchecked_str =3D unsafe { checked_cstr.as_str_unchecked() }=
;
>          assert_eq!(unchecked_str, "=F0=9F=90=A7");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_display() {
> -        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
).unwrap();
> +    fn test_cstr_display() -> Result {
> +        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
)?;
>          assert_eq!(format!("{}", hello_world), "hello, world!");
> -        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0").unwrap();
> +        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0")?;
>          assert_eq!(format!("{}", non_printables), "\\x01\\x09\\x0a");
> -        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").=
unwrap();
> +        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?=
;
>          assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
> -        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0").unwrap();
> +        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0")?;
>          assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_display_all_bytes() {
> +    fn test_cstr_display_all_bytes() -> Result {
>          let mut bytes: [u8; 256] =3D [0; 256];
>          // fill `bytes` with [1..=3D255] + [0]
>          for i in u8::MIN..=3Du8::MAX {
>              bytes[i as usize] =3D i.wrapping_add(1);
>          }
> -        let cstr =3D CStr::from_bytes_with_nul(&bytes).unwrap();
> +        let cstr =3D CStr::from_bytes_with_nul(&bytes)?;
>          assert_eq!(format!("{}", cstr), ALL_ASCII_CHARS);
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_cstr_debug() {
> -        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
).unwrap();
> +    fn test_cstr_debug() -> Result {
> +        let hello_world =3D CStr::from_bytes_with_nul(b"hello, world!\0"=
)?;
>          assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
> -        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0").unwrap();
> +        let non_printables =3D CStr::from_bytes_with_nul(b"\x01\x09\x0a\=
0")?;
>          assert_eq!(format!("{:?}", non_printables), "\"\\x01\\x09\\x0a\"=
");
> -        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0").=
unwrap();
> +        let non_ascii =3D CStr::from_bytes_with_nul(b"d\xe9j\xe0 vu\0")?=
;
>          assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
> -        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0").unwrap();
> +        let good_bytes =3D CStr::from_bytes_with_nul(b"\xf0\x9f\xa6\x80\=
0")?;
>          assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\=
"");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_bstr_display() {
> +    fn test_bstr_display() -> Result {
>          let hello_world =3D BStr::from_bytes(b"hello, world!");
>          assert_eq!(format!("{}", hello_world), "hello, world!");
>          let escapes =3D BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
> @@ -683,10 +673,11 @@ fn test_bstr_display() {
>          assert_eq!(format!("{}", non_ascii), "d\\xe9j\\xe0 vu");
>          let good_bytes =3D BStr::from_bytes(b"\xf0\x9f\xa6\x80");
>          assert_eq!(format!("{}", good_bytes), "\\xf0\\x9f\\xa6\\x80");
> +        Ok(())
>      }
>
>      #[test]
> -    fn test_bstr_debug() {
> +    fn test_bstr_debug() -> Result {
>          let hello_world =3D BStr::from_bytes(b"hello, world!");
>          assert_eq!(format!("{:?}", hello_world), "\"hello, world!\"");
>          let escapes =3D BStr::from_bytes(b"_\t_\n_\r_\\_\'_\"_");
> @@ -697,6 +688,7 @@ fn test_bstr_debug() {
>          assert_eq!(format!("{:?}", non_ascii), "\"d\\xe9j\\xe0 vu\"");
>          let good_bytes =3D BStr::from_bytes(b"\xf0\x9f\xa6\x80");
>          assert_eq!(format!("{:?}", good_bytes), "\"\\xf0\\x9f\\xa6\\x80\=
"");
> +        Ok(())
>      }
>  }
>
> --
> 2.49.0
>
>

