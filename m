Return-Path: <linux-kselftest+bounces-26709-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5FAA36CB8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 10:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEA11891951
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F15D19E965;
	Sat, 15 Feb 2025 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdB2ebeU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8136199FB2
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610233; cv=none; b=i1VI/oebqFSLNAQhGK7jaF7Ef8kt4lbCILtudxI5+tu5q91EyxXGXsSPIHBEQ5iYadlNjYH1+QY4xbd53egTdPfJcQdlLh++3NWrgsDkM2MVg3t6G28ZnFtQF7KgGxhSSQrtAZtWngpP92VHVEvXnfC8MKeHPWNI34Gn98+SGYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610233; c=relaxed/simple;
	bh=wu4hAISnyt3ZF493xbmjLqZ2KnqJoV8uJ0ii26KSl70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+pnyz/0Qpicx74+lKRo2qrqeX3X62ZEmpcoZL70Da3fL4i/IhjkA/KFySUxTTXMGEbK0bUOcLJ2WoOYQzVO6rmXx/6fMWy1A54x/7JOAiNPds0LJ5fufPZwnh9G6j15+fVVoz8hjSQEcK48Qsoa0qdki8yt7VfK6tP2D/CZWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdB2ebeU; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0848d475cso178576485a.2
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 01:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610228; x=1740215028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtlYOxDF+gRaZupPu7vd9kCV4mp2BnY+eP8X4ysEQZA=;
        b=QdB2ebeUlDlrANCWnxY21GQRSalSkGUFyikJM6c2hBBqm7mSZIvxBHGZRfB1tyOSmZ
         40zjUgcEA2wEq/Ut/a46VNN92hlsrypZ7gyhiLJCvgUHhQHXLhEHZ1NgJMPh/XXwjQf3
         cabSZInJ9uHF/KGz8OBnn6E/X/a0Q0LRfEmlHUPSh2n185q1OE8Krf8avSVKZTEPf/cb
         nohOdIVDs/k/EZNKCidbyqOjTVUTKUFAMCl+gvE8SvGeK7BFjBOmepO9dswOuvI6aSI2
         Vj9xQTI5DLZAQ9qW+E+yMQedTq+OpYalXkqRn5dRu1m//VMa2Q+KZcSuvTVBoCqVWwcI
         GEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610228; x=1740215028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtlYOxDF+gRaZupPu7vd9kCV4mp2BnY+eP8X4ysEQZA=;
        b=rj5CGudmlRfDZgjshy4MHFHL+WqD7VdhL418WVazj3Me0Ohsa4VFEwXSP7LJwREabm
         +24fZSyjf51Irg26vqS2jzQiBPGfotCsGCJlCujyjHFtWnB2ylCI85hO8lbUPIdeNXiK
         ycLv92fZA1mc5TEHm6am+M4EBR9T5EdxFdkzxbARDFfGqcgmdn4XrOBRlwttAC9xqChn
         28CskXbAGKZ44ntSdLow60e7JGUUMV6cDQqkyWtpEyCLxMEP3KlqPjTH87L9kXrFYXqg
         fHh8qeNkPxWnA4obkNI0OGgDsfT3gFR+viEoQz7rWVw+fdBp87yV4OfB5Ciyyx1YXpaq
         nLRA==
X-Forwarded-Encrypted: i=1; AJvYcCWKDOqarDUuAZxKVfbjHO89b2B1F/K7r5DGQdoJRp778Bd12T3d/ZdZJ8ZCcCMOfgAHezT6nQTVVIXpOCqB5Nk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEnqsKWijpcq1I4V8br5L0ZcTIdC1aMDYtYXhripLx6/jWd4Pc
	3Nqeynv4TUlh0nQ8Nb1Ydn9/AWGuHl5uEf1IPW0J583scIP59r345RuvezwQ1lrEaOoTw/K9Nhv
	+sTTJH4SASgHCdrCG8eXyXrwC1fp4XhyRJEr//wFwM50Vx6A8EQ==
