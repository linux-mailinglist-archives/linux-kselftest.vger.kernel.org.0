Return-Path: <linux-kselftest+bounces-25341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81062A21378
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 22:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB88C18851EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 21:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C671E00BE;
	Tue, 28 Jan 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bNYJhN1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3691DEFC5
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738098444; cv=none; b=lnk2ey2al+/63dMYvP1M7F6OT3dg7cBZ15zWNE63m2Deu57RB2Smwp4mW+tUY4MF8gqaqHyX4fxweOzUQx5a/1iOF0U9Gfnt3tKuf829ZmuGRFjUaa4jwQ1YMaJNH1WpAE2Lr6G5xLUbzU5Yq+33lop3eYOrONu+5eb06PXW6KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738098444; c=relaxed/simple;
	bh=tQWPSfd29jAb/+6dxN1Azzarx+5KxjRLA7zuyfgU0yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjzFj5gFvaOqZQw/KAKLC4Jhbe0J+WUff2cHgY19UFO+hrMQi4f5Q5zpF6zGvZP+S2WrzXblJBrTRbmBDMh9zDO7gSc/azWRMBwgtstdxSwvGxu92hv7Atz9wR9fNAc6/hj/AkOyyEh40xj6yirttLNvM0FSFrL67DGB38l5f9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bNYJhN1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so8299053a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738098442; x=1738703242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QK497g/6YRHBQWEHRzFRbGaEnXX5xC4fNqFlti0tjyQ=;
        b=4bNYJhN1rYm3VLItt1ZXuxqcv4yJKvs/XppHzj97uUX2VQEaHfw2G6zk9AG6Gfqu3L
         Dn4yObrRlOjM/Zp6d9thf7dL/OoGzkYer2Z2Z2bnETg/BDotzlZoc1c9AN5cfzCFzftM
         7yngSzoY2sC+lAQOHL+0/Yneu4EBYetTukQ8rHuGcekRSiOQZuvImY931xcoBIRpTI7n
         N1M28lRBJFNh3zKl2vu62l+yoXyyc/BmLWsLnj5I7x46LAsh8WSJbZDPKYEF7E6uGnyk
         P9X6vLxs89EyuEsacyFGUFpFIoRm9o5SwZu61YZEmbkK6NRlhS8N4RJbOi+9jfVxbF08
         5LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738098442; x=1738703242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QK497g/6YRHBQWEHRzFRbGaEnXX5xC4fNqFlti0tjyQ=;
        b=QPw+zLnfQzB0+zim75rRR2zJZJ/yHm7izOwBpB9dbk3RUbAxT+m0Q6Ei0PCZTNBv8d
         8Y118L1ity1z27sPKj2UhyiEpBp6gaTAhfMnSPibnKkraAWBtXGM9NLy+kbMczQTSRxx
         h4UHxeyBBWcM8XHn1ltUKD0QejXPePzD4dizSZZRtoYQ65xnBEtecIbvjGbhbi/8ZUQB
         WL+93uI50utMWHhYS3F7uXlTL166yZ1xdmQx2/Eg+ZLhqCcRdVas4HKBq6Q5GZRHjerj
         9g4SUhIjNXcWcY6vYbXLi/cXTSIwFHKursOB1UtbXt2JHlzwZqrZVotNM9reI95zaxgZ
         5XEA==
X-Forwarded-Encrypted: i=1; AJvYcCUCFbeVsB9H56QEN0B62d6y7eAKnfefOcWkQac2Rsuv6UhjYfpoPiI9b6TnzaeEz0oSmL8HTPs9CpAmwOhiwws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTUOCft+8x493juMyEnOCvytBPdWjAPq9T+eCfBI/l5VGqWr9X
	oOlzv1KrsYy9iOogkpwKG1blxVXMtNO2usO6Oe/6Sb3ImN3kUsdNbE+/zAnBXH2hERppo8HBjco
	OknzD86aoSZuXBryf8FYrT/Q2v9N9zOjm/CMn
X-Gm-Gg: ASbGnctLPdx+VXmfr3EH5BSi+9kkGLim4VdJZnMBL/xYWMoVb8noEswoFrnYSNVBP3C
	zmr7iR8pKPnktyMSSsGGX5IpS+ckdPhINGrXf4eANmj1yp5odon9U6pw/c35q0xaNrR/q+MJw9A
	==
X-Google-Smtp-Source: AGHT+IH/lkJUsgOOkYQIY71+zE4VMub6TDVQlrlJUr+ZynBpE7dZZOzfulWBYCBgeTkybQoFXs2WuJxlrLIR+mWyj5A=
X-Received: by 2002:a17:90b:1f8c:b0:2ee:94d1:7a89 with SMTP id
 98e67ed59e1d1-2f83ab8c371mr692765a91.1.1738098441153; Tue, 28 Jan 2025
 13:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250126223627.732451-1-sergio.collado@gmail.com>
 <CANiq72koWg-GGD3w5mJw3F-hGrOBZ7hiK1G4pHY+y_rQmtG5+Q@mail.gmail.com>
 <CAA76j93kQG0GjaMWpR+AnxPWDO1ud0SLECCE3uxN7FAyNB6Dsg@mail.gmail.com> <CANiq72kXG4qURXjnZZTLPMn-k_WwFt0yabR0nfCAzDMqYNJKHg@mail.gmail.com>
In-Reply-To: <CANiq72kXG4qURXjnZZTLPMn-k_WwFt0yabR0nfCAzDMqYNJKHg@mail.gmail.com>
From: Rae Moar <rmoar@google.com>
Date: Tue, 28 Jan 2025 16:07:09 -0500
X-Gm-Features: AWEUYZkKC1VY3tjA3ydqlvc8OmdBVLMFqk2PhIKYhR__-FUAX6WpHbJt4T_2JJI
Message-ID: <CA+GJov5qSXG71YFgqo=h5PP=HP7MPmvU+XVsTcaChR1DOBvHuQ@mail.gmail.com>
Subject: Re: [PATCH v6] Kunit to check the longest symbol length
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, David Rheinsberg <david@readahead.eu>, 
	rust-for-linux@vger.kernel.org, x86@kernel.org, 
	Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2025 at 3:56=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Jan 28, 2025 at 1:24=E2=80=AFPM Sergio Gonz=C3=A1lez Collado
> <sergio.collado@gmail.com> wrote:
> >
> > > > +#include <linux/kallsysms.h>
> > >
> > > Typo?
> >
> > #include <linux/kallsysms.h> is needed to be able to read
> > KSYM_NAME_LEN: https://elixir.bootlin.com/linux/v6.13/source/include/li=
nux/kallsyms.h#L18
>
> What I meant is that the `#include` in the patch is:
>
>     kallsysms.h
>
> which is different from:
>
>     kallsyms.h
>
> Does that file build? Or am I missing something?
>
> I just tried, and I indeed get:
>
>       HOSTCC  arch/x86/tools/insn_decoder_test
>     arch/x86/tools/insn_decoder_test.c:13:10: fatal error:
> 'linux/kallsysms.h' file not found
>       13 | #include <linux/kallsysms.h>
>           |          ^~~~~~~~~~~~~~~~~~~
>     1 error generated.
>
> Thanks!
>
> Cheers,
> Miguel

Hi!

Oh yep definitely missed that typo. Thanks for catching this!

Thanks!
-Rae

>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion visit https://groups.google.com/d/msgid/kunit-dev=
/CANiq72kXG4qURXjnZZTLPMn-k_WwFt0yabR0nfCAzDMqYNJKHg%40mail.gmail.com.

