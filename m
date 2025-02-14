Return-Path: <linux-kselftest+bounces-26657-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A351A360AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 15:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4BA53A28C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78D9266573;
	Fri, 14 Feb 2025 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWrttBuP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206E2661B9;
	Fri, 14 Feb 2025 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739544094; cv=none; b=AmmeQPwngaENtWQzSpL1MP/YyiJiPwbDSlOZbk21ygrvfPZzoH64KzTItkb1yPAUmm5Dgi/Rt7GZC6dnyVbvIN48RL9Tu+yUtp5I8Vm8flYdiEGfByv0B+DhYFaKlGUkXZQeWm/g6T2rgQf3dcR5RKw6E5ytvqyEEoYn5v5141U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739544094; c=relaxed/simple;
	bh=pyw+BJyPn139JLUocYBhLcBKS55uFur4xdWb9MEQN8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1xh7pJOhcJ7tYXDTZ1X1KzYJVKRVlh6pIj6NkZeZ6eIoxws1zQBxhkVMExePkCqXj6ltaiU6jFGijfvAQGANklxtxWv1OAJbPkl03MxagvjsY0D1U5KrOGBVw+X1zkg/3WA7iahLPUu/bJX2WT4kV7rS5cxuPfbr5Y7IQMzhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FWrttBuP; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-307c13298eeso20828961fa.0;
        Fri, 14 Feb 2025 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739544091; x=1740148891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oe9/eEqMmqvNor8cwQSKhskL7gHhmbo4tvwhBhdYuso=;
        b=FWrttBuPyP8msFQhheXvnBAwwI43oAWBaT5ssgPiAw+Ktwaxl+eu4o2weg8AGPg4Dt
         T0Io64eChE8Ds4ZAwA58g5fKk1Ax+7CoFeG2ZUTFNpvsWCOdPfRbMSx8HOwb0UfYWo8G
         kHP6XPvnftZlKpHOFrqrNovFlcZY22wfhNye4nv3l3WUYT9iV93rvhe83HzeHq06hB01
         hCUlIqY5hHmELjgZGyXSqC27ziutv8hELUWfLHvGE+KsonngT9aOD5C5LuiftvgB4jtt
         IkT7hmqntyt5vZyF1lBvu9pd4QvhM+SBlTTgPdsu4sfVge458+F4hHQ+cRyWULlF9q2O
         WENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739544091; x=1740148891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oe9/eEqMmqvNor8cwQSKhskL7gHhmbo4tvwhBhdYuso=;
        b=QnPRuDzuK43espfOswxL0lU40gwyUaKykSfCnQDYTmLcGZ2qGZaFrK/seAVMOdprTx
         fHBs8UqgBPOK6kejphRjMDpdMgxN5J4vPBxTnMOGWpReLIf2KgSExqwdyzAz2jcIktQL
         0QBflD3ugvNbUIbuqcIGkITOLVe4eOczHAIlof4T2xHZlT0a+dubuaKLchNxJwHz+i8J
         3hs1/qyt3kqAJK2dKKulbtGPi1SHy6/nmEEAe32/Jwl60mg3/pr6Y9gWTMYhQ7WCoI6E
         awrQnQEPFHpRs2DMOB1CgCUZhAZb4ow/+Y9+O4lGtK5GvpTkmSZTQhNd5D6vVrDmzYVa
         3gpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOZC3KIkIxVq+QUxRYPYwxbG8oEvJIPpjIDO05VUiAoaAAIPtgZir9plKrp6aN3KL4sYoASqCOgtAsYJWS3u0Q@vger.kernel.org, AJvYcCVmLv6BC0PEXANJ0fc4LPqNXQRIvehwK41I2FVYkW4ajz+yRkJn0alC3NQuGIOqyD6uxyI31lkxq3QXzrQ=@vger.kernel.org, AJvYcCXiTij1ywVEeplfEOj83LipcrTVXCzGctEiC35f3WERk+gJjwHOp+vJOEjNfWZLLyFEDMcWYiwOA883yRvPPo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrTLjKL+IRCLgeKF9GgufEmGIBCA7Wzkb64ve4rqd2taCyFDdM
	wgVr4HRiwRrb5wo82e3bLIWgsQDu0yd4x4CLBDelaSco3GKOkWquRMWor1kO3XRhsAbYIoid0T2
	l7IyMoxNOCaEUY/8OpmJnTtEFwV8=
