Return-Path: <linux-kselftest+bounces-32284-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73CAA88A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 19:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC871899A87
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 17:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECB221730;
	Sun,  4 May 2025 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nD1e+VpE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C1A221F08;
	Sun,  4 May 2025 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380049; cv=none; b=gZMXgJpcdbd3w8ZATwhd2/7hS8oQfrHaaSUGHbkSt6Hzx54KWQXjACG0IxHZNi1KhKkTPYXcm/+1d5Ll2OVRLbyY78LN9+h5czMcRLx9UExgxveOIqQ+YXRArFrYmmV0yowm/aqIiOJrn/MRKM1opshJf3Hsmc4JleGfVGM510g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380049; c=relaxed/simple;
	bh=TI+IAdyGi+IL8Xy71Y9qCmSdPrRxiWOpnXzL5ViZOC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwEqRguAmqoKxMnxiCnrtd++X+qvdomPUVYcc7CSAZRIGT4eN/4tDfJ8IXpOGmNKkdOfxQ2v9Xn0cMDoIX93E95KvXifjBx1qq6vMWmQ4RcerGYCauIGEWsmP/ZVPQ05Qyhjc4G8tvCE6vdsQNFSbkB0XcrE2/yAUx0DvOZQ0OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nD1e+VpE; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-310447fe59aso38726441fa.0;
        Sun, 04 May 2025 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746380045; x=1746984845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1fVaVItBBDC1ZD6iIEWvvKbSsgQoZnhQOhbzKdtWXs=;
        b=nD1e+VpEZUzE0MrZm25UUIhHAJ3Ub2rtp6VxQpojZcZTpRYQTPL/EfsR6kdHEvrkcF
         dK+0iFTjxxycl7RsDjE+rM3AXdbQWfpH/MFFPPjreF6p4GAkkqB6XIJdbK9+kFNsFlAd
         1aXdf/kWLvIgHXuyDmpLyltTsa+i6X3X/rcyjzhAcTcvGTAiriRxdbqqBCspW5nIiGma
         LSXJW5w89Wd0CNGkzwG78f+BHR315h1xmcV++t/LFB311fvxKQ7x4ee7AzXseWiwG5/B
         e4b8akGl3FR7dWUxgzZdG99wQGdg19Ha34FGQA1RpjAGZwxYupfB7pxtWgEGpx6QhE43
         4oBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746380045; x=1746984845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1fVaVItBBDC1ZD6iIEWvvKbSsgQoZnhQOhbzKdtWXs=;
        b=l3CGHQCho695tad4BgJz0wiuXUI3y0HfzLHatdnLIxJtYgdQruCZTkigviP8YfZZKg
         wVUkDRPspQSEh6faQktRw33SF6ZNVrwDjmGtDsJPxa0edJuBVXCpTDuPVbJEgkjd6Pm0
         gkixm7WaBjz/2bc060wY99jNz9wN4752vEbfRx+8sEAsqSmZ0U+ESbOsGJ5d9j9PW1f0
         OUFuTYkJL25at7uya2mmH+XFMqx5DsrR+NqJCBAUQz1l9FQpwGVAr1E99f4l9NXCz1wV
         qUX9DaFXm24N/0tnllJcNKkya14BmF4imrhk4Lp5gsBsMObaCfDRIi/0E9sc6TVmYzx9
         y/GA==
X-Forwarded-Encrypted: i=1; AJvYcCUTq0Fv2mhdSod8Oy8oQPTAZhiVEDuN/rl/m8tmz3Niv1scqEUfLNZGp7zilWwAFl2at+97d7D5gnk4wdAWkEE=@vger.kernel.org, AJvYcCUZEkJCzstNF1AW+4i+nwGgH9Nf5/kyTyCmvID14gjQ2ZrNMyhQwK0Ai2F93ayIcXiPrUueyIiUrG0V83M=@vger.kernel.org, AJvYcCWxF/gPtsyW7vlkaob/6ei1WgMcqkL0o9ny/TM6ofuZmndcvxeytmy/OnQ/9iY0LdiTo0HuSWyy7c8VYKa1djh7@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPxYC27W9JhIrlNaH1L6NgGpAuel58d8A2HG6lJauy2240CZ9
	oebtaMyPLBFk3Ih0JD3PjatuUIwxrBjPyCeVEK4GdApomsYWuqoAr+yB99tEDEuvhM+xahepuWT
	Dk2TJYOfUetH3xuxTOKxf0LgQy/A=
