Return-Path: <linux-kselftest+bounces-21720-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C24F9C2B3E
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 09:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFA0B21F09
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 08:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D436D13E043;
	Sat,  9 Nov 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5TAfaDl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F313D53A
	for <linux-kselftest@vger.kernel.org>; Sat,  9 Nov 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731140325; cv=none; b=uM+v8WS8Yqc47AT6zscyEsvgQUbQjKENoG4r7I1tomwaU9x+NB7Lb2SVWXRrsKQ7T7SwhXDVYsek0noMNDgLl6hSYyDpyZ23nVjeIUS/rdOer5X1Fo1tJbkweHK9TlpEJRQZ8XdYOJDAQDepemgSbOpJdKZHboB8wJz1TZK/sCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731140325; c=relaxed/simple;
	bh=EoTt6c6SduuWyCva0kRKYiuWXQUdfqyytdgmaP0VYIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BI/IhxM7/JaJzBUa2OKB0vbB+ibLh6tShYZUGIHPAXAhjMfbGhLQw7EazNtYwtQTyb1UUgdqUvVuVnT2ZJQ/KNnVW5dQ6dNvvhwArPt4g4sHlmSYShXtqFUwTpprAjr9vDZGbU3JIhjaOxUQJNS9//G3QTixt7gao9EGKHoARtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5TAfaDl; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b15416303aso190369185a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Nov 2024 00:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731140323; x=1731745123; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXifjQfWxbD1brHQo24cBjIZUNqeqj0sp2tDzlNrjz8=;
        b=Y5TAfaDllTlJfhT7ztOHs1/gOfB5IA8nj8uCl8x66Co08QpQXCfmKY/P3l8F/S9wgH
         DjJffEhEfn3XXIWQ+dKRFbkwGaHpLGsCq9L4VcaCyqFFllHFafnxrY4EMjZ33epuCk2i
         RZViD2Muiwf4Ypbg/X++ldGdvuFTiY6Y2QEjU2lzrt4/4iD/YXuRjDL+DFq+kLdkyX6e
         U3buLwf6MvC2rFzcN/Z5+YuQ3DkmaGMuQw3Jq6RUWjICBoJWDFuK6EQONt/5fbvo77Oo
         Mrij8pFKbxsmbu3ijRQrp6+ipZ+YOAj1Bc4jpCFIHf4cKB+5w/MmKviRR+SWJ5WO7j9s
         +tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731140323; x=1731745123;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXifjQfWxbD1brHQo24cBjIZUNqeqj0sp2tDzlNrjz8=;
        b=MWz9p9k+MZReHIfJCIHSOpFKoogjd9ce+gJLh6ovqh/n2nNDyNumteZQX3TZNA0K6S
         8eoe25C1cjS4t05JZY/4oTiE2/Jv0F/PS/uYf/9Jq4P9Oq1lDFzsjqbmSnwNUcmIl+GT
         uuFCwcRHyh1bTg9KjMf2+uo2GlDx/4IFJBoAECbcpeR4N+z6UgMmucDM40xkFhgCBIHt
         9Q3Xm/9vtHGZWUe3fZ9oGJTTttxQQzBBVvGMqQEz/Vc5/zjkBT2dJmie97VbPlWyiJv3
         sTnX39KmX1KYEM0dmr+bq6aJfioLbsRt8cp9AT3ihtOZHRhYkZo35hJjV+fe+gH/HzW4
         WpCw==
X-Forwarded-Encrypted: i=1; AJvYcCURwbu87fRtaaXCgLHWTzTM3+KWBsja1FNfF+DjnnFIRN8CCHqNB6HrwF5V7bDmeB/LXnWf+X6lBuJaBlcaaOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHFkrcTrvsNGJJGdhxUs4YdLJBD9IwOjLTpa0FB25v9jLQt+18
	RSxNcEcQo0Dngq8YecRbBvIdvgl7ezTIjMASMBdu0ofc4u0Aih1Q40ubiHl5y3mYJXf/AcPHRf3
	Aia/EXGhTKMm9SkZ1Q0iPXHjMd82KWl6PJru0
X-Google-Smtp-Source: AGHT+IGlekRWmioZ7Ds1670XPM49xspw72/W1vNO2dK8ZpyRZfp3fiEkDXIpYIY+1uKn/dJdYhYDQp6tVGCgGwsIHJ0=
X-Received: by 2002:a05:6214:328d:b0:6cc:378f:f7fb with SMTP id
 6a1803df08f44-6d39e1a5e82mr66951016d6.35.1731140322644; Sat, 09 Nov 2024
 00:18:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101064505.3820737-1-davidgow@google.com> <20241101064505.3820737-2-davidgow@google.com>
 <ZyUUGNywoADngOwM@Boquns-Mac-mini.local>
