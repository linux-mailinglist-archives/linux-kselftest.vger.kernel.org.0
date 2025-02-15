Return-Path: <linux-kselftest+bounces-26716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C59EDA36E4C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 14:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134743A8405
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D231A2545;
	Sat, 15 Feb 2025 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B72rRaci"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A34623;
	Sat, 15 Feb 2025 13:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739624517; cv=none; b=gRnjCKMtAS5dtsw3taFkwId++FsTqt6rEPKYVi32cKCSXTQg9JStJwfMgFGgKYRwSFXC4VdtYdCZPf7o+QrbTMokTP0Ot6TZPCj9XOSaYUmQzKjIxjah3yUPYVQ0NE/k3KmjPPjQx6jq1QUIS+FD1LsRICI31yZ7Tx3KxCnHYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739624517; c=relaxed/simple;
	bh=yLJ2xFGq8f/gfg6NkwwjwmCBmrRbjJ1xnr113KsNsVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ei4jOWvrcfpfafz2ftJGMoHQI14TlKWbvvuQPze820uN/2NqmIMNfNtB2Xa0vNMaH7vLdciKCmpmzUShWP407X2sCv99VGuk/0jttiLBU8TgFNxSjp6IGS1cYbIWaS3zz4MvMzCCbpiW5he3d1XzeLqU9TrSNTOet/6qG0FwtmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B72rRaci; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5439a6179a7so3026754e87.1;
        Sat, 15 Feb 2025 05:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739624513; x=1740229313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozhKsWX3kweoYJQju1+qqAjGdDcPiipwU+Xczk1SZZE=;
        b=B72rRaci3TSIXrEGsC/e2fPBWJZxurhUhE8V3P4F9f3aQQdbMR2yg/f8oA403SUSfN
         pMSoM+Z51DzEsGvVZnm/u/ZiRySJBsDEi9Q2GFqnacTCJRxQMRiKHyqQobDiiI/q0OgE
         o393fHTo0fh5tbIoX7O+WluCm62tcXPtmoz976lPu60D/Gge+sLxjghhoS4fF4gFr0Ky
         wJU0oOZmzHhPRoNeBflWLMF/5icfMp8mF8t9VYl6LEatFhlHt8gGdV4WDAR+/GErt+SG
         SI2nMeIOnu6702fpjHm+DuKhyFTFM8GLsazIoTTwqwIHGVA6KjWGMkxHO3XU7WwTflJ4
         X8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739624513; x=1740229313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozhKsWX3kweoYJQju1+qqAjGdDcPiipwU+Xczk1SZZE=;
        b=WKIHVHpTKRbCqmZN4tqAEHATQqsUhDJdbD8Pazb8AVPBQ3yWXpHJJG6jE8gPntspql
         SfGB+MvA6CwKMVHu7unkVbisTmCCE4jSOST0UkZJ009iHscP0hrigMmfxWHDTtYVv291
         s5c2f/OUJpJ/7W5xamQ4DkgtEaE5THUIpDt1MubfkxcH7E8cDBNpqzLFa9TykKz1vhMB
         RmYevlREENlYCW51BZuc3YLq9gN8HddYZPv2DtM5SX9YvwCpqKqDWmi0M4qRBo9c9/Wf
         Mfc00KOdljD+6p9PQQPmlOJiLeOEyI4NOJcokcw0t2O7MqXv3wlP2HACz6zh6QWvR9xN
         oIVg==
X-Forwarded-Encrypted: i=1; AJvYcCUcC7cejAOT2xuvNpRG6OcB1PTnXOUNrrDA3o9mYu29lY3RpRTS+vV8Cmu+opCkP0wP0dS97yl83TmtxuCteLU=@vger.kernel.org, AJvYcCV24xYcUELo/wP817L1dv5vBRT66m6TwLjPY7Yz4YM0UbZXdBiFQUmp3lTQoxCTexyPDzHrWc6Qny2TbjU=@vger.kernel.org, AJvYcCW4FPWaM20lqQNrJN7LAmAoF+pDdMOEAFLSfCgvT+PLJ+2cI/zYZ0N2lcDdEGmmxbvgQVW6ycA2tj6+HhVo1Zh6@vger.kernel.org
X-Gm-Message-State: AOJu0YxzGT8W3fKAOsUZhqO81KIuwIB8jiw038SI1mUMcn1+7bjgVtWi
	c50fU10JXKoRNVQNOiD4lD5y0cA+i6K9LiaK5eO+RVQlYOrZX6Km1r3BbW/IE1edD31mg+ccDnr
	J29GkR8KavThgqMIU/ZQTCYAhGms=
