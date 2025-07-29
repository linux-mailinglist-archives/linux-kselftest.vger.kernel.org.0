Return-Path: <linux-kselftest+bounces-38047-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E44B14834
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 08:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7073BDED6
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Jul 2025 06:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B125A2AA;
	Tue, 29 Jul 2025 06:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMt6TjM1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C724A043
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 06:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770490; cv=none; b=c6Z0rxkeW2rdWNcwK3bT81JZwiyeYRH6JPcTcUhTd9IhG07n/k/J77mDn9cSk7t9rS/BePX4a630v2EaWdICRwD5uGS9zM7FGFcBK5hDdHeqkvnYqSUO2As1wNPt74inkikqwvFkkL5c1DVNVclZkUvu+wjIsN1/UhrzSMCY4PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770490; c=relaxed/simple;
	bh=KrDfmVaJGJe42cKJmRTIK/ZWbWJp2O3JTl7gf3dJRKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lT9mNMfCV2HnMVKQ7IipYXZY4KRleT0HWMRrQ2hBcC9Dasm52hIPmBDnxzve04zXIXGTbNQv60tvr1pP2a0QsjUJsyspMfENQyzfwls9+GFWjowWh4vLcx19SD//G99P5GJ6DEMOQoRyPFu0YSqwOeIhLPhKqXnDaAGsPI13NL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMt6TjM1; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6facf4d8e9eso33984366d6.1
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Jul 2025 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753770486; x=1754375286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TCEOykxdvL8Cm8WObRtPSYTMwm5knYQsMLD8k4gk1xk=;
        b=hMt6TjM1lWjcvS8+J/f9wcf9cqbuG7MN1xHhR0PVWYGinG5NnXtKEt1ibz1e/9VSUS
         BUBkCsQMKCmPlnABGgkaWJPFxSONJYcf9k0HM5UOXLZe4U7HOjR75Q8/ZQ5yJ4FxvBX0
         V915bH7wEBpZ/v/n1rK1ZJDfFclaop4vDlCzgvCkPbl8qpX3Qzrn3zb6P1I4yRKEtAtA
         DJ0hDoRwakl2YQBR1j4cHPoDHo/dIk3yR2D6bUTPIcz3nWdm5UjIym93D5OkV0QIfYdg
         Y/Yh9mBJd1k5YpiQpr6igYiLwpGyuGKVqHqdGJXvFcaYUsEZFSKXeYespsn4XccWkaFS
         yMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753770486; x=1754375286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCEOykxdvL8Cm8WObRtPSYTMwm5knYQsMLD8k4gk1xk=;
        b=RqkbhDncvfoWInyDMVCxWsETwBviphsyfJHjQMvqTA1NLu2VvrEt6SmJPVOjghIlIv
         bNIhiLufeyW3SMgczc7t0SsAy1cK92YNB5HJO0aOeNPuMrmwHKZKIN3lklNVU0RGVwzN
         2SdZCo+f4NIstACYhGnLu0UghI0I0UqP6c2FrPXi5ofvwLlntmhgUl6HpBJYPhai5eEZ
         B3rH3Os7nHoQi98eMX2FjJlvp2PKRr+nyyaMyHvkHVDFwobyOKFXyAqL7HjOLfKJAJmq
         Qj5qkZnaiz4mpgoKSdnPBDU1COIJiXwudWZiUKtKVLTjvLkcwPUHZaaXGYb1X2dFrwSD
         rcsw==
X-Forwarded-Encrypted: i=1; AJvYcCVwVNbs7y5a2qcbEY+0Msr3FZiVwQP1Q9FpYdukCufADNZePoWAuqKXapYQQVuAI4nf+38u66XYGSz96hw9EBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQY9gA/iyjAAAnF0Nvu7h3mJVGRLbw5vV4UcERZI7hMR/9RHDR
	EUWUBpgNEX1RWyCyJdsqx7LEj6OZl0Pzjw2RXZLnzWNNkEQK5j40vCqONnGwynqyuUMQr4hjMru
	ND9yhjNpqf50tgAZJTn3oxLjidNCA6GX7bt2pxx/X
X-Gm-Gg: ASbGncsyAyKfRB+qjkKu46Tj0LaZsmprkCgJLKe47QC3MoZLNd15e9x8OufA6xgjpD6
	L4W/H96v6MiArrY3aFhAqIoUpacFinzL+1i0pqct3VxNT2fHAl6lp8WvAodpnBKQcymb8Xzj9vy
	AGxHlPmDZoeIs0FQC6oFck5fNP0BQSlu6HdMILgAYX6ghuAi63QZSam8ipD6m6+2lQqhVK7xAli
	+lkwxUh
X-Google-Smtp-Source: AGHT+IHkDhVjlDXkKoJPb/zHwvWemtrgFQf/cvbjZ0Qeqopxn8IxnwgPvo9tYHg/4/LMrdSDc8NIhSduX3ei955YgTQ=
X-Received: by 2002:a05:6214:3901:b0:707:23ea:2991 with SMTP id
 6a1803df08f44-70723ea2b8bmr212058476d6.35.1753770485569; Mon, 28 Jul 2025
 23:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250726180750.2735836-1-ojeda@kernel.org>
