Return-Path: <linux-kselftest+bounces-49312-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFDFD39A6C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 23:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 802BC3001FC7
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 22:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD5230C601;
	Sun, 18 Jan 2026 22:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWiIQ9HX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C239B30BB91
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768774472; cv=pass; b=ACMUA+ceZTHEgopqGoaUeCm4wS9vIg8ZbhhWkp9q29IncrEV2rUY7cBHY3axvxZ2lp/lFnSAmJhTdOp5wUq3PBmOYY6ZAlUaLtiQ0o1o103rzBXjcLqd1XlkwgiBBlpNjMKLGX+kRsKbFRRq+5WHUiGZwRQKv3SpCemMtZ65pgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768774472; c=relaxed/simple;
	bh=rFVaXTamawVca7FcuOUlaGPv4PCZvXD301YzgKJrMFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6M6aFKFKqIJq3gWR1ZEPhUELlhmFRYM77zwJ4EH9dvxQj2d1q7oqYoRVaBuuq9B5bubbbLs8tw6WuyPY/NO6RFEA3g3i7R0Lq6a6nXjodzfuiWg21Elv9+MxdoOOFfmpYU+eLRSZLJlkl36GmTlSVMEYM3/te5aVCjE+0NndG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWiIQ9HX; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1233ad1b4cdso223892c88.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 14:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768774470; cv=none;
        d=google.com; s=arc-20240605;
        b=UoDTHqTFvkU6wpT8MsYAu2pHf23OOgusP4HHghHJj4uotqiKKeCLcJbPK9XfuP2/H+
         XJfWdEPxHRFB7GfNbfCruFSZtIQs6ZfjCGvB8jyIxR5FqWqwIBrC6R9KGKJ9OiwEpSpJ
         LfhPkY47dW19ZHNVFfr/nlmlUkXpNUz5vIOLAjMoZ1nWyQCZlUH6m9GDCNakWuKhxr15
         GcmJd5GMqK7nj1OGWZVZABpreLmW7Mpasd/ms10IYC0ahAEUPbuBKWrCV8J4d/naGF1c
         4e+n12JoioT03s3XAWAtxJ4lIV7AJTEDNGuRtEvUTNPvDaUN8CHdTTW7kx9HlBw9EDi8
         CzSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rFVaXTamawVca7FcuOUlaGPv4PCZvXD301YzgKJrMFo=;
        fh=SO+M+ogKS7ilWbSjwgrVysJNlxfAKwAraKrWB6wwYuo=;
        b=Xt6d4FiDmuTWZ7VJMYFoVKtjqjM5NBfR5PFZ0OGmQFZ7O1/tI0EtbYu3r9fQFvdiSf
         bVgOzmkhBjzvqfXuSSYeM7NvlGs0X/j3GQd0UwLsZK981Ia6Ze3qt4eFzdgR1lV9QHba
         IiLWUIhiH//94DZ5oevIDDz1NbR7ktRfWSmDrixsNE9jFLOgQ7A+hIr95X0dHJ2OEEv1
         ++9TTxYxV1+shIjzKGJx2PwoeonRGC/wOlXM0dWp+vv3B1p8WMEZs+K84fojjNVAAJU7
         VqJoHRNrrvLQkHDuLFy6zGnSlPHi93/fuQgt94fatNFIwk6FTWwTA2wK/iAUQ1A89lB7
         ULpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768774470; x=1769379270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFVaXTamawVca7FcuOUlaGPv4PCZvXD301YzgKJrMFo=;
        b=JWiIQ9HXnyHlxeIvNWseZ40qClOQD0daZAW7xELlgF2Z49UCc9kJLgiUguxqUqG+zS
         4lnqx19AF6FljkTUWlCVJw4cTNX8JMz2XXeXSjtZYd0BzZxVFTWV+LiKJoVzbXHJdp4+
         89Ow1Uowhy/mJ83wPL6NSVCH8n5kbAUbjDSBaJlSULg3Yuk893QpFipIsVLtn4mtJS1k
         hc2CC5sPxBjb0ERpzMCTWvE89HvvDvBb+XaPl22AYWf0DM5vkZBCcGqCQkPVHZDjb/0F
         S0kutDrDqrjyo6bPXRTe+wZrpW6SxKuCiI7rYtz0s/V7nY4A2jUtq8xvRzAsMWpFgW6y
         Sz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768774470; x=1769379270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rFVaXTamawVca7FcuOUlaGPv4PCZvXD301YzgKJrMFo=;
        b=sVH7wxHdLMkZ5JFOtj2YwdFN9neRaF3vi4Qq2IcvFiuaxvqlO5Puq7joH2zyGJcPkc
         vcf1/vea3qQMPhEqLpTZ3Hjc+dVF4Wr8/QpHB9QYkVKD6Vod7/0OGjN0lxc/XWP0Br+5
         712werhbRDC0gLMybFB9a7VOaw5KgJH/7/Frb+Fj0IfbNfuLUR+UszlmuszESAyt7oIG
         Z5O7gRgaZPgp0CYRD9mM47285PB2qjRpS0McIpxbbDFdrwp3ChRO/MrD2+GeJLcs2tlE
         xs3wggP0L2LXUEhX6CCMokk+TFe+8vT4bChqZUfbqVPGk3Yksl9TOoxI3WoDQmOdFvB9
         Bh4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEb0aiYW3EoKah+wOaS9w0UjvfYYZY57diTlnlRFqe51+2ps4xX3eSoSyWhLM6ZmIr3d49oINUi8XNXVtYS08=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVfsf9x8goqgeYDbppJp/0qvyPJPvKNJcP2qoI8rRfl5Up9mCi
	fj6auLQHf0zXdD+2n0kpuE9E7YwM3zlDLfxP7Qqv0rk0v18Zaz/dW8V7Sf0otRU3eXuu/6KG+EK
	sOKgNTJhHGB3hpBwNDVcwBqAofy76ako=