X-Gm-Gg: ASbGncsD9BXB72D2vmvJA/++JtFUDPSCQhwm7GrRz0uELD4FmW5cttO4zU8qI08p1k8
	nmDB6xwL2WqC2zkoL/2YducEMuXiji+yihpauzBOxWxS0Ynb7nlnFHC/aEEBYidSeVGf/I8UaTR
	D2D2yyRQdfXQQ4Ysv1UxSiPfO2JeIdlw==
X-Google-Smtp-Source: AGHT+IGKVOUfO1mi/BujIz8JVHzz8ieUmXy4eCf+jhg42xu7xOL4QbqHEO0He+TVLlt+CR/i1mw2UYZAGOMLV5lvF+0=
X-Received: by 2002:a05:6512:3ca1:b0:545:f90:2771 with SMTP id
 2adb3069b0e04-5451dfc13fcmr3731365e87.3.1739624512703; Sat, 15 Feb 2025
 05:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-2-davidgow@google.com>
 <CAJ-ks9kw7FTJ7EcHy8B+-1XFK8J4a-DuHLJhP1f3hPy10nOJZA@mail.gmail.com> <CABVgOSkcDPwWEz=Uo0q+HXSeQT4a5yPg8vb4BMkpZ0yyDu4wQA@mail.gmail.com>
In-Reply-To: <CABVgOSkcDPwWEz=Uo0q+HXSeQT4a5yPg8vb4BMkpZ0yyDu4wQA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Feb 2025 08:01:16 -0500
X-Gm-Features: AWEUYZkVH7Z7HtHO3XWyE9VdXkKoq077qDEkI6kD3AGCSxCPbfw3nUR0i29ULfQ
Message-ID: <CAJ-ks9mEocaBAhovLvjFuEPrSipLpOEzKOtJ7uGK5X-TG44QBw@mail.gmail.com>
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

On Sat, Feb 15, 2025 at 4:03=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Fri, 14 Feb 2025 at 22:41, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > Very excited to see this progress.
> >
> > On Fri, Feb 14, 2025 at 2:41=E2=80=AFAM David Gow <davidgow@google.com>=
 wrote:
