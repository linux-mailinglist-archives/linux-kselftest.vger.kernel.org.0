Return-Path: <linux-kselftest+bounces-26182-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F3FA2F163
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B6C3A80FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF7F2206AB;
	Mon, 10 Feb 2025 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C47cRks3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC02528E1;
	Mon, 10 Feb 2025 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739200970; cv=none; b=YOZ0GzAPpC1egg1ZIB3wsRUmpWQyw3ip8ZbfpW72Xl5DrrHSPtqIabvcUgiysMxQafg3e6X/Fo/+rflb783HPgasNz+r3o11T9f7UAw4BTLNvqmsxYvomZ3//qVGXbS3TVio4HMWSYC+Xnowa0mL7R4APDYodOGUTggKdAy8cWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739200970; c=relaxed/simple;
	bh=TZCS6IBZR8cszFMrHSzCpnO9x5U+OCEkf3vi+82wSGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsKxO1ZPHIl01erN4q7XJzkEFW7zRFDlz+tn2eOrZTy9WEgwh97X+eOEu6cVCGchmn6reoNqvvUI+QRpeZqxW77EWj2//ewEWbLZND027mGWBeNorn2hnJeDD7nfnVLhsZW5G2lBYhFXd4V9wXAHUMbnJ2VwWjgHGOQKdUWaEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C47cRks3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-308dc0878dfso23774751fa.3;
        Mon, 10 Feb 2025 07:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739200967; x=1739805767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVnl0/6iTa687ys0sS6ZoplvY9NJhSDmVZYOuoSNQcg=;
        b=C47cRks3NCh0jgCGEzAQBwUPenues+T5499mbIQfzmT/JZNxjMTyrY9745jQtmx0fX
         5uSPseOLfsR49f76zDAVPf/GPYUI3rxth+2tyr2Zg7MBevc6DKim46TbgXrHvzpn5s3v
         KIPI+sdHTdzNGpFACiM8G9TzeXPbCb7JkZ/fJ7Ns6Og22lo0/+siOwxoHYhyTfJ9WVpA
         c3SZlAIiGP6r0Eh0xb635Wl464ARGWJesmXHLgHay3DrmJYvX1mvImHQu2LIWjzWAq0s
         RlgOGzFvH79zf9ieoj/rrtJTNbFGLYqt3gjItfRJqApLe2x21hvu9ER54PONj3ivo6Pt
         HKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739200967; x=1739805767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVnl0/6iTa687ys0sS6ZoplvY9NJhSDmVZYOuoSNQcg=;
        b=lh/XO3CjaQDITO67VgSroTM7YB/msWe4rKLHVKmVHanvuwE3Wqh5bD00noxlbval4w
         bwXsquAPjAfbw3BxVZS54e3k7vb0Ohf5oE94ir9g5rusVzvUNelrS5+HlSjX72wM29EH
         EH7fRLEMveWguUnTekVTp3U2L+DvElOb+7ofuKHWuoxZkGGkVGxDILcfDf/+hhndb1Vc
         7fI5I7f1lszZg4AunXQQnr2kbDxU0r6zbo+mqzfrB2Tv68573KG8AxWBd4Kdiz51QQ+1
         oXMSEig5f7b6f46uRKWnOJdIn/k3Aty4yuOgT0mpC5qAFOezDAMZPFpsB8Mx9xyN//r1
         IMeg==
X-Forwarded-Encrypted: i=1; AJvYcCU1mHipaNUDPMvGSJVfjbZnrcrP8wgTW4oSCbc585+C36g+N3iM6htVPCTJSRB+pVMXrKMHlp+dRVkw49E=@vger.kernel.org, AJvYcCWnI9K593ZGD9Rc+4DCGGgd9hZ9OBP9qxmwBoHuuM341UIAhkpbDMtToyQxfqBeZJBe2so/Hx7kaAVEZ4a4ze5S@vger.kernel.org
X-Gm-Message-State: AOJu0YyxsrtkDhCFrAUNkyClX3Z559w+CIykv4k0wl5IYULprgkdHtQy
	nrpeRaYKERtrDp2T5+2R4r5CMcVFgG8QXhm+8ktSq9RiygmtPzS8o3g6+rcM1Wt2YKt/7ka1HMF
	DM0xWgW7XFn4woTG4N5Yl39XHQFQ=
X-Gm-Gg: ASbGnctPlRgjFyfacKi3tbL810OMR1vbfxcbPm3VXfWXkyxAesYuadkWNlk8ArVQTtp
	SeGaryMSq8oTnSQVHchCMZ/XclzM3buG/frhS5WsCqZiFPeNCe2avVJd73ty9wxMcK7DzwYUEpe
	acD/ba7m44txag
X-Google-Smtp-Source: AGHT+IEpHdeN8erLClieOL+UomsBwE/+19nnH3UavI05Sg6CvoxUKHuTm40UVq5ptbzOuLmNsS1gVNW92OToQTVXP7o=
X-Received: by 2002:a05:651c:893:b0:307:2aea:5594 with SMTP id
 38308e7fff4ca-307e57f2535mr53288961fa.18.1739200966544; Mon, 10 Feb 2025
 07:22:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-printf-kunit-convert-v2-0-057b23860823@gmail.com>
 <20250207-printf-kunit-convert-v2-1-057b23860823@gmail.com>
 <87tt92q7hw.fsf@prevas.dk> <CAJ-ks9=SEBCZiuq2YE3Uj5wJ4Pv+78W-VBTeV7CSzLYJZqsR8Q@mail.gmail.com>
 <CAMuHMdXSprzzCBTBM+w39FN+OudEYPT_SX6BOMSus+8NLvZNVA@mail.gmail.com>
In-Reply-To: <CAMuHMdXSprzzCBTBM+w39FN+OudEYPT_SX6BOMSus+8NLvZNVA@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 10:22:09 -0500
X-Gm-Features: AWEUYZnzE6BRlQx9qk1ro7iUnFE4CnVeQsrFsCvEnqAc2kVsBlbumEb6u0wnLuk
Message-ID: <CAJ-ks9m-R7bEKdvzdoWQtu+NyMvDY62JgeWZMn74Fj3UeAVzhg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] printf: convert self-test to KUnit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arpitha Raghunandan <98.arpi@gmail.com>, 
	David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:52=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Tamir,
>
> On Mon, 10 Feb 2025 at 15:37, Tamir Duberstein <tamird@gmail.com> wrote:
> > On Mon, Feb 10, 2025 at 8:01=E2=80=AFAM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> > >
> > > On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> > >
> > > [...]
> > >
> > > If/when you do re-roll a v3, can you split the defconfig changes off =
to
> > > a separate patch? It's a little annoying to scroll through all those
> > > mechanical one-liner diffs to get to the actual changes.
> >
> > Yep. I'll split them into one for m68k and another for powerpc. Geert,
> > I'll move your Acked-by to the m68k patch.
>
> Fine for me!
>
> Alternatively, you could just drop them. I do refresh the m68k
> defconfigs after every kernel release, but these updates only go
> upstream one cycle later.  In this case that doesn't matter at all.

Will do, and in scanf and bitmap as well.

Cheers.
Tamir