X-Gm-Gg: AY/fxX7fkgRIbfU2sX1UKOa6xxH6HULIHRoqaxXCtxXdExFrxyytHn0I8DKGfA6cbEM
	hKOybhr2QW12rlmtgOPuz9DDmRZWAJbjaNGa5kO8ymaAjrq44sJ0Bq6FanNmoOrVUo3kN8oE8uL
	pEGBVVgXQZnE4FybhRQgsEwcEi9Nkz0Zj9jy4j1FAwo5q1/sJ3EWKYpVcuQ+J7t8Yp45lbrZaAj
	lAVrv51lUa150qWKA8WnDp0cGarf5jM4CI6K322exKfKpm0l3fl+zo5XoxAB1rfxkr+09Znao6d
	oubWj/MLm5CItjv1UuQT+TQDOQba1nLuLiYN0VVqu6HCBXApOCOpbOI7ZpeaC+ozeflja0tHjGE
	34PmBxDwV5mFi
X-Received: by 2002:a05:7300:fd0f:b0:2ae:605b:d530 with SMTP id
 5a478bee46e88-2b6b40f82e3mr4624275eec.6.1768774469760; Sun, 18 Jan 2026
 14:14:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251130211233.367946-1-seimun018r@gmail.com> <DEMK8K1I3FFY.27ERA2LKI7MYB@nvidia.com>
In-Reply-To: <DEMK8K1I3FFY.27ERA2LKI7MYB@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 18 Jan 2026 23:14:16 +0100
X-Gm-Features: AZwV_QhbmS6fYnaLHG9OmfFPvxPSjjMQeHjogZCNf2NRKzxWYqqnS5uWm8UjCzE
Message-ID: <CANiq72=BN3gQfBX-0abv+8hDKDL20JC5G0U0BS=r3nY5VB4a0g@mail.gmail.com>
Subject: Re: [PATCH] rust: use consistent backtick formatting for NULL in docs
To: Alexandre Courbot <acourbot@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <raemoar63@gmail.com>
Cc: Peter Novak <seimun018r@gmail.com>, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-clk@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	KUnit Development <kunit-dev@googlegroups.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 4:29=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.c=
om> wrote:
>
> On Mon Dec 1, 2025 at 6:12 AM JST, Peter Novak wrote:
> > Some doc comments use `NULL` while others use plain NULL.
> > This patch makes it consistent by adding backticks everywhere,
> > matching the majority of existing usage.
> >
> > This is my first kernel patch - just getting familiar with
> > the contribution process.
> >
> > Signed-off-by: Peter Novak <seimun018r@gmail.com>
>
> This looks like a pretty good first patch! :)
>
> Just make sure to put the meta-comments (the "This is my first kernel
> patch" sentence) below a `---` line so they don't get picked up in the
> git log. See [1] for an example.
>
> With that sentence removed (which I believe will be done when applying
> if no other fixes are required),
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> I have double-checked with `rg '\/\/\/.*NULL'` from the `rust` directory
> and this indeed appears to address all cases.
>
> [1] https://lore.kernel.org/rust-for-linux/20251124-bounded_fix-v1-1-d8e3=
4e1c727f@nvidia.com/

Thanks Alexandre for this welcoming review, and Peter for the patch.

I see Cc's were missing, which explains why there weren't more
reactions. OK, added everyone now: clk, debugfs and KUnit.

It would be nice to have Acked-by's for them, but if nobody shouts, I
guess I will eventually apply it...

Thanks!

Cheers,
Miguel

