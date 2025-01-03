Return-Path: <linux-kselftest+bounces-23873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9473A00B98
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9782D162B22
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Jan 2025 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855BF1FA8C4;
	Fri,  3 Jan 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEh1ggNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66781BD9E5;
	Fri,  3 Jan 2025 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735918783; cv=none; b=qTuQPg11gdJtJlGFC54xTGIu5LSbZExzZvFJz1MMZc1nc1LvciATLj2PnD7LH+NoHfcF+mISWYVMxFNbBAlwKg3g0V+oMLz61ZwPIkIw9UdLYO8z9KfphKTd6EPTbR05WoKW2EhoUMb+brnd40vgGyp/uIORgen8iB2N09DTwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735918783; c=relaxed/simple;
	bh=YPFsoC7Y1YJLUCneN5mcz0GFtJQ7uUeTiDyY0k4Ao4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnOf9SefS2Mc4nAaDbP+BeksOaqbQVIqkkODBK+h0cEGSx0JF4MIjmtWUUoDgfgzQ3UbMuY9ynVBmzAMEEgShbk1KLCHdgpkCuMEMDN4Y8L5EWDV8rYoshv4xtlPtvqJO2yCLECFJ8UFJSCYt9v6xp7kDTp46ZsidIfQkFLHyXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEh1ggNw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8ecb721dso2642802a91.3;
        Fri, 03 Jan 2025 07:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735918781; x=1736523581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xydfCyLys7KHCZBcmjDtmoczEh/h2QkHFtFSEukYlYA=;
        b=OEh1ggNwgHwWn6t5Ni/5tgKui+9QOqp0vGLBWsJHMxOWvmuu+a/I50ZWWvTzQQWt26
         aVUTMDCKw7CP3pbJMgoHt2l3Cn0PjfQvAVINtkCOezlNHjv6Y20gLpo/d5e3wi19Wf+z
         xDZ4YINVboFlKQuB3D+om6W8iq8ruYNL9i74dqjP69NEHvhcKauESiLlvfkNYXsRaz7b
         WpO4R0zQiZCba/iwruA3gXwSXi/sfOMgbTxcy+4sODyIOsp7Sn3p4kcEjfzTBP/vE872
         MgoU2cBheDSja1ALnrDPCTcExemvAwFXli9RnwD7s491m98VVIgFLFDseifFiZQWCfa3
         E32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735918781; x=1736523581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xydfCyLys7KHCZBcmjDtmoczEh/h2QkHFtFSEukYlYA=;
        b=gM4vFttgFI0fVSmAfbefZfLztHeNLT5nPYKJwsKG+Sn/HG9hcMiNeGUNNURjbHd/24
         EA6kr75XHxk6kbqd/6kVJ0Hf7onkRtLMe0zOk6Gt+wuESAAcS48lApS0xjizu46O5rwu
         KXkxONNcuWTcJoaFsrzJyeulf83JYLa49YSYuk2ipn23V0b0FjMHJpYNO0ZfXs1XiPDC
         FnKMi770CC26yvbEOYczWwcI+F8aWStu/NfjdESISuy4VzB4dCyEpFwTh/uETlRz+Ry0
         W2TxyARAhVgNqRZ+gNN/389EJpHOgFGpbIyeNEvdRIFHxcI2zx4mm0dfMTWgSmGuaVM/
         90Aw==
X-Forwarded-Encrypted: i=1; AJvYcCUbO8g877vRxN6uS5EDDCDn1NRKzr1AFzDvRgp3IfgotJU9aYy0rIPU6m2cVmn0iqQC5ZYv2LvCNrzXImY=@vger.kernel.org, AJvYcCW6Y1fEGIAYDexCvSw8UhKTrnOIUDuyVnagGeBsdkR8YDy9zH7tNfvNzGvBlAHV9rUxHt7JD3g9G8fCuGlJbX5m@vger.kernel.org, AJvYcCXBX5CEfqGm4FPc8GYXKhnX3myU/4hFC2l0pGUqcCfLyEEXZgr4OAHUXQLU4111L/+N4kKMtbw1Kb7phZDzmGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUxACQPZuBai0mB9+mrbv4+XAsml55Scd+ebr2yVcZhsjoQyQH
	69i8DBaF2TrpwPU7Ru9yfhnOF/RyiqAmXUwWwoNBEMGOecYaP0aNLTohMngL1dlZVc+vnzHHKpL
	ACwUwOwWJrn2cm1bvaT1cQhzXJ3k=
X-Gm-Gg: ASbGncu9I59BYw5lxJZSnVbB/36akxc339IMRCT24wvl2EhEergJygfv+YRkI5xfAYg
	N+BkCc8rJ8cm4y9UgZBeEJVJCgjewh4DAzhf55Q==
X-Google-Smtp-Source: AGHT+IG17zKiwFu2MvPaZQx2w3CPEH3CzNN+6IfJKeNeaOU3YRTgO9nQFaNzz+lLjmMDVxm6lfxpOfSTOwCvr3PWptg=
X-Received: by 2002:a17:90a:c88c:b0:2ee:948b:72d3 with SMTP id
 98e67ed59e1d1-2f452dee1f6mr28157538a91.1.1735918780954; Fri, 03 Jan 2025
 07:39:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213081035.2069066-1-davidgow@google.com> <20241213081035.2069066-2-davidgow@google.com>
