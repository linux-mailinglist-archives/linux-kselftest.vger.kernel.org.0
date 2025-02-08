Return-Path: <linux-kselftest+bounces-26111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A720A2D810
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 19:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8673A6927
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 18:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE451922F8;
	Sat,  8 Feb 2025 18:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAn0uPJj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0839C241120;
	Sat,  8 Feb 2025 18:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739040162; cv=none; b=P1vJw24jkIPj05wQVrO1BhP08i9K9a5O125kcltJC0z1KvLHyi0GFUjcepMDWtbbZqG6jUXWSnJ35x4kfIXwclFd/xW2wq4fbeJ2zhxCuxTuYCUNlVYhNhxpmZYcFzDdA+UZbVOY5u5Ipgntn//HgAEHwwBHDZIAg+71qsX5KbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739040162; c=relaxed/simple;
	bh=9FjKQ/BoQv+CHpMARBhnQGJ+h9/ib6o+976NotBuoh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJoWmTPH5fepC79Hn4l+6pr+wu8K53LxjLCqcFcQ/9iT/HCwmOZq9hx9rhS4s+48FM3sb/QhUTgrbz1MLkCHqzf598l9iWORdYUeCihJZxKy6srVfLiUzODMrvPMMalJxKBMOcxToVQhWu0wElFjlyn8NI7gaqri3wGT31pklwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAn0uPJj; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a6bso33277121fa.1;
        Sat, 08 Feb 2025 10:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739040159; x=1739644959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF3d2v/Cd40GRW7Y3SKITD/wzvp4wTLT0QafaTbIXWQ=;
        b=fAn0uPJjLGkODVdE9xZTODp2fMRZHv6UqrPkn5zfwyFrSS8gO6OmGNGefzV0muNWkE
         oK6X6ciLYRF/Y86Q3pGvboYTvmXz33xXxMK1P1xFiNPODEs+GWeUi+jTQLn5vkgXBMKn
         J2N7ADmupdi/QJmKNDcLs+HHznwYVNrrgD8zL8voKxhLUkRZDM5/wl4t5eVipRPXDMDY
         068edcm72meanNAzV9mOg0PoQkRjzEpv/320TpBVXnSnCznG8q9haGtU4LkV1EECU50R
         iU1C6kP5a9wbnM+KaPy6jCgUp2lIdfBNG+S/bT7HhculnKPqE7uZjlQI1HGIFLe+sPiJ
         LLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739040159; x=1739644959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OF3d2v/Cd40GRW7Y3SKITD/wzvp4wTLT0QafaTbIXWQ=;
        b=Sbwd8UcoOb6lSSLBdN22dpe+gCbsQ5rF80UTokBf4CDt3Zt2GgrDHjT/ihMzzcQWE2
         v4Syv+OVBKP7r+u6ilmmW4hpKHLO3SLom358U6EuQ6wPWfXI/YxO3CSpC89Y6yoSUi1n
         5a0PZlyG+XwFrDryFnaHw+2v+fHUy5m4HqWenWleBXshEoSy1Cz/eBaSuYlOi1XRgH9H
         2xcBBgMoP9pcC3Qek3l+fxvx8brJZFflusIJvZlr73YQdWe6ixmlcbWZYBj1XNy2gfRk
         cjkiqujfyx+p8Q2ozGfgQEruK3YbfGvpGdrWZZ4NC0XwCzRdLlqEFp0XRwNXShd9ozST
         hkzA==
X-Forwarded-Encrypted: i=1; AJvYcCVBgw40jhjEPOp3rA+su1w/KPCa2vFpn0Q+1DHtGSxvxIty+QAVRSDnLBLp+6GX4NomwgVze6AWXQ9DkE/xcudj@vger.kernel.org, AJvYcCW23v1EGlpC4No9iV49hosCOcJtNx6p2AP1ceBZxZFeLwM/oPHo2TPFMdh3/L5njcmLEeMmQKHcFGAq0SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkDczOAXbTsc1HLb3LnK81LCYVTsupdoquUh7Rh48iyRLn9Gj2
	Lbfc1JlzcL5q00yw+/SgKWJ9vMS+dCcvcKpseOQDECuGQX70ETPuG4Q2zN38GfkiXmOBj6WCBDV
	j9g+qeFycoQjZbpHCbQc4yPwxC3g=
