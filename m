Return-Path: <linux-kselftest+bounces-20949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A64039B4921
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 13:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEA91F24192
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0669205AD9;
	Tue, 29 Oct 2024 12:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dJWbfrk3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E78205AAA
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 12:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203721; cv=none; b=Nf8hPzd7T7zRojocKjszlqhXxu6PX9ju0LwXI5u9AR0KerMMZcOtobcRkYrCW/DXEFd/4CSy/nab4bVay9WbXmoJBZL+tlEftEgrLc0Wlknfn3bt6z3p4B0wLxwHqZBpoPRCrVcw4OiRH0LcjHfnp5uGL/N/ohA8lg25DqhWX/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203721; c=relaxed/simple;
	bh=Uvmac346ZWih9Wmlh71FsRI2IkLU304KRd2Cw+TuekY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbGs61gS6/BSDzQqDhb7BqDj3UhHjsJ/WmqXkXwhd3lJkSknqJdR6bfu27PoXVjavbisjAbKpgK9mIqS9Mt+/OkqnJJxM9fYTllUIBwRyDfotPOrDkDjlZM1QZKt3Gl9boekiSJX+17WKrqrbhnX07JvCvWPm8Xxqug/lU1/yTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dJWbfrk3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e3f35268so6335911e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 05:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730203717; x=1730808517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwGGH4dZC3X0uZsNpbAh1w3llTzffwb2TzON31hFyPM=;
        b=dJWbfrk3RvpBebjXiejj1tEalDxPBHMeukIQ7bnKKoXgRl5gjT3fAaa+tjug7DFbr0
         Q4izljUYZX+xaf2hKQJ+xMo+yXmUr0ICQfKrPKqYK8B9X52jjr696+aDetNYDf4rkunE
         fyCAjoE3AnKrmYsr3pFnID+D+ijWGgOlqXMkoDwMlsMgWjIa8/pV31K9jI+CclQAbf5G
         3J0jIPuuzP3on3IFzYf03x3oWgjkG5j7mhrZ9YBvdfLuIn6sbkjj7lNB4WXjy91lQPB5
         I4Y2U91HxlmlPH42E4y82EoYFB09bI/wl9XhPl/Kqq5aRTzyBc1YXZQmPFm3seqsLzn9
         XuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730203717; x=1730808517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZwGGH4dZC3X0uZsNpbAh1w3llTzffwb2TzON31hFyPM=;
        b=xIEdEil1vdK7qiZ+GY6QybuowlsQJ5NWyzHPtNEMRNNiMBkn644TTnbOdFK1PKOuKP
         RcdoxxjtLWQfTp2bGu6tYyTKjEiU/D+698D9A1urbhpBNaElHk+keDke1V4FwoJbc7j4
         9yldMf/ispF3wYPMq9GJnYVQDxJ5sDa5a0waczi6TD/uw+WyxXGzIC8nYwQ1q5bT+Gbm
         RZggzs/ZhmnMbziE/9mm5iBkTN4XvmnueDxz3oZXrbfhdZSbPDNkgstrQEUtJlykN77W
         KlyzU2zKh2py5UIhniEFwEwm4V20aPwWiqVNs7GnRYq9PXp2Q5a0hiPZvcJC1EKpsABH
         LjsA==
X-Forwarded-Encrypted: i=1; AJvYcCUdl5JYDa4oRRA5Pd9xeEot4Y14g2zHovIV+tH78cPE7fCfFUcri+KFc0jWzGtpF9yJRcyCW22ZPpULxWNVqVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1NW2KbyCgWWWrO/GBUvqh/QyCYf6gXTE09Vkwd/+D9Woy1854
	E/RQpDJ783EjuL1WNOaefXbmynZInCxGTZuRq2vOqQoVWvrcZmh95x8Bl6gl7veBNG6Wi81GoLR
	CLGJea2iYxNwXzR3DFFiNo9V1nxcNYZqjQjsN
X-Google-Smtp-Source: AGHT+IGwIQGzoduKGCdS7lX55dcklJs7IvG7qXMaZ8kzf+PodOdq4gXBxpS0K58nggoMy8D4qNp0jIm2xCFQmLJjF1U=
X-Received: by 2002:a05:6512:31c9:b0:539:e436:f1cc with SMTP id
 2adb3069b0e04-53b34a33c57mr5764330e87.52.1730203716859; Tue, 29 Oct 2024
 05:08:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com> <20241029092422.2884505-2-davidgow@google.com>
