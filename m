Return-Path: <linux-kselftest+bounces-28835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BAA5E445
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E8CC3B23F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 19:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFB4258CC0;
	Wed, 12 Mar 2025 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZYdI5NE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1C1D54E2;
	Wed, 12 Mar 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741807201; cv=none; b=AKaOtyLTi56U3wPoOPCDlM0qgnWSNQS0xyfeDE7AqrcTtpaPbfkG/a7SQRtgn7rk5ux39eYxLiPqHTdKRypIot6shVNtGeDGPrG0D4PDeJZQ1aFTiEUhONevBHNyNV3MzaTzpi5EmVfuw47uvAXXkn8Ifd3/yTbsS/Mv2IU07eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741807201; c=relaxed/simple;
	bh=U39QWTFDK4krNJkLtnrZRy8mlrJO57HBq1xBCbiHc9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsQGaRkuCiDJyH+GLIl0JVx/b/6khUUKdXDV1ZH9zScYFFCkiwbRIHcoMOFkFImtmIJBM6A4etcmY3uYoJOURgPpUAMeFulkkVVjK5sBQiFYh7PacTMPeZv+NCc/JNyP5ExdT9HYNsrZREoe9szPQYmN+P6fZqlvTJCxE3OceNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZYdI5NE; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bef9b04adso2201951fa.1;
        Wed, 12 Mar 2025 12:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741807198; x=1742411998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBWDNU70+QIgrvpnovntFcRY1fH48FyWMogI9/w0zXI=;
        b=OZYdI5NEqYyOxuen2WpvYzL7I7dUQX9F5+Esw2r0oa6kVcrPoJdD10IeNf4f07C8ol
         B1CZpJCK91NI9ksU1+M4gid0EKKE5Qhk4Hc/dejCo2Lplws/uBBFPsGQ8LEgDT/KwuG1
         PoeirrcZxCvpzRDKpzbrQ6kLPERGvlaLv6sG2emb8PTRO3sJXa09xYtGU2rW/ni1EiNk
         ZJF8seCWWpkGlzn+fVo4tzo0EQKVV9FqgBBsiCBWNWlJUHyRmw2JpIRSKa/OraG1rIMn
         pl/J/80K1lT1zvBsAqjMnYHCfC4ncSBjbFX6gYahdKkp+u0j8+XT+MePrn36OCtTdSyK
         oM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741807198; x=1742411998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBWDNU70+QIgrvpnovntFcRY1fH48FyWMogI9/w0zXI=;
        b=nfoD/+qUIuwHC84Ql1sO25BDep7OrU/+LuUV5KvoFYk7eLkxegvCjpTCPb8JWcxV9J
         96L3gNWac2qQqI80Z4DQ5BTuFghm8mMIXf5jW+Ri3KluY2IwQwi0QS2Lx1f1zOjik8/b
         u8pTPp0MgJPBAirvUkRAeQsULzHZ4prpd2ceWTxJswH9FiqWaEeBhtD3TpVVMt9UsTAR
         Y2Iv3qNX0lz2rJpooC6rgjIauvGuDOT10EoKhtqC1pY5TSxUFJqTXqMSiZ+CEZmYqnKf
         BwnbgGznngsY0mbjJnZooGUvMK5Mcs/zUBNa6gN4QXjdMp69iZrcW9x5LB2NevPjUd+l
         lTcA==