In-Reply-To: <20250726180750.2735836-1-ojeda@kernel.org>
From: David Gow <davidgow@google.com>
Date: Tue, 29 Jul 2025 14:27:53 +0800
X-Gm-Features: Ac12FXyeK1EodX0LEMaLg05WtgxULgHDYJkotq5O5IK4MGpaLU1MSLHZ5XzohVI
Message-ID: <CABVgOS=BPZYrJ8NLbVHj4S5CBpPd3xovBFCn8rhZmSuYq0rWSQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: remove support for unused host `#[test]`s
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Masahiro Yamada <masahiroy@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000dc5acf063b0b8201"

--000000000000dc5acf063b0b8201
Content-Type: text/plain; charset="UTF-8"

On Sun, 27 Jul 2025 at 02:08, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Since commit 028df914e546 ("rust: str: convert `rusttest` tests into
> KUnit"), we do not have anymore host `#[test]`s that run in the host.
>
> Moreover, we do not plan to add any new ones -- tests should generally
> run within KUnit, since there they are built the same way the kernel
> does. While we may want to have some way to define tests that can also
> be run outside the kernel, we still want to test within the kernel too
> [1], and thus would likely use a custom syntax anyway to define them.
>
> Thus simplify the `rusttest` target by removing support for host
> `#[test]`s for the `kernel` crate.
>
> This still maintains the support for the `macros` crate, even though we
> do not have any such tests there.
>
> Link: https://lore.kernel.org/rust-for-linux/CABVgOS=AKHSfifp0S68K3jgNZAkALBr=7iFb=niryG5WDxjSrg@mail.gmail.com/ [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

With my (biased) KUnit hat on, this looks good to me.

_Maybe_ it's worth updating Documentation/rust/testing.rst, though it
already says these are "mostly used for testing the macros crate's
examples".

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  rust/Makefile        | 9 +--------
>  rust/kernel/alloc.rs | 6 +++---
>  rust/kernel/error.rs | 4 ++--
>  rust/kernel/lib.rs   | 2 +-
>  4 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 115b63b7d1e3..5290b37868dd 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -235,7 +235,7 @@ quiet_cmd_rustc_test = $(RUSTC_OR_CLIPPY_QUIET) T  $<
>         $(objtree)/$(obj)/test/$(subst rusttest-,,$@) $(rust_test_quiet) \
>                 $(rustc_test_run_flags)
>
> -rusttest: rusttest-macros rusttest-kernel
> +rusttest: rusttest-macros
>
>  rusttest-macros: private rustc_target_flags = --extern proc_macro \
>         --extern macros --extern kernel --extern pin_init
> @@ -245,13 +245,6 @@ rusttest-macros: $(src)/macros/lib.rs \
>         +$(call if_changed,rustc_test)
>         +$(call if_changed,rustdoc_test)
>
> -rusttest-kernel: private rustc_target_flags = --extern ffi --extern pin_init \
> -    --extern build_error --extern macros --extern bindings --extern uapi
> -rusttest-kernel: $(src)/kernel/lib.rs rusttestlib-ffi rusttestlib-kernel \
> -    rusttestlib-build_error rusttestlib-macros rusttestlib-bindings \
> -    rusttestlib-uapi rusttestlib-pin_init FORCE
> -       +$(call if_changed,rustc_test)
> -
>  ifdef CONFIG_CC_IS_CLANG
>  bindgen_c_flags = $(c_flags)
>  else
> diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
> index a2c49e5494d3..335ae3271fa8 100644
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -2,16 +2,16 @@
>
>  //! Implementation of the kernel's memory allocation infrastructure.
>
> -#[cfg(not(any(test, testlib)))]
> +#[cfg(not(testlib))]
>  pub mod allocator;
>  pub mod kbox;
>  pub mod kvec;
>  pub mod layout;
>
> -#[cfg(any(test, testlib))]
> +#[cfg(testlib)]
>  pub mod allocator_test;
>
> -#[cfg(any(test, testlib))]
> +#[cfg(testlib)]
>  pub use self::allocator_test as allocator;
>
>  pub use self::kbox::Box;
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 3dee3139fcd4..7812aca1b6ef 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -157,7 +157,7 @@ pub fn to_ptr<T>(self) -> *mut T {
>      }
>
>      /// Returns a string representing the error, if one exists.
> -    #[cfg(not(any(test, testlib)))]
> +    #[cfg(not(testlib))]
>      pub fn name(&self) -> Option<&'static CStr> {
>          // SAFETY: Just an FFI call, there are no extra safety requirements.
>          let ptr = unsafe { bindings::errname(-self.0.get()) };
> @@ -174,7 +174,7 @@ pub fn name(&self) -> Option<&'static CStr> {
>      /// When `testlib` is configured, this always returns `None` to avoid the dependency on a
>      /// kernel function so that tests that use this (e.g., by calling [`Result::unwrap`]) can still
>      /// run in userspace.
> -    #[cfg(any(test, testlib))]
> +    #[cfg(testlib)]
>      pub fn name(&self) -> Option<&'static CStr> {
>          None
>      }
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e13d6ed88fa6..8a0153f61732 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -197,7 +197,7 @@ pub const fn as_ptr(&self) -> *mut bindings::module {
>      }
>  }
>
> -#[cfg(not(any(testlib, test)))]
> +#[cfg(not(testlib))]
>  #[panic_handler]
>  fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>      pr_emerg!("{}\n", info);
>
> base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
> --
> 2.50.1
>

