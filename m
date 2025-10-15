Return-Path: <linux-kselftest+bounces-43184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7D7BDE7F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07EFC188EB7E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16851A9F92;
	Wed, 15 Oct 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="SwIkVUCO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49C1E515
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531826; cv=none; b=X6QsGRdH3YBcrJaCW5OZXuzV8XWYhCvLEVHZdDsIlSshEo7N86OtkfbrF+1HK5ZjyxTtGhnDgvFm+JasMnAp8YYhcs3pNH1C0Opr1S4GsXpFWw9h9jodQH8nMq6IoFtCOLpLV/0rwVI1CqhbS48/q8TjSc8/w09bBR4j9r7XSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531826; c=relaxed/simple;
	bh=cZWQFWkqXSzxQIAOS5/0Tl7zL5qo9QseMzuk922DgLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBSy5+IJt0Zz2kOaSWqvn4zbGDsE5yzCksmOYBaSPx1GcWaMd4ikVto+j31XTLWwiMF3hI1quTcbF0FEwXVovEhsPnhhcXIFMQ0Ypo9uNy1YqYG6GhZMiZ4orWmoHbqGjr0RPqE8fX2cQEPINe2vl78yYA2DxL/Uf4AjbcUKsoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=SwIkVUCO; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3da3b34950so1062953066b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760531822; x=1761136622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b8E+MJevdLFCHBwF7mS7GoEuKQlVbSLU5v6n96OsPT4=;
        b=SwIkVUCOhKFEqwQn2FTeNcmu7S/vPdvLcIu4QzVAvGULFgCainQ5FX4nPWyfLikVt0
         7v/SXoIiV9OR9Gde8DfhUx08SGyPkDK+4UtPkFM4b2dyYNIIHkAEg1lv56yoN23GPjQz
         Ocic5d71Wy1RUx4QvPNBHNnwVMiDOxuDeWwhASO0IRTtyuTdEHkDDDcVCi2wvWWWE1ss
         Q/TzPkpg+Lt5BodpDA87pbtr+vPkLLeO2YOlCdLYkaKNst9LEog4N2n55deQeK1q/+69
         dvROo3H0yKoIUN1q+PZkT55LT1J2jDty1mNlRXdBDA+j1GDX6P5WTLiWqiP482Xd/0j6
         4ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760531822; x=1761136622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8E+MJevdLFCHBwF7mS7GoEuKQlVbSLU5v6n96OsPT4=;
        b=h4QfWyV9FvyKfUOeN8e8w6E/NXQRFULcNlBmY2cHGgMk8KDWbSAOaTmw5Rs6OVwuOu
         piuMtRBMMrwusOujbyAFTxLJLa9uyHJgtdVrGVPJfMok5MTV557uDhnZ80E9etCJHsrr
         uS8SUFe0KQ8q0XZpXeqAToXDnPYoNAfDcSWjwBcMFtQBzVU2ZB2JeC3fD5BJ4kWBBFWw
         zjOTcALSaVGFsmf0zmF5WFOc4XjQqfi4XxbFeSJ3DYECTvMhSieRPJrQ7qnBJxN+IdMk
         KrHF0qiGZ367FS3OOF0eLgJAy9RCXOTD7ga0ld/ihGzZHxJHi6oWonxtpb2IkL660vxr
         G4Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUvo2rY1FkJgONmpNkeZgW2fsIW1Fj20Hg4x25VX4iX3WbQ1mrYLkxjMfV/7pG2qkw46EbZ4HlcBYwAW6CWrlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaByOSrq3P1vpAUpD9ZvfoEnjo/wxE1/9F3FxnWLgiJjAcJy9z
	KBIvzXKRaqBcVKHmTUZhgLk3GfziVh5X+wXy0ykRBQYlcF11Ox60lcLjtloQxpsQnHCv8p1c8ZX
	Hz2RV+nFtNsVsh6PO8I7PNNxTOfpN0SyAdo4EAhusYA==
X-Gm-Gg: ASbGnctwkHug+XvKnuvSDvwL5rGrR12HGHhyW2YiNzhSRKt3HLLJooIioTm3LM89Ovd
	38InTTDcVb7A56SQLvLKlts62NYPncar7co6BNavy18a5YgTYl9aS/65cLcm5EVMlAM7dZIgFbS
	n4t8H1wBSkMB2ew6avfVcs8ZxTBeDSPMsqLxusqYpnpLcAlxV/j2p5M3TIpCCxWCLotpI9D4/YK
	FrGLhPoBsFv9wRad37ur8o=
X-Google-Smtp-Source: AGHT+IEDF7iyIXNjv4yFMv0Mll29DePR8hod/9dF7gMGC5HJnD9K/nVXAKiAd5Z8GOd414WiFCTkFSP/++NSmqR2Z5Y=
X-Received: by 2002:a17:907:7e88:b0:b3f:9e3d:daa4 with SMTP id
 a640c23a62f3a-b50ac9f3424mr2775434166b.65.1760531822098; Wed, 15 Oct 2025
 05:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-2-pasha.tatashin@soleen.com> <aO9ZiERHff7vQiBL@kernel.org>
