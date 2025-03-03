Return-Path: <linux-kselftest+bounces-28090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DE0A4CC05
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 20:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFC71739A2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 19:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B99C22E002;
	Mon,  3 Mar 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpuA3+Vc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F71C8604
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030459; cv=none; b=ZgrkjovkdS6TDuvJHJTa2Je0CHXkDwis0gXLMuB6n7wswHp0z0HXI9A22COiHZPpnrRpPlP/cAanKWqkY8/Y83GKh0lPPEjrJELyzb2IK7KSQoMT8+iERTw4BTWdhnnurYawSEp10vGPr63BCiOwkyaLAdqo+BVUuSA93VAzjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030459; c=relaxed/simple;
	bh=v+CymtTSnhzau6gvKAu/GJ76T7dVVsDpnT9yJxPQmtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ff1RUc3ZlKvHKsdcl9i1TJGO3mz49Tbkk+sFfHmXpFksxphNg16td6Lm7i4mn2olMcz6JLbYHvxLkCkqnV6zbGUMKn1iraJkjciriypVcqxg9ohzKGU4vMLXUbUSpzbVPQ8waOL/4MKtP87SmBiOYZQhUHPGpfyRXSwWohZiWFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YpuA3+Vc; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f3ff8d7362so69469b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 11:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741030456; x=1741635256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TRJ44BH31NUhCHJXuBhqstjp6BiV2xjfEwoVOhwUP0=;
        b=YpuA3+VcdJluMgth9Y1o4DnQ1qkAf3A3HQ4/YSxzFHm9jyBjwoqChGbO1w9NHne3/s
         4kmHxGYUlS/bYmQoj8PZP5ImiT66Yq0bHElT/Cv1sTkD3meaeQrkqBTCwjRsHxAkkJZn
         OSTb1bdVDB4/Boj4ic+RkT4xBIF+CDQWEVk1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030456; x=1741635256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TRJ44BH31NUhCHJXuBhqstjp6BiV2xjfEwoVOhwUP0=;
        b=JkQT1NJwdFzt/1odR5uVYVnNpl0emyF4yEsApc4LVWuVqdx61kVnVBYWHYGRxD+12T
         HzVx2CtR98DRcAisLNzB8+kL8/IyE5EcEhyPVTRvVVWpNTaKal4SCJ47ddmrWVNwpZyS
         0I+yD8Ba3L8sQbPbJaGn5rD2/YI4KQeqEg3y/9q5RrssSlGTO6/34X0egiBYaPxu5PHd
         ElSvWxUFlJTM0FhurV6Wyd+vNuTCP9NFcYI5drWX+q3vOvTtWXAw9R+cDtJzCbMlFk5y
         43c+nE8Ou9SExugu8ybxPJlaQOPe6AZHHYIpF+IETYPqc6vvLyWthZCZ/e2ZgQA6X1km
         LLzA==
X-Forwarded-Encrypted: i=1; AJvYcCUiu/EqAtWQMONKt649i94jczeqfCHXD6RRxhtJVOfUf3G9Lt92pjZBFuoGoST1p8xix+CiDt4Aspf/ULEkm2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWpzUGsWqPEwzUXbf8NJ0NTJZokq9qgjQqHGT4Ua5DahIEoBbI
	XMmMJlt47FPnsgjZT/9TuytVvOADC0mleUybnbV0yzYMmcybvXXUlqtDvXbLwSZ9UGZzEal8YqM
	rZ4arQ0aPj2TyDcTDagRvspfceDxloo+8mwUg
X-Gm-Gg: ASbGnctp5ncuBPW4xlA/Za3zPmgmzyXxBBR4RVn+bYb/6QCmVDNhDktmwQOewzkZidD
	nn1FaKqKAdqPryx+DpzQ/arG51y1BySREhofNi9/9igZ6kcOTHiK2l5bNKrToOnKx6WOAvJLG0N
	hkHX4yBobBddHjyriQJfdn+oJ2MtfAG76Hoh2Zvz6h1PILFQHLvFyR2gw=