X-Gm-Gg: ASbGnctwMmQbDgifpCzmLLiAtuJNMB3kEgGa4K5+o2XQkq3uNlAQAuWcXoexfqU8LUJ
	U8F9hx65gVhLFhrPVuWZkLvEbQBDlJDQppdQSqCXBmCz9Pl7TKfu312Cmzz3urhbR2Q0jFdhVqw
	==
X-Google-Smtp-Source: AGHT+IFKE8ChB6L6v2E7rlYezqpL4fBITRyytBoBopI+mnrVuaDiveYPAedrHlDmf4D8hgnUGynWPpYmiSdht4hMc1U=
X-Received: by 2002:a05:620a:2a0f:b0:7c0:6976:cea3 with SMTP id
 af79cd13be357-7c08a9aa3f3mr343397885a.21.1739610228334; Sat, 15 Feb 2025
 01:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-2-davidgow@google.com>
 <CAJ-ks9kw7FTJ7EcHy8B+-1XFK8J4a-DuHLJhP1f3hPy10nOJZA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kw7FTJ7EcHy8B+-1XFK8J4a-DuHLJhP1f3hPy10nOJZA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 15 Feb 2025 17:03:35 +0800
X-Gm-Features: AWEUYZkwKV0uaJ87p6zHz7asDwjlvsovNn_fNIgXFJZuvFFfT4i4ftWrGAEmr8w
Message-ID: <CABVgOSkcDPwWEz=Uo0q+HXSeQT4a5yPg8vb4BMkpZ0yyDu4wQA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] rust: kunit: add KUnit case and suite macros
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Rae Moar <rmoar@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000be59b6062e2a9192"

--000000000000be59b6062e2a9192
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 22:41, Tamir Duberstein <tamird@gmail.com> wrote:
>
> Very excited to see this progress.
>
> On Fri, Feb 14, 2025 at 2:41=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> >
> > Add a couple of Rust const functions and macros to allow to develop
> > KUnit tests without relying on generated C code:
> >
> >  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
> >    `kunit_test_suite` C macro. It requires a NULL-terminated array of
> >    test cases (see below).
> >  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C macr=
o.
> >    It generates as case from the name and function.
> >  - The `kunit_case_null` Rust function generates a NULL test case, whic=
h
> >    is to be used as delimiter in `kunit_test_suite!`.
> >
> > While these functions and macros can be used on their own, a future
> > patch will introduce another macro to create KUnit tests using a
> > user-space like syntax.
> >
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > Co-developed-by: David Gow <davidgow@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
> >
> > Changes since v5:
> > https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@google.co=
m/
> > - Rebased against 6.14-rc1
> > - Several documentation touch-ups, including noting that the example
> >   test function need not be unsafe. (Thanks, Miguel)
> > - Remove the need for static_mut_refs, by using core::addr_of_mut!()
> >   combined with a cast. (Thanks, Miguel)
> >   - While this should also avoid the need for const_mut_refs, it seems
> >     to have been enabled for other users anyway.
> > - Use ::kernel::ffi::c_char for C strings, rather than i8 directly.
> >   (Thanks, Miguel)
> >
> > Changes since v4:
> > https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-davidg=
ow@google.com/
> > - Rebased against 6.13-rc1
> > - Allowed an unused_unsafe warning after the behaviour of addr_of_mut!(=
)
> >   changed in Rust 1.82. (Thanks Boqun, Miguel)
> > - Fix a couple of minor rustfmt issues which were triggering checkpatch
> >   warnings.
> >
> > Changes since v3:
> > https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-davidg=
ow@google.com/
> > - The kunit_unsafe_test_suite!() macro now panic!s if the suite name is
> >   too long, triggering a compile error. (Thanks, Alice!)
> >
> > Changes since v2:
> > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davidg=
ow@google.com/
> > - The kunit_unsafe_test_suite!() macro will truncate the name of the
> >   suite if it is too long. (Thanks Alice!)
> > - We no longer needlessly use UnsafeCell<> in
> >   kunit_unsafe_test_suite!(). (Thanks Alice!)
> >
> > Changes since v1:
> > https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@google=
.com/
> > - Rebase on top of rust-next
> > - As a result, KUnit attributes are new set. These are hardcoded to the
> >   defaults of "normal" speed and no module name.
> > - Split the kunit_case!() macro into two const functions, kunit_case()
> >   and kunit_case_null() (for the NULL terminator).
> >
> > ---
> >  rust/kernel/kunit.rs | 121 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >
> > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > index 824da0e9738a..d34a92075174 100644
> > --- a/rust/kernel/kunit.rs
> > +++ b/rust/kernel/kunit.rs
> > @@ -161,3 +161,124 @@ macro_rules! kunit_assert_eq {
> >          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right=
);
> >      }};
> >  }
> > +
> > +/// Represents an individual test case.
> > +///
> > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated lis=
t of valid test cases.
> > +/// Use `kunit_case_null` to generate such a delimiter.
>
> Can both of these be linkified? [`kunit_unsafe_test_suite!`] and
> [`kunit_case_null`]. There are more instances below.
>