> > >
> > > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > >
> > > Add a couple of Rust const functions and macros to allow to develop
> > > KUnit tests without relying on generated C code:
> > >
> > >  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
> > >    `kunit_test_suite` C macro. It requires a NULL-terminated array of
> > >    test cases (see below).
> > >  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C ma=
cro.
> > >    It generates as case from the name and function.
> > >  - The `kunit_case_null` Rust function generates a NULL test case, wh=
ich
> > >    is to be used as delimiter in `kunit_test_suite!`.
> > >
> > > While these functions and macros can be used on their own, a future
> > > patch will introduce another macro to create KUnit tests using a
> > > user-space like syntax.
> > >
> > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > Co-developed-by: David Gow <davidgow@google.com>
> > > Signed-off-by: David Gow <davidgow@google.com>
> > > ---
> > >
> > > Changes since v5:
> > > https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@google.=
com/
> > > - Rebased against 6.14-rc1
> > > - Several documentation touch-ups, including noting that the example
> > >   test function need not be unsafe. (Thanks, Miguel)
> > > - Remove the need for static_mut_refs, by using core::addr_of_mut!()
> > >   combined with a cast. (Thanks, Miguel)
> > >   - While this should also avoid the need for const_mut_refs, it seem=
s
> > >     to have been enabled for other users anyway.
> > > - Use ::kernel::ffi::c_char for C strings, rather than i8 directly.
> > >   (Thanks, Miguel)
> > >
> > > Changes since v4:
> > > https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-davi=
dgow@google.com/
> > > - Rebased against 6.13-rc1
> > > - Allowed an unused_unsafe warning after the behaviour of addr_of_mut=
!()
> > >   changed in Rust 1.82. (Thanks Boqun, Miguel)
> > > - Fix a couple of minor rustfmt issues which were triggering checkpat=
ch
> > >   warnings.
> > >
> > > Changes since v3:
> > > https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-davi=
dgow@google.com/
> > > - The kunit_unsafe_test_suite!() macro now panic!s if the suite name =
is
> > >   too long, triggering a compile error. (Thanks, Alice!)
> > >
> > > Changes since v2:
> > > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-davi=
dgow@google.com/
> > > - The kunit_unsafe_test_suite!() macro will truncate the name of the
> > >   suite if it is too long. (Thanks Alice!)
> > > - We no longer needlessly use UnsafeCell<> in
> > >   kunit_unsafe_test_suite!(). (Thanks Alice!)
> > >
> > > Changes since v1:
> > > https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@goog=
le.com/
> > > - Rebase on top of rust-next
> > > - As a result, KUnit attributes are new set. These are hardcoded to t=
he
> > >   defaults of "normal" speed and no module name.
> > > - Split the kunit_case!() macro into two const functions, kunit_case(=
)
> > >   and kunit_case_null() (for the NULL terminator).
> > >
> > > ---
> > >  rust/kernel/kunit.rs | 121 +++++++++++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 121 insertions(+)
> > >
> > > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > > index 824da0e9738a..d34a92075174 100644
> > > --- a/rust/kernel/kunit.rs
> > > +++ b/rust/kernel/kunit.rs
> > > @@ -161,3 +161,124 @@ macro_rules! kunit_assert_eq {
> > >          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $rig=
ht);
> > >      }};
> > >  }
> > > +
> > > +/// Represents an individual test case.
> > > +///
> > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated l=
ist of valid test cases.
> > > +/// Use `kunit_case_null` to generate such a delimiter.
> >
> > Can both of these be linkified? [`kunit_unsafe_test_suite!`] and
> > [`kunit_case_null`]. There are more instances below.
> >
>
> I've done this here. I've not linkified absolutely everything, but the
> most obvious/prominent ones should be done.
>
> > > +#[doc(hidden)]
> > > +pub const fn kunit_case(
> > > +    name: &'static kernel::str::CStr,
> > > +    run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
> > > +) -> kernel::bindings::kunit_case {
> > > +    kernel::bindings::kunit_case {
> > > +        run_case: Some(run_case),
> > > +        name: name.as_char_ptr(),
> > > +        attr: kernel::bindings::kunit_attributes {
> > > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> > > +        },
> > > +        generate_params: None,
> > > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > > +        module_name: core::ptr::null_mut(),
> > > +        log: core::ptr::null_mut(),
> >
> > These members, after `name`, can be spelled `..kunit_case_null()` to
> > avoid some repetition.
>
> I'm going to leave this as-is, as logically, the NULL terminator case
> and the 'default' case are two different things (even if, in practice,
> they have the same values). And personally, I find it clearer to have
> them more explicitly set here for now.
>
> It is a nice thought, though, so I reserve the right to change my mind
> in the future. :-)
>
> > > +    }
> > > +}
> > > +
> > > +/// Represents the NULL test case delimiter.
> > > +///
> > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated l=
ist of test cases. This
> > > +/// function returns such a delimiter.
> > > +#[doc(hidden)]
> > > +pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
> > > +    kernel::bindings::kunit_case {
> > > +        run_case: None,
> > > +        name: core::ptr::null_mut(),
> > > +        generate_params: None,
> > > +        attr: kernel::bindings::kunit_attributes {
> > > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMAL,
> > > +        },
> > > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > > +        module_name: core::ptr::null_mut(),
> > > +        log: core::ptr::null_mut(),
> > > +    }
> > > +}
> > > +
> > > +/// Registers a KUnit test suite.
> > > +///
> > > +/// # Safety
> > > +///
> > > +/// `test_cases` must be a NULL terminated array of valid test cases=
.
> > > +///
> > > +/// # Examples
> > > +///
> > > +/// ```ignore
> > > +/// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
> > > +///     let actual =3D 1 + 1;
> > > +///     let expected =3D 2;
> > > +///     assert_eq!(actual, expected);
> > > +/// }
> > > +///
> > > +/// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2] =
=3D [
> > > +///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn),
> > > +///     kernel::kunit::kunit_case_null(),
> > > +/// ];
> > > +/// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> > > +/// ```
> > > +#[doc(hidden)]
> > > +#[macro_export]
> > > +macro_rules! kunit_unsafe_test_suite {
> > > +    ($name:ident, $test_cases:ident) =3D> {
> > > +        const _: () =3D {
> > > +            const KUNIT_TEST_SUITE_NAME: [::kernel::ffi::c_char; 256=
] =3D {
> > > +                let name_u8 =3D ::core::stringify!($name).as_bytes()=
;
> >
> > This can be a little simpler:
> >
> > let name =3D $crate::c_str!(::core::stringify!($name)).as_bytes_with_nu=
l();
> >
>
> I'm not sure this ends up being much simpler: it makes it (possible?,
> obvious?) to get rid of the cast below, but we don't actually need to
> copy the null byte at the end, so it seems wasteful to bother.
>
> So after playing around both ways, I think this is probably best.

If you don't want to copy the null byte, you can s/as_bytes_with_nul/as_byt=
es.

The main thing is that `as` casts in Rust are a rare instance of
unchecked coercion in the language, so I encourage folks to avoid
them. The rest I don't feel strongly about.

> > > +                let mut ret =3D [0; 256];
> > > +
> > > +                if name_u8.len() > 255 {
> > > +                    panic!(concat!(
> > > +                        "The test suite name `",
> > > +                        ::core::stringify!($name),
> > > +                        "` exceeds the maximum length of 255 bytes."
> > > +                    ));
> > > +                }
> > > +
> > > +                let mut i =3D 0;
> > > +                while i < name_u8.len() {
> > > +                    ret[i] =3D name_u8[i] as ::kernel::ffi::c_char;
> > > +                    i +=3D 1;
> > > +                }
> >
> > I'd suggest `ret[..name.len()].copy_from_slice(name)` but
> > `copy_from_slice` isn't `const`. This can stay the same with the
> > now-unnecessary cast removed, or it can be the body of
> > `copy_from_slice`:
> >
> >                 // SAFETY: `name` is valid for `name.len()` elements
> > by definition, and `ret` was
> >                 // checked to be at least as large as `name`. The
> > buffers are statically know to not
> >                 // overlap.
> >                 unsafe {
> >                     ::core::ptr::copy_nonoverlapping(name.as_ptr(),
> > ret.as_mut_ptr(), name.len());
> >
> >                 }
> >
>
> I think I'll keep this as the loop for now, as that's more obvious to
> me, and avoids the extra unsafe block.
>
> If copy_from_slice ends up working in a const context, we can consider
> that later (though, personally, I still find the loop easier to
> understand).
>
> > > +
> > > +                ret
> > > +            };
> > > +
> > > +            #[allow(unused_unsafe)]
> > > +            static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit_s=
uite =3D
> > > +                ::kernel::bindings::kunit_suite {
> > > +                    name: KUNIT_TEST_SUITE_NAME,
> > > +                    // SAFETY: User is expected to pass a correct `t=
est_cases`, given the safety
> > > +                    // precondition; hence this macro named `unsafe`=
.
> > > +                    test_cases: unsafe {
> > > +                        ::core::ptr::addr_of_mut!($test_cases)
> > > +                            .cast::<::kernel::bindings::kunit_case>(=
)
> > > +                    },
> >
> > This safety comment seems to be referring to the safety of
> > `addr_of_mut!` but this was just a compiler limitation until Rust
> > 1.82, right? Same thing below on `KUNIT_TEST_SUITE_ENTRY`.
> >
>
> Yeah, this comment was originally written prior to 1.82 existing.
>
> But I think we probably should keep the safety comment here anyway, as
> -- if I understand it -- 1.82 only makes this safe if $test_cases is
> static, so it's still worth documenting the preconditions here.

I don't think the safety guarantees changed. In the Rust 1.82 release notes=
:

> In an expression context, STATIC_MUT and EXTERN_STATIC are place expressi=
ons. Previously, the compiler's safety checks were not aware that the raw r=
ef operator did not actually affect the operand's place, treating it as a p=
ossible read or write to a pointer. No unsafety is actually present, howeve=
r, as it just creates a pointer.

https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-un=
safe-statics

That's why I flagged this; the SAFETY comment is not actually correct.

> If we eventually stop supporting rust < 1.82, though, I'd be happy to
> remove the unsafe and thereby enforce the use of this macro only on
> statics at compile time.
>
> > Can we also narrow the `#[allow]`? This seems to work:
> >
> >                     #[allow(unused_unsafe)]
> >                     // SAFETY: ...
> >                     test_cases: unsafe {
> >                         ::core::ptr::addr_of_mut!($test_cases)
> >                             .cast::<::kernel::bindings::kunit_case>()
> >                     },
> >
>
> We hit problems before with #[allow] not working on expressions, so
> assumed we couldn't narrow it further. Seems to be working here,
> though, so I've changed it.
>
> > > +                    suite_init: None,
> > > +                    suite_exit: None,
> > > +                    init: None,
> > > +                    exit: None,
> > > +                    attr: ::kernel::bindings::kunit_attributes {
> > > +                        speed: ::kernel::bindings::kunit_speed_KUNIT=
_SPEED_NORMAL,
> > > +                    },
> > > +                    status_comment: [0; 256usize],
> >
> > I don't think you need the usize hint here, there's always a usize in
> > the length position.
> >
> > > +                    debugfs: ::core::ptr::null_mut(),
> > > +                    log: ::core::ptr::null_mut(),
> > > +                    suite_init_err: 0,
> > > +                    is_init: false,
> > > +                };
> > > +
> > > +            #[used]
> > > +            #[link_section =3D ".kunit_test_suites"]
> >
> > This attribute causes the same problem I describe in
> > https://lore.kernel.org/all/20250210-macros-section-v2-1-3bb9ff44b969@g=
mail.com/.
> > That's because the KUnit tests are generated both on target and on
> > host (even though they won't run on host). I don't think you need to
> > deal with that here, just pointing it out. I think we'll need a cfg to
> > indicate we're building for host to avoid emitting these attributes
> > that only make sense in the kernel.
> >
>
> I've added the same exclusion for macos here, but don't have a macos
> machine to test it on. If it's broken, we can fix it in a follow-up.
>
> > > +            static mut KUNIT_TEST_SUITE_ENTRY: *const ::kernel::bind=
ings::kunit_suite =3D
> > > +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> > > +                unsafe { ::core::ptr::addr_of_mut!(KUNIT_TEST_SUITE)=
 };
> >
> > This is missing the `#[allow(unused_unsafe)]` (it appears in the next
> > patch). This means this commit will not compile on bisection.
>
> Whoops. This must have snuck in during one of the many squashes and
> rebases. I'll fix that now.
>
> Annoyingly, I'm no longer able to actually reproduce the warning,
> which is strange.
> >
> > > +        };
> > > +    };
> > > +}
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >
> > >
> >
> > Global note: it seems more customary to use crate:: and $crate::
> > instead of kernel:: and ::kernel in functions and macros,
> > respectively.
>
> Hmm... I think I had that at one point and was told to change it to
> kernel. Personally, I think kernel:: makes more sense. So if it's not
> breaking anything, and I'll only get yelled at a little bit, let's
> keep it as is.
>
> In any case, I'm sending out v7 with the changes above. My hope is
> that this is then probably "good enough" to let us get started, and
> future changes can be done as independent patches, so we're both not
> holding this up for too long, and can better parallelise any fixes,
> rather than having to re-spin the whole series each time.
>
> Thanks a lot,
> -- David

