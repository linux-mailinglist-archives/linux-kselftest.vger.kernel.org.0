Return-Path: <linux-kselftest+bounces-28541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A09A57A48
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 13:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 555703B2716
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 12:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E21E1BBBD3;
	Sat,  8 Mar 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUZ6uDOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DF1DFF0;
	Sat,  8 Mar 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741438409; cv=none; b=TGSr1TVO9Z1cbMx+kjO+IB22xNxaks5Pp7bQnVwhwaRlnymcU2Y42L3yuo/gR+tjONqBXy8QzWehwdLbTNZBGsZvywV7zkfY0Ttv9v2KO7c/hJJkfgNKtasLLnY5UB4HCOqjIzg+H7X6KnTh8cxfa+gBH62ZfUdY7vhWPK+ifUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741438409; c=relaxed/simple;
	bh=1sfeeTT7Gmak9LSwhS1Ra7os+FPKWlJywEkinY+5Hwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMsjcFXvkrpMqmHUNLvwbZZ0pg46jlyB/GijYxk/lU13HzAM3e0b7pV6wffy9qz53wuBLkeQbJ4D0TOOiNHhGUioxy1TO/qb5M+Ke4w4NmUoIyyZIDaseKNO8MpD0aVUb+nsKjNve9/2fMbMwXnrbQ1cNf49Kp275lC5dGoH5zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JUZ6uDOK; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso15697851fa.0;
        Sat, 08 Mar 2025 04:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741438406; x=1742043206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sfeeTT7Gmak9LSwhS1Ra7os+FPKWlJywEkinY+5Hwo=;
        b=JUZ6uDOKWHQ2R/8r8T03jNmgazsKrDw63EcwIOD01ix2VZmsLRH2WiI/skMFDkmlT6
         wQElOgK2HmFBBad17/yFcjbrvEsKR8GMRnpQZ4Dpu8NWVVxp1+fgdMi5xiMRgysD8v0z
         EAGCL5Bs+I4YTTcA9U4l9gFgOz9vDXZKxGIqo0KLP8/CMszWfIKhXTcqFdwK/4r8NcU5
         y8WHrW/RzBibdrWNIbXgjCKDLvf/WVnzMxszVgmYu2OJ7jx3F+6YWoouQOwL/bBCbn65
         6BKuv54GXhVSQUHvYFOHM7O00n/m5Wq2k530t3muPxIHdogz2OcVkkofTLwPFYxtO3rg
         fM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741438406; x=1742043206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1sfeeTT7Gmak9LSwhS1Ra7os+FPKWlJywEkinY+5Hwo=;
        b=Xwa9erMu6WCuYR3yNj5OebOATQgoBaAXx6XjKb8ybdqm8NtnPgDOWyS51OJwbPv4hZ
         pAASeIJiNvZr52UoVDZTi8buTp5/G/lPs1Ninnlope9PLNzY980O5mHXABrBVS+wmw3C
         3AnWHPrOFGfxEgztLrZhZ9WwU0SZi8+FhAmZTnpDpNzktSCx3sDijoeuyqH2orIbk5BR
         FKB8WbsXHYzfOUHjFr4+9XilRRF1sIIVOU3Ut83+7R+so92T6IWKq1XsEM/GgwtKMjXq
         VSaFTNIlcOIkCmZwwVcTNCnq+ytMFGKesF4G/SCu5tFXCp5yzarYfPog+sSMdCyXZaa4
         ELaA==
