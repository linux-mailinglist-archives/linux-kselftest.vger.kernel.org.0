Return-Path: <linux-kselftest+bounces-26840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28969A39610
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 09:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8C7B1886629
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE1E22D782;
	Tue, 18 Feb 2025 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2TxxDg3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317C1B6D11
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739868716; cv=none; b=ByR3pJirSfSMTGMUK7KRmi/CoUJs/UTSqCSFWqS/k0O4ceKCI8IKlEXmNvE17QB2ssdOqyBX9w+7yKiHtKJJmehxSEwX8monvPaOyFwPNMgfJwPvNi9l5Mk9R3rXgf/cT6Ar+56yS/yu7Y2UJWPnZexZDbgvPKXy7HIc2UV2Wu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739868716; c=relaxed/simple;
	bh=pbYaCG2L5RboQFSk/v5ks5DFkhQIaYlJAAvBTaZCPtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxa9nlktoMTe86CnlnbF3LiUCtNeSHA/qJUIVInJvs1KcerkmfUydncxnATA/1FaKMJya44+AyWFYZKUJ4JJ1FDnf9P/REmOXfmawmzCKcVIUlF4KLc6tK8OlhWhyZr4UmJVOtF97a2iJOHBOj3H+j/9AKLugBASlLDQxQtDesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2TxxDg3; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e67bc04a3bso22995026d6.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 00:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739868713; x=1740473513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ATL8LYo+/9WYl5K0q7+HZ6/OrnzCAU0/OCFT/Z2+yCA=;
        b=I2TxxDg3c1UATLoffmbJaBDGPkR3C4kyf2K8VehovZMF3pCjVMYbjC8I31qJIm15Vu
         wP4ae92RXS6QYQQ6AgdavO7Mwi2koMlKL+CMSZPEnOmCdFTTaM3FiqJ2a/HvnRkGwT/X
         ysjVz6WdlvWDemj1ZAcw+ShZxrWbbOk/NgnJVTajZO18RBXRQNjruG3Nv07oa8feaI3L
         YvOh6f0rW3xQFmM3/w+FOL1GgDhsA1/voOgkryJ6yEtU4EZa+aEHmetPz4klOFxta2x3
         tPpaMDuVe4w0yv9IM6116kiAaDzYS6s39Ta9SZ+Idrfi+fE8GNykX+SPACfqtQmcgFSV
         Myxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739868713; x=1740473513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ATL8LYo+/9WYl5K0q7+HZ6/OrnzCAU0/OCFT/Z2+yCA=;
        b=wIqlBwk/f9eejLUWVbrXAmW4kQ+uGdCHGF5/fGQDstxWFxPpA6IiXOoHKJnMk4kOxA
         2sm2SUuba6ZINERvtjb2ns2TDK8mRTCyvI88gASiyOtDNRD2KKYQmb21mndB6t8Q/68M
         JiUYAZsgH0CvWinqKOhNc9/VYTKpoFI32AFRTZJ3cxwIpusfW4fNJdyHuyPMUCqK5Ryj
         KTm6oThvWw83lCI5OjYj1vqZlQJLq0D4Xjz6SBjqH+fMGQJP4kTwE39AfoO/3fh6ojy8
         q27Jnu4O9e76JcuGG4h3RVyItyqRr5AHJZaHpZ/7Bz33E0Jhr0WX8dI9i+1w40TIMB21
         /VUw==
X-Forwarded-Encrypted: i=1; AJvYcCUHyd5ox+QNgES4B+qv6UtVxz11FSf/NwATtVTosls/sMws9Ij46DOLNZrgFmV4h16W+xNI/SY1iZGC8TI/+tQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZpULBPGpJGgxkaM36Z2N+gMH7C4zGWqP+8j97RB/IgbMrdhNs
	aB4RTRsLtvhux2o98EjMkKaRUPVoUOomA7QZCSM9dqENzkSQcITiEi3MJHr6TOoXvYOeryjbgOt
	iVnvhDon8rRoS7uNSg8KY3DtyrCjvE88qbNCZ
X-Gm-Gg: ASbGncsAzARBK9r/fGM3nDxQI6widRt+uXWgim/RoYju9mtSJIpbLXhDwF0ekbVOap1
	//PRNbFrQKNVJN3yfHhV78aJEOwwZE2uwgUoCtGzVntCenl1Yto+CyuG2reOUtWLtxsiXkKC17w
	==