X-Google-Smtp-Source: AGHT+IEwrg6wY8Y2ouC1pR3h3Bh3ijMUnINP28bst/fv0Tz3SsD+Thqpp0hOQ1CjWKueIO3bwWa1zIY9jvKARU43hRY=
X-Received: by 2002:a05:6808:179f:b0:3f4:3ec:11ff with SMTP id
 5614622812f47-3f558304cd2mr3549126b6e.0.1741030456616; Mon, 03 Mar 2025
 11:34:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303050921.3033083-1-jeffxu@google.com> <20250303050921.3033083-4-jeffxu@google.com>
 <24be17fd-4899-49ae-9b4e-9372fcb4e0cd@lucifer.local>
In-Reply-To: <24be17fd-4899-49ae-9b4e-9372fcb4e0cd@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 3 Mar 2025 11:34:05 -0800
X-Gm-Features: AQ5f1Jq2xY3e4auvFuYbMS1vMNpdRf4M_yrHWrDo25LJ6mNLdQqRcc_Co3iWjCs
Message-ID: <CABi2SkVbu13SQ9HOWHiVUqCddYc9tuphV4L-obDQaEQy5wqx1w@mail.gmail.com>
Subject: Re: [PATCH v8 3/7] mseal sysmap: enable x86-64
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, jorgelo@chromium.org, sroettger@google.com, 
	hch@lst.de, ojeda@kernel.org, thomas.weissschuh@linutronix.de, 
	adobriyan@gmail.com, johannes@sipsolutions.net, pedro.falcato@gmail.com, 
	hca@linux.ibm.com, willy@infradead.org, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:01=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> I tried b4 shazam'ing this and there's a problem applying the patch, seem=
s
> maybe a conflict?
>
> Not sure if Andrew can resolve or if something needs to be done here?
>
> Seems to be commit d77a800944d8 ("mm: make DEBUG_@WX dependent on
> GENERIC_PTDUMP")?
>
> Should be a trivial resolve though.
>
This version is based on linux-main, if that helps resolving the conflict.

I can also rebase using the mm-(unstable/stable) branch or other
branches if asked.

Thanks
-Jeff


> On Mon, Mar 03, 2025 at 05:09:17AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on x86-64,
> > covering the vdso, vvar, vvar_vclock.
> >
> > Production release testing passes on Android and Chrome OS.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  arch/x86/Kconfig          | 1 +
> >  arch/x86/entry/vdso/vma.c | 7 ++++---
> >  2 files changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index be2c311f5118..c6f9ebcbe009 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -26,6 +26,7 @@ config X86_64
> >       depends on 64BIT
> >       # Options that are inherently 64-bit kernel only:
> >       select ARCH_HAS_GIGANTIC_PAGE
> > +     select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> >       select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
> >       select ARCH_SUPPORTS_PER_VMA_LOCK
> >       select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
> > diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
> > index 39e6efc1a9ca..a4f312495de1 100644
> > --- a/arch/x86/entry/vdso/vma.c
> > +++ b/arch/x86/entry/vdso/vma.c
> > @@ -268,7 +268,8 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >                                      text_start,
> >                                      image->size,
> >                                      VM_READ|VM_EXEC|
> > -                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
> > +                                    VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
> > +                                    VM_SEALED_SYSMAP,
> >                                      &vdso_mapping);
> >
> >       if (IS_ERR(vma)) {
> > @@ -280,7 +281,7 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >                                      addr,
> >                                      (__VVAR_PAGES - VDSO_NR_VCLOCK_PAG=
ES) * PAGE_SIZE,
> >                                      VM_READ|VM_MAYREAD|VM_IO|VM_DONTDU=
MP|
> > -                                    VM_PFNMAP,
> > +                                    VM_PFNMAP|VM_SEALED_SYSMAP,
> >                                      &vvar_mapping);
> >
> >       if (IS_ERR(vma)) {
> > @@ -293,7 +294,7 @@ static int map_vdso(const struct vdso_image *image,=
 unsigned long addr)
> >                                      addr + (__VVAR_PAGES - VDSO_NR_VCL=
OCK_PAGES) * PAGE_SIZE,
> >                                      VDSO_NR_VCLOCK_PAGES * PAGE_SIZE,
> >                                      VM_READ|VM_MAYREAD|VM_IO|VM_DONTDU=
MP|
> > -                                    VM_PFNMAP,
> > +                                    VM_PFNMAP|VM_SEALED_SYSMAP,
> >                                      &vvar_vclock_mapping);
> >
> >       if (IS_ERR(vma)) {
> > --
> > 2.48.1.711.g2feabab25a-goog
> >