I've done this here. I've not linkified absolutely everything, but the
most obvious/prominent ones should be done.

> > +#[doc(hidden)]
> > +pub const fn kunit_case(
> > +    name: &'static kernel::str::CStr,
> > +    run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
> > +) -> kernel::bindings::kunit_case {
> > +    kernel::bindings::kunit_case {
> > +        run_case: Some(run_case),
> > +        name: name.as_char_ptr(),
> > +        attr: kernel::bindings::kunit_attributes {
> > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> > +        },
> > +        generate_params: None,
> > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > +        module_name: core::ptr::null_mut(),
> > +        log: core::ptr::null_mut(),
>
> These members, after `name`, can be spelled `..kunit_case_null()` to
> avoid some repetition.

I'm going to leave this as-is, as logically, the NULL terminator case
and the 'default' case are two different things (even if, in practice,
they have the same values). And personally, I find it clearer to have
them more explicitly set here for now.

It is a nice thought, though, so I reserve the right to change my mind
in the future. :-)

> > +    }
> > +}
> > +
> > +/// Represents the NULL test case delimiter.
> > +///
> > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated lis=
t of test cases. This
> > +/// function returns such a delimiter.
> > +#[doc(hidden)]
> > +pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
> > +    kernel::bindings::kunit_case {
> > +        run_case: None,
> > +        name: core::ptr::null_mut(),
> > +        generate_params: None,
> > +        attr: kernel::bindings::kunit_attributes {
> > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> > +        },
> > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > +        module_name: core::ptr::null_mut(),
> > +        log: core::ptr::null_mut(),
> > +    }
> > +}
> > +
> > +/// Registers a KUnit test suite.
> > +///
> > +/// # Safety
> > +///
> > +/// `test_cases` must be a NULL terminated array of valid test cases.
> > +///
> > +/// # Examples
> > +///
> > +/// ```ignore
> > +/// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
> > +///     let actual =3D 1 + 1;
> > +///     let expected =3D 2;
> > +///     assert_eq!(actual, expected);
> > +/// }
> > +///
> > +/// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] =3D=
 [
> > +///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
> > +///     kernel::kunit::kunit_case_null(),
> > +/// ];
> > +/// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> > +/// ```
> > +#[doc(hidden)]
> > +#[macro_export]
> > +macro_rules! kunit_unsafe_test_suite {
> > +    ($name:ident, $test_cases:ident) =3D> {
> > +        const _: () =3D {
> > +            const KUNIT_TEST_SUITE_NAME: [::kernel::ffi::c_char; 256] =
=3D {
> > +                let name_u8 =3D ::core::stringify!($name).as_bytes();
>
> This can be a little simpler:
>
> let name =3D $crate::c_str!(::core::stringify!($name)).as_bytes_with_nul(=
);
>

I'm not sure this ends up being much simpler: it makes it (possible?,
obvious?) to get rid of the cast below, but we don't actually need to
copy the null byte at the end, so it seems wasteful to bother.

So after playing around both ways, I think this is probably best.

> > +                let mut ret =3D [0; 256];
> > +
> > +                if name_u8.len() > 255 {
> > +                    panic!(concat!(
> > +                        "The test suite name `",
> > +                        ::core::stringify!($name),
> > +                        "` exceeds the maximum length of 255 bytes."
> > +                    ));
> > +                }
> > +
> > +                let mut i =3D 0;
> > +                while i < name_u8.len() {
> > +                    ret[i] =3D name_u8[i] as ::kernel::ffi::c_char;
> > +                    i +=3D 1;
> > +                }
>
> I'd suggest `ret[..name.len()].copy_from_slice(name)` but
> `copy_from_slice` isn't `const`. This can stay the same with the
> now-unnecessary cast removed, or it can be the body of
> `copy_from_slice`:
>
>                 // SAFETY: `name` is valid for `name.len()` elements
> by definition, and `ret` was
>                 // checked to be at least as large as `name`. The
> buffers are statically know to not
>                 // overlap.
>                 unsafe {
>                     ::core::ptr::copy_nonoverlapping(name.as_ptr(),
> ret.as_mut_ptr(), name.len());
>
>                 }
>

I think I'll keep this as the loop for now, as that's more obvious to
me, and avoids the extra unsafe block.

If copy_from_slice ends up working in a const context, we can consider
that later (though, personally, I still find the loop easier to
understand).

> > +
> > +                ret
> > +            };
> > +
> > +            #[allow(unused_unsafe)]
> > +            static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_sui=
te =3D
> > +                ::kernel::bindings::kunit_suite {
> > +                    name: KUNIT_TEST_SUITE_NAME,
> > +                    // SAFETY: User is expected to pass a correct `tes=
t_cases`, given the safety
> > +                    // precondition; hence this macro named `unsafe`.
> > +                    test_cases: unsafe {
> > +                        ::core::ptr::addr_of_mut!($test_cases)
> > +                            .cast::<::kernel::bindings::kunit_case>()
> > +                    },
>
> This safety comment seems to be referring to the safety of
> `addr_of_mut!` but this was just a compiler limitation until Rust
> 1.82, right? Same thing below on `KUNIT_TEST_SUITE_ENTRY`.
>

Yeah, this comment was originally written prior to 1.82 existing.

But I think we probably should keep the safety comment here anyway, as
-- if I understand it -- 1.82 only makes this safe if $test_cases is
static, so it's still worth documenting the preconditions here.

If we eventually stop supporting rust < 1.82, though, I'd be happy to
remove the unsafe and thereby enforce the use of this macro only on
statics at compile time.

> Can we also narrow the `#[allow]`? This seems to work:
>
>                     #[allow(unused_unsafe)]
>                     // SAFETY: ...
>                     test_cases: unsafe {
>                         ::core::ptr::addr_of_mut!($test_cases)
>                             .cast::<::kernel::bindings::kunit_case>()
>                     },
>

We hit problems before with #[allow] not working on expressions, so
assumed we couldn't narrow it further. Seems to be working here,
though, so I've changed it.

> > +                    suite_init: None,
> > +                    suite_exit: None,
> > +                    init: None,
> > +                    exit: None,
> > +                    attr: ::kernel::bindings::kunit_attributes {
> > +                        speed: ::kernel::bindings::kunit_speed_KUNIT_S=
PEED_NORMAL,
> > +                    },
> > +                    status_comment: [0; 256usize],
>
> I don't think you need the usize hint here, there's always a usize in
> the length position.
>
> > +                    debugfs: ::core::ptr::null_mut(),
> > +                    log: ::core::ptr::null_mut(),
> > +                    suite_init_err: 0,
> > +                    is_init: false,
> > +                };
> > +
> > +            #[used]
> > +            #[link_section =3D ".kunit_test_suites"]
>
> This attribute causes the same problem I describe in
> https://lore.kernel.org/all/20250210-macros-section-v2-1-3bb9ff44b969@gma=
il.com/.
> That's because the KUnit tests are generated both on target and on
> host (even though they won't run on host). I don't think you need to
> deal with that here, just pointing it out. I think we'll need a cfg to
> indicate we're building for host to avoid emitting these attributes
> that only make sense in the kernel.
>

I've added the same exclusion for macos here, but don't have a macos
machine to test it on. If it's broken, we can fix it in a follow-up.

> > +            static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bindin=
gs::kunit_suite =3D
> > +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> > +                unsafe { ::core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) }=
;
>
> This is missing the `#[allow(unused_unsafe)]` (it appears in the next
> patch). This means this commit will not compile on bisection.

Whoops. This must have snuck in during one of the many squashes and
rebases. I'll fix that now.

Annoyingly, I'm no longer able to actually reproduce the warning,
which is strange.
>
> > +        };
> > +    };
> > +}
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
> >
>
> Global note: it seems more customary to use crate:: and $crate::
> instead of kernel:: and ::kernel in functions and macros,
> respectively.

