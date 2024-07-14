Return-Path: <linux-kselftest+bounces-13713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B1C930AF5
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 19:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5C9281674
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B406413B580;
	Sun, 14 Jul 2024 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSk3/g3x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C87335C0;
	Sun, 14 Jul 2024 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720978230; cv=none; b=XGl7f6FiWK0pp4P3ykulmL9W+P4DTRncURsgPRV4m1TfZ+Szq8uswqQTCqVanXKCG+9Fk7rNhJ3kLAdhQsY6T4JUGPRanQozzXTUioTsvNns4PZSauxeRMjSMFxMljot/X0x1yCIPWlR4tkspEEmoRcmwKSNArHSjrYbsnwnmwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720978230; c=relaxed/simple;
	bh=eoz4ISS7d2sH2hTa7QRiAuGG1rWHxXjixXnT2ssYqnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO3Fj0XMJKh90T00COq5XQ16IqaOB66SioCeLGAnkpqzmySy2je2+ttMsFf35wmO89Wu5QQtaXKKxnZbLHguo/VA+DIYjEzL9EiS9qx1UrU2c4RvjFp1K/yAkHqFAR7mU3sApNpOTx1syAqYeRTwgaS4sSKRVeAsSWWHV04YVHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSk3/g3x; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5ce739c2650so744199eaf.1;
        Sun, 14 Jul 2024 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720978228; x=1721583028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cLW4DNVGNshBrBTsdLmOTS96GV7TP/xD70TwT5VJ2s=;
        b=RSk3/g3x+KC5pdCWdnNBf61NEFFzqwP+LIhKpoLUseg+/U8g/MimyGrBobCcujxVtC
         FusL/wAghTCez1/FpUASI4SSwf2QMQs0xPuoZvXvtj1DwlJhtUiOBmI3PGWYCqPMa9KR
         GF207AvA96ovz0b3zSl1Tz+cbWhb1+UhH6q/Jke5iCMe0BalRxMLByn+7YcAxzVL493F
         +LmSRFQ5syd+qmch8wmrQRfS21YAJeVHGo6fD5V15X3jUbIz55bx3ZtIlcng7Jdsmq82
         nPVUSvNTxvKStLCMfsNFytxZNf4jAxTzF0QaaOkBfdGnUKYjm0bCn03yB685UmgKv7nA
         5aAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720978228; x=1721583028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cLW4DNVGNshBrBTsdLmOTS96GV7TP/xD70TwT5VJ2s=;
        b=wjx0HrmDplV9eMQmGvcQTJAxH2zPwf8q9Harnprj3WqsTJ4IT37O/HC/GmAb1D9Bz9
         Gxi7FKsIzlRMuT+yRCfQFr+sIkxeU6ZkE11B80Enhu3KymlVTgP8DMuEZYbB/EUvURdF
         hqkFclBCYYUFJ8YA9ANkXdZ+1k6v3QtO/TkLxqvOZD62JqbY6cDZRdb9Rr9SypmM1qg8
         IL6PAiO/yacFdxJio7HH9pE9hQTDSjJtyFTWzm7kualU6nVI/0d/zsTFtKtBXyWzHjkk
         TH1Wq5lYiJ/9xBVNXd/JQq8/w8zBaJwhmOP5HwIcfy+yPGJWYSNXsdt0AOryNDz5hTkv
         DGTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWehTQFvXvR2MLELndXl093ysXio5C5xfHrjuXWiCCghw56V2Yit9cO2X7UWG3oHxGDNsFiZoon9vqq9021Hz0RPHTBSyKm1qrQzY0DDZCDHw3RLmJRXOhKmddozOsRYrjyURijJSxXqX8px/w9G0hx0EsSS/inOBL5A96C1wtenPUZMXb7tpZwyYN9kI4IS7i9ZJkc/Lcxt6lRZOui56TjB9MvRng=
