Return-Path: <linux-kselftest+bounces-26710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD6EA36CB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 10:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3023AC6FA
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Feb 2025 09:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6A719F127;
	Sat, 15 Feb 2025 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ks19wzNI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3119D06A
	for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739610234; cv=none; b=U0XHVywHgjrImViogH1ispovvroE8dkHhLtNo1vbeKqfIeahY/hkE7sti/OkKn/ag/JQuzkuNwelIMTQ3zmqnrGN07RN3T0JvUbAUHe27hAQFsE+Bi65IYA3pGpSJxQeiPDXNyh+mlHyO018NK0T0w6zCV9+PkG7I6HUUwXefyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739610234; c=relaxed/simple;
	bh=qNeQjezwjOvRUWBSkl4Q+MELnILHRTRTpDLSfE8ParA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+5YsNJgfAYvusOH0RJEVsBtTxcxozDCFg+IPhVYRqTIhJPlyqrFhi9wRVELI1pE6PInyGbbiYr9O3RlcGWIPHElHEjMYwU+2/m20TC0kgiizpovpyJBYUvAFTeiuneZUkcyieNBe9C3RHfstK5t3CT0u/akySIlkVSS5xUPXfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ks19wzNI; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e65baef2edso22686896d6.2
        for <linux-kselftest@vger.kernel.org>; Sat, 15 Feb 2025 01:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739610231; x=1740215031; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0vMTn8K7qPuYwtfI5EHbl6ePkqGd9hm5RlqugImSeYw=;
        b=Ks19wzNIMo1mybsyYqSF2n/bhpvEAK0IhaApisXYnAQIeQpMPOguWv+AIr8azUlI7p
         yZW1s3XYIfb5iPaYD5gyl/xG4Zaiqjm3f+NNOCO1Q2ofPg64ta0IleDHJWRdotEnYc9t
         1PdXllIifYCasQ6bTUaaT0uFSgeuV1NPaNCVYGfGCB0WtjfZMxUYDL3mSMF+JJY4tWfy
         ziGGOTiEfBEtYw+xaRKIlZE9vtgDv0ZoHZ+wZREcTGNtu4VBnejlUYBTzvVtA6CCEckt
         Q0QGOH3cHUHkupKf+tzZ2EhPlFfs1eOxhGC/s+6S+SRdVHFgJAoKPksrn0ayskITIOmo
         1pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739610231; x=1740215031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vMTn8K7qPuYwtfI5EHbl6ePkqGd9hm5RlqugImSeYw=;
        b=FdQmVxgAiJFrliowIEow6eSYlT7RR6Rm0I/xCZZb7ytyWUq3xqJ8qus9N0asxb76hL
         6JsE6IfIC28E8Dft0kAibm6nDIMUXX885hl1GG8rCGU2dV/Nl6cDcmE6KlUbfcl8HqGm
         SddZCUJELVeKVS7QoDtKqEgW1TAsJsmWn++77M0z8AS1Ov7S52I7O13axEsQ/9gA57m4
         WUuG71dq7MwV/iacStacxZvhwX0Si/utKYXpFaNpqnQLl8ezFreXjWRsd9alGXcOwOxm
         D/t/1HKBLtovR8+p50igzRdwNzDroWAbXQM5tVsyXW6zoN8bZEqCF/qg15sW+20YRWFD
         RX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTDtMCu9mXnG+jx2RnAVd/ZqeWkwF6tycuk/Hl3IY8R1UbgFBM3fRPnx9gacOgBLirXX9MVMZFOlt8Bn3Xjas=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhl1AsFXYxylbyNfT/qJPi0fcbmPIjYJnPxrKou6uZJp5ft7e0
	aXeTcVVnCLfe7grcBxkzx+O/dRYIJEWmvrgmdkpM9Tz7UFOfCs1gtXK4w95Th2fcJLyRESY2H6C
	BKJxMUW1AxUMluhENf0OuaoTeTe4sYF2fAs7G
X-Gm-Gg: ASbGnctpAhSYkNHbShC+1pS0RK1CAipqfZxPiBqRTr4V2VnmLGJPXBqwe3xi5Qfleps
	QWZ0rOU1aJYdT7Tiv3UdlYYqnzrAHSczyMG4NoP8yesDuzXwZHfIQ1I4VDTOPDwlzz2j36bPfYA
	==
