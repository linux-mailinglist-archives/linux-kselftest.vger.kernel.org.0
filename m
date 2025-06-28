Return-Path: <linux-kselftest+bounces-36049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDAAEC769
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 15:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D078E3BE7CC
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Jun 2025 13:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316C245028;
	Sat, 28 Jun 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2oXXtkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD6A16EB42;
	Sat, 28 Jun 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751117324; cv=none; b=vD58jd2pFiC3CT2U+sfFXUpUOIR/+qROhJ143eRdcnXxomPbmacvCmC31IfZmpkvYkFddAf1BmWH0CTvt5wLWwKvdcwiJ5hdIPbJgjPJWZHxcJAdJdioN/NW6Qa1VAAwEJFFJnpLjFd4nOVrLp6Fa6lYF+dziNalDHZQ8MPwYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751117324; c=relaxed/simple;
	bh=T/j8U9rdyUQILkZZOO6YDvdjlKeeHE2rOYeTpHYUXZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iI6SqYyT9Pa2xTdsrZWr4fWs8/Bsnuw0Q010BnNCmXkTdki64VtRM25i4B2WBFf9c8nVrl+YnE/8A/WQf4MQHx5evkFY5ctU98jYzsc5wXGYN1r4of8UKNsqUSZgeky0ntC5FGSis46pv2A/NvmZH5Zq++AD3fy30a+FZxG9FSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2oXXtkB; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313336f8438so715274a91.0;
        Sat, 28 Jun 2025 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751117322; x=1751722122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WL3lDKYi2M4QM/WmNCuiZEoDjKzJbZf9w3+SaIZN3M=;
        b=j2oXXtkBF1J2M8lX0u0z0QI68jY4uo9SBhVKsP1uXf7sUN1BKTzhzNfjNaICe5E0do
         OizzUUufesIHzgtuA/zdQfomnUOR1O7k1wISbcTzXJAt3yVXhDajjk7szqfwX5pFS7xv
         HX3QfWk2e4E5ZKNXjv7ZcKH+eEfYLvwTGfDyhEhUZT/ZSaZzRrr/WPEfsv7BLB3xX5ZR
         bSCyO3Fzqe85n6+vWHE4FTUUenfs7tgokWINGXN/MVbAkzqW2txlzbNQzdXg5ke3KzaS
         tm84T/Erh+aILI8URUqLU4HwuYVl5FWAjHXZxLmi5uQxPufJVBQ+0uWfjsYKOUPApIVN
         qgyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751117322; x=1751722122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7WL3lDKYi2M4QM/WmNCuiZEoDjKzJbZf9w3+SaIZN3M=;
        b=TSn8bUNDSkZCSERSOesRGyMe87fPlSfW5FnNRv7z/pbdm6jHtmru/P1TYYbKVPALtx
         bc4yEjpQrii/TGwj7Lgds6CF3+aZgN2dJ92ozEQoAKZ037Z1HDRvyNb5k5K66HRYBS5O
         2+BKMgTZ426CoIUGfKcnkIbs8IyMLaK7BjrXrn73w9qJ21bwU80H9J5qlz2B+5Xj4s2K
         BsLIDK9pQ2Vxmmd7kWQSsGOHQaukUkpqc0ndkTT5YdZFywFLAFORqO6lbCK6LvgF5qH6
         NzRxSfcqrtLLPOx3dgylsCrYc845bqoLBcwuMAHSY+eLF/zc5vJ9GFmkErxuUxzxFYUu
         +hdw==
X-Forwarded-Encrypted: i=1; AJvYcCUDWwMxXrd9kFsn943FdjXd2IKlWJsJUPFnxCZfS1JKFrxJ0rVsjvO9xZCBM+uuDpe7tu2xGsIem28KiDk=@vger.kernel.org, AJvYcCUfPvmwp4EG4ipcqFUuncYqGsljENXMZSy+ol+U9eB93uNYHj98oEpb1Gf/up+7QCRIrwt+lAdpeLU=@vger.kernel.org, AJvYcCWU28B/dX4oPMrgQypL1WykBCosRaDof73igSqlv9gYjkAZF2epDnCYICvyBmjsz/YJT2VYbz1EQuCGZJe3ZSQ=@vger.kernel.org, AJvYcCXF6SHMcL50SwJ7hJ3Xi+zrAbNOx348dsCi0jt+FU1AF4+M0PZIc7HizY0tYD7+JssWS2F1nD2IF22nfR5uGmUF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DaT8CfuTRfTepsKzyCku6J4vbrLH6aw3CG30Kly6LXXroYBU
	strxNPQ/O2rFvkiQV9WP4D1i0CtBERgKZ0eJDLxZ/Y2UhvHiffuG0dZ/QbT7iGntRgSkszhcSor
	YI77MeXRuA0v6Ajj1222xhrvIMPE8i60=