In-Reply-To: <ZyUUGNywoADngOwM@Boquns-Mac-mini.local>
From: David Gow <davidgow@google.com>
Date: Sat, 9 Nov 2024 16:18:28 +0800
Message-ID: <CABVgOSmAj0hwVF0cKmzK_wS96Q4hgbe0t5L2dHFpcZpqrHev4Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] rust: kunit: add KUnit case and suite macros
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Benno Lossin <benno.lossin@proton.me>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Matt Gilbride <mattgilbride@google.com>, 
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000048e5f062676841f"

--000000000000048e5f062676841f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2 Nov 2024 at 01:47, Boqun Feng <boqun.feng@gmail.com> wrote:
>
> On Fri, Nov 01, 2024 at 02:45:00PM +0800, David Gow wrote:
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
> >  rust/kernel/kunit.rs | 112 +++++++++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs   |   1 +
> >  2 files changed, 113 insertions(+)
> >
> > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > index 824da0e9738a..85bc1faff0d5 100644
> > --- a/rust/kernel/kunit.rs
> > +++ b/rust/kernel/kunit.rs
> > @@ -161,3 +161,115 @@ macro_rules! kunit_assert_eq {
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
> > +const fn kunit_case(name: &'static kernel::str::CStr, run_case: unsafe=
 extern "C" fn(*mut kernel::bindings::kunit)) -> kernel::bindings::kunit_ca=
se {
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
> > +    }
> > +}
> > +
> > +/// Represents the NULL test case delimiter.
> > +///
> > +/// The `kunit_unsafe_test_suite!` macro expects a NULL-terminated lis=
t of test cases. This
> > +/// function retuns such a delimiter.
> > +const fn kunit_case_null() -> kernel::bindings::kunit_case {
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
> > +
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
> > +                if name_u8.len() > 255 {
> > +                    panic!(concat!("The test suite name `", core::stri=
ngify!($name), "` exceeds the maximum length of 255 bytes."));
> > +                }
> > +
> > +                let mut i =3D 0;
> > +                while i < name_u8.len() {
> > +                    ret[i] =3D name_u8[i] as i8;
> > +                    i +=3D 1;
> > +                }
> > +
> > +                ret
> > +            };
> > +
> > +            static mut KUNIT_TEST_SUITE: $crate::bindings::kunit_suite=
 =3D
> > +                $crate::bindings::kunit_suite {
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
> > +                };
> > +
> > +            #[used]
> > +            #[link_section =3D ".kunit_test_suites"]
> > +            static mut KUNIT_TEST_SUITE_ENTRY: *const $crate::bindings=
::kunit_suite =3D
> > +                // SAFETY: `KUNIT_TEST_SUITE` is static.
> > +                unsafe { core::ptr::addr_of_mut!(KUNIT_TEST_SUITE) };
>
> FYI, `addr_of` and `addr_of_mut` is safe now on statics since 1.82:
>
>         https://blog.rust-lang.org/2024/10/17/Rust-1.82.0.html#safely-add=
ressing-unsafe-statics
>
> We need a `#[allow(unused_unsafe)]` here to avoid the unused unsafe
> warning.
>

I've not been able to work out how to fix this: adding
"#![allow(unused_unsafe)]" to the unsafe block here triggers another
error:
ERROR:root:error[E0658]: attributes on expressions are experimental

Is there somewhere else we can put the attribute to support this
without having to either disable the warning, or use the experimental
feature globally?

-- David

--000000000000048e5f062676841f
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
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgJ/zGCKhzhMvsp7s0g+mzxa/8ZPoi
dyqGpmcBzCqZgl8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MTA5MDgxODQzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBACv1802ZWqgMcV8lnVygkGVWr8y1l1u9CkJOAk8FO40rkEJl
M/6wsGVZBxWYQWRnZm38ZK1c1sYoulq5+utSi+hNd9C/6iXJhyPLsASub8eN/82mIaYspnSrk1dk
GIRJQi4Gq4nxn+oX7R5sJDFC4v0xbyILTuZIC0aCsTXQqFyPveXEHMKnSK1RTaexQuyg1GTPhYNa
dAe/daBwTM+N3UXdrAGgw3euMQXCnIkMVaw7i49GaYRgZs3kaozc5n+uWPLePUAgpAK119Vw9JZ2
S8oQU6FSFcQ+ui5HwiBpqCDQoDU4N5AT4MTX+i5UZmoQvfKK30D8rYyvPtcnjGulcfU=
--000000000000048e5f062676841f--