X-Google-Smtp-Source: AGHT+IHS8q4r+uTR+tSMN5/xjeUBRMtIxpfema1951PsokkXSDga9pGH/CYC27tzfWrB3/5bvLg0BA9ZVZwNjCA/QI4=
X-Received: by 2002:a05:6214:2528:b0:6d8:a730:110c with SMTP id
 6a1803df08f44-6e66cd2e54dmr212195066d6.38.1739868713018; Tue, 18 Feb 2025
 00:51:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-2-davidgow@google.com>
 <CAJ-ks9kw7FTJ7EcHy8B+-1XFK8J4a-DuHLJhP1f3hPy10nOJZA@mail.gmail.com>
 <CABVgOSkcDPwWEz=Uo0q+HXSeQT4a5yPg8vb4BMkpZ0yyDu4wQA@mail.gmail.com> <CAJ-ks9mEocaBAhovLvjFuEPrSipLpOEzKOtJ7uGK5X-TG44QBw@mail.gmail.com>
In-Reply-To: <CAJ-ks9mEocaBAhovLvjFuEPrSipLpOEzKOtJ7uGK5X-TG44QBw@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Tue, 18 Feb 2025 16:51:41 +0800
X-Gm-Features: AWEUYZld-PzYeZoGy-KWjR6RUG886vYSj_xf9iwT-FnCbjPSzjf80N_6jVxAg_4
Message-ID: <CABVgOSmQVXAdRpZBCDo2G4at3-MNaX2xV565m_jVcyw0y7sDfg@mail.gmail.com>
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
	boundary="000000000000a1b211062e66c028"

--000000000000a1b211062e66c028
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 15 Feb 2025 at 21:01, Tamir Duberstein <tamird@gmail.com> wrote:
>
> On Sat, Feb 15, 2025 at 4:03=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > On Fri, 14 Feb 2025 at 22:41, Tamir Duberstein <tamird@gmail.com> wrote=
:
> > >
> > > Very excited to see this progress.
> > >
> > > On Fri, Feb 14, 2025 at 2:41=E2=80=AFAM David Gow <davidgow@google.co=
m> wrote:
> > > >
> > > > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > >
> > > > Add a couple of Rust const functions and macros to allow to develop
> > > > KUnit tests without relying on generated C code:
> > > >
> > > >  - The `kunit_unsafe_test_suite!` Rust macro is similar to the
> > > >    `kunit_test_suite` C macro. It requires a NULL-terminated array =
of
> > > >    test cases (see below).
> > > >  - The `kunit_case` Rust function is similar to the `KUNIT_CASE` C =
macro.
> > > >    It generates as case from the name and function.
> > > >  - The `kunit_case_null` Rust function generates a NULL test case, =
which
> > > >    is to be used as delimiter in `kunit_test_suite!`.
> > > >
> > > > While these functions and macros can be used on their own, a future
> > > > patch will introduce another macro to create KUnit tests using a
> > > > user-space like syntax.
> > > >
> > > > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > > > Co-developed-by: Matt Gilbride <mattgilbride@google.com>
> > > > Signed-off-by: Matt Gilbride <mattgilbride@google.com>
> > > > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > > Co-developed-by: David Gow <davidgow@google.com>
> > > > Signed-off-by: David Gow <davidgow@google.com>
> > > > ---
> > > >
> > > > Changes since v5:
> > > > https://lore.kernel.org/all/20241213081035.2069066-2-davidgow@googl=
e.com/
> > > > - Rebased against 6.14-rc1
> > > > - Several documentation touch-ups, including noting that the exampl=
e
> > > >   test function need not be unsafe. (Thanks, Miguel)
> > > > - Remove the need for static_mut_refs, by using core::addr_of_mut!(=
)
> > > >   combined with a cast. (Thanks, Miguel)
> > > >   - While this should also avoid the need for const_mut_refs, it se=
ems
> > > >     to have been enabled for other users anyway.
> > > > - Use ::kernel::ffi::c_char for C strings, rather than i8 directly.
> > > >   (Thanks, Miguel)
> > > >
> > > > Changes since v4:
> > > > https://lore.kernel.org/linux-kselftest/20241101064505.3820737-2-da=
vidgow@google.com/
> > > > - Rebased against 6.13-rc1
> > > > - Allowed an unused_unsafe warning after the behaviour of addr_of_m=
ut!()
> > > >   changed in Rust 1.82. (Thanks Boqun, Miguel)
> > > > - Fix a couple of minor rustfmt issues which were triggering checkp=
atch
> > > >   warnings.
> > > >
> > > > Changes since v3:
> > > > https://lore.kernel.org/linux-kselftest/20241030045719.3085147-4-da=
vidgow@google.com/
> > > > - The kunit_unsafe_test_suite!() macro now panic!s if the suite nam=
e is
> > > >   too long, triggering a compile error. (Thanks, Alice!)
> > > >
> > > > Changes since v2:
> > > > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-2-da=
vidgow@google.com/
> > > > - The kunit_unsafe_test_suite!() macro will truncate the name of th=
e
> > > >   suite if it is too long. (Thanks Alice!)
> > > > - We no longer needlessly use UnsafeCell<> in
> > > >   kunit_unsafe_test_suite!(). (Thanks Alice!)
> > > >
> > > > Changes since v1:
> > > > https://lore.kernel.org/lkml/20230720-rustbind-v1-1-c80db349e3b5@go=
ogle.com/
> > > > - Rebase on top of rust-next
> > > > - As a result, KUnit attributes are new set. These are hardcoded to=
 the