X-Forwarded-Encrypted: i=1; AJvYcCV+n8SFut03LUNRT+6R4AA1NpNIQMS0C6E/v0qrB/RqJAwwp51feaklRu6Pn7D1w8v9RcLBUjJEVJpECXgT@vger.kernel.org, AJvYcCVF9aTXSknJgxYqXI+1JJXuAaQ5qvux6xAKJKXLyU1z5tdOUX4wuVA0N5MHZVY8EB699B/ek22NTF8u@vger.kernel.org, AJvYcCWd1OB7HhIfQmWto/6MdIsWCP7eu20It1cIVkXD7qYJZIX2Ioti/B/WDtwfDeZO1eJnHKFQo+J5DhkKfCM2oAU0@vger.kernel.org, AJvYcCWycAUg5iF+wMk+KndaNC+WQLE+mNJiuyH7HgKozM6AHmic3Rhv7rDu9/oFag/KJuaxUXGYCsTFsxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6eYFp95Ie04qI3mzhih85wc5/H/vRjElV1EwDV4/jQSU9CLb
	eNTl1PHs3JogWfY7dMo/tySbVXLAaexfnN1tIEXusho3sOynhJY1n857uyzKHI4GlEYw1uXaz1L
	S18JOHzITxaHMGdru30cc/WALIrM=
X-Gm-Gg: ASbGncups0g1quR8yplVEnLEDypHqHfqUiEnSh75jflhgpg3ej87bxj3rRUc0dIHJ1T
	D85/6zJpz14jdIYQRlilRh0kP9f3k7/RiM0+tFEyUfe50WQRTazVX3Mql4GxTy58dUL3xih/0GJ
	+3vsLMLI5XL7ikbET67/79LrLEywvzJQOh4UH4O+pJVPmkK4CNyriagulPFmVNiD8sAYI/ji0=
X-Google-Smtp-Source: AGHT+IGBc+05qVuuXjaeI2ZzjZWIrRA4Fj6//dVvSffSqc3+iAQQVbEHM/psLC4ti7AS6LxNuas3m+DVljjO7VA71i0=
X-Received: by 2002:a2e:a58b:0:b0:30b:8e06:86a3 with SMTP id
 38308e7fff4ca-30bf452d9c5mr25912651fa.16.1741438405382; Sat, 08 Mar 2025
 04:53:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-printf-kunit-convert-v6-0-4d85c361c241@gmail.com>
 <202503072046.34DAF614E6@keescook> <CAJ-ks9kTO-u+Wqp0K-vdMLAs08fBeoovSeb_pGkMjSHFnBKysA@mail.gmail.com>
In-Reply-To: <CAJ-ks9kTO-u+Wqp0K-vdMLAs08fBeoovSeb_pGkMjSHFnBKysA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Mar 2025 07:52:49 -0500
X-Gm-Features: AQ5f1Jo-nlWUK8722g4g1onlCZtycc6IeZsxrVSNnIky0DEy506UFGHSg9dFWWw
Message-ID: <CAJ-ks9=zHBmOApsqa=UZcKtg1cH0tp34Kt9_5AEJ7vzwt2QeOA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] printf: convert self-test to KUnit
To: Kees Cook <kees@kernel.org>
Cc: Arpitha Raghunandan <98.arpi@gmail.com>, David Gow <davidgow@google.com>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linuxppc-dev@lists.ozlabs.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 7:51=E2=80=AFAM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> On Fri, Mar 7, 2025 at 11:49=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > On Fri, Mar 07, 2025 at 05:08:55PM -0500, Tamir Duberstein wrote:
> > > This is one of just 3 remaining "Test Module" kselftests (the others
> > > being bitmap and scanf), the rest having been converted to KUnit.
> > >
> > > I tested this using:
> > >
> > > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=
=3D1 printf
> > >
> > > I have also sent out a series converting scanf[0].
> > >
> > > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-3=
86d7c3ee714@gmail.com/T/#u [0]
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > > Changes in v6:
> > > - Use __printf correctly on `__test`. (Petr Mladek)
> > > - Rebase on linux-next.
> >
> > Thanks for doing this!
> >
> > If Petr, Rasmus, Andy, and/or others Ack this I can carry it in my
> > "lib/ kunit tests move to lib/tests/" tree, as that's where all the
> > infrastructure in lib/tests/ exists.
>
> I think the plan is to take it through the printk tree. We're still
> working on it, here's v6:
> https://lore.kernel.org/all/20250307-printf-kunit-convert-v6-0-4d85c361c2=
41@gmail.com/
> where I've rebased and put the test in lib/tests.

Whoops, this is already the v6 thread! Does the layout here look correct to=
 you?