In-Reply-To: <20241029092422.2884505-2-davidgow@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 29 Oct 2024 13:08:24 +0100
Message-ID: <CAH5fLghSJtxKPZczEzc30m=LrG_BX0JkxX+0tFQLhojsOEzogg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: kunit: add KUnit case and suite macros
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 10:24=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
>
> Add a couple of Rust const functions and macros to allow to develop
> KUnit tests without relying on generated C code:
>
>  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
>    `kunit_test_suite` C macro. It requires a NULL-terminated array of
>    test cases (see below).
>  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C macro.
>    It generates as case from the name and function.
>  - The `kunit_case_null` Rust function generates a NULL test case, which
>    is to be used as delimiter in `kunit_test_suite!`.
>
> While these functions and macros can be used on their own, a future
> patch will introduce another macro to create KUnit tests using a
> user-space like syntax.
>
> Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v1:
> https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google.c=
om/
> - Rebase on top of rust-next
> - As a result, KUnit attributes are new set. These are hardcoded to the
>   defaults of "normal" speed and no module name.
> - Split the kunit_case!() macro into two const functions, kunit_case()
>   and kunit_case_null() (for the NULL terminator).
>
> ---
>  rust/kernel/kunit.rs | 108 +++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs   |   1 +
>  2 files changed, 109 insertions(+)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 824da0e9738a..fc2d259db458 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -161,3 +161,111 @@ macro_rules! kunit_assert_eq {
>          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right);
>      }};
>  }
> +
> +/// Represents an individual test case.
> +///
> +/// The test case should have the signature
> +/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)`.
> +///
> +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list =
of test cases.
> +/// Use `kunit_case_null` to generate such a delimeter.
> +const fn kunit_case(name: &kernel::str::CStr, run_case: unsafe extern "C=
" fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_case {

This should probably say `name: &'static CStr` to require that the
name lives forever.

> +/// Registers a KUnit test suite.
> +///
> +/// # Safety
> +///
> +/// `test_cases` must be a NULL terminated array of test cases.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit) {
> +///     let actual =3D 1 + 1;
> +///     let expected =3D 2;
> +///     assert_eq!(actual, expected);
> +/// }
> +///
> +/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case =3D crate::k=
unit_case(name, test_fn);
> +/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case =3D crate::k=
unit_case_null();
> +/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] =3D u=
nsafe {
> +///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
> +/// };
> +/// crate::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> +/// ```
> +#[macro_export]
> +macro_rules! kunit_unsafe_test_suite {
> +    ($name:ident, $test_cases:ident) =3D> {
> +        const _: () =3D {
> +            static KUNIT_TEST_SUITE_NAME: [i8; 256] =3D {
> +                let name_u8 =3D core::stringify!($name).as_bytes();
> +                let mut ret =3D [0; 256];
> +
> +                let mut i =3D 0;
> +                while i < name_u8.len() {
> +                    ret[i] =3D name_u8[i] as i8;
> +                    i +=3D 1;
> +                }

I assume the name must be zero-terminated? If so, you probably need to
enforce that somehow, e.g. by failing if `name_u8` is longer than 255
bytes.

> +
> +            static mut KUNIT_TEST_SUITE: core::cell::UnsafeCell<$crate::=
bindings::kunit_suite> =3D

You don't actually need UnsafeCell here since it's already `static mut`.

> +                core::cell::UnsafeCell::new($crate::bindings::kunit_suit=
e {
> +                    name: KUNIT_TEST_SUITE_NAME,
> +                    // SAFETY: User is expected to pass a correct `test_=
cases`, hence this macro
> +                    // named 'unsafe'.
> +                    test_cases: unsafe { $test_cases.as_mut_ptr() },
> +                    suite_init: None,
> +                    suite_exit: None,
> +                    init: None,
> +                    exit: None,
> +                    attr: $crate::bindings::kunit_attributes {
> +                        speed: $crate::bindings::kunit_speed_KUNIT_SPEED=
_NORMAL,
> +                    },
> +                    status_comment: [0; 256usize],
> +                    debugfs: core::ptr::null_mut(),
> +                    log: core::ptr::null_mut(),
> +                    suite_init_err: 0,
> +                    is_init: false,
> +                });
> +
> +            #[used]
> +            #[link_section =3D ".kunit_test_suites"]
> +            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings::=
kunit_suite =3D
> +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> +                unsafe { KUNIT_TEST_SUITE.get() };

If you change `KUNIT_TEST_SUITE` to not be an UnsafeCell, then you'll
want to do `core::ptr::addr_of_mut!(KUNIT_TEST_SUITE` instead.

> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b62451f64f6e..d662aa37070f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -18,6 +18,7 @@
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
>  #![feature(unsize)]
> +#![feature(const_mut_refs)]

Is this still needed with the above changes?

Alice