X-Gm-Gg: ASbGncsy7Jt8MF0IUFCKxZfC/Zou6o4kH++KCFPM3IPgYAYM2xPsscN3xHgtlvnrrXW
	Vri5X0RymG0xsQv1TUSUgSXshlEm8op5/KOi9lhYd+eD/7/N5VV4OarmMvUge2CufkJPGtS2Mks
	3L0UPhLV6tkumyWjLEowLMwOAL7u6e1M1/VPvvoB4Ier4=
X-Google-Smtp-Source: AGHT+IHc6wdHVj6IpZsm+aHQxHlCim58v6/HcwGkhWy25SGPfViHk3Es9U5eM3IItHwndHObtV3frrARCnNb42IPH6w=
X-Received: by 2002:a17:90b:3f50:b0:311:fde5:c4ae with SMTP id
 98e67ed59e1d1-318ec431932mr1841270a91.6.1751117321888; Sat, 28 Jun 2025
 06:28:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250628040956.2181-1-work@onurozkan.dev> <20250628040956.2181-4-work@onurozkan.dev>
 <CANiq72kjdj4KbDhfnTbm8jZpLC1+WPB3E6M8D8M2NLnphMs5vg@mail.gmail.com>
 <20250628133013.703461c8@nimda.home> <CANiq72kY9DA_JD_XkF01ZSmXbD8iaFthVZ66X+9N5aa_WObt+A@mail.gmail.com>
 <20250628154237.0f367cee@nimda.home> <CANiq72mxJM-7WAP8xVDukmiXq=ntThyFESFLs1+dmZJSS2q60Q@mail.gmail.com>
 <20250628161117.7786b3a4@nimda.home>
In-Reply-To: <20250628161117.7786b3a4@nimda.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 28 Jun 2025 15:28:29 +0200
X-Gm-Features: Ac12FXzaVuWKO4aWMseA1ihBqRgJ54vOY07I6pfAHsieZ7gtsGYmuexr3j1wmCo
Message-ID: <CANiq72kgB6gQ3+etQOYLLDqWt4EQhiDfN3dcwHBOpZh9USt3iA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] rust: remove `#[allow(clippy::non_send_fields_in_send_ty)]`
To: Onur <work@onurozkan.dev>
Cc: viresh.kumar@linaro.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com, 
	tmgross@umich.edu, rafael@kernel.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 28, 2025 at 3:11=E2=80=AFPM Onur <work@onurozkan.dev> wrote:
>
> Aha, I see. I missed that. I guess `allow` was added when the author
> had this lint enabled on their checkout, but their work was merged when
> lint removal was merged before that.

Yeah, some of the code going around was written years ago, so
sometimes this sort of thing happens. :)

> Do you want me to update the patch description by including
> 5e7c9b84ad08 ref and send v4?

Sure -- maybe wait a few days, to see if anyone says anything else.
Then we will need to wait for Acked-bys from other maintainers.

Or, actually, if you are sending a new version and you are willing to
do it, then it would be easier to land if you split the first patch
also by subsystem -- that way each maintainer can take their patches
on their own time instead. Since each patch is independent, you can
send them in independent patch series, that makes it even easier for
maintainers to track.

For instance, you could do this grouping:

     rust/kernel/error.rs                | 2 +-
     rust/kernel/types.rs                | 2 +-
     rust/macros/helpers.rs              | 2 +-
     (+ this patch #2)

     rust/kernel/init.rs                 | 6 +++---

     rust/kernel/kunit.rs                | 2 +-

     drivers/gpu/nova-core/regs.rs       | 2 +-
     rust/kernel/drm/ioctl.rs            | 8 ++++----

     rust/kernel/devres.rs               | 2 +-
     rust/kernel/driver.rs               | 2 +-

     rust/kernel/alloc/allocator_test.rs | 2 +-

     rust/kernel/opp.rs                  | 4 ++--
     (+ this patch #3)

So e.g. the top one (Rust) would be a series of 2 patches, then the
next one (pin-init) a single independent patch, and so on.

> Sorry for misunderstanding by the way!

No worries at all! It happens :)

And thanks for doing these cleanups! They are appreciated.

Cheers,
Miguel

