Return-Path: <linux-kselftest+bounces-32306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0FBAA8BF2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA79D7A4776
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 06:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0B1B9831;
	Mon,  5 May 2025 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IuYmISe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733F15574E
	for <linux-kselftest@vger.kernel.org>; Mon,  5 May 2025 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746424953; cv=none; b=Mf0VnS9usSMRlf0IyraqE4l9RtTjS8/umr/Ii0a57zO7xs0gqHN7syOcrCdUeLbautPzt93mbP9zi17nwNOrljBLV8mmBIZodsNFUXKuPGCOhF+hASDvozgWQiLhh7+eIY8I9uCI582O5Vfh3EFGF61FiqHi/8fbY+DBwBGJOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746424953; c=relaxed/simple;
	bh=SrPbUSeJaORKtk8VV5bME4cdpKB5b+XWC+3ARekPs0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul0TWvtI45ghynRXktlQ+9djjD7Ymxml8YxdsJacpXxwldAm7dU7CUYz13Fo6oauN+Z+2aSWmFGvUfN+d1vF0j11i5WbpM0yYMhttcXwzWqJpX6y1R/xSNWZC7cHiihHFKXlGmwrIfsCErASR29uZFJ//dJ1HLzdEcaH5OKst1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IuYmISe6; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6e8fc176825so38760916d6.0
        for <linux-kselftest@vger.kernel.org>; Sun, 04 May 2025 23:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746424950; x=1747029750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3N+iHsFiorFPRE3Yk4zo+9tVCJrPGX+pa9zxnKvMmRI=;
        b=IuYmISe6BFVVm/DKNrU93ivWgTMYjU9HX/r2OUbS0OsD2G65Wynum0ZChBiVPkUtpd
         V8Z/qWyixp9akCogfDnI1PaqhDDtutUo2dFPEbzlvHkz8A5pMdqWqJ+aCfOtrH646CzM
         m8w24GfC6NyfQHXVfHFTHioa8fgN788ggB2ciW4ZhOrayefDxERt6/HnK23it4Zcvwi3
         chqsGpOb2r3mjigZoO0ugpYltdlw0I4LFajAOdoYH6KWGkcFaxcRAV8+sevJ+gIwKfKx
         gW3+te0LxVGfYISZ7BzYLnTm0ro8KhqIe5F5xaesqZmD4YfVXsSSXXFVYyvEckpKkDqp
         Mnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746424950; x=1747029750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N+iHsFiorFPRE3Yk4zo+9tVCJrPGX+pa9zxnKvMmRI=;
        b=IBb1n6p4hIxsrKqXABFOhpofBAzyFfgHQOf/46hxgma1+Hw5NkAV1mJGO2eyGMpqa5
         +pVObdiDRTm2d4Jpf5kkuRmnWCBvLAGqfalKxquEmZuBlGDICPDh7RFAfeUmGo3YP1s1
         yYHdWkNRbvm/UBLFe4Chf1S3dHIFdK16FRAwPyYrIrLFS2sY+obytwrE8JQuqgJAFV8B
         Or9bu5qCD36BGqA8cOOtwP5Yup069vvtEJdz9v5L1CzXdZNiVhNHtQ5yXxkvXPFmuS5m
         sWiRpwfRf63f+69Am3eEUbK3CnGp1uPDWbvcolL0SQDigZe8OLSaECXjp/Rnfk4AgiaX
         ED6w==
X-Forwarded-Encrypted: i=1; AJvYcCVZ8Of/ExhLzjoI57xAIGl4rV7abWOaLvGgQJIS4dSUtkd9tW6KM6Zp3eWL316/j0nEK4Xm5rdfLT3+ABgWiUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj9DE5zgPbriz+XusS1H4T1CupP524SZJEtxaXrVLH4J6spfwL
	aGFfjonUSuGsDTw/MpXqIvYze66pWjOSRmGkVk5u7BDnEZy0hz87XLGvI+1hIG3pChmSGQZpgMV
	D0Lx9TOwhy1S8TtY65hEGAnHA9h0a8j33n68V
X-Gm-Gg: ASbGncugLIJHdPTRmQwCjBcHuzvle9+mfU5YY5hX2LY/qyzNSx/6miHyeYCqdvnvj6z
	89Cu43gcYpijD7W/Gpk9I7kmWuYyWa26bU+ymcnSrrFpcDVRa17W533rkOJriCmRt71jlbcLKqw
	aC5pV4tIO/mjhrPnT1LPSMasg=