In-Reply-To: <20241213081035.2069066-2-davidgow@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Jan 2025 16:39:28 +0100
Message-ID: <CANiq72mjf51e=dNzx-P1=m7Ns=7yAV5Ky6GumtRDBeoo46mLyQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] rust: kunit: add KUnit case and suite macros
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 9:10=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> +/// The test case should have the signature
> +/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)`.

I guess this is here so that people can copy-paste it (i.e. users)?
However, given it is private (i.e. users are not expected to manually
use this function) and that it is already in the signature
(`run_case`), I wonder if we need to mention it this paragraph.

Moreover, does it need to be `unsafe fn`? Safe ones coerce into unsafe
ones (i.e. not in the parameter, but in the one that the user defines)

> +/// Use `kunit_case_null` to generate such a delimeter.

Typo: delimiter

> +/// function retuns such a delimiter.

Typo: returns

> +/// Registers a KUnit test suite.
> +///
> +/// # Safety
> +///
> +/// `test_cases` must be a NULL terminated array of test cases.

I guess "test cases" here also means "valid ones", i.e. without
invalid pointers and so on inside, right? Perhaps it is good to at
least mention "valid" clearly. Otherwise, one can read it as "any
possible instance of `kunit_case`", which would be unsound, no?

We could go finer-grained, and explain exactly what needs to be valid,
which would be good.

A third alternative would be to mention that these test cases must be
created using the two functions above (`kunit_case*()`), and make the
`kunit_case()` one require a suitable `run_case` function pointer
(i.e. making it `unsafe`). That way the requirements are a bit more
localized, even if it means making that one `unsafe fn`.

> +/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit) {

Does this function need to be `unsafe`? (please see above for the
comment on the docs of `kunit_case`). If so, then we would need a `#
Safety` section if the example was built (see below).

> +/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case =3D crate::k=
unit_case(name, test_fn);

Shouldn't this `name` be a `CStr` for this example? (The example is
ignored, but it would be ideal to keep it up to date).

> +/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] =3D u=
nsafe {
> +///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
> +/// };

These should have a space after `&mut`. However, why do we need the
mutable reference here anyway? (please see discussion below and in the
next patch)

In addition, doesn't this end up with duplicated statics? i.e. one in
the array, and an independent one. So we can instead put them directly
into the array, which would avoid `unsafe` in the initializer too.
(This applies to the generation in the next patch, too).

Finally, should we make this documentation `#[doc(hidden)]` (but
keeping the docs)? i.e. it is not expected to be used by users
directly anyway (and currently the example wouldn't work, since e.g.
`kunit_case` is private).

Speaking of the example, we could fix it and make it non-`ignore`
(assuming we made `kunit_case*` public which we will probably
eventually need, in which case they should also be `#[doc(hidden)]`),
e.g.:

    /// ```
    /// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
    ///     let actual =3D 1 + 1;
    ///     let expected =3D 2;
    ///     assert_eq!(actual, expected);
    /// }
    ///
    /// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] =3D =
[
    ///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
    ///     kernel::kunit::kunit_case_null(),
    /// ];
    /// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
    /// ```

(If so, we should then use explicit names, since otherwise the KUnit
output in the log is confusing.)

> +            static KUNIT_TEST_SUITE_NAME: [i8; 256] =3D {

This should probably be `::kernel::ffi::c_char` instead (and then the
cast below needs a change too).

And I think we can make this a `const` instead, since we just use it
to initialize the array in the `static mut`, no?

> +                let name_u8 =3D core::stringify!($name).as_bytes();

Since it is a macro, I would use absolute paths, e.g. `::core::...`.

> +            static mut KUNIT_TEST_SUITE: $crate::bindings::kunit_suite =
=3D
> +                $crate::bindings::kunit_suite {
> +                    name: KUNIT_TEST_SUITE_NAME,
> +                    // SAFETY: User is expected to pass a correct `test_=
cases`, hence this macro

Nit: usually we say "by the safety preconditions" or similar, instead
of "User is expected to pass...".

> +                    // named 'unsafe'.

`unsafe`. (Also, not an English speaker, but should this be "is named" inst=
ead?)

> +                    test_cases: unsafe { $test_cases.as_mut_ptr() },

This warns due to `static_mut_refs` starting Rust 1.83:

    error: creating a mutable reference to mutable static is discouraged
    --> rust/kernel/kunit.rs:261:42
        |
    261 |                     test_cases: unsafe { $test_cases.as_mut_ptr()=
 },
        |                                          ^^^^^^^^^^^ mutable
reference to mutable static

    https://doc.rust-lang.org/nightly/edition-guide/rust-2024/static-mut-re=
ferences.html

It can still be `allow`ed; however, doesn't the call to `as_mut_ptr()`
create an intermediate mutable reference that we should avoid anyway?

Instead, can we have an array static directly, rather than a mutable
reference static to an array, and use `addr_of_mut!` here? Then we
also avoid adding the `const_mut_refs` feature (even if it is stable
now).

That is, we would have (with all the feedback in place) something like:

    static mut TEST_CASES: [kernel::bindings::kunit_case; 3] =3D [
        kernel::kunit::kunit_case(kernel::c_str!("foo"),
kunit_rust_wrapper_foo),
        kernel::kunit::kunit_case(kernel::c_str!("bar"),
kunit_rust_wrapper_bar),
        kernel::kunit::kunit_case_null(),
    ];

And then:

    test_cases: unsafe {
        ::core::ptr::addr_of_mut!($test_cases).cast::<::kernel::bindings::k=
unit_case>()
    },

So no mutable references in sight.

>  #![feature(unsize)]
> +#![feature(const_mut_refs)]

The list should be kept sorted.

However, we can avoid enabling the feature I think, if we avoid the
`&mut`s (please see above).

Cheers,
Miguel

