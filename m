Return-Path: <linux-kselftest+bounces-43621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D1BF3CB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 23:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD9E54E48F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6082ECD37;
	Mon, 20 Oct 2025 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TBt5uTMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8E1EF39E
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760997435; cv=none; b=iqJWtK/scmcSFqinSSkp7rwMHU09KP+CrYzLyOKoxD5qOJ9pTgTxt13JI3/of1RXij6oTRpRKUOOZJZUveyO1LvcrkaKFNwroQkgDuO7wdWf6DXbYGkXJOZceITszWsqKJlHGQ8VVF4l6IndqOnXuwiUFeMT6A+92Sn/fvvBAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760997435; c=relaxed/simple;
	bh=V768A8yxayt7P4IfA0lT/xT5Fhuc4WSMi3Z0ranezsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ASdsp6PXC0sZWOnpnsidhH4z4hGqV/ZDGNaNIaeyIOQPOVFQ5ntnlPcUjdlqc7CFqSeO9sdNc7ErZumkkZJ677RxsXuYnmsuFUhLANbSu5oiTKK9ZPpvchgl5DYtbTi3R9z+j6rY06R1zgIIyX3sNgOPeloMXtqwEe/vzVJOsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=TBt5uTMD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e7cc84b82so942740866b.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760997432; x=1761602232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yknPt/PYO8q5rRsHwsdUNqs0P5wiVU3fHyZ3dxpXBPg=;
        b=TBt5uTMDCPlJKdFEd4YNcVZ6UPjAh3XCPoohpq6P2BglQYr60tiv1p3iCxYpliLASx
         of5Bz68276tsl+RDxY/YkgKeNAbyjcVHnYjHVNdXvz+xW89u3eQlj0xF6Gluqf8ZxUyK
         UUhkXbxS33dfMoKDjpuVnw80GVaG3JWEEuI0PNSD0zlHZ2sDHz+8AK3wRwtPN4rqLxAr
         Tcz+ZiHX8tAUHcXUDdFkxPY2BWuVR8jM25YjA/zr61DyJal1+3bXyhbhdJ5UKY3hyYIW
         tVgpA27m81WH6bxLaf5BXAOEqacT465eoJNUfof2yrn//xvgf7pALW0DtUHfd7pGGIO6
         LBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760997432; x=1761602232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yknPt/PYO8q5rRsHwsdUNqs0P5wiVU3fHyZ3dxpXBPg=;
        b=Czz3WYsBK5KDlXwHJuFX27bcLjL4DFLsdsiSRfMytLWC3RFWM8+daIeGMQbYG4MNNz
         Dt/FuUcuC53nuybZ8ljNepavGeViuzkSfrXnx6mPmU35sFJxnzqUB9MGp2XFpy0iZ/8V
         HdudhBzPg1JPLEL1814agcbCqA2OPmgD7aKE9dqb/YRe6Kf35NpQ853wLbGadViLBYjE
         ClKkcUJT8+66uk1lcPN8RZ4V1LhFLYdIde5rqizsd+D1i+DuwzjHLn7tM22ZEMbQ+UJz
         acwQHyAfAx6JVcfaAtg6bT26aBWC46ylrQ3zedWBiuMCAmxtX1pokTsEoC/QEVFiufqC
         oVJA==
X-Forwarded-Encrypted: i=1; AJvYcCXYzK446Diigj2mAVXvukpcrQGpvG3QoCEALKTxvaQ5ekPe8F+rnEdlOHl3rOsI3G6+6RaVEXRd9yBMwmSlGk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPlSojFMHAzjiziCN6f/lhl1j5ARKJM/Ha3yO1oLmNXbqcyDlC
	gYY+dKkMuKPoGHFkekqe6n4OERnfAIK0k7gBTQ3TGr3XABYiYvEdZsuFpAUOgBXu6TBP91rbptT
	2Q5mV+zh7Tq+Zf+mHs1exPQEypiEn/7a+yZO6ycLN9w==
X-Gm-Gg: ASbGncsQmK8LoHUjVgt/j9029jEUHMl+U6a6FEv/+QDNn3+0qvrSTJqA932c1syTT1V
	SDJeHPocmoTkz8bNoBRotTPXseOcyCbJJSH3ogpTJe8k42Au09TBV12UGd7LihdhHxrVdFIZ550
	kzk3i/k1mzZLeJP0Lr7LaP23Ulm3dtNs4uQAofSLIjjDbCxYlSJgShYFeprhU4YrUNEs317xytw
	vyPaZA/1ZmzG4RpfTvtLHTDk8yzzNw3WbLi/xJp1+vmUhjOdK4GkAk3czOHieoEkXLA
