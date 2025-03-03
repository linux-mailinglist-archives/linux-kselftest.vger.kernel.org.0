Return-Path: <linux-kselftest+bounces-28089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3DDA4CBF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 20:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AE4173906
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 19:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A8922F17B;
	Mon,  3 Mar 2025 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fXBDlPdh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428A1EF0B7
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741030176; cv=none; b=F1dZTt6psWJrDhTiNoj+R3E+0AMI3bz8nORPU2iue90u2wFOEv1aofe1VKbBXm4/z6sNHwHHeo8vxZ0KH4b7klWdxb1EGqZ6tblAHkb4H4YDoSQTh2Qk31OXhKLNSwqtQgTx/amANQdEFAiM2KYkNH96JIA7LlYiE8RztIL+gUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741030176; c=relaxed/simple;
	bh=cg5RFTUeHXvHldBYXq+EDsTRu38vvlrrKZ5Iv5575aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PmHp73KrLp2ZwONEOvLoLOw4nhB4Z3lfLtx93GNB3kfbB0hnbAW7DBS8eKmOtynTYcznsTaXQVy+7UsUgZTMzev586j2kJE7eykcf9u+xUEpSCh+I0D9/O0mWeIpHqSURBTPNxPX+QD/KqLjS45euMV05+xGAntwRoK2xwtOLuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fXBDlPdh; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2b1f2b286f5so499413fac.3
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 11:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741030173; x=1741634973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wm1bw6PogSWQ/oeY0cZaU0D8DinTMlzqO3h/YyHdka4=;
        b=fXBDlPdhSfjM8CGY17i+INbHZ/re1yv7RpigtEwE2yv7Ok9phVI5JhplNDzqJtejWI
         gTxSmq1BmQqjFD78Z6gsZagraTiYWf9yJHnrtS7HNrHskm0cFgzV24pymPfCDmi5oJ7m
         tUtiU5iS81hPZwjP6vWtQXCTrgii3V9sKgmoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741030173; x=1741634973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wm1bw6PogSWQ/oeY0cZaU0D8DinTMlzqO3h/YyHdka4=;
        b=BOpbMmDbvPHAbhEQDvCM2bVccjxuWM0xT0frLn2Iap/i8Pd0fxGtYMHV2qxfgb4lOI
         /jDHdI9XVForp70u+NFZM7rGMks+OPBYSgBIW1xSwdvVkuW5HyVf3cP56NAIH0IPg82s
         vH4w1pqzzODlfqkqLoh6ZFDkKEKaCV89pniNHGt4vaJJ2/RQl5i0AALHJ2QLUGmI/nfI
         G+ZpeIgdXE3dVPy4zq3ScYqUm0IYw/fEvXfn/RyK3QEX0w1yBgiywKfc70aNBRurn/LI
         Nxqrxx1gTKltcgAS4rblvO/2jEAswErKvr+714v8vnE7WbGHPOFlloSMLyztNv6NRx0U
         CMzg==
X-Forwarded-Encrypted: i=1; AJvYcCVWBdFrQQN81JYO636euLf6ENzk6JVS/RnmQe3+SRqE1Cufda5loNJoXiOXGe0v/O5G788Mkufh5dOy8ddjQE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAXAkIFuJ8hUa+aCeO4Q5QiPDXtwaVvru0SWnOKQJhcSt6Jhoq
	Ycbv6h9m2+52Fh+KcH5+G3hvWYU1ibpQezDmvFVo/PMCxj5QcHX0E5a76AgiLR9eg30WMfpaqUK
	+NrEPCho6BZsj/jfHYiWNXnFXP4lZbADeUlQV
X-Gm-Gg: ASbGnct2MCvv+ONVnyNK3u5AgyjX3VP6LFKepmS8gJhLwKW0oF1dJVmLne6Dzqqh9ai
	a03Xhe6yPdUz6ZfQGit+0onibMAS6PNFm/TmVSyIXwa5FkOGpqVjesWBHyZWjXucDMpUQq27ZB0
	c995TK4D0L1/gklYupZxXvq9XC/xf7kS22ge/8ZcnD0U00dKZHvdozWls=
X-Google-Smtp-Source: AGHT+IF6t86k4HXZQOpYrZhTArHYnjZ+cSsTfbGMol0i8lJDnf/V6fvf43xFaF25VFFNhp6135KGfflzyp8sId/j2Ao=
X-Received: by 2002:a05:6808:1a27:b0:3f4:756:52e6 with SMTP id
 5614622812f47-3f5584f51b0mr3566805b6e.1.1741030173329; Mon, 03 Mar 2025
 11:29:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303050921.3033083-1-jeffxu@google.com> <20250303050921.3033083-2-jeffxu@google.com>
 <202503030834.C4ED5911A@keescook>