X-Gm-Message-State: AOJu0Yz664Uvb7nWdYx1idFtE8p6jVfa6rmigLXsIkryaAxQ7l7M1Mrg
	BDWQSNrRwehQIHj3uppBs0OneXgWVhzfR5Q3V9ezhRhtzj8hqcnoiexqKiaBK7b+LhtrqkEWrh6
	zaEZQfxSmzBXoPsr0vQd1jAr1EUE=
X-Google-Smtp-Source: AGHT+IEl8QKe4NvFcBM4q9JGhb2MwGeuTO3IyYzcItTz+lIQYAUJkOIhJojhagfWcGc8DwiST3dj+mLBvjJ/MoDWQBw=
X-Received: by 2002:a05:6358:70b:b0:1ac:6234:faaf with SMTP id
 e5c5f4694b2df-1ac6234fdc4mr496748155d.17.1720978227984; Sun, 14 Jul 2024
 10:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714160238.238708-1-vadorovsky@gmail.com>
In-Reply-To: <20240714160238.238708-1-vadorovsky@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 14 Jul 2024 19:30:15 +0200
Message-ID: <CANiq72=kchSt5XjAJRVgNWG-iNXbc2E64ojwsQYnB2pshULK1Q@mail.gmail.com>
Subject: Re: [PATCH] rust: str: Use `core::CStr`, remove the custom `CStr` implementation
To: Michal Rostecki <vadorovsky@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Finn Behrens <me@kloenk.dev>, Manmohan Shukla <manmshuk@gmail.com>, 
	Valentin Obst <kernel@valentinobst.de>, Laine Taffin Altman <alexanderaltman@me.com>, 
	Danilo Krummrich <dakr@redhat.com>, Yutaro Ohno <yutaro.ono.418@gmail.com>, 
	Tiago Lam <tiagolam@gmail.com>, Charalampos Mitrodimas <charmitro@posteo.net>, 
	Ben Gooding <ben.gooding.dev@gmail.com>, Roland Xu <mu001999@outlook.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

Thanks for the patch! Some notes below...

On Sun, Jul 14, 2024 at 6:02=E2=80=AFPM Michal Rostecki <vadorovsky@gmail.c=
om> wrote:
>
> `CStr` became a part of `core` library in Rust 1.75, therefore there is
> no need to keep the custom implementation.

It would depend on the differences, right? i.e. for a reader, is this
meant to imply there is no meaningful difference in what you point out
below?

> - It does not implement `Display` (but implements `Debug`).

One question that comes up when reading this is: are we losing
`Display`'s output form?

Also, for clarity, please mention if there is a difference in the
output of the `Debug` ones.

>   - Otherwise, having such a method is not really desirable. `CStr` is
>     a reference type
>     or `str` are usually not supposed to be modified.

The sentence seems to be cut, and it should probably try to explain
better why it is undesirable, i.e. if it is needed for something like
`DerefMut`, then it seems better to have a method.

> -            static CONDITION: &'static $crate::str::CStr =3D $crate::c_s=
tr!(stringify!($condition));
> +            static CONDITION: &'static core::ffi::CStr =3D unsafe {
> +                core::ffi::CStr::from_bytes_with_nul_unchecked(
> +                    core::concat!(stringify!($condition), "\0").as_bytes=
()
> +                )
> +            };

This looks worse after the change and requires `unsafe`. Can we do
something to improve it?

> +        // SAFETY: Casting to CStr is safe because its internal represen=
tation
> +        // is a [u8] too.
> +        unsafe { &mut *(self.buf.as_mut_slice() as *mut [u8] as *mut CSt=
r) }

I see Bj=C3=B6rn commented on this already -- `CStr`'s layout is not
guaranteed (and is a `[c_char]` instead).

Also, the casting is not what is unsafe, so perhaps it may be clearer
to reword the comment.

In addition, please format comments as Markdown.

> -//!             work <- new_work!("MyStruct::work"),
> +//!             work <- new_work!(c"MyStruct::work"),

I agree as well that it may make sense to simplify the callers as much
as possible, unless there is a need to have that flexibility.

Cheers,
Miguel

