Return-Path: <linux-kselftest+bounces-26857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED92A3A086
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B5061627FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 14:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9848F26A0C9;
	Tue, 18 Feb 2025 14:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjAxObCt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32161146D6A;
	Tue, 18 Feb 2025 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890303; cv=none; b=K7R6AXLUCHk3PtKQe76gtd4UnlqsI0UX93KjV9AktCfBpiEqLIlUd6Uaf/mQLajXs3YPFHBd8MZkvFvY1wZpXli/CxYcWBEMWH4HZ42LDlDaFIuuR888+OQHkLdBrj337emEjNmU7BvTvA30m/H6C0V31gtWNkHPHwo+GCEXhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890303; c=relaxed/simple;
	bh=oTF9OGgQOo7QUPMtiM1xfzhROy2FfVJqIg5oGqolJuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvA404sgyzv80/efKdwkjdUhXjvuAYuOeLg+5j8l1zbAbpzF3Uw4EGa1TK5/SRlCNhN3QkhGKHltYAILz8/9H3H0jrEvDjzf+0O8QZxe3ynkaIaXOG2svGkQ9Iuk0fnd1q55t6bPvOBt84HpFe5xazWhR+GXAUz5QcXGR2pZItU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjAxObCt; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a6bso57751231fa.1;
        Tue, 18 Feb 2025 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739890298; x=1740495098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Bvz/zhAQ0hIVx678swznPxuw5OPR9vqZoFb1gQtV3A=;
        b=CjAxObCt8mboSqzwzLQGvMfFBOynk8cnY640nY9n2qCCBqMzHPpZK+tUefqjJ0ctGG
         dqWhJb0htoW+nd8ys1Alq8Bct0xT2HcYh96sh5HPLAhmCMNwQZm9I247qLkPB/GLptrX
         zzQ2KbIVuNa0QKzmgXeGoGU5AkwMjgPhqTPoaAhM+lZZxjPahJPmInJ88QwmZjdGvVBI
         IGlAa6yzv39udDveEgiabQj3P6+5P/4m+mLhs/yjytIvsr38AbZVz64MpMdhqZab2ojl
         5tjcPdZtwR2Mxw5N555oRxS+Mukl5w7l0adeS4R/z30I5EiD8Gve9pBG8k9dYCgp5NjX
         4Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739890298; x=1740495098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Bvz/zhAQ0hIVx678swznPxuw5OPR9vqZoFb1gQtV3A=;
        b=mSvvfacxWm1UiMQqaFkuvN5DspTZBW9M+rU74/B4+S+pAD6qWpg1KTfOEadl2e5i6a
         /TkGYLIM9L7RXQ+gQzeactZGyhKqLj8jJhOlaTOIWDNj8CxXK5g5hN9M4R8jirFshcZQ
         GcHERsoWoLmKSN3w2Md7l96k95gp5iJI9xCoSJrtQGARhN5bYahg1nBqMjm7WT7RhC7e
         XAYC/lFL3QSueJXE60XeX1exIms9pGlJYhWvoM5jisOdtWQCqjIozxyZPuzObSCqlSPG
         1Tab7PwpMDlT0ytSNPhHKKiZI2syq4Jy7QschVhgrmtRYX8+3h6UlskdSpmywhJKo7ye
         if5g==
X-Forwarded-Encrypted: i=1; AJvYcCUIee3mL6pDfbFGi9swu/7+LhXCDCLFDfVXrjK4SafVkL8yoVnHQWfgtOIHT+X7h4OvaDr6x/1U8O37A6tJKQg=@vger.kernel.org, AJvYcCUqnPcwaL7UXcl2vsqFg2QQCqLVIbE02bZ+XEWyxM8MXDNmDf8CTJSUAtJa/WDwVa16SrJQRXGKpAgIaRM=@vger.kernel.org, AJvYcCWkW+GyOj/q2qocM7NaFiBGoev3ILxHLsSi82zvU4R3geWImb/RLr2aBuk7NoH3DxHjVwt2UsF9v7IO7tCL39ZP@vger.kernel.org
X-Gm-Message-State: AOJu0YyqsTnxpN/NJwkIAadA2hQrlIMEif7bazVv8ZQRsIqElFkxSbeU
	9VjoCAHVY/IInY+w1RWcUPM7WVo1FTC4FlRc/G/MWgsttxShUPB6IMEdL9TJW/6z+P95WiRCaK1
	TtxwObN7iky3fkH0mQXxTJUJq0U0=
