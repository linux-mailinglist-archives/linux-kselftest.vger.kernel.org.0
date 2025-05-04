Return-Path: <linux-kselftest+bounces-32283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5EAA8884
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 19:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 788521897EBA
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 17:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365F151990;
	Sun,  4 May 2025 17:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebDFf8w8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A0C1CD1F;
	Sun,  4 May 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746379866; cv=none; b=ty/S2uSzVHv6ZdncKdMjRxN5USNKmHHUL5dRRDZWxv6ocTW5qfcAkLr3Ku0Oh6qBQUJ9JsVcsPwWqgazUYXY/BbhCnAqVa6Br2NOw0TvaMO0wVvsdJtsF7Osf2lAmvam2xKgGWLSXOLoq5059Q+oPuaz8ArAG6wDEmcpLTk6R3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746379866; c=relaxed/simple;
	bh=T3U/9FuOE2xtfOj0tUx2Kuhmdtf7tLVJexcbxbRimKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bICt6TOxPGstHzucwF3Nq4IzSqrGjtVg7J3uRBzhiukgFkkbKAG1gWbovORFq5mxARuSbTluZgoL33qGlw9tkbNk12vBnQS8E+DNmcALVJsUv7qBkmXqq2O6mJJ74M5zSP2f9Ksf9E+aACS83PBh4JedKSxl0o1vjkf2yMxfLi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebDFf8w8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54c0fa6d455so4467578e87.1;
        Sun, 04 May 2025 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746379860; x=1746984660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MAjfptIMQwKjMkK2caSxzARquP7ADDmjnSLYI6Zjxw=;
        b=ebDFf8w84ZEbzEyUGdsF/Usq4cLX1YaOgZbyKFHcICwdLObIv6XZDTVLBJkDPuaPyn
         DihtA1w7sW6NXrvFehYDjZwU7di8vsAFVmVZEQoCRmebNF4JOKVMGBtqnQWAprhRbD3B
         8zX8w7L8rVuEqx59EhscaaQDtG/jqYCJm3UAWnHQxFWjsUNVpeUhQQ7a0yt/RL6ho0yY
         cWnjmIFruJmnuQXatmkXwH08Q2AZQSgDVW28g+PYfy7yEQNTLSaQm8uhuncX2JVn8N6u
         0hqN9v6dwoPHTOwX0BXfu4bp+xU7OQCMId3vqehyZi8m2OCwFYF2dijnMGUM1PhI7cZH
         4zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746379860; x=1746984660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MAjfptIMQwKjMkK2caSxzARquP7ADDmjnSLYI6Zjxw=;
        b=lwRVV1Erv7nhVhB4jdmlT2VQJnxfq2YyQtcoY45vqzf8RrBPtdUJouT+WopBAhKHYp
         LiGTSN2qhwubEubyQqKtuf3b2/tzEeHhkpplVZxxrdCucBitW1IK/zFFjKalQv1AUZil
         LSVSzb123/G4WixgvDs3hR47NuC9P5nYHAnf5PrrZLL1/dDpy/oy4VRFI+LPcQOSDfys
         mNATFMnFGSLXVTfS5KZm/tk66tUyEus9nO2WVc0gtREVJMdzrqd20fz4cny15d+MQDch
         gCF1dhnM+sV0NfDGmIzXRrxRSedbrDHu3eleQgIWLjBUX3ZMixL8LVlyHrrs9ha+PWU4
         HZZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR4jhMUpOx/sVMmnXEsO3NZeepcbExtDJebgicFhwRKn7FhhhwGZCzwFdxDywF9Xi4Oq5c+hiB+2XPU7E=@vger.kernel.org, AJvYcCUy6lYf1JgrMo+v6YWPuHaIfrGhMV/8psYJIDa283gXFVVw7F7Xih5jKMhfu9ep2kemPWFHy229qwTXzO6jawzR@vger.kernel.org, AJvYcCXwG1RJrc088LKqKga++kvRjKZu9l7iB4hQhHV0pxhGtvdn9DLjemrF9eZp1sqndoMwuQHswz3lkOilfFyBFi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznMknSVJHnF/6KLufUJGh4lzCDsn9M8RZVIT5NLUrLWNU84qMK
	JDQeAVLyWAdBuVDzRUUtqzagM89gaSMgePH2zRBuCh8p0hZ/lSCCvLJcu1ErlL3JRWerm7mqnjn
	jKo7a1I82OEiAeiZDfMwkWZNbDEo=
X-Gm-Gg: ASbGncuGIJoPUrvQ1KBD/S4T9uWdkevd2QM3MvjQR5gzctJkpfOrVba7mkB7V+y8Qzn
	WK2i3P1HqQcDoEa8QYKsJ9fm2JF10kOEiT6U86ZIShft/xnTg1jN9ODwT2Gpq7MlZZN6rW4Td+s
	v7aE1xCZRin7ylMP4Z8WMl1+dvaCVGBH1UCCxa5aa3sJL+/XV9BKdHWGY=
X-Google-Smtp-Source: AGHT+IGk67ZjNfI5JRZk1E9sIkaiWYoh/CFeHhNDrNSEmUPefy9/YpSuJCSkf4tQjbpLx1hp8nibAzsjUmqph/UNhtQ=
X-Received: by 2002:a2e:be9c:0:b0:30d:e104:cb74 with SMTP id
 38308e7fff4ca-320c5fd2023mr23540791fa.41.1746379859507; Sun, 04 May 2025
 10:30:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502215133.1923676-1-ojeda@kernel.org> <20250502215133.1923676-5-ojeda@kernel.org>
In-Reply-To: <20250502215133.1923676-5-ojeda@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 4 May 2025 13:30:23 -0400
X-Gm-Features: ATxdqUH6DCMZhtsVocCllU2SKUNfgzC5NnOkbEXIh3IhAUh31vvSHfK6t0f55C0
Message-ID: <CAJ-ks9k=uxxumgEU84-54u8OxxJVBsUprGk7Ht31ndoumHB95w@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:53=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In general, we should aim to test as much as possible within the actual
> kernel, and not in the build host.

Is that true? The build host is often easier to work with. There's a
number of host tests on the C side that exist precisely for this
reason.

> Thus convert these `rusttest` tests into KUnit tests.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/str.rs | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 878111cb77bc..cf2caa2db168 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -6,7 +6,7 @@
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, DerefMut, Index};
>
> -use crate::error::{code::*, Error};
> +use crate::prelude::*;
>
>  /// Byte string without UTF-8 validity guarantee.
>  #[repr(transparent)]
> @@ -572,8 +572,7 @@ macro_rules! c_str {
>      }};
>  }
>
> -#[cfg(test)]
> -#[expect(clippy::items_after_test_module)]
> +#[kunit_tests(rust_kernel_str)]
>  mod tests {
>      use super::*;
>
> @@ -622,11 +621,10 @@ fn test_cstr_to_str() {
>      }
>
>      #[test]
> -    #[should_panic]
> -    fn test_cstr_to_str_panic() {
> +    fn test_cstr_to_str_invalid_utf8() {
>          let bad_bytes =3D b"\xc3\x28\0";
>          let checked_cstr =3D CStr::from_bytes_with_nul(bad_bytes).unwrap=
();
> -        checked_cstr.to_str().unwrap();
> +        assert!(checked_cstr.to_str().is_err());
>      }
>
>      #[test]
> --
> 2.49.0
>
>