> > > >   defaults of "normal" speed and no module name.
> > > > - Split the kunit_case!() macro into two const functions, kunit_cas=
e()
> > > >   and kunit_case_null() (for the NULL terminator).
> > > >
> > > > ---
> > > >  rust/kernel/kunit.rs | 121 +++++++++++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 121 insertions(+)
> > > >
> > > > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > > > index 824da0e9738a..d34a92075174 100644
> > > > --- a/rust/kernel/kunit.rs
> > > > +++ b/rust/kernel/kunit.rs
> > > > @@ -161,3 +161,124 @@ macro_rules! kunit_assert_eq {
> > > >          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $r=
ight);
> > > >      }};
> > > >  }
> > > > +
> > > > +/// Represents an individual test case.
> > > > +///
> > > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated=
 list of valid test cases.
> > > > +/// Use `kunit_case_null` to generate such a delimiter.
> > >
> > > Can both of these be linkified? [`kunit_unsafe_test_suite!`] and
> > > [`kunit_case_null`]. There are more instances below.
> > >
> >
> > I've done this here. I've not linkified absolutely everything, but the
> > most obvious/prominent ones should be done.
> >
> > > > +#[doc(hidden)]
> > > > +pub const fn kunit_case(
> > > > +    name: &'static kernel::str::CStr,
> > > > +    run_case: unsafe extern "C" fn(*mut kernel::bindings::kunit),
> > > > +) -> kernel::bindings::kunit_case {
> > > > +    kernel::bindings::kunit_case {
> > > > +        run_case: Some(run_case),
> > > > +        name: name.as_char_ptr(),
> > > > +        attr: kernel::bindings::kunit_attributes {
> > > > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMA=
L,
> > > > +        },
> > > > +        generate_params: None,
> > > > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > > > +        module_name: core::ptr::null_mut(),
> > > > +        log: core::ptr::null_mut(),
> > >
> > > These members, after `name`, can be spelled `..kunit_case_null()` to
> > > avoid some repetition.
> >
> > I'm going to leave this as-is, as logically, the NULL terminator case
> > and the 'default' case are two different things (even if, in practice,
> > they have the same values). And personally, I find it clearer to have
> > them more explicitly set here for now.
> >
> > It is a nice thought, though, so I reserve the right to change my mind
> > in the future. :-)
> >
> > > > +    }
> > > > +}
> > > > +
> > > > +/// Represents the NULL test case delimiter.
> > > > +///
> > > > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated=
 list of test cases. This