X-Google-Smtp-Source: AGHT+IGZft1pESiR5Xx5gNPkFz4ylkaQhVbUYxCmkQibJ7KNjyJCGsPfmhnL7fqpw/xrK2FSKvk/E5iFshI7ucxr+Rk=
X-Received: by 2002:a05:6214:c6c:b0:6e1:f40c:b558 with SMTP id
 6a1803df08f44-6e66cf420dfmr30638156d6.44.1739610230853; Sat, 15 Feb 2025
 01:03:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214074051.1619256-1-davidgow@google.com> <20250214074051.1619256-4-davidgow@google.com>
 <CAJ-ks9kwVz4sPdmqfTLVK-Z2C7WmXHpBhbe5_ozWBZnwxJ8HpA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kwVz4sPdmqfTLVK-Z2C7WmXHpBhbe5_ozWBZnwxJ8HpA@mail.gmail.com>
From: David Gow <davidgow@google.com>
Date: Sat, 15 Feb 2025 17:03:38 +0800
X-Gm-Features: AWEUYZlTbJrCodmwWDXU9bdBt9r--ax0J4ZH9F1SHGejTIFW3dnuthmFOKV03ls
Message-ID: <CABVgOS=2f3Yg8Wb7qxneRC_+s-W_TQey083niujpZD3fYcfL_w@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] rust: kunit: allow to know if we are in a test
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
	boundary="000000000000e4021e062e2a9144"

--000000000000e4021e062e2a9144
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 at 22:41, Tamir Duberstein <tamird@gmail.com> wrote:
>
> On Fri, Feb 14, 2025 at 2:42=E2=80=AFAM David Gow <davidgow@google.com> w=
rote:
> >
> > From: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> >
> > In some cases, we need to call test-only code from outside the test
> > case, for example, to mock a function or a module.
> >
> > In order to check whether we are in a test or not, we need to test if
> > `CONFIG_KUNIT` is set.
> > Unfortunately, we cannot rely only on this condition because:
> > - a test could be running in another thread,
> > - some distros compile KUnit in production kernels, so checking at runt=
ime
> >   that `current->kunit_test !=3D NULL` is required.
> >
> > Forturately, KUnit provides an optimised check in
> > `kunit_get_current_test()`, which checks CONFIG_KUNIT, a global static
> > key, and then the current thread's running KUnit test.
> >
> > Add a safe wrapper function around this to know whether or not we are i=
n
> > a KUnit test and examples showing how to mock a function and a module.
> >
> > Signed-off-by: Jos=C3=A9 Exp=C3=B3sito <jose.exposito89@gmail.com>
> > Co-developed-by: David Gow <davidgow@google.com>
> > Signed-off-by: David Gow <davidgow@google.com>
> > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > ---
> >
> > Changes since v5:
> > https://lore.kernel.org/all/20241213081035.2069066-4-davidgow@google.co=
m/
> > - Greatly improved documentation, which is both clearer and better
> >   matches the rustdoc norm. (Thanks, Miguel)
> > - The examples and safety comments are also both more idiomatic an
> >   cleaner. (Thanks, Miguel)
> > - More things sit appropriately behind CONFIG_KUNIT (Thanks, Miguel)
> >
> > Changes since v4:
> > https://lore.kernel.org/linux-kselftest/20241101064505.3820737-4-davidg=
ow@google.com/
> > - Rebased against 6.13-rc1
> > - Fix some missing safety comments, and remove some unneeded 'unsafe'
> >   blocks. (Thanks Boqun)
> >
> > Changes since v3:
> > https://lore.kernel.org/linux-kselftest/20241030045719.3085147-8-davidg=
ow@google.com/
> > - The example test has been updated to no longer use assert_eq!() with
> >   a constant bool argument (fixes a clippy warning).
> >
> > No changes since v2:
> > https://lore.kernel.org/linux-kselftest/20241029092422.2884505-4-davidg=
ow@google.com/
> >
> > Changes since v1:
> > https://lore.kernel.org/lkml/20230720-rustbind-v1-3-c80db349e3b5@google=
.com/
> > - Rebased on top of rust-next.
> > - Use the `kunit_get_current_test()` C function, which wasn't previousl=
y
> >   available, instead of rolling our own.
> > - (Thanks also to Boqun for suggesting a nicer way of implementing this=
,
> >   which I tried, but the `kunit_get_current_test()` version obsoleted.)
> > ---
> >  rust/kernel/kunit.rs | 66 ++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> > index 9e27b74a605b..3aad7a281b6d 100644
> > --- a/rust/kernel/kunit.rs
> > +++ b/rust/kernel/kunit.rs
> > @@ -286,11 +286,77 @@ macro_rules! kunit_unsafe_test_suite {
> >      };
> >  }
> >
> > +/// Returns whether we are currently running a KUnit test.
> > +///
> > +/// In some cases, you need to call test-only code from outside the te=
st case, for example, to
> > +/// create a function mock. This function allows to change behavior de=
pending on whether we are
> > +/// currently running a KUnit test or not.
> > +///
> > +/// # Examples
> > +///
> > +/// This example shows how a function can be mocked to return a well-k=
nown value while testing:
> > +///
> > +/// ```
> > +/// # use kernel::kunit::in_kunit_test;
> > +/// fn fn_mock_example(n: i32) -> i32 {
> > +///     if in_kunit_test() {
> > +///         return 100;
> > +///     }
> > +///
> > +///     n + 1
> > +/// }
> > +///
> > +/// let mock_res =3D fn_mock_example(5);
> > +/// assert_eq!(mock_res, 100);
> > +/// ```
> > +///
> > +/// Sometimes, you don't control the code that needs to be mocked. Thi=
s example shows how the
> > +/// `bindings` module can be mocked:
>
> [`bindings`] here, please. There are two more instances below but
> those aren't doc comments, so I don't think bracketing them will do
> anything.
>