X-Gm-Gg: ASbGncspEPFrTFBzXxjd7GzpC1S+yObQ91TjqYIOxDEdSUgGEH1Nf8Ub4DkIq56qJoA
	3PH8sfDcdo6jdIlNokobeZe+CpKTCNTeei54ZkFym6ElQ/BLY/SIPEXt3T4eQ+ppAwcSiHP6jFJ
	Mx6as+TFtmHEI1Ilx9pLJeDwjS6cBfLho=
X-Google-Smtp-Source: AGHT+IH7HGD0q4iPuGZhFRFcS6rATjqs/v6yGEfyKos2K/Ufa4UaO80TefatQT/GqBa/n3jaUbCOLON5jyZ64RxibuE=
X-Received: by 2002:a2e:95c4:0:b0:308:eb58:6581 with SMTP id
 38308e7fff4ca-30927950313mr40566901fa.0.1739890297828; Tue, 18 Feb 2025
 06:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-2-davidgow@google.com>
 <CAJ-ks9kw7FTJ7EcHy8B+-1XFK8J4a-DuHLJhP1f3hPy10nOJZA@mail.gmail.com>
 <CABVgOSkcDPwWEz=Uo0q+HXSeQT4a5yPg8vb4BMkpZ0yyDu4wQA@mail.gmail.com>
 <CAJ-ks9mEocaBAhovLvjFuEPrSipLpOEzKOtJ7uGK5X-TG44QBw@mail.gmail.com> <CABVgOSmQVXAdRpZBCDo2G4at3-MNaX2xV565m_jVcyw0y7sDfg@mail.gmail.com>
In-Reply-To: <CABVgOSmQVXAdRpZBCDo2G4at3-MNaX2xV565m_jVcyw0y7sDfg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Feb 2025 09:51:00 -0500
X-Gm-Features: AWEUYZnDh82qsBXFcGIeQnh0619ef6POYyeoE5WFptffaGZZK5rmXWEWl3_J9_4
Message-ID: <CAJ-ks9kL6e7hBUMN+jaVy=DP2ixHXUE19eKgb9fywZY8jM+mDA@mail.gmail.com>
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

On Tue, Feb 18, 2025 at 3:51=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> On Sat, 15 Feb 2025 at 21:01, Tamir Duberstein <tamird@gmail.com> wrote:
> >
> > On Sat, Feb 15, 2025 at 4:03=E2=80=AFAM David Gow <davidgow@google.com>=
 wrote:
> > >
> > > On Fri, 14 Feb 2025 at 22:41, Tamir Duberstein <tamird@gmail.com> wro=
te:
> > > >
> > > > Very excited to see this progress.
> > > >
> > > > On Fri, Feb 14, 2025 at 2:41=E2=80=AFAM David Gow <davidgow@google.=
com> wrote:
> > > > >
> > > > > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > > >
> > > > > Add a couple of Rust const functions and macros to allow to devel=
op
> > > > > KUnit tests without relying on generated C code:
> > > > >
> > > > >  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
> > > > >    `kunit_test_suite` C macro. It requires a NULL-terminated arra=
y of
> > > > >    test cases (see below).
> > > > >  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` =
C macro.
> > > > >    It generates as case from the name and function.
> > > > >  - The `kunit_case_null` Rust function generates a NULL test case=
, which
> > > > >    is to be used as delimiter in `kunit_test_suite!`.
> > > > >
> > > > > While these functions and macros can be used on their own, a futu=
re
> > > > > patch will introduce another macro to create KUnit tests using a
> > > > > user-space like syntax.
> > > > >
> > > > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com=
>
> > > > > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > > > > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > > > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > > > Co-developed-by: David Gow <davidgow@google.com>
> > > > > Signed-off-by: David Gow <davidgow@google.com>
> > > > > ---
> > > > >
> > > > > Changes since v5:
> > > > > https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@goo=
gle.com/
> > > > > - Rebased against 6.14-rc1
> > > > > - Several documentation touch-ups, including noting that the exam=
ple
> > > > >   test function need not be unsafe. (Thanks, Miguel)
> > > > > - Remove the need for static_mut_refs, by using core::addr_of_mut=
!()
> > > > >   combined with a cast. (Thanks, Miguel)
> > > > >   - While this should also avoid the need for const_mut_refs, it =
seems
> > > > >     to have been enabled for other users anyway.
> > > > > - Use ::kernel::ffi::c_char for C strings, rather than i8 directl=
y.
> > > > >   (Thanks, Miguel)
> > > > >
> > > > > Changes since v4:
> > > > > https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-=
davidgow@google.com/
> > > > > - Rebased against 6.13-rc1
> > > > > - Allowed an unused_unsafe warning after the behaviour of addr_of=
_mut!()
> > > > >   changed in Rust 1.82. (Thanks Boqun, Miguel)
> > > > > - Fix a couple of minor rustfmt issues which were triggering chec=
kpatch
> > > > >   warnings.
> > > > >
> > > > > Changes since v3:
> > > > > https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-=
davidgow@google.com/
> > > > > - The kunit_unsafe_test_suite!() macro now panic!s if the suite n=
ame is
> > > > >   too long, triggering a compile error. (Thanks, Alice!)
> > > > >
> > > > > Changes since v2:
> > > > > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-=
davidgow@google.com/
> > > > > - The kunit_unsafe_test_suite!() macro will truncate the name of =
the
> > > > >   suite if it is too long. (Thanks Alice!)
> > > > > - We no longer needlessly use UnsafeCell<> in
> > > > >   kunit_unsafe_test_suite!(). (Thanks Alice!)
> > > > >
> > > > > Changes since v1:
> > > > > https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@=
google.com/
> > > > > - Rebase on top of rust-next
> > > > > - As a result, KUnit attributes are new set. These are hardcoded =
to the
> > > > >   defaults of "normal" speed and no module name.
> > > > > - Split the kunit_case!() macro into two const functions, kunit_c=
ase()
> > > > >   and kunit_case_null() (for the NULL terminator).
> > > > >
> > > > > ---
> > > > >  rust/kernel/kunit.rs | 121 +++++++++++++++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 121 insertions(+)
> > > > >
> > > > > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > > > > index 824da0e9738a..d34a92075174 100644
> > > > > --- a/rust/kernel/kunit.rs
> > > > > +++ b/rust/kernel/kunit.rs
> > > > > @@ -161,3 +161,124 @@ macro_rules! kunit_assert_eq {
> > > > >          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D =
$right);
> > > > >      }};
> > > > >  }
> > > > > +
> > > > > +/// Represents an individual test case.
> > > > > +///
> > > > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminat=
ed list of valid test cases.
> > > > > +/// Use `kunit_case_null` to generate such a delimiter.
> > > >
> > > > Can both of these be linkified? [`kunit_unsafe_test_suite!`] and
> > > > [`kunit_case_null`]. There are more instances below.
> > > >
> > >
> > > I've done this here. I've not linkified absolutely everything, but th=
e
> > > most obvious/prominent ones should be done.
> > >
> > > > > +#[doc(hidden)]
> > > > > +pub const fn kunit_case(
> > > > > +    name: &'static kernel::str::CStr,
> > > > > +    run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit)=
,
> > > > > +) -> kernel::bindings::kunit_case {
> > > > > +    kernel::bindings::kunit_case {
> > > > > +        run_case: Some(run_case),
> > > > > +        name: name.as_char_ptr(),
> > > > > +        attr: kernel::bindings::kunit_attributes {
> > > > > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NOR=
MAL,
> > > > > +        },
> > > > > +        generate_params: None,
> > > > > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > > > > +        module_name: core::ptr::null_mut(),
> > > > > +        log: core::ptr::null_mut(),
> > > >
> > > > These members, after `name`, can be spelled `..kunit_case_null()` t=
o
> > > > avoid some repetition.
> > >
> > > I'm going to leave this as-is, as logically, the NULL terminator case
> > > and the 'default' case are two different things (even if, in practice=
,
> > > they have the same values). And personally, I find it clearer to have
> > > them more explicitly set here for now.
> > >
> > > It is a nice thought, though, so I reserve the right to change my min=
d
> > > in the future. :-)
> > >
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +/// Represents the NULL test case delimiter.
> > > > > +///
> > > > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminat=
ed list of test cases. This
> > > > > +/// function returns such a delimiter.
> > > > > +#[doc(hidden)]
> > > > > +pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
> > > > > +    kernel::bindings::kunit_case {
> > > > > +        run_case: None,
> > > > > +        name: core::ptr::null_mut(),
> > > > > +        generate_params: None,
> > > > > +        attr: kernel::bindings::kunit_attributes {
> > > > > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NOR=
MAL,
> > > > > +        },
> > > > > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > > > > +        module_name: core::ptr::null_mut(),
> > > > > +        log: core::ptr::null_mut(),
> > > > > +    }
> > > > > +}
> > > > > +
> > > > > +/// Registers a KUnit test suite.
> > > > > +///
> > > > > +/// # Safety
> > > > > +///
> > > > > +/// `test_cases` must be a NULL terminated array of valid test c=
ases.
> > > > > +///
> > > > > +/// # Examples
> > > > > +///
> > > > > +/// ```ignore
> > > > > +/// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
> > > > > +///     let actual =3D 1 + 1;
> > > > > +///     let expected =3D 2;
> > > > > +///     assert_eq!(actual, expected);
> > > > > +/// }
> > > > > +///
> > > > > +/// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; =
2] =3D [
> > > > > +///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_f=
n),
> > > > > +///     kernel::kunit::kunit_case_null(),
> > > > > +/// ];
> > > > > +/// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASE=
S);
> > > > > +/// ```
> > > > > +#[doc(hidden)]
> > > > > +#[macro_export]
> > > > > +macro_rules! kunit_unsafe_test_suite {
> > > > > +    ($name:ident, $test_cases:ident) =3D> {
> > > > > +        const _: () =3D {
> > > > > +            const KUNIT_TEST_SUITE_NAME: [::kernel::ffi::c_char;=
 256] =3D {
> > > > > +                let name_u8 =3D ::core::stringify!($name).as_byt=
es();
> > > >
> > > > This can be a little simpler:
> > > >
> > > > let name =3D $crate::c_str!(::core::stringify!($name)).as_bytes_wit=
h_nul();
> > > >
> > >
> > > I'm not sure this ends up being much simpler: it makes it (possible?,
> > > obvious?) to get rid of the cast below, but we don't actually need to
> > > copy the null byte at the end, so it seems wasteful to bother.
> > >
> > > So after playing around both ways, I think this is probably best.
> >
> > If you don't want to copy the null byte, you can s/as_bytes_with_nul/as=
_bytes.
> >
> > The main thing is that `as` casts in Rust are a rare instance of
> > unchecked coercion in the language, so I encourage folks to avoid
> > them. The rest I don't feel strongly about.
> >
>
> As far as I can tell, as_bytes() returns a u8 slice anyway, so
> shouldn't we need the cast anyway? Or is there something I'm missing?

Ah, we don't need the cast at all, I think. `kernel::ffi::c_char` is u8.

> (Also, is there a difference between this and the Rust stdlib's
> to_bytes()? Or is the name difference just a glitch?)

It's just an inconsistency. I believe our CStr predates some necessary
features in the standard library. There is
https://lore.kernel.org/all/20250203-cstr-core-v8-0-cb3f26e78686@gmail.com/=
t/#u
to replace our custom implementation with upstream's.

> Either way, I don't personally feel too strongly about it: the 'as'
> cast doesn't worry me particularly (particularly out-on-the open like
> this, rather than hidden behind lots of macros/indirection), but I'm
> happy to bow to stronger opinions for now.
>
>
> > > > > +                let mut ret =3D [0; 256];
> > > > > +
> > > > > +                if name_u8.len() > 255 {
> > > > > +                    panic!(concat!(
> > > > > +                        "The test suite name `",
> > > > > +                        ::core::stringify!($name),
> > > > > +                        "` exceeds the maximum length of 255 byt=
es."
> > > > > +                    ));
> > > > > +                }
> > > > > +
> > > > > +                let mut i =3D 0;
> > > > > +                while i < name_u8.len() {
> > > > > +                    ret[i] =3D name_u8[i] as ::kernel::ffi::c_ch=
ar;
> > > > > +                    i +=3D 1;
> > > > > +                }
> > > >
> > > > I'd suggest `ret[..name.len()].copy_from_slice(name)` but
> > > > `copy_from_slice` isn't `const`. This can stay the same with the
> > > > now-unnecessary cast removed, or it can be the body of
> > > > `copy_from_slice`:
> > > >
> > > >                 // SAFETY: `name` is valid for `name.len()` element=
s
> > > > by definition, and `ret` was
> > > >                 // checked to be at least as large as `name`. The
> > > > buffers are statically know to not
> > > >                 // overlap.
> > > >                 unsafe {
> > > >                     ::core::ptr::copy_nonoverlapping(name.as_ptr(),
> > > > ret.as_mut_ptr(), name.len());
> > > >
> > > >                 }
> > > >
> > >
> > > I think I'll keep this as the loop for now, as that's more obvious to
> > > me, and avoids the extra unsafe block.
> > >
> > > If copy_from_slice ends up working in a const context, we can conside=
r
> > > that later (though, personally, I still find the loop easier to
> > > understand).
> > >
> > > > > +
> > > > > +                ret
> > > > > +            };
> > > > > +
> > > > > +            #[allow(unused_unsafe)]
> > > > > +            static mut KUNIT_TEST_SUITE: ::kernel::bindings::kun=
it_suite =3D
> > > > > +                ::kernel::bindings::kunit_suite {
> > > > > +                    name: KUNIT_TEST_SUITE_NAME,
> > > > > +                    // SAFETY: User is expected to pass a correc=
t `test_cases`, given the safety
> > > > > +                    // precondition; hence this macro named `uns=
afe`.
> > > > > +                    test_cases: unsafe {
> > > > > +                        ::core::ptr::addr_of_mut!($test_cases)
> > > > > +                            .cast::<::kernel::bindings::kunit_ca=
se>()
> > > > > +                    },
> > > >
> > > > This safety comment seems to be referring to the safety of
> > > > `addr_of_mut!` but this was just a compiler limitation until Rust
> > > > 1.82, right? Same thing below on `KUNIT_TEST_SUITE_ENTRY`.
> > > >
> > >
> > > Yeah, this comment was originally written prior to 1.82 existing.
> > >
> > > But I think we probably should keep the safety comment here anyway, a=
s
> > > -- if I understand it -- 1.82 only makes this safe if $test_cases is
> > > static, so it's still worth documenting the preconditions here.
> >
> > I don't think the safety guarantees changed. In the Rust 1.82 release n=
otes:
> >
> > > In an expression context, STATIC_MUT and EXTERN_STATIC are place expr=
essions. Previously, the compiler's safety checks were not aware that the r=
aw ref operator did not actually affect the operand's place, treating it as=
 a possible read or write to a pointer. No unsafety is actually present, ho=
wever, as it just creates a pointer.
> >
> > https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressin=
g-unsafe-statics
> >
> > That's why I flagged this; the SAFETY comment is not actually correct.
> >
>
> I won't pretend to be an expert on the exact semantics of Rust
> references / place expressions / etc here -- I still don't totally
> understand why this needs the cast for a start -- but I do still think
> there's more to the story than "this is just a compiler limitation".
>
> The reason is that, whilst -- as you suggest -- this is always safe
> when $test_cases is static, that's not actually guaranteed anywhere.
> And with the unsafe block, it's up to the _user_ of
> kunit_unsafe_test_suite() to guarantee that $test_cases is safe here.

It's the other way around. In Rust, it is unsafe to take mutable
references to statics. What the compiler didn't understand until 1.82
is that taking a raw pointer to the static did not require forming a
reference, and thus wasn't unsafe (later dereferencing that pointer to
create a reference would be unsafe, static or not).

> Now, I don't think the current documentation is particularly clear
> about this, so I'm definitely open to it changing, though I think we'd
> need to change the overall documentation for the macro, not just the
> safety comment. And maybe this will be something which, presumably, we
> can have enforced by the compiler in the future, should we be able to
> depend on rustc>1.82 and remove the 'unsafe' entirely. (But support
> for older compilers is important to me, so I don't want to push that
> point too much.)

I think there's a bit of confusion going on here because the same word
is being used to describe the Rust notion of memory safety as well as
the preconditions expected by KUnit. That's why this comment is so
misleading; the compiler says "please tell me why it's safe to form a
mutable reference to this static here" and the answer comes "it's safe
because the user pinky promised to end the array with a null test
case". It doesn't make sense.

>
> (Also, does anyone else find the whole 'lets change the unsafe rules
> in a minor compiler version, and require a weird attribute to avoid a
> warning' thing incredibly frustrating? I've read that it's not what
> the formal purpose of Rust editions is, but it _feels_ like this sort
> of change should be in an edition intuitively to me.)
>
> Anyway, I've got a few higher-priority non-Rust things to do by the
> end of the month, so I'm unlikely to have time to spin up a v8 myself
> for a few weeks. So if folks want to either send out an updated
> version or the series, or accept it as-is and send out a follow-up
> fix, I'm happy to review it, but otherwise it'll have to wait a little
> bit.
>
> Cheers,
> -- David

