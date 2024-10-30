Return-Path: <linux-kselftest+bounces-21080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9CE9B5AFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 05:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FD5DB23284
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 04:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE7719C571;
	Wed, 30 Oct 2024 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gA2kX7GW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B99199222
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730264376; cv=none; b=lky1vKQK9dgqW42GvqPT2KuI+Y40+h7Yr1lhY2rNNWJg5NqW66D/q/j8e7YJXDRhIvZuNhwzOKAdzunHVtKgvXpKdgjnE8i7IqtpYJzA2S+26o4Ui0MuNDWmPW0EzZTTLuCKbxFN+i76/JSdpPyDwTWxCpXuuCgbWpg3q5DEx94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730264376; c=relaxed/simple;
	bh=GK5CRZU142Ru97AIg4QQj6Nee/AdCRR1Zm12ows2oMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FNIx3sCM/wPhMV6fitBjZGWE6Im7LFHkLyMd+eQ0JvDad54t5Y9u7jjDzkRA8as+DU2YnyD3iG62xZpkbNvjBK9HHepVdjwwTOKCMHkI0x6qysBNV/ds+E2ek0raaS63A3/n7s6FMPOzLDDk2IKF3zEABCicEKEjqUdUYgZwfhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gA2kX7GW; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cd7a2ed34bso38053156d6.2
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730264372; x=1730869172; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oVAfQRF8pFPIO6/kHcXu8TEC5Pa1oXka5lKvkoruMG8=;
        b=gA2kX7GWboe77MW9HnGtoovukxAJqxRkY4eEakSuki6QULRjGLSkgZQHdyXZ5tyf/v
         PMJs8MV3gjoaath509VSCz7u5tvs+2rGUM1huw5+WK4Cl/eNgXmz2Y2KRjaS7MsHgz5J
         Phz7VrJxkbsA2MAH0uCDSuv4o5ye5IdiR5IkLeynhz9+VB1p5G1dQ0su8HfEVVp/GQnl
         TLtMH20L2QDqxliaSzjfLsck0dxKRyCEdji/HvUX6Ck0iPncnB9xSsnbXgM6z002V4Oa
         VapfNHmNex/AIPYoPInfCHGIZy2yJMu+MVEiPDacggC41eRzbs4EhRrLSH4akeLw0fyC
         tvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730264372; x=1730869172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVAfQRF8pFPIO6/kHcXu8TEC5Pa1oXka5lKvkoruMG8=;
        b=dl0RwlJXhD3wZydyOrNjy/KA0wmx8Z56UL0zaGdlit72kA5LXDwZ6o2FXFFEmNek4e
         LTptP1c1zyh1+29B8kG3gL+nSvVT1TJAxuM/Lx4h+eeTyneh5AX4uYyBRFZdw376tU08
         BQGREiDDqjV2MhiA4rRM7pNu7REervm1eiL1Ji0A25XOoQoVif61Yre9iWCn16EzNON9
         5opceoHiKzTTii9fW6SnHgnpKM0h4M6siiutaQvfEljta7oOEXGmsOocN4SdgdW74QPh
         VXA360msgEZso2FarQrYr80pCLfFXrCrvsfM18S9Y0/4kNaKGGgBcYvVIDjJwBoUDox4
         zXDg==
X-Forwarded-Encrypted: i=1; AJvYcCW/x6D+9O6vbuWjM1aBoSVRqFrKrCPAvsI2vluxNeVPNSLwr3rpHKFSsrqTwoVGwxxWiqE049tg/0PiMEBbz0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVZ772qaaVScJAuNZtMyG8yyUqLBYy1Ow04/izdXq9fCHPwpB
	zfNFL/ZUsloVt5b8lQ8mJefrEaM7MLO27CkYi8kSGzSlqvVO8CEcOT6bT+R4MNVz/OaFlsZ3EYJ
	5qCwE/ofJYUOzBL9nIL8QQN9ZQFqF3Iqihz7W