X-Google-Smtp-Source: AGHT+IE1jvV5zyoDQV6U8eJw4nA3aGdNUsdl8m1aIfk+yYb28903AQoLHqt9OrvhB+SmObJpSWzkav4YzK3p/GNjbPw=
X-Received: by 2002:a05:6214:40e:b0:6f5:e2b:98a3 with SMTP id
 6a1803df08f44-6f51578d484mr226285866d6.25.1746424950430; Sun, 04 May 2025
 23:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-4-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-4-ojeda@kernel.org>
From: David Gow <davidgow@google.com>
Date: Mon, 5 May 2025 14:02:18 +0800
X-Gm-Features: ATxdqUGk-208LuwU83pB8PjZACgO3m0UULik7N9jS6i3J2EgxkCEtrpGH_sixD8
Message-ID: <CABVgOSms9m6zRsaC0d3PLxe+Q1x7d0a5+mMqQrT9Nk2onqC9=w@mail.gmail.com>
Subject: Re: [PATCH 3/7] rust: add `kunit_tests` to the prelude
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d4850d06345d3e5c"

--000000000000d4850d06345d3e5c
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 May 2025 at 05:52, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> It is convenient to have certain things in the `kernel` prelude, and
> means kernel developers will find it even easier to start writing tests.
>
> And, anyway, nobody should need to use this identifier for anything else.
>
> Thus add it to the prelude.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---

Definitely a fan of this here, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  rust/kernel/kunit.rs   | 3 +--
>  rust/kernel/prelude.rs | 2 +-
>  rust/macros/lib.rs     | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
> index f43e3ed460c2..053a7da147d5 100644
> --- a/rust/kernel/kunit.rs
> +++ b/rust/kernel/kunit.rs
> @@ -6,6 +6,7 @@
>  //!
>  //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
>
> +use crate::prelude::*;
>  use core::{ffi::c_void, fmt};
>
>  /// Prints a KUnit error-level message.
> @@ -40,8 +41,6 @@ pub fn info(args: fmt::Arguments<'_>) {
>      }
>  }
>
> -use macros::kunit_tests;
> -
>  /// Asserts that a boolean expression is `true` at runtime.
>  ///
>  /// Public but hidden since it should only be used from generated tests.
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index baa774a351ce..e5d61a83952f 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -17,7 +17,7 @@
>  pub use crate::alloc::{flags::*, Box, KBox, KVBox, KVVec, KVec, VBox, VVec, Vec};
>
>  #[doc(no_inline)]
> -pub use macros::{export, module, vtable};
> +pub use macros::{export, kunit_tests, module, vtable};
>
>  pub use pin_init::{init, pin_data, pin_init, pinned_drop, InPlaceWrite, Init, PinInit, Zeroable};
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index 8bd7906276be..8b8d46e759d4 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -406,7 +406,7 @@ pub fn paste(input: TokenStream) -> TokenStream {
>  /// # Examples
>  ///
>  /// ```ignore
> -/// # use macros::kunit_tests;
> +/// # use kernel::prelude::*;
>  /// #[kunit_tests(kunit_test_suit_name)]
>  /// mod tests {
>  ///     #[test]
> --
> 2.49.0
>

--000000000000d4850d06345d3e5c
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
Al0wggJZAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAcDMKctW1GQKDKqEUSh4
pjANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQgyVIv2KTG0sHx4GPvduQfEpjs4QHi
wtvMFVXMrQLcCRUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjUw
NTA1MDYwMjMwWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcN
AQEBBQAEggEAfQfEOONDheqDipQdZLOmU32jZnkyIvBfn6W8WHgj1FLfERidpIpc35DRW3thCsiJ
sUsnu2t0QUI48s//pJJRdaIhiylazBDsvMCDwkEHZKtGgcrwrcWqFqNwNFTGE/YOmqTlaDVvCTF6
efj8441hUX7owXgTz0NMMLYK1LalUekez6urSWQCS83ZOhA9S/4I1ZSdCW7XbtgujzgTHidIRovQ
XsmWj0NE89P9Ingwc5VLkrX6aZgmO1bWMJExk+99dvoVSQdib7tAFohOe5vfVO3ekw2VQ3exN4Rr
g/QoT4/JFCABSuADc7KWhB1S4JeXBZhtO5k4Cv7LZzPCxP+18Q==
--000000000000d4850d06345d3e5c--