X-Gm-Gg: ASbGnctbPKIS3wVaAAOjtSA9ulT8XeVljRKGou/sTPSIGFLQ88CUIKBbQS/AyyRsAf6
	we6aygm7QtNtFmu0vQwH1cX8an79KcbubEGrnjCjni+NYVT9+Xa+MsihEmT2A1KWI07dLjoNJlE
	hyZxDXztyiqTk2ZCri4vSdn4WluBgCzec=
X-Google-Smtp-Source: AGHT+IEHP1/ou32oGaJo+ui+Aoc0iAWhMsZ+zjW+y2I1QHaXj2d7iOxXdc2cExE7NP4Px14pEOsLVfeB6zsuqBbtkuw=
X-Received: by 2002:a2e:9648:0:b0:308:eb31:df9c with SMTP id
 38308e7fff4ca-3090f11c8e5mr21047021fa.1.1739544090444; Fri, 14 Feb 2025
 06:41:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-2-davidgow@google.com>
In-Reply-To: <20250214074051.1619256-2-davidgow@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 09:40:54 -0500
X-Gm-Features: AWEUYZn94LVObzk-67NyV5Edu12iMHyaHU-UZd5O3IiVN77rUgILpWhQIsbqA9g
Message-ID: <CAJ-ks9kw7FTJ7EcHy8B+-1XFK8J4a-DuHLJhP1f3hPy10nOJZA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] rust: kunit: add KUnit case and suite macros
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

Very excited to see this progress.

On Fri, Feb 14, 2025 at 2:41=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
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
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> Changes since v5:
> https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@google.com/
> - Rebased against 6.14-rc1
> - Several documentation touch-ups, including noting that the example
>   test function need not be unsafe. (Thanks, Miguel)
> - Remove the need for static_mut_refs, by using core::addr_of_mut!()
>   combined with a cast. (Thanks, Miguel)
>   - While this should also avoid the need for const_mut_refs, it seems
>     to have been enabled for other users anyway.
> - Use ::kernel::ffi::c_char for C strings, rather than i8 directly.
>   (Thanks, Miguel)
>
> Changes since v4:
> https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-davidgow=
@google.com/
> - Rebased against 6.13-rc1
> - Allowed an unused_unsafe warning after the behaviour of addr_of_mut!()
>   changed in Rust 1.82. (Thanks Boqun, Miguel)
> - Fix a couple of minor rustfmt issues which were triggering checkpatch
>   warnings.
>
> Changes since v3:
> https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-davidgow=
@google.com/
> - The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
>   too long, triggering a compile error. (Thanks, Alice!)
>
> Changes since v2:
> https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davidgow=
@google.com/
> - The kunit_unsafe_test_suite!() macro will truncate the name of the
>   suite if it is too long. (Thanks Alice!)
> - We no longer needlessly use UnsafeCell<> in
>   kunit_unsafe_test_suite!(). (Thanks Alice!)
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
>  rust/kernel/kunit.rs | 121 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index 824da0e9738a..d34a92075174 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -161,3 +161,124 @@ macro_rules! kunit_assert_eq {
>          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right);
>      }};
>  }
> +
> +/// Represents an individual test case.
> +///
> +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list =
of valid test cases.
> +/// Use `kunit_case_null` to generate such a delimiter.

Can both of these be linkified? [`kunit_unsafe_test_suite!`] and
[`kunit_case_null`]. There are more instances below.