X-Google-Smtp-Source: AGHT+IGrPleH17ISuoD0kPH2uZeTOKlQqTgTz/B2d8NuRC2cJP3ZhfjK8k8wWOIMsoa6zrrMhv/pIcTN10UBPKPeLGg=
X-Received: by 2002:a05:6214:4303:b0:6cb:399d:6ec3 with SMTP id
 6a1803df08f44-6d18567981amr194824876d6.9.1730264372076; Tue, 29 Oct 2024
 21:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029092422.2884505-1-davidgow@google.com> <20241029092422.2884505-2-davidgow@google.com>
 <CAH5fLghSJtxKPZczEzc30m=LrG_BX0JkxX+0tFQLhojsOEzogg@mail.gmail.com>
In-Reply-To: <CAH5fLghSJtxKPZczEzc30m=LrG_BX0JkxX+0tFQLhojsOEzogg@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Wed, 30 Oct 2024 12:59:18 +0800
Message-ID: <CABVgOS=tp1SiZeQYgDX2ET3twJ8-xCZTu8ofsWabjsQZQbyMCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: kunit: add KUnit case and suite macros
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com, 
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000004bb46b0625aa9103"

--0000000000004bb46b0625aa9103
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 29 Oct 2024 at 20:08, Alice Ryhl <aliceryhl@google.com> wrote:
>
> On Tue, Oct 29, 2024 at 10:24=E2=80=AFAM David Gow <davidgow@google.com> =
wrote:
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
> > Co-developed-by: David Gow <davidgow@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > ---
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
> >  rust/kernel/kunit.rs | 108 +++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs   |   1 +
> >  2 files changed, 109 insertions(+)
> >
> > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > index 824da0e9738a..fc2d259db458 100644
> > --- a/rust/kernel/kunit.rs
> > +++ b/rust/kernel/kunit.rs
> > @@ -161,3 +161,111 @@ macro_rules! kunit_assert_eq {
> >          $crate::kunit_assert!($name, $file, $diff, $left =3D=3D $right=
);
> >      }};
> >  }
> > +
> > +/// Represents an individual test case.
> > +///
> > +/// The test case should have the signature
> > +/// `unsafe extern "C" fn test_case(test: *mut crate::bindings::kunit)=
`.
> > +///
> > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated lis=
t of test cases.
> > +/// Use `kunit_case_null` to generate such a delimeter.
> > +const fn kunit_case(name: &kernel::str::CStr, run_case: unsafe extern =
"C" fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_case {
>
> This should probably say `name: &'static CStr` to require that the
> name lives forever.

Fixed in v3, thanks.