Hmm... I think I had that at one point and was told to change it to
kernel. Personally, I think kernel:: makes more sense. So if it's not
breaking anything, and I'll only get yelled at a little bit, let's
keep it as is.

In any case, I'm sending out v7 with the changes above. My hope is
that this is then probably "good enough" to let us get started, and
future changes can be done as independent patches, so we're both not
holding this up for too long, and can better parallelise any fixes,
rather than having to re-spin the whole series each time.

Thanks a lot,
-- David

--000000000000be59b6062e2a9192
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
YE9NAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFHgsCGkO2Hex
N6ybc+GeQEb6790qMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQAs
exV05yVDmPhHRqOq9lAbfWOUvEf8zydxabZUHna6bayb83jD2eb9nMGGEprfuNBRmFg35sgF1TyN
+ieuQakvQYmY8tzK49hhHa2Y3qhGCTqYTHO3ypHvhHsZiGbL0gmdgB9P8ssVIws//34ae99GUOxo
XKTxPwwsQ5Arq42besv3/HXAW+4nRAT8d3ht5ZWCHc5rjL/vdGzu7PaYo3u0da69AZ8Sh4Gf5yoc
QANr2ZkMrxXbLmSmnRvbkQrzlZp2YbTFnczx46429D6q75/FNFOL1vAjxtRAPzkyACvW0eKvchza
TMvvD3IWERLlcBL5yXpENc3rI8/wVjqgAWYxlFg1b/4b/TCgYe2MZC0rx4Uh3zTIbmPNiHdN6QZ9
oDiYzWUcqWZ5jCO4bMKNlVJXeCvdANLHuhcC8FONj5VzNgYXs6gWkp9/Wt6XnQPX4dF4JBa8JdL/
cT46RJIzoiJHEx/8syO5FparZHIKbkunoq6niPsRaQUGeqWc56H4Z1sQXuBJN9fhqkIkG0Ywfrwt
uFrCoYIRlx4rSVHpBIKgnsgdm0SFQK72MPmIkfhfq9Fh0h8AjhF73sLO7K5BfwWkx1gwMySyNY0e
PCRYr6WEVOkUJS0a0fui693ymMPFLQAimmz8EpyFok4Ju066StkYO1dIgUIla4x61auxkWHwnzGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQglNpv5GoBjdyWkHE5NJFP3aQbFM/9
LmylwH383rVWLlwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjE1MDkwMzQ4WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAHYI/5AaFauQi4kAlGwexEznZ/HyQ3+dusVC+AfTZW5mXwvP
1VpjX/mMakEYBWnvL2wf8bdZl0OhuT9DO9AA8m5+ugpOawfxP/k/gTRweALupNuGGXWnhpqf86Ks
PYQ1A6tVC1tWcTMB4WhVV0fILKdcrkMC6bM2jWh6eeBN834i4vhUtiWlaXtAdkWtrdEXc40IZhvp
3tjLiqaaz/DTdXn9CsUqPPVkZf2tiRstIkbGT/18B7UqWOGmLEbSJsAca+jxYOgFkSelplp+NZe+
b4dj+dQ57cKkSLmm/UR7KgJ1gGFFHNdpAUIZCfhk8cSpfMJpQB/kC/1kLYxdPEjykvQ=
--000000000000be59b6062e2a9192--