X-Forwarded-Encrypted: i=1; AJvYcCV12uNQR7OGhcr1421tzdpNY9r8Gwwh/tHc/hBP26WJhhHViXwrEyqa/mcn0rmJUewSlGHVHO8qykmCyB/xav6a@vger.kernel.org, AJvYcCV7oSk6EYRSz8ceVj19wDu5uKzTVwln5nqEHnCzq5o56JcnJzQTOIpZ06fgZJuFH3GxB02NfsC97cdhicO4@vger.kernel.org, AJvYcCW5p5sG2T+e/DEM41ZgaYbdGcXfoaKjvmh0lBnwbkfWjQoVODv3cB8HWc+GmWqeWwfMhsfBrYibkJ0a@vger.kernel.org, AJvYcCWO8c0Q6PiOm5sv+e2zZ9Zg6aWVmUPWOXGLDxkpwLzklQbXRUErNQNchREeNeJLr4xImOalicjiWQfmBaXNIXk=@vger.kernel.org, AJvYcCWZlRiM8W60pGS9JmT+dRNWX7Akzlj8yU6GtP8KYUb4Qx1MLO5h87s1ltxRaHvNgpgI88kLCCEcBaP1Kxct@vger.kernel.org, AJvYcCXcQTGr8kXNbH1wRuPrQfy+84722qYUrnC7n9px9wgeZ2c3iy+fVf9GbVnSPLt9HmW3CPHdOOfwCB0IDhc=@vger.kernel.org, AJvYcCXzr80REAVuRgYOhxM/TCXM8SFdAzrhnixEhL2DH94m2UFZJWYp1LG/COz63OuPbI1nZAjg8ZkNcVeW@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFzaN9AejcvRnMTqS/IeEHPRyMU7uzD5snw9DY00ESvearvl7
	NtO36R3I1pJ7j52lHleW/UiwJdd/eP3ibdQvbxWmJ7Zo0eaiQfJzDykTES71TLDlZVV27fKLTtc
	75nMyHL2qCbMCZP9d/j5ZfY3B6TI=
X-Gm-Gg: ASbGncuAd4+6FVXfBuaSDTVmoUXPXRBgWCtTcBbFZu5F4l4W9UnUAkIvDs80cAyrfP1
	b2zp+EYuzNB/jcQ3sAqVuC++kuacEtst4oMnwJSetH9xVL5tUAC+eYFDptskT4xxPs8xOzTr2v+
	hIlTchut1V39ZQ2Yjezw6N9b4lWC0TET7PkKt8SiH64g==
X-Google-Smtp-Source: AGHT+IGD6zNVJVWgFOO6G90D0rPFLIHNOVEMUagwK87xdFC1eRLaEju9pI3oX3tu/vimUN3mvopAMb/IMoqWudC/G7w=
X-Received: by 2002:a05:651c:19aa:b0:30b:ef0f:81f1 with SMTP id
 38308e7fff4ca-30c206b1cd9mr38199441fa.20.1741807197608; Wed, 12 Mar 2025
 12:19:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
 <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
 <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com>
 <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me>
In-Reply-To: <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 15:19:21 -0400
X-Gm-Features: AQ5f1JogmqHL_AvQvVeP-De9ldEMD36AqwkJUY-3JIBgpEu7e5l95FUfkwaWph0
Message-ID: <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 3:11=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 12, 2025 at 7:01 PM CET, Tamir Duberstein wrote:
> > I think all the remaining comments are about strict provenance. I buy
> > that this is a useful thing to do, but in the absence of automated
> > tools to help do it, I'm not sure it's worth it to do it for just
> > these things I happen to be touching rather than doing it throughout.
> >
> > I couldn't find a clippy lint. Do you know of one? If not, should we
> > file an issue?
>
> A quick search gave me:
>
>     https://doc.rust-lang.org/nightly/unstable-book/language-features/str=
ict-provenance-lints.html
>
> The linked tracking issue is closed which seems like a mistake, since
> it's not yet stabilized. I found a different issue tracking it though:
>
>     https://github.com/rust-lang/rust/issues/130351
>
> We probably should use both in that case:
>
>     #![feature(strict_provenance_lints)]
>     #![warn(fuzzy_provenance_casts, lossy_provenance_casts)]

Nice! I didn't think to check rustc lints.

> I don't want to push more work onto this series, so it's fine to leave
> them in. Thus:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks!

>
> We can either make this a good-first-issue, or if you also want to
> tackle this, then go ahead :)

I tried using the strict provenance lints locally and I think we can't
until we properly bump MSRV due to `clippy::incompatible_msrv`:

warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but
this item is stable since `1.84.0`
   --> ../rust/kernel/str.rs:696:22
    |
696 |             pos: pos.expose_provenance(),
    |                      ^^^^^^^^^^^^^^^^^^^
    |
    =3D help: for further information visit
https://rust-lang.github.io/rust-clippy/master/index.html#incompatible_msrv

This is with `#![feature(strict_provenance)]`. I can file the issue
but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know of a
path forward :)

I'll send v3 with the tags and the phys_addr_t fix shortly.

