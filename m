Return-Path: <linux-kselftest+bounces-15725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D5695764C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3F11C23A10
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98D158851;
	Mon, 19 Aug 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBa5F3lM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92B2C18C;
	Mon, 19 Aug 2024 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101222; cv=none; b=Q3+Cz8NqERof0dsTS+AfA2UpnDvBh64bh8xehAmQ/w7rjmXm8fmvawrm7rtlEzWVdMaNHdUwJWHHKfZpA5GhBYPvYLaa42K0BZ5BDfyEytZO+fFDGAitl0e7aWB33Ku8JjFeeNJ3hLKEycrGeqbEuvozuR4u+n0FaQKqqLYXEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101222; c=relaxed/simple;
	bh=vZUA3Tul1vhCpVvgKKF0+KzEb+tjCqlGrblu1VOW5TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Luit/ywhSTrd/jZaAdGdlLBvxlGcHXm1Ls8IRYETN9ESzk/b4BNdjMI+MaeEJVHDAmJrdCRpn0h7XlWmpT0a4hRBrixBn6ClI0ttPcmiA1ELU2fVVjuXV7hKtwCWTXmIaffRxyRsbi3vOYKVF9PJ8LYuXY9RMq1AG4WB0q30vSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBa5F3lM; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-49762c3eb85so1542705137.0;
        Mon, 19 Aug 2024 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724101220; x=1724706020; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tXNZjwr+hBs8nEysGgHixtJhZqND0ZaCAsJOcANha8=;
        b=DBa5F3lMix32ZtwPYFCESlJSW1tb9yGI3k/zqwoO5vRoMOzYl4KbTYjP8Mtp1YF/wT
         qCc/+R+bkzBmI68khE45O5vshl5agaNNaxzrZ/SS/n09xAhXSFvnn49LWwOdlhSzCFee
         cv5hWIW+5k9ZUns8uyHUGjBkUYe0eW7pQjarcizwBqdXRuDF+yT0JpFe2/r5d9b/vqDB
         0VhAuQWkau+RDQSuvyDkSYg6NOXEBB1BbkAz1MX/Kyfi2vBtmJsuNL3+Psaa5nZ8HJGs
         JY23i2pbPg4b2Shd1gmZDUBGKZVkRGAK/dOT9DIDrEsXt/mSv5OhwR7/51/t0VrbH71M
         qwlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101220; x=1724706020;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5tXNZjwr+hBs8nEysGgHixtJhZqND0ZaCAsJOcANha8=;
        b=uoQe1wUSoOnYUK4XdVV15+kmNZh5KJH0uhhNquQGuuIot0uQgav+pYzfe4d91TOqXM
         yPas5/vjhKCzBpyb6Bm5PC/pzyDiUT9O89g0YiUC+ZzvsP+h4pP6PuVby/XBb+pYlzVh
         rUxp5fu0IsbvJh3hWAM7/7FHcObydR/jb9w+SGU/4moQVn78bewRQLoOhy53KRJbSX2W
         kiAXDuSCRdaHd73qm7jOksWNwkLeCENKc61v+1+XgOPYw4f8S54w8I5oMQsn2Zvj018K
         +eOuXGvh8J0I3OewLTBiFqN+nt3UoX/mmJFRhhVWhBIOQ58+57x4V2nAcPXHu4LEyb0j
         nHuw==
X-Forwarded-Encrypted: i=1; AJvYcCUFlgyBvnG5p3o42tEJZDprTMJ7usGvxtHxWGSRcJR9CN8EyrpL8DtmG+6BobIId7Mp0rqIJKgIas5D41ucZx24a7hABdji9yXAZZx61zxP6UiTDWNCKQQ1hqdcwqwT7zIlR6pJQpnqtxMCflUI
X-Gm-Message-State: AOJu0YzAHnwcGU0IB5Z+/hgfcvQmZ5vZubE/dVwdO+eB4z7FSED7M3//
	/2gIzf8qnjmFPPD4aCxjIgvrPEdeJEFcojvP+XU1QmEP1GMQ//BrqiILFRTj0ralwmdyG5TtRh6
	i5zy0x7Tg1YOGqEcOgo/urwE64NpCBQ==
X-Google-Smtp-Source: AGHT+IFgyf09STPsI38BphKGnEeIk0IuhIpUZe4M/rkhpaHXmXXbr2kT7JrKiDhpU0K8kRu+41V9eeAGKiVaFg50c8c=
X-Received: by 2002:a05:6102:370a:b0:493:df26:f9c5 with SMTP id
 ada2fe7eead31-497798d15d7mr9743758137.11.1724101219912; Mon, 19 Aug 2024
 14:00:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817-mseal-depessimize-v3-0-d8d2e037df30@gmail.com>
 <20240817-mseal-depessimize-v3-1-d8d2e037df30@gmail.com> <fp2z3jevyvhpjqutv4a6aziws7bittmz3imelu4eh3eyp7niie@hnyca5qt6nmm>
In-Reply-To: <fp2z3jevyvhpjqutv4a6aziws7bittmz3imelu4eh3eyp7niie@hnyca5qt6nmm>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Mon, 19 Aug 2024 22:00:08 +0100
Message-ID: <CAKbZUD0XGESusp8FmGsR_OAiT_1X8gKFURpMiNN63xyaM+Q-6A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm: Move can_modify_vma to mm/vma.h
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	jeffxu@chromium.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 9:15=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Pedro Falcato <pedro.falcato@gmail.com> [240816 20:18]:
> > Move can_modify_vma to vma.h so it can be inlined properly (with
> > the intent to remove can_modify_mm callsites).
> >
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  mm/mseal.c | 17 -----------------
> >  mm/vma.h   | 28 ++++++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+), 17 deletions(-)
> >
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 15bba28acc00..2170e2139ca0 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -16,28 +16,11 @@
> >  #include <linux/sched.h>
> >  #include "internal.h"
> >
> > -static inline bool vma_is_sealed(struct vm_area_struct *vma)
> > -{
> > -     return (vma->vm_flags & VM_SEALED);
> > -}
> > -
> >  static inline void set_vma_sealed(struct vm_area_struct *vma)
> >  {
> >       vm_flags_set(vma, VM_SEALED);
> >  }
> >
> > -/*
> > - * check if a vma is sealed for modification.
> > - * return true, if modification is allowed.
> > - */
> > -static bool can_modify_vma(struct vm_area_struct *vma)
> > -{
> > -     if (unlikely(vma_is_sealed(vma)))
> > -             return false;
> > -
> > -     return true;
> > -}
> > -
> >  static bool is_madv_discard(int behavior)
> >  {
> >       switch (behavior) {
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 6efdf1768a0a..e979015cc7fc 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -361,4 +361,32 @@ struct vm_area_struct *vma_iter_prev_range(struct =
vma_iterator *vmi)
> >       return mas_prev_range(&vmi->mas, 0);
> >  }
> >
> > +#ifdef CONFIG_64BIT
> > +
> > +static inline bool vma_is_sealed(struct vm_area_struct *vma)
> > +{
> > +     return (vma->vm_flags & VM_SEALED);
> > +}
>
> If you respin, I'd support dropping this entirely as it seems
> unnecessary.

ACK, I'll fold this into the next patch if the need for v4 arises.

> Either way,
> Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Thank you for the speedy review(s)!

--=20
Pedro