> +#[doc(hidden)]
> +pub const fn kunit_case(
> +    name: &'static kernel::str::CStr,
> +    run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
> +) -> kernel::bindings::kunit_case {
> +    kernel::bindings::kunit_case {
> +        run_case: Some(run_case),
> +        name: name.as_char_ptr(),
> +        attr: kernel::bindings::kunit_attributes {
> +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> +        },
> +        generate_params: None,
> +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> +        module_name: core::ptr::null_mut(),
> +        log: core::ptr::null_mut(),

These members, after `name`, can be spelled `..kunit_case_null()` to
avoid some repetition.

> +    }
> +}
> +
> +/// Represents the NULL test case delimiter.
> +///
> +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated list =
of test cases. This
> +/// function returns such a delimiter.
> +#[doc(hidden)]
> +pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
> +    kernel::bindings::kunit_case {
> +        run_case: None,
> +        name: core::ptr::null_mut(),
> +        generate_params: None,
> +        attr: kernel::bindings::kunit_attributes {
> +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> +        },
> +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> +        module_name: core::ptr::null_mut(),
> +        log: core::ptr::null_mut(),
> +    }
> +}
> +
> +/// Registers a KUnit test suite.
> +///
> +/// # Safety
> +///
> +/// `test_cases` must be a NULL terminated array of valid test cases.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
> +///     let actual =3D 1 + 1;
> +///     let expected =3D 2;
> +///     assert_eq!(actual, expected);
> +/// }
> +///
> +/// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] =3D [
> +///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
> +///     kernel::kunit::kunit_case_null(),
> +/// ];
> +/// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> +/// ```
> +#[doc(hidden)]
> +#[macro_export]
> +macro_rules! kunit_unsafe_test_suite {
> +    ($name:ident, $test_cases:ident) =3D> {
> +        const _: () =3D {
> +            const KUNIT_TEST_SUITE_NAME: [::kernel::ffi::c_char; 256] =
=3D {
> +                let name_u8 =3D ::core::stringify!($name).as_bytes();

This can be a little simpler:

let name =3D $crate::c_str!(::core::stringify!($name)).as_bytes_with_nul();

> +                let mut ret =3D [0; 256];
> +
> +                if name_u8.len() > 255 {
> +                    panic!(concat!(
> +                        "The test suite name `",
> +                        ::core::stringify!($name),
> +                        "` exceeds the maximum length of 255 bytes."
> +                    ));
> +                }
> +
> +                let mut i =3D 0;
> +                while i < name_u8.len() {
> +                    ret[i] =3D name_u8[i] as ::kernel::ffi::c_char;
> +                    i +=3D 1;
> +                }

I'd suggest `ret[..name.len()].copy_from_slice(name)` but
`copy_from_slice` isn't `const`. This can stay the same with the
now-unnecessary cast removed, or it can be the body of
`copy_from_slice`:

                // SAFETY: `name` is valid for `name.len()` elements
by definition, and `ret` was
                // checked to be at least as large as `name`. The
buffers are statically know to not
                // overlap.
                unsafe {
                    ::core::ptr::copy_nonoverlapping(name.as_ptr(),
ret.as_mut_ptr(), name.len());

                }

> +
> +                ret
> +            };
> +
> +            #[allow(unused_unsafe)]
> +            static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_suite=
 =3D
> +                ::kernel::bindings::kunit_suite {
> +                    name: KUNIT_TEST_SUITE_NAME,
> +                    // SAFETY: User is expected to pass a correct `test_=
cases`, given the safety
> +                    // precondition; hence this macro named `unsafe`.
> +                    test_cases: unsafe {
> +                        ::core::ptr::addr_of_mut!($test_cases)
> +                            .cast::<::kernel::bindings::kunit_case>()
> +                    },

This safety comment seems to be referring to the safety of
`addr_of_mut!` but this was just a compiler limitation until Rust
1.82, right? Same thing below on `KUNIT_TEST_SUITE_ENTRY`.

Can we also narrow the `#[allow]`? This seems to work:

                    #[allow(unused_unsafe)]
                    // SAFETY: ...
                    test_cases: unsafe {
                        ::core::ptr::addr_of_mut!($test_cases)
                            .cast::<::kernel::bindings::kunit_case>()
                    },

> +                    suite_init: None,
> +                    suite_exit: None,
> +                    init: None,
> +                    exit: None,
> +                    attr: ::kernel::bindings::kunit_attributes {
> +                        speed: ::kernel::bindings::kunit_speed_KUNIT_SPE=
ED_NORMAL,
> +                    },
> +                    status_comment: [0; 256usize],

I don't think you need the usize hint here, there's always a usize in
the length position.

> +                    debugfs: ::core::ptr::null_mut(),
> +                    log: ::core::ptr::null_mut(),
> +                    suite_init_err: 0,
> +                    is_init: false,
> +                };
> +
> +            #[used]
> +            #[link_section =3D ".kunit_test_suites"]

This attribute causes the same problem I describe in
https://lore.kernel.org/all/20250210-macros-section-v2-1-3bb9ff44b969@gmail=
.com/.
That's because the KUnit tests are generated both on target and on
host (even though they won't run on host). I don't think you need to
deal with that here, just pointing it out. I think we'll need a cfg to
indicate we're building for host to avoid emitting these attributes
that only make sense in the kernel.

> +            static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindings=
::kunit_suite =3D
> +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> +                unsafe { ::core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };

This is missing the `#[allow(unused_unsafe)]` (it appears in the next
patch). This means this commit will not compile on bisection.

> +        };
> +    };
> +}
> --
> 2.48.1.601.g30ceb7b040-goog
>
>

Global note: it seems more customary to use crate:: and $crate::
instead of kernel:: and ::kernel in functions and macros,
respectively.

Cheers.




Tamir