--000000000000dc5acf063b0b8201
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUnQYJKoZIhvcNAQcCoIIUjjCCFIoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
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
ZbjmGnFuoKjxguhFPmzWAtcKZ4MFWsmkEDCCBeQwggPMoAMCAQICEAFFwOy5zrkc9g75Fk3jHNEw
DQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
KjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMzAeFw0yNTA2MDEwODEx
MTdaFw0yNTExMjgwODExMTdaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5jb20w
ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqxNhYGgWa19wqmZKM9x36vX1Yeody+Yaf
r0MV27/mVFHsaMmnN5CpyyGgxplvPa4qPwrBj+5kp3o7syLcqCX0s8cUb24uZ/k1hPhDdkkLbb9+
2Tplkji3loSQxuBhbxlMC75AhqT+sDo8iEX7F4BZW76cQBvDLyRr/7VG5BrviT5zFsfi0N62WlXj
XMaUjt0G6uloszFPOWkl6GBRRVOwgLAcggqUjKiLjFGcQB5GuyDPFPyTR0uQvg8zwSOph7TNTb/F
jyics8WBCAj6iSmMX96uJ3Q7sdtW3TWUVDkHXB3Mk+9E2P2mRw3mS5q0VhNLQpFrox4/gXbgvsji
jmkLAgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFBp5bTxrTm/d
WMmRETO8lNkA4c7fMFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBF
tO3/N2l9hTaij/K0xCpLwIlrqpNo0nMAvvG5LPQQjSeHnTh06tWTgsPCOJ65GX+bqWRDwGTu8WTq
c5ihCNOikBs25j82yeLkfdbeN/tzRGUb2RD+8n9I3CnyMSG49U2s0ZdncsrIVFh47KW2TpHTF7R8
N1dri01wPg8hw4u0+XoczR2TiBrBOISKmAlkAi+P9ivT31gSHdbopoL4x0V2Ow9IOp0chrQQUZtP
KBytLhzUzd9wIsE0QMNDbw6jeG8+a4sd17zpXSbBywIGw7sEvPtnBjMaf5ib3kznlOne6tuDVx4y
QFExTCSrP3OTMUkNbpIdgzg2CHQ2aB8i8YsTZ8Q8Q8ztPJ+xDNsqBUeYxILLjTjxQQovToqipB3f
6IMyk+lWCdDS+iCLYZULV1BTHSdwp1NM3t4jZ8TMlV+JzAyRqz4lzSl8ptkFhKBJ7w2tDrZ3BEXB
8ASUByRxeh+pC1Z5/HhqfiWMVPjaWmlRRJVlRk+ObKIv2CblwxMYlo2Mn8rrbEDyfum1RTMW55Z6
Vumvw5QTHe29TYxSiusovM6OD5y0I+4zaIaYDx/AtF0mMOFXb1MDyynf1CDxhtkgnrBUseHSOU2e
MYs7IqzRap5xsgpJS+t7cp/P8fdlCNvsXss9zZa279tKwaxR0U2IzGxRGsWKGxDysn1HT6pqMDGC
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAUXA7LnOuRz2DvkWTeMc
0TANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg3qTPfxcg0yB9ntH92dWAvRNT4uHM
wLSwI1soKRthdIMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NzI5MDYyODA2WjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAf38aLZVLVJFVzEME1SrJpA+ZsfC3zUZzd9ws/CHRcW+4584m1wP3XUwAtnWqqRKJ
M1R0yXhN2NuK8aGLc39shI/Ljh3PAo6eGo7cw6WqzJMCAfhZf76xGKHYELrZvj6qYU+pXS19nH4V
7MEFP3btpW2++W6I1jn63IIKCexYtaFc6ijpnAse+8ZbRurTkFXMnfVUnd+oGLsdV02seI/gNEt6
vaToxywysGsnVbhmfrMc4BWxFmocOsdwsTNu53j52U4etsmBIp1npO3V7Oy7YiadiulLXrUM/eYa
hOVOPvwEumWSrxECB0zLJPptFhtQGuWE23jwyGxwf0LzCZtQ/w==
--000000000000dc5acf063b0b8201--