In-Reply-To: <202503030834.C4ED5911A@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 3 Mar 2025 11:29:21 -0800
X-Gm-Features: AQ5f1JpNJhlC4d3_-OlZv4_ZKEKPcTm851BECZGkcYWdJqb17n518uve8jCwfqo
Message-ID: <CABi2SkUgmxLe6GOeRq1Lo7yz-FG0dfeAuxK4woz2JPVPH9c-Ow@mail.gmail.com>
Subject: Re: [PATCH v8 1/7] mseal sysmap: kernel config and header change
To: Kees Cook <kees@kernel.org>
Cc: akpm@linux-foundation.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
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

On Mon, Mar 3, 2025 at 8:37=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 03, 2025 at 05:09:15AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Provide infrastructure to mseal system mappings. Establish
> > two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> > macro for future patches.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  include/linux/mm.h | 10 ++++++++++
> >  init/Kconfig       | 22 ++++++++++++++++++++++
> >  security/Kconfig   | 21 +++++++++++++++++++++
> >  3 files changed, 53 insertions(+)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 7b1068ddcbb7..8b800941678d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_str=
uct *t, unsigned long __user *st
> >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned long =
status);
> >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned long=
 status);
> >
> > +
> > +/*
> > + * mseal of userspace process's system mappings.
> > + */
> > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > +#define VM_SEALED_SYSMAP     VM_SEALED
> > +#else
> > +#define VM_SEALED_SYSMAP     VM_NONE
> > +#endif
> > +
> >  #endif /* _LINUX_MM_H */
> > diff --git a/init/Kconfig b/init/Kconfig
> > index d0d021b3fa3b..c90dd8778993 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> >       bool
> >
> > +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +     bool
> > +     help
> > +       Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       To enable this feature, the architecture needs to update their
> > +       special mappings calls to include the sealing flag and confirm
> > +       that it doesn't unmap/remap system mappings during the life
> > +       time of the process. The existence of this flag for an architec=
ture
> > +       implies that it does not require the remapping of thest system
>
> typo nit: "the" instead of "thest"
>
> > +       mappings during process lifetime, so sealing these mappings is =
safe
> > +       from a kernel perspective.
> > +
> > +       After the architecture enables this, a distribution can set
> > +       CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config HAVE_PERF_EVENTS
> >       bool
> >       help
> > diff --git a/security/Kconfig b/security/Kconfig
> > index f10dbf15c294..5311f4a6786c 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
> >
> >  endchoice
> >
> > +config MSEAL_SYSTEM_MAPPINGS
> > +     bool "mseal system mappings"
> > +     depends on 64BIT
> > +     depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +     depends on !CHECKPOINT_RESTORE
> > +     help
> > +       Apply mseal on system mappings.
> > +       The system mappings includes vdso, vvar, vvar_vclock,
> > +       vectors (arm compact-mode), sigpage (arm compact-mode), uprobes=
.
>
> typo nits: "compat" instead of "compact".
>
Got it, I will change everywhere for this (mseal.rst, coverletter)


> > +
> > +       A 64-bit kernel is required for the memory sealing feature.
> > +       No specific hardware features from the CPU are needed.
> > +
> > +       WARNING: This feature breaks programs which rely on relocating
> > +       or unmapping system mappings. Known broken software at the time
> > +       of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Theref=
ore
> > +       this config can't be enabled universally.
> > +
> > +       For complete descriptions of memory sealing, please see
> > +       Documentation/userspace-api/mseal.rst
> > +
> >  config SECURITY
> >       bool "Enable different security models"
> >       depends on SYSFS
> > --
> > 2.48.1.711.g2feabab25a-goog
> >
>
> Perhaps akpm can fix these up directly instead of a v9 spin?
>
V9 is relatively easy for me. I probably need a good version for
backporting to chromeOS/Android.

If all goes well, I'll follow up with a V10 based on Thomas
Wei=C3=9Fschuh's vdso refactor branch [1] [2].

[1] https://lore.kernel.org/all/CABi2SkXwaJ=3Ds3XqHKu1aFVfcacgxpQ5Ji1_BqaN+=
ch2i_RnA9Q@mail.gmail.com/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/?h=3Dti=
mers/vdso


> But otherwise, yes, reads well to me:
>
> Reviewed-by: Kees Cook <kees@kernel.org>
>
> --
> Kees Cook