Done in v7. Alas, I'll have to keep getting used to the differences
between kerneldoc and rustdoc...

> > +///
> > +/// ```
> > +/// // Import our mock naming it as the real module.
> > +/// #[cfg(CONFIG_KUNIT)]
> > +/// use bindings_mock_example as bindings;
> > +/// #[cfg(not(CONFIG_KUNIT))]
> > +/// use kernel::bindings;
> > +///
> > +/// // This module mocks `bindings`.
> > +/// #[cfg(CONFIG_KUNIT)]
> > +/// mod bindings_mock_example {
> > +///     /// Mock `ktime_get_boot_fast_ns` to return a well-known value=
 when running a KUnit test.
> > +///     pub(crate) fn ktime_get_boot_fast_ns() -> u64 {
> > +///         1234
> > +///     }
> > +/// }
> > +///
> > +/// // This is the function we want to test. Since `bindings` has been=
 mocked, we can use its
> > +/// // functions seamlessly.
> > +/// fn get_boot_ns() -> u64 {
> > +///     // SAFETY: `ktime_get_boot_fast_ns()` is always safe to call.
> > +///     unsafe { bindings::ktime_get_boot_fast_ns() }
> > +/// }
> > +///
> > +/// let time =3D get_boot_ns();
> > +/// assert_eq!(time, 1234);
> > +/// ```
>
> Isn't this swapping out the bindings module at compile time, and for
> the whole build? In other words cfg(CONFIG_KUNIT) will apply to all
> code, both test and non-test.
>

I believe so, so this is probably something best done only in test files.

Ideally, we'd have support for something like the KUnit function
mocking features here, but that's horribly C-specific at the moment.

> > +pub fn in_kunit_test() -> bool {
> > +    // SAFETY: `kunit_get_current_test()` is always safe to call (it h=
as fallbacks for
> > +    // when KUnit is not enabled).
> > +    unsafe { !bindings::kunit_get_current_test().is_null() }
>
> Nit if you care about reducing unsafe blocks:
>
> !unsafe { bindings::kunit_get_current_test() }.is_null()
>
>

Huh, I thought this wouldn't work, but it's working fine for me here,
so I've made the change.

Thanks!

> > +}
> > +
> >  #[kunit_tests(rust_kernel_kunit)]
> >  mod tests {
> > +    use super::*;
> > +
> >      #[test]
> >      fn rust_test_kunit_example_test() {
> >          #![expect(clippy::eq_op)]
> >          assert_eq!(1 + 1, 2);
> >      }
> > +
> > +    #[test]
> > +    fn rust_test_kunit_in_kunit_test() {
> > +        assert!(in_kunit_test());
> > +    }
> >  }
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
> >

Thanks a lot, these should be fixed in v7.

Cheers,
-- David

--000000000000e4021e062e2a9144
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
pjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgRBCAqRfxSKU6bK62E81GKnmETUSr
HVKQoOmQSqbdATQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
MjE1MDkwMzUxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBACqBwIWceVCuOYEEKyOI0/gHYGjWTSfO7Vo/1K3TVucHXt1A
fmER+dl5GXjjPjsStaoTrBaHSBOW+ThR373yligvQ235rRvM4SrKGEdBC1wciYW2/L/nlKb6ORWM
/Q+YHsuKgtsmkYRdZHohzYptWoAKGkYzbZbrACJlGF4XL9P6UE5CtszzjycKq2Yj4P2VpvHMlZyf
WW1C9VCbcwlmsOHe0bkxVAnx8QxqeIulFz7/KZ93wqS5PdseF6fsTxa0uhos4Ho5kRX2TUo5yS1R
Seu5nxaT1wfk2qX+i0AlVkV+RGuN7Fmnx64PJx//qwwoUZDie/YyCStXQW3mV98YfdQ=
--000000000000e4021e062e2a9144--