X-Gm-Gg: ASbGncucaG7zuiRIKaOXZfjbLrsGdn7U5AGoGpSZHtsS1pqBOrJrwusCLpkepDSSsQ9
	0KW5hQHCexmZsK54VnYHMvobuSJHkHID3KHZu/9bmD8faqAJDQgfYPqhQMkPUg4Av1Mncos2s6k
	PCmwehDkyg6abYpfQAwYJ3q3ZGa4XfApE=
X-Google-Smtp-Source: AGHT+IE5yIE5Ue/y+RzFKL8z9km0wUX+8BN+VY4C0BGBjE9wQybUdFtxMRSR6CK8CWLDtOvu3dWumbmGNC9v45fv/pQ=
X-Received: by 2002:a05:651c:199f:b0:307:dc1f:e469 with SMTP id
 38308e7fff4ca-307e580c5d1mr26440881fa.20.1739040158468; Sat, 08 Feb 2025
 10:42:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com> <Z6eaDuXnT_rjVSNS@thinkpad>
In-Reply-To: <Z6eaDuXnT_rjVSNS@thinkpad>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 8 Feb 2025 13:42:02 -0500
X-Gm-Features: AWEUYZka1JKrPSYInI4GKv2M2y8rfwixxdFsdqTGcwpCPpsY53i6WsWMtdiDkWA
Message-ID: <CAJ-ks9=f8d7jh=15bHc28Z37p9rA-Kg4J2mQ++VBcsesVvezUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] bitmap: convert self-test to KUnit
To: Yury Norov <yury.norov@gmail.com>
Cc: David Gow <davidgow@google.com>, John Hubbard <jhubbard@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 8, 2025 at 12:53=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> [...]
>
> Take over means that you'd at least add the Co-developed-by tag.

I didn't use their code - the thing being "taken over" is the work of
having these debates with the maintainers.

> [...]
>
> KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
> on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to
> boot-test bitmaps. Even worse, I'll be unable to build the standalone
> test from sources as a module and load it later.
>
> Or I misunderstand it, and there's a way to build some particular KUNIT
> test without enabling KUNIT in config and/or re-compiling the whole kerne=
l?
> Please teach me, if so
>
> Unless you give me a way to build and run the test in true
> production environment, I'm not going with KUNITs. Sorry.

This is a question for David -- I don't know if this is possible.

> [...]
>
> This is my evidence: sometimes people report performance or whatever
> issues on their systems, suspecting bitmaps guilty. I ask them to run
> the bitmap or find_bit test to narrow the problem. Sometimes I need to
> test a hardware I have no access to, and I have to (kindly!) ask people
> to build a small test and run it. I don't want to ask them to rebuild
> the whole kernel, or even to build something else.
>
> https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/

This is compelling evidence, and it was not previously raised. Thank you.

I notice that two things are true about the performance test part of
test_bitmap.c:
- It's a minority of the code in the file (48 lines out of 1462).
- There are no assertions in it.

Do you also find value in running the testing portion on other
people's machines, to which you don't have access?

> [...]
>
> Nice summary for the discussion. Unfortunately you missed my concerns.
> Which are:
>
> Pros:
>  - Now we switch to KUNITs because KUNITs are so good
>
> Cons:
>  - Wipes git history;

I was very careful to minimize churn, and the result is 249 lines on
which I'd now own the blame (228 with `-w`). Still, it's a valid con.

>  - Bloats the test's source code;

The test is 74 lines shorter after this series.

>  - Adds dependencies;
>  - Doesn't run on most popular distros and defconfig;

Yep, I understand your concerns much better now - and I'm grateful for
your having taken the time to explain and show receipts. Still, I
wonder if we can get the best of both worlds - either by finding what
you need in KUnit, or by moving the testing bit to KUnit and keeping
the performance bit where it is.

Thanks.
Tamir