> > > > +/// function returns such a delimiter.
> > > > +#[doc(hidden)]
> > > > +pub const fn kunit_case_null() -> kernel::bindings::kunit_case {
> > > > +    kernel::bindings::kunit_case {
> > > > +        run_case: None,
> > > > +        name: core::ptr::null_mut(),
> > > > +        generate_params: None,
> > > > +        attr: kernel::bindings::kunit_attributes {
> > > > +            speed: kernel::bindings::kunit_speed_KUNIT_SPEED_NORMA=
L,
> > > > +        },
> > > > +        status: kernel::bindings::kunit_status_KUNIT_SUCCESS,
> > > > +        module_name: core::ptr::null_mut(),
> > > > +        log: core::ptr::null_mut(),
> > > > +    }
> > > > +}
> > > > +
> > > > +/// Registers a KUnit test suite.
> > > > +///
> > > > +/// # Safety
> > > > +///
> > > > +/// `test_cases` must be a NULL terminated array of valid test cas=
es.
> > > > +///
> > > > +/// # Examples
> > > > +///
> > > > +/// ```ignore
> > > > +/// extern "C" fn test_fn(_test: *mut kernel::bindings::kunit) {
> > > > +///     let actual =3D 1 + 1;
> > > > +///     let expected =3D 2;
> > > > +///     assert_eq!(actual, expected);
> > > > +/// }
> > > > +///
> > > > +/// static mut KUNIT_TEST_CASES: [kernel::bindings::kunit_case; 2]=
 =3D [
> > > > +///     kernel::kunit::kunit_case(kernel::c_str!("name"), test_fn)=
,
> > > > +///     kernel::kunit::kunit_case_null(),
> > > > +/// ];
> > > > +/// kernel::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES)=
;
> > > > +/// ```
> > > > +#[doc(hidden)]
> > > > +#[macro_export]
> > > > +macro_rules! kunit_unsafe_test_suite {
> > > > +    ($name:ident, $test_cases:ident) =3D> {
> > > > +        const _: () =3D {
> > > > +            const KUNIT_TEST_SUITE_NAME: [::kernel::ffi::c_char; 2=
56] =3D {
> > > > +                let name_u8 =3D ::core::stringify!($name).as_bytes=
();
> > >
> > > This can be a little simpler:
> > >
> > > let name =3D $crate::c_str!(::core::stringify!($name)).as_bytes_with_=
nul();
> > >
> >
> > I'm not sure this ends up being much simpler: it makes it (possible?,
> > obvious?) to get rid of the cast below, but we don't actually need to
> > copy the null byte at the end, so it seems wasteful to bother.
> >
> > So after playing around both ways, I think this is probably best.
>
> If you don't want to copy the null byte, you can s/as_bytes_with_nul/as_b=
ytes.
>
> The main thing is that `as` casts in Rust are a rare instance of
> unchecked coercion in the language, so I encourage folks to avoid
> them. The rest I don't feel strongly about.
>

As far as I can tell, as_bytes() returns a u8 slice anyway, so
shouldn't we need the cast anyway? Or is there something I'm missing?

(Also, is there a difference between this and the Rust stdlib's
to_bytes()? Or is the name difference just a glitch?)

Either way, I don't personally feel too strongly about it: the 'as'
cast doesn't worry me particularly (particularly out-on-the open like
this, rather than hidden behind lots of macros/indirection), but I'm
happy to bow to stronger opinions for now.


> > > > +                let mut ret =3D [0; 256];
> > > > +
> > > > +                if name_u8.len() > 255 {
> > > > +                    panic!(concat!(
> > > > +                        "The test suite name `",
> > > > +                        ::core::stringify!($name),
> > > > +                        "` exceeds the maximum length of 255 bytes=
."
> > > > +                    ));
> > > > +                }
> > > > +
> > > > +                let mut i =3D 0;
> > > > +                while i < name_u8.len() {
> > > > +                    ret[i] =3D name_u8[i] as ::kernel::ffi::c_char=
;
> > > > +                    i +=3D 1;
> > > > +                }
> > >
> > > I'd suggest `ret[..name.len()].copy_from_slice(name)` but
> > > `copy_from_slice` isn't `const`. This can stay the same with the
> > > now-unnecessary cast removed, or it can be the body of
> > > `copy_from_slice`:
> > >
> > >                 // SAFETY: `name` is valid for `name.len()` elements
> > > by definition, and `ret` was
> > >                 // checked to be at least as large as `name`. The
> > > buffers are statically know to not
> > >                 // overlap.
> > >                 unsafe {
> > >                     ::core::ptr::copy_nonoverlapping(name.as_ptr(),
> > > ret.as_mut_ptr(), name.len());
> > >
> > >                 }
> > >
> >
> > I think I'll keep this as the loop for now, as that's more obvious to
> > me, and avoids the extra unsafe block.
> >
> > If copy_from_slice ends up working in a const context, we can consider
> > that later (though, personally, I still find the loop easier to
> > understand).
> >
> > > > +
> > > > +                ret
> > > > +            };
> > > > +
> > > > +            #[allow(unused_unsafe)]
> > > > +            static mut KUNIT_TEST_SUITE: ::kernel::bindings::kunit=
_suite =3D
> > > > +                ::kernel::bindings::kunit_suite {
> > > > +                    name: KUNIT_TEST_SUITE_NAME,
> > > > +                    // SAFETY: User is expected to pass a correct =
`test_cases`, given the safety
> > > > +                    // precondition; hence this macro named `unsaf=
e`.
> > > > +                    test_cases: unsafe {
> > > > +                        ::core::ptr::addr_of_mut!($test_cases)
> > > > +                            .cast::<::kernel::bindings::kunit_case=
>()
> > > > +                    },
> > >
> > > This safety comment seems to be referring to the safety of
> > > `addr_of_mut!` but this was just a compiler limitation until Rust
> > > 1.82, right? Same thing below on `KUNIT_TEST_SUITE_ENTRY`.
> > >
> >
> > Yeah, this comment was originally written prior to 1.82 existing.
> >
> > But I think we probably should keep the safety comment here anyway, as
> > -- if I understand it -- 1.82 only makes this safe if $test_cases is
> > static, so it's still worth documenting the preconditions here.
>
> I don't think the safety guarantees changed. In the Rust 1.82 release not=
es:
>
> > In an expression context, STATIC_MUT and EXTERN_STATIC are place expres=
sions. Previously, the compiler's safety checks were not aware that the raw=
 ref operator did not actually affect the operand's place, treating it as a=
 possible read or write to a pointer. No unsafety is actually present, howe=
ver, as it just creates a pointer.
>
> https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-addressing-=
unsafe-statics
>
> That's why I flagged this; the SAFETY comment is not actually correct.
>

I won't pretend to be an expert on the exact semantics of Rust
references / place expressions / etc here -- I still don't totally
understand why this needs the cast for a start -- but I do still think
there's more to the story than "this is just a compiler limitation".

The reason is that, whilst -- as you suggest -- this is always safe
when $test_cases is static, that's not actually guaranteed anywhere.
And with the unsafe block, it's up to the _user_ of
kunit_unsafe_test_suite() to guarantee that $test_cases is safe here.

Now, I don't think the current documentation is particularly clear
about this, so I'm definitely open to it changing, though I think we'd
need to change the overall documentation for the macro, not just the
safety comment. And maybe this will be something which, presumably, we
can have enforced by the compiler in the future, should we be able to
depend on rustc>1.82 and remove the 'unsafe' entirely. (But support
for older compilers is important to me, so I don't want to push that
point too much.)

(Also, does anyone else find the whole 'lets change the unsafe rules
in a minor compiler version, and require a weird attribute to avoid a
warning' thing incredibly frustrating? I've read that it's not what
the formal purpose of Rust editions is, but it _feels_ like this sort
of change should be in an edition intuitively to me.)

Anyway, I've got a few higher-priority non-Rust things to do by the
end of the month, so I'm unlikely to have time to spin up a v8 myself
for a few weeks. So if folks want to either send out an updated
version or the series, or accept it as-is and send out a follow-up
fix, I'm happy to review it, but otherwise it'll have to wait a little
bit.

Cheers,
-- David

--000000000000a1b211062e66c028
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
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgTFKxLnJ7PLqsg8JTGsr733vALG9f
qzQr/oY4YDSL4bwwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjE4MDg1MTUzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAIft3PQCNkDKWuI8IGg+1/9y3BOCKshKEtvWiVavDCYA4ThS
QO8hNcXIAJyjLCbgPhPngQf+Z7Wv5VoHmze6Z8Pwm3888+5VpWGUcxqJ2Hixif22s4E471dKvCYH
FHl4TKKlHHuw1dGeuzrqQndCPN2CebA/q7N4HUZq3mZxSD4+QbsyEcvk41/TwORYlY4qlqPCcIN4
0AnnbQLMo4+vtwP+H/OHuEaegIdegAXiYbGunEBBD7/9Y2uHXefjOn22t9GcQe50IJEZYZDW2WfC
kqgj/Csgv1aJP8vFS91pkqBy8YIplTJCAWl1cy96xmNxRVSnYlp0LZBUDQ0zYXOne/Q=
--000000000000a1b211062e66c028--