X-Google-Smtp-Source: AGHT+IHQae2JTSc9wDUKvH2Zkgs7s+B9woSGFjjo4cTKOt1mF9fuNToFGqWKvdpPe0XvAAEv7aHWf3quANxxuxkPcIo=
X-Received: by 2002:a17:907:3d91:b0:b30:2f6b:448f with SMTP id
 a640c23a62f3a-b6473245877mr1851254166b.25.1760997431856; Mon, 20 Oct 2025
 14:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018171756.1724191-1-pasha.tatashin@soleen.com>
 <20251018171756.1724191-9-pasha.tatashin@soleen.com> <aPXrLy8BmblbLpCG@kernel.org>
In-Reply-To: <aPXrLy8BmblbLpCG@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 20 Oct 2025 17:56:34 -0400
X-Gm-Features: AS18NWAztFjNYjBIm4rRiGeQCx-E5VPlPZGMKjs9EYAdnOCA2q6eV6QJOgzo-JU
Message-ID: <CA+CK2bDMYwd59_+OkRN-qcy70V=06Ui1AhCiMb9YJRPdn3-SYQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"

> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem. Since, KHO performance is crucial in live update
> > +       scenarios and the extra code might be adding overhead it is
> > +       only optionally enabled.
>
> And empty line here would be nice.

Done.

>
> >  endmenu
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index c87d00c40c82..ebfc31814d16 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -8,6 +8,7 @@
> >
> >  #define pr_fmt(fmt) "KHO: " fmt
> >
> > +#include <linux/cleanup.h>
> >  #include <linux/cma.h>
> >  #include <linux/count_zeros.h>
> >  #include <linux/kexec.h>
> > @@ -131,26 +132,26 @@ static struct kho_out kho_out = {
> >
> >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> >  {
> > -     void *elm, *res;
> > +     void *res = xa_load(xa, index);
> >
> > -     elm = xa_load(xa, index);
> > -     if (elm)
> > -             return elm;
> > +     if (res)
> > +             return res;
> > +
> > +     void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
> >
> > -     elm = kzalloc(sz, GFP_KERNEL);
> >       if (!elm)
> >               return ERR_PTR(-ENOMEM);
> >
> > +     if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz)))
>
> I'd move the WARN_ON into kho_scratch_overlap().

I do not like O(N^2), let's keep it outside, even though it is a debug
kernel, there is no need to make it unnecessary slow, when we are
saving just two lines of code.

>
> > +             return ERR_PTR(-EINVAL);
> > +
> >       res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
> >       if (xa_is_err(res))
> > -             res = ERR_PTR(xa_err(res));
> > -
> > -     if (res) {
> > -             kfree(elm);
> > +             return ERR_PTR(xa_err(res));
> > +     else if (res)
> >               return res;
> > -     }
> >
> > -     return elm;
> > +     return no_free_ptr(elm);
> >  }
>
> ...
>
> > @@ -379,14 +384,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
> >       struct khoser_mem_chunk *chunk = NULL;
> >       struct kho_mem_phys *physxa;
> >       unsigned long order;
> > +     int ret = -ENOMEM;
>
> Nit: s/ret/err/

Done.

>
> >
> >       xa_for_each(&kho_out->track.orders, order, physxa) {
> >               struct kho_mem_phys_bits *bits;
> >               unsigned long phys;
> >
> > diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
> > new file mode 100644
> > index 000000000000..7986dcc63047
> > --- /dev/null
> > +++ b/kernel/liveupdate/kexec_handover_debug.c
> > @@ -0,0 +1,25 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * kexec_handover_debug.c - kexec handover optional debug functionality
> > + * Copyright (C) 2025 Google LLC, Pasha Tatashin <pasha.tatashin@soleen.com>
> > + */
> > +
> > +#define pr_fmt(fmt) "KHO: " fmt
> > +
> > +#include "kexec_handover_internal.h"
> > +
> > +bool kho_scratch_overlap(phys_addr_t phys, size_t size)
> > +{
> > +     phys_addr_t scratch_start, scratch_end;
> > +     unsigned int i;
> > +
> > +     for (i = 0; i < kho_scratch_cnt; i++) {
> > +             scratch_start = kho_scratch[i].addr;
> > +             scratch_end = kho_scratch[i].addr + kho_scratch[i].size - 1;
>
> I agree with Pratyush that
>
>                 scratch_end = kho_scratch[i].addr + kho_scratch[i].size;
>
>                 if (phys < scratch_end ...
>
> is clearer.

Done.

Thanks,
Pasha