> > +/// Registers a KUnit test suite.
> > +///
> > +/// # Safety
> > +///
> > +/// `test_cases` must be a NULL terminated array of test cases.
> > +///
> > +/// # Examples
> > +///
> > +/// ```ignore
> > +/// unsafe extern "C" fn test_fn(_test: *mut crate::bindings::kunit) {
> > +///     let actual =3D 1 + 1;
> > +///     let expected =3D 2;
> > +///     assert_eq!(actual, expected);
> > +/// }
> > +///
> > +/// static mut KUNIT_TEST_CASE: crate::bindings::kunit_case =3D crate:=
:kunit_case(name, test_fn);
> > +/// static mut KUNIT_NULL_CASE: crate::bindings::kunit_case =3D crate:=
:kunit_case_null();
> > +/// static mut KUNIT_TEST_CASES: &mut[crate::bindings::kunit_case] =3D=
 unsafe {
> > +///     &mut[KUNIT_TEST_CASE, KUNIT_NULL_CASE]
> > +/// };
> > +/// crate::kunit_unsafe_test_suite!(suite_name, KUNIT_TEST_CASES);
> > +/// ```
> > +#[macro_export]
> > +macro_rules! kunit_unsafe_test_suite {
> > +    ($name:ident, $test_cases:ident) =3D> {
> > +        const _: () =3D {
> > +            static KUNIT_TEST_SUITE_NAME: [i8; 256] =3D {
> > +                let name_u8 =3D core::stringify!($name).as_bytes();
> > +                let mut ret =3D [0; 256];
> > +
> > +                let mut i =3D 0;
> > +                while i < name_u8.len() {
> > +                    ret[i] =3D name_u8[i] as i8;
> > +                    i +=3D 1;
> > +                }
>
> I assume the name must be zero-terminated? If so, you probably need to
> enforce that somehow, e.g. by failing if `name_u8` is longer than 255
> bytes.

Nice catch. I'm not sure how to nicely throw a compile time error in
this function, so I'm truncating it here and doing a compile error in
the macro in patch #2. This isn't ideal, but seems to work.

> > +
> > +            static mut KUNIT_TEST_SUITE: core::cell::UnsafeCell<$crate=
::bindings::kunit_suite> =3D
>
> You don't actually need UnsafeCell here since it's already `static mut`.
>

Thanks, this works.

> > +                core::cell::UnsafeCell::new($crate::bindings::kunit_su=
ite {
> > +                    name: KUNIT_TEST_SUITE_NAME,
> > +                    // SAFETY: User is expected to pass a correct `tes=
t_cases`, hence this macro
> > +                    // named 'unsafe'.
> > +                    test_cases: unsafe { $test_cases.as_mut_ptr() },
> > +                    suite_init: None,
> > +                    suite_exit: None,
> > +                    init: None,
> > +                    exit: None,
> > +                    attr: $crate::bindings::kunit_attributes {
> > +                        speed: $crate::bindings::kunit_speed_KUNIT_SPE=
ED_NORMAL,
> > +                    },
> > +                    status_comment: [0; 256usize],
> > +                    debugfs: core::ptr::null_mut(),
> > +                    log: core::ptr::null_mut(),
> > +                    suite_init_err: 0,
> > +                    is_init: false,
> > +                });
> > +
> > +            #[used]
> > +            #[link_section =3D ".kunit_test_suites"]
> > +            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings=
::kunit_suite =3D
> > +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> > +                unsafe { KUNIT_TEST_SUITE.get() };
>
> If you change `KUNIT_TEST_SUITE` to not be an UnsafeCell, then you'll
> want to do `core::ptr::addr_of_mut!(KUNIT_TEST_SUITE` instead.
>
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index b62451f64f6e..d662aa37070f 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -18,6 +18,7 @@
> >  #![feature(inline_const)]
> >  #![feature(lint_reasons)]
> >  #![feature(unsize)]
> > +#![feature(const_mut_refs)]
>
> Is this still needed with the above changes?
>

Yes, this seems to still be needed for the kunit_unsafe_test_suite!() macro=
.

Thanks,
-- David

--0000000000004bb46b0625aa9103
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
NjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjAeFw0xNDEyMTAwMDAw
MDBaFw0zNDEyMTAwMDAwMDBaMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMw
EQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMIICIjANBgkqhkiG9w0BAQEF
AAOCAg8AMIICCgKCAgEAlQfoc8pm+ewUyns89w0I8bRFCyyCtEjG61s8roO4QZIzFKRvf+kqzMaw
iGvFtonRxrL/FM5RFCHsSt0bWsbWh+5NOhUG7WRmC5KAykTec5RO86eJf094YwjIElBtQmYvTbl5
KE1SGooagLcZgQ5+xIq8ZEwhHENo1z08isWyZtWQmrcxBsW+4m0yBqYe+bnrqqO4v76CY1DQ8BiJ
3+QPefXqoh8q0nAue+e8k7ttU+JIfIwQBzj/ZrJ3YX7g6ow8qrSk9vOVShIHbf2MsonP0KBhd8hY
dLDUIzr3XTrKotudCd5dRC2Q8YHNV5L6frxQBGM032uTGL5rNrI55KwkNrfw77YcE1eTtt6y+OKF
t3OiuDWqRfLgnTahb1SK8XJWbi6IxVFCRBWU7qPFOJabTk5aC0fzBjZJdzC8cTflpuwhCHX85mEW
P3fV2ZGXhAps1AJNdMAU7f05+4PyXhShBLAL6f7uj+FuC7IIs2FmCWqxBjplllnA8DX9ydoojRoR
h3CBCqiadR2eOoYFAJ7bgNYl+dwFnidZTHY5W+r5paHYgw/R/98wEfmFzzNI9cptZBQselhP00sI
ScWVZBpjDnk99bOMylitnEJFeW4OhxlcVLFltr+Mm9wT6Q1vuC7cZ27JixG1hBSKABlwg3mRl5HU
Gie/Nx4yB9gUYzwoTK8CAwEAAaNjMGEwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFK5sBaOTE+Ki5+LXHNbH8H/IZ1OgMB8GA1UdIwQYMBaAFK5sBaOTE+Ki5+LXHNbH
8H/IZ1OgMA0GCSqGSIb3DQEBDAUAA4ICAQCDJe3o0f2VUs2ewASgkWnmXNCE3tytok/oR3jWZZip
W6g8h3wCitFutxZz5l/AVJjVdL7BzeIRka0jGD3d4XJElrSVXsB7jpl4FkMTVlezorM7tXfcQHKs
o+ubNT6xCCGh58RDN3kyvrXnnCxMvEMpmY4w06wh4OMd+tgHM3ZUACIquU0gLnBo2uVT/INc053y
/0QMRGby0uO9RgAabQK6JV2NoTFR3VRGHE3bmZbvGhwEXKYV73jgef5d2z6qTFX9mhWpb+Gm+99w
MOnD7kJG7cKTBYn6fWN7P9BxgXwA6JiuDng0wyX7rwqfIGvdOxOPEoziQRpIenOgd2nHtlx/gsge
/lgbKCuobK1ebcAF0nu364D+JTf+AptorEJdw+71zNzwUHXSNmmc5nsE324GabbeCglIWYfrexRg
emSqaUPvkcdM7BjdbO9TLYyZ4V7ycj7PVMi9Z+ykD0xF/9O5MCMHTI8Qv4aW2ZlatJlXHKTMuxWJ
U7osBQ/kxJ4ZsRg01Uyduu33H68klQR4qAO77oHl2l98i0qhkHQlp7M+S8gsVr3HyO844lyS8Hn3
nIS6dC1hASB+ftHyTwdZX4stQ1LrRgyU4fVmR3l31VRbH60kN8tFWk6gREjI2LCZxRWECfbWSUnA
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAGelarM5qf94BhVtLAhbngw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNDA4MTYxNzE0
MzRaFw0yNTAyMTIxNzE0MzRaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDmB/GGXDiVzbKWbgA5SjyZ6CD50vgxMo0F
hAx19m1M+rPwWXHnBeQM46pDxVnXoW2wXs1ZeN/FNzGVa5kaKl3TE42JJtKqv5Cg4LoHUUan/7OY
TZmFbxtRO6T4OQwJDN7aFiRRbv0DYFMvGBuWtGMBZTn5RQb+Wu8WtqJZUTIFCk0GwEQ5R8N6oI2v
2AEf3JWNnWr6OcgiivOGbbRdTL7WOS+i6k/I2PDdni1BRgUg6yCqmaSsh8D/RIwkoZU5T06sYGbs
dh/mueJA9CCHfBc/oGVa+fQ6ngNdkrs3uTXvtiMBA0Fmfc64kIy0hOEOOMY6CBOLbpSyxIMAXdet
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQg0JNybvi/Lz1SA05QBBeAQzZOjkNu
u1KAQ36oGzTYTmIwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDMwMDQ1OTMyWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAESelbegc2bMgcuUomECsi/FXTV9VYZ6SJe6zXeqkjgp6rAG
3QXvGuEdWucH7I03t3cmdx2bB26XTCnNkt0GZ9fVChV2Of+JNM5YkOrXplU8RD0RUGABasNXbGh9
3RcqaTm0eULXzri2r+s4HwlCrwM7rwEbpH9yCCNbRXFWZB3u5zBlvJA7r+I3JMy15G3Bxxs7hXvq
MDhL8Aa3jlSVaAVfxiIwpol1XWw42tD8J69w/YksbstAPv7LnLJpLsKKfZyxAeeLRHgNeAPGc/2/
BeH09Zze9Tb/ZBcgK8M+CgPZXC7i3D36ss05bnN2I6QPJkXVQZC2E8i9XCbBlxsROI0=
--0000000000004bb46b0625aa9103--