In-Reply-To: <aO9ZiERHff7vQiBL@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 15 Oct 2025 08:36:25 -0400
X-Gm-Features: AS18NWCPb-lo4AJ85wFH4W7tNY7wonucvX9sAJrCA5Y6CElFA6kZge8K_GeLICU
Message-ID: <CA+CK2bA5Eyz6TUMTy3pa5HBvZ7KkiHX3EHn17T=d6LX_X5i3bg@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/Kconfig                   | 15 ++++++++++
>
> Feels like kernel/liveupdate/Makefile change is missing

It's not, we already have KEXEC_HANDOVER_DEBUGFS that pulls in
kexec_handover_debug.c

That debug file contains KHO debugfs and debug code. The debug code
adds KEXEC_HANDOVER_DEBUGFS as a dependency, which I think is
appropriate for a debug build.

However, I do not like ugly ifdefs in .c, so perhaps, we should have two files:
kexec_handover_debugfs.c for debugfs and kexec_handover_debug.c ? What
do you think?

> >  kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
> >  kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
> >  kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
> >  4 files changed, 70 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> > index 522b9f74d605..d119f4f3f4b1 100644
> > --- a/kernel/liveupdate/Kconfig
> > +++ b/kernel/liveupdate/Kconfig
> > @@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
> >         Also, enables inspecting the KHO fdt trees with the debugfs binary
> >         blobs.
> >
> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem.
> > +
> > +       These checks verify that neither preserved memory regions nor KHO's
> > +       internal metadata are allocated from within a KHO scratch area.
> > +       An overlap can lead to memory corruption during a subsequent kexec
> > +       operation.
> > +
> > +       If an overlap is detected, the kernel will print a warning and the
> > +       offending operation will fail. This should only be enabled for
> > +       debugging purposes due to runtime overhead.
> >  endmenu
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 5da21f1510cc..ef1e6f7a234b 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
> > +             kfree(elm);
>
> I think __free() cleanup would be better than this.

Sorry, not sure what do you mean. kfree() is already is in this
function in case of failure.

>
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> >       if (xa_is_err(res))
> >               res = ERR_PTR(xa_err(res));
> > @@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
> >
> >       chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> >       if (!chunk)
> > -             return NULL;
> > +             return ERR_PTR(-ENOMEM);
>
> I don't think it's important to return -errno here, it's not that it's
> called from a syscall and we need to set errno for the userspace.
> BTW, the same applies to xa_load_or_alloc() IMO.

HM, but they are very different errors: ENOMEM, the KHO user can try
again after more memory is available, but the new -EINVAL return from
this function tells the caller that there is something broken in the
system, and using KHO is futile until this bug is fixed.

> > +
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE))) {
> > +             kfree(chunk);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> > +
> >       chunk->hdr.order = order;
> >       if (cur_chunk)
> >               KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
> > @@ -379,14 +390,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >       struct khoser_mem_chunk *chunk = NULL;
> >       struct kho_mem_phys *physxa;
> >       unsigned long order;
> > +     int ret = -ENOMEM;
> >
> >       xa_for_each(&kho_out->track.orders, order, physxa) {
> >               struct kho_mem_phys_bits *bits;
> >               unsigned long phys;
> >
> >               chunk = new_chunk(chunk, order);
> > -             if (!chunk)
> > +             if (IS_ERR(chunk)) {
> > +                     ret = PTR_ERR(chunk);
>
> ... and indeed, -errno from new_chunk() juts makes things more complex :(
>
> >                       goto err_free;
> > +             }
> >
> >               if (!first_chunk)
> >                       first_chunk = chunk;
> > @@ -396,8 +410,10 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >
> >                       if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
> >                               chunk = new_chunk(chunk, order);
> > -                             if (!chunk)
> > +                             if (IS_ERR(chunk)) {
> > +                                     ret = PTR_ERR(chunk);
> >                                       goto err_free;
> > +                             }
> >                       }
> >
> >                       elm = &chunk->bitmaps[chunk->hdr.num_elms];
> > @@ -414,7 +430,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >
> >  err_free:
> >       kho_mem_ser_free(first_chunk);
> > -     return -ENOMEM;
> > +     return ret;
> >  }
> >
> >  static void __init deserialize_bitmap(unsigned int order,
> > @@ -737,6 +753,9 @@ int kho_preserve_folio(struct folio *folio)
> >       const unsigned int order = folio_order(folio);
> >       struct kho_mem_track *track = &kho_out.track;
> >
> > +     if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
> > +             return -EINVAL;
> > +
> >       return __kho_preserve_order(track, pfn, order);
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_folio);
> > @@ -784,6 +803,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
> >       unsigned long failed_pfn = 0;
> >       int err = 0;
> >
> > +     if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
> > +                                     nr_pages << PAGE_SHIFT))) {
> > +             return -EINVAL;
> > +     }
>
> Can't we check this in __kho_preseve_order() and not duplicate the code?

Yes, that is possible, I will move it in the next version.

> > +
> >       while (pfn < end_pfn) {
> >               const unsigned int order =
> >                       min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
>
> --
> Sincerely yours,
> Mike.

