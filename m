Return-Path: <linux-kselftest+bounces-25340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF226A21353
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 21:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4514C167369
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 20:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D611DFDA2;
	Tue, 28 Jan 2025 20:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bH2Za6OL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C341A841A;
	Tue, 28 Jan 2025 20:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097785; cv=none; b=vF/ZEscBItYg0aY0Uc/QK2XtuhTQvWh34QlEDcJ5P7sTIArDo/lTA+cEOy72ZOEDDn/KC8aifVfWi5LRwkK87KLO6g4B4+cSy6wMN0ZKuW4WTaxctqxjytVdyjepLIKmlL/bsI6FLzkfI9HT1Zkn/kRIN9IbMHvWmSjdB9bnZIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097785; c=relaxed/simple;
	bh=8loRBTK4oxn9ZcE2/ZQpQLeAHRgVEExKEWDQgOfIit8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmO7t0GFeOQhmdbcWZZuCmnoDuIEE+Orzory+acB9XLzNj1ZNtvryUpjQM90dfwIjMEIgpqLzd2+2fqspjCk5Q48fgqrx3R+9YobqDHLQ6C6G3SV3KsJF9pAUPG2CmUnIg2vPkk+6ofVCDfFrKn18fQEvX+bYi4LewtCdIFtpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bH2Za6OL; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f800b5c2d5so1096672a91.2;
        Tue, 28 Jan 2025 12:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738097784; x=1738702584; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PS9HIem1hHx/9kQROBmQ355P0gGLxBHH8bm6/Xx9izE=;
        b=bH2Za6OLwIqrHtnr2XnAC0nn6Yd91Tiqh8P2PYNuYMgbV4BwDztIeJkRZlY3vTilCK
         k8LpeO4654Jj0/aHxqppDs7WaY9chN81+rWqOxr8m7K9Gq+hlDeks/GLw0PQ+istvObO
         JAVv5IA38/XzXmJQlBNe5CCVir+62UBh4bZaka4qjfEMTg14ybs6eXb1aNTPI6ZKakXM
         j9VDLWDLEcaJo7P3dWXehphvTghnpNW8qPS/zi1MjuBZ4+HvgKNKrvAWrBJvI+/Iul1m
         eaK4cCrHYUvI3r3RDlBEh86BdTjnF+TO14FCLI3MkZY/qbtfFZXxPuO/d/ob3PaZlwKt
         zbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738097784; x=1738702584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PS9HIem1hHx/9kQROBmQ355P0gGLxBHH8bm6/Xx9izE=;
        b=LjtNKzUGeMkRK+F1YZJz5oujLWvmaF1NT9oaWbQaDfDtWYVEoCdMC40CwK80Jp1bBx
         t0ITbj1hkhZqlrxJuI2m8QVCsoCa0IyyX8rNEWa8c6myCscamDK0rSc093Uo6NEw890f
         /E7DOFWyfCJ0SxDFbLz4R5eP+hR67epCM2ITqLF8cxbMu4a+lK2m3Th4ASL+mwF8/tU2
         E+x1mUxIGoUsiWobWt5aLfsieiQc/c6Q8x8oboesdUDYhH6ohYkR2oPQpJKBWZS8MTkv
         xG1ZZnwZBiBNreIYCYXGmEzL22olot3Ll3NayM+0yRxlw/3mVOmle1ivOAoZWwf5pwXG
         kwgw==
X-Forwarded-Encrypted: i=1; AJvYcCU0xpv2LiYBsD/PsiQH9KUVRuyCq92n3dAwRHL9p9UYY1QtUW+g0a3bwgITdBAbkFEZZGhA7RM0KkDNL4e9c38=@vger.kernel.org, AJvYcCXMNyMgR59s3VgkGLS/a4c1i0sV2CRT6udctDAvti115E7BZfxgBd+By0Qol07mhurMaWUiZRF3OWYDz0q7DTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68wqP+tbf0Z71ZYNbO2cXsA0r0xnraUcN7/orfI6JeGgW9iqu
	QeteiMdMx8Xd8veL2XgDAfw4e2WMvDdouRI993yZuaLKyDfTXWSVn819GyUGLHcBqPfqUwAn41u
	PMRelAXHykuIDG9WsvNj/5UXcfDQ=
X-Gm-Gg: ASbGncvrvcG41dtuTyj5puqTmelghFMo9XzipFjc1E1vzqWjDsrN+KQnZNIZzOuiYWu
	E3tvrWr/F2nytJy0AJBTwr9zl1p8hmXeXohTjjEnvbXxrzAofyx0augxn4jy0LEl7WTFdFW/bkg
	==
X-Google-Smtp-Source: AGHT+IH4CcpV/pe9+fel3zee7jXKa5DaeI6taNtY9gioMS7/R5yIDDgN4mGBHMAQhti1a34E2dpTf/3qFuk4e95mIIg=
X-Received: by 2002:a17:90b:3a08:b0:2ee:3fa7:ef23 with SMTP id
 98e67ed59e1d1-2f83acaa9c8mr242995a91.8.1738097783814; Tue, 28 Jan 2025
 12:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126223627.732451-1-sergio.collado@gmail.com>
 <CANiq72koWg-GGD3w5mJw3F-hGrOBZ7hiK1G4pHY+y_rQmtG5+Q@mail.gmail.com> <CAA76j93kQG0GjaMWpR+AnxPWDO1ud0SLECCE3uxN7FAyNB6Dsg@mail.gmail.com>
In-Reply-To: <CAA76j93kQG0GjaMWpR+AnxPWDO1ud0SLECCE3uxN7FAyNB6Dsg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 28 Jan 2025 21:56:10 +0100
X-Gm-Features: AWEUYZntlmwO4enIGZKNb2l4xXe6E_FGYy4i-PNo8mMe1ggtBgEXBVNYnJ4BK4E
Message-ID: <CANiq72kXG4qURXjnZZTLPMn-k_WwFt0yabR0nfCAzDMqYNJKHg@mail.gmail.com>
Subject: Re: [PATCH v6] Kunit to check the longest symbol length
To: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Cc: David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 1:24=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
<sergio.collado@gmail.com> wrote:
>
> > > +#include <linux/kallsysms.h>
> >
> > Typo?
>
> #include <linux/kallsysms.h> is needed to be able to read
> KSYM_NAME_LEN: https://elixir.bootlin.com/linux/v6.13/source/include/linu=
x/kallsyms.h#L18

What I meant is that the `#include` in the patch is:

    kallsysms.h

which is different from:

    kallsyms.h

Does that file build? Or am I missing something?

I just tried, and I indeed get:

      HOSTCC  arch/x86/tools/insn_decoder_test
    arch/x86/tools/insn_decoder_test.c:13:10: fatal error:
'linux/kallsysms.h' file not found
      13 | #include <linux/kallsysms.h>
          |          ^~~~~~~~~~~~~~~~~~~
    1 error generated.

Thanks!

Cheers,
Miguel