X-Gm-Gg: ASbGnctVWi+CKw4gqp/ERal4k0NbVdNZlxg1b59nkHnwO6B1MBwLmpjNoOk3wfLN0c5
	bmvTakJ/BzluJHxVax69QgzdhA4QA7sZnLJpAPZdm4as/rxMghfe1ZtS20WzeuBgVkQnKhfQJRq
	LBHotEmUuuLXdpRtLKpe5j245uUzn5rJcFDPW24pEWugTHxeZMbkDJkRg=
X-Google-Smtp-Source: AGHT+IHjlg5r+GtZPby1N3y/lBB/JYkis+ONns+ydoYTgWyGUU7+7O4MuOnenH2xOKWDCtegS00Wd//KowDVF/l59is=
X-Received: by 2002:a2e:be1b:0:b0:308:fbd5:9d2d with SMTP id
 38308e7fff4ca-323525056damr11809611fa.37.1746380045047; Sun, 04 May 2025
 10:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-3-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-3-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 May 2025 13:33:28 -0400
X-Gm-Features: ATxdqUGeVFcwO9nOZqJQZmUYd49yvR_Ewg1ZcZNRyKblGfpu9Gz2cSxTrocB1zc
Message-ID: <CAJ-ks9=v8E_bV+oJ-bdm3KZW2dfrFdiCmeVLs+bgK8oVu6BCUA@mail.gmail.com>
Subject: Re: [PATCH 2/7] rust: kunit: support checked `-> Result`s in KUnit `#[test]`s
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

On Fri, May 2, 2025 at 5:53=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Currently, return values of KUnit `#[test]` functions are ignored.
>
> Thus introduce support for `-> Result` functions by checking their
> returned values.
>
> At the same time, require that test functions return `()` or `Result<T,
> E>`, which should avoid mistakes, especially with non-`#[must_use]`
> types. Other types can be supported in the future if needed.

Why not restrict this to Result<(), E>?

>
> With this, a failing test like:
>
>     #[test]
>     fn my_test() -> Result {
>         f()?;
>         Ok(())
>     }
>
> will output:
>
>     [    3.744214]     KTAP version 1
>     [    3.744287]     # Subtest: my_test_suite
>     [    3.744378]     # speed: normal
>     [    3.744399]     1..1
>     [    3.745817]     # my_test: ASSERTION FAILED at rust/kernel/lib.rs:=
321
>     [    3.745817]     Expected is_test_result_ok(my_test()) to be true, =
but is false

Is it possible to include the error in the output?

>     [    3.747152]     # my_test.speed: normal
>     [    3.747199]     not ok 1 my_test
>     [    3.747345] not ok 4 my_test_suite
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/kunit.rs | 25 +++++++++++++++++++++++++
>  rust/macros/kunit.rs |  3 ++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 2659895d4c5d..f43e3ed460c2 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -164,6 +164,31 @@ macro_rules! kunit_assert_eq {
>      }};
>  }
>
> +trait TestResult {
> +    fn is_test_result_ok(&self) -> bool;
> +}
> +
> +impl TestResult for () {
> +    fn is_test_result_ok(&self) -> bool {
> +        true
> +    }
> +}
> +
> +impl<T, E> TestResult for Result<T, E> {
> +    fn is_test_result_ok(&self) -> bool {
> +        self.is_ok()
> +    }
> +}
> +
> +/// Returns whether a test result is to be considered OK.
> +///
> +/// This will be `assert!`ed from the generated tests.
> +#[doc(hidden)]
> +#[expect(private_bounds)]
> +pub fn is_test_result_ok(t: impl TestResult) -> bool {
> +    t.is_test_result_ok()
> +}
> +
>  /// Represents an individual test case.
>  ///
>  /// The [`kunit_unsafe_test_suite!`] macro expects a NULL-terminated lis=
t of valid test cases.
> diff --git a/rust/macros/kunit.rs b/rust/macros/kunit.rs
> index eb4f2afdbe43..9681775d160a 100644
> --- a/rust/macros/kunit.rs
> +++ b/rust/macros/kunit.rs
> @@ -105,8 +105,9 @@ pub(crate) fn kunit_tests(attr: TokenStream, ts: Toke=
nStream) -> TokenStream {
>      let path =3D crate::helpers::file();
>      for test in &tests {
>          let kunit_wrapper_fn_name =3D format!("kunit_rust_wrapper_{}", t=
est);
> +        // An extra `use` is used here to reduce the length of the messa=
ge.
>          let kunit_wrapper =3D format!(
> -            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kun=
it) {{ {}(); }}",
> +            "unsafe extern \"C\" fn {}(_test: *mut kernel::bindings::kun=
it) {{ use kernel::kunit::is_test_result_ok; assert!(is_test_result_ok({}()=
)); }}",
>              kunit_wrapper_fn_name, test
>          );
>          writeln!(kunit_macros, "{kunit_wrapper}").unwrap();
> --
> 2.49.0
>
>

