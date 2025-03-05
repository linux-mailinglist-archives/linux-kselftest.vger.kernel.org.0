Return-Path: <linux-kselftest+bounces-28316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F22EEA50384
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 16:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21C4B16A0FC
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 15:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFD0248895;
	Wed,  5 Mar 2025 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxoCQqR3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEAE2E3389
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741188778; cv=none; b=FdOmjD7HCkWiosLes646rrCoXykPIlokBNnHG7DwzROTWikdEWuYYWD5XwvwfRpM39O1DVqwT+f79kEretu/8XRUi2hh0Ufi7C87/WdEF1qY2/8ocD9jxnKbmoCMJAkZ8DtuE8RJfGwFLnvjj0YnWUReBvLTx8flhj2Rix0eM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741188778; c=relaxed/simple;
	bh=TfTznDHxpfcuoOq7SmzlrxC65Gw8TiLrqyQHhdNlTDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EbPouFurbnkiaOG401Nr69FT3OW6/d+OGuyRMbNgSn7G068g0WdjnDjr2rsx9W6nQzNQfumgd1lvVqIUX/HW4S5gxJJIwi5RgEKN9Gmlxa25z/PQr1bZ4K6k+IZqgE1AAveAI9438CGupVIHgByJnM1YFVzXIWc10Y3ujQuGsLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dxoCQqR3; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3f68adc3864so10354b6e.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Mar 2025 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741188775; x=1741793575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SS6BzhqiixXwpgZ1lOCUu0lGg37nPCW8otcVBfAF/jU=;
        b=dxoCQqR3qwmiReFGOMfBj1KrjQg7EipMS2rPGB+9vxWWRJ7luvyIG1YbArF+41xKH1
         BXRknyQTEA7f4MA32v/2P/g7fs3nFI/t/3rGMbZKO70E+LzKcFIKm4dfLCuRR8DBTrAP
         NA7oJVKa6PsvnqR7bciI8VZw/vgQfJtf4l5Vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741188775; x=1741793575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SS6BzhqiixXwpgZ1lOCUu0lGg37nPCW8otcVBfAF/jU=;
        b=aaJryICqGTBCbaarH12OMNvd10yBHRULi1z7lkxtamyFfkh0/Mrh4wzKA5IJbaMqaw
         DBpYzBWHMt2fkjfd9dM7npjuC6NwgQm56hx5CiHp1bIaQ7xTiUu2H12lp6W2h3rS1tLu
         h19DM8ItqFv7uh8oYcw0adLdBOd2aw+9288YLZopuk8KHP/DTMegy2wZc34yq1RyReQH
         Tv2qDzoB6thuJuR6Ro0/vqsS2DgOL5EYO98Sx/LBl36Fd0TWFvww8xdgHfN9iZkG603M
         G7LyHpdPkdk+976YxEkSnPijE1NILdxLrnJFdV0XCc2wHh3KnUnp7oFbdX6DdfJcvaPI
         9wew==
X-Forwarded-Encrypted: i=1; AJvYcCUyT7ElQkLqA3YdFEy6c3vAuqXxUINAUbn4n8ni1PoMgyDpTCLX8US8OAXrXyF3ayLIXQyDGXl08BQlu+LG/uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAOqSGW2fnjgqTLuyxlEbPup3ybRl9+HiH17jVIlkcNll/NynX
	h2yitTGevqGj/Dc75lsf659/eK8bz5wtiluFyLwXgxH6AN/TrFmkXvKsrfFCffwwfuUDeXpnUbN
	tmSdPH/+AMKeR2PqwzeBBr5D/rRQWTSl5GO1K
X-Gm-Gg: ASbGncu6Y0fLv7v64/t01jxlCk8MLTGrSa7LjOgJlE3jk/BVg0BQbW/VFYG0vHMRLWc
	2bW9SN901SMPmBm/SB8lofGxhfb1pp7/XRWeXrcxut+oePLAIVufqsdhO8z7Zlma6/xqUMRd6FU
	p0lBSfKYbM6w1/lODgzqdWUbrv1M2KT31yKLUQtauJaxNgtUssN6MqfLsk+z0=
X-Google-Smtp-Source: AGHT+IFmgQ/jsM4ekshudszqyy/BHab2n0718o5/RoujAOysfXPRGiP2FfWjW9zuj0BCFQvhc76kV7MrdK1QvZDlJA0=
X-Received: by 2002:a05:6830:4490:b0:727:2f27:2a5d with SMTP id
 46e09a7af769-72a1fcbf088mr630865a34.3.1741188775377; Wed, 05 Mar 2025
 07:32:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305021711.3867874-1-jeffxu@google.com> <20250305021711.3867874-2-jeffxu@google.com>
 <2a42ac63-d7a2-48ae-ae86-568d0fc59d51@lucifer.local> <544138c0-5668-4a6b-9160-59da95b990f6@lucifer.local>
In-Reply-To: <544138c0-5668-4a6b-9160-59da95b990f6@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 5 Mar 2025 07:32:43 -0800
X-Gm-Features: AQ5f1JotN2ty1jvx9pG2bDT15L1-P_rvXknb6-3kPtBF4GqlDgBfa9YcB410LUQ
Message-ID: <CABi2SkXoRWQ7_xaYZECWWRZOMcVhzwJK_y8guhdCMYMV9Of=yw@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] mseal sysmap: kernel config and header change
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
	mike.rapoport@gmail.com, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:57=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Mar 05, 2025 at 05:54:24AM +0000, Lorenzo Stoakes wrote:
> > On Wed, Mar 05, 2025 at 02:17:05AM +0000, jeffxu@chromium.org wrote:
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Provide infrastructure to mseal system mappings. Establish
> > > two kernel configs (CONFIG_MSEAL_SYSTEM_MAPPINGS,
> > > ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS) and VM_SEALED_SYSMAP
> > > macro for future patches.
> > >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > Reviewed-by: Kees Cook <kees@kernel.org>
> >
> > Umm... I reviewed this too? :) unless you made substantial changes here
> > (doesn't appear so), please do propagate tags for each revision :>)
> >
> > Anyway, FWIW:
> >
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
>
> (you also forgot to propagate Liam's tag here)
>
Sorry about that, I missed  "Reviewed-by" from you and Liam's from V8 [1] [=
2]
[1] https://lore.kernel.org/all/maamck3gjqjikefwlubtzg4ymaa6vh47hlxqqn4v23g=
qwl2tli@t372meccgycq/
[2] https://lore.kernel.org/all/0ea20f84-bd66-4180-aa04-0f66ce91bdf6@lucife=
r.local/

Thanks


> > > ---
> > >  include/linux/mm.h | 10 ++++++++++
> > >  init/Kconfig       | 22 ++++++++++++++++++++++
> > >  security/Kconfig   | 21 +++++++++++++++++++++
> > >  3 files changed, 53 insertions(+)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 7b1068ddcbb7..8b800941678d 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4155,4 +4155,14 @@ int arch_get_shadow_stack_status(struct task_s=
truct *t, unsigned long __user *st
> > >  int arch_set_shadow_stack_status(struct task_struct *t, unsigned lon=
g status);
> > >  int arch_lock_shadow_stack_status(struct task_struct *t, unsigned lo=
ng status);
> > >
> > > +
> > > +/*
> > > + * mseal of userspace process's system mappings.
> > > + */
> > > +#ifdef CONFIG_MSEAL_SYSTEM_MAPPINGS
> > > +#define VM_SEALED_SYSMAP   VM_SEALED
> > > +#else
> > > +#define VM_SEALED_SYSMAP   VM_NONE
> > > +#endif
> > > +
> > >  #endif /* _LINUX_MM_H */
> > > diff --git a/init/Kconfig b/init/Kconfig
> > > index d0d021b3fa3b..7f67d8942a09 100644
> > > --- a/init/Kconfig
> > > +++ b/init/Kconfig
> > > @@ -1882,6 +1882,28 @@ config ARCH_HAS_MEMBARRIER_CALLBACKS
> > >  config ARCH_HAS_MEMBARRIER_SYNC_CORE
> > >     bool
> > >
> > > +config ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > +   bool
> > > +   help
> > > +     Control MSEAL_SYSTEM_MAPPINGS access based on architecture.
> > > +
> > > +     A 64-bit kernel is required for the memory sealing feature.
> > > +     No specific hardware features from the CPU are needed.
> > > +
> > > +     To enable this feature, the architecture needs to update their
> > > +     special mappings calls to include the sealing flag and confirm
> > > +     that it doesn't unmap/remap system mappings during the life
> > > +     time of the process. The existence of this flag for an architec=
ture
> > > +     implies that it does not require the remapping of the system
> > > +     mappings during process lifetime, so sealing these mappings is =
safe
> > > +     from a kernel perspective.
> > > +
> > > +     After the architecture enables this, a distribution can set
> > > +     CONFIG_MSEAL_SYSTEM_MAPPING to manage access to the feature.
> > > +
> > > +     For complete descriptions of memory sealing, please see
> > > +     Documentation/userspace-api/mseal.rst
> > > +
> > >  config HAVE_PERF_EVENTS
> > >     bool
> > >     help
> > > diff --git a/security/Kconfig b/security/Kconfig
> > > index f10dbf15c294..a914a02df27e 100644
> > > --- a/security/Kconfig
> > > +++ b/security/Kconfig
> > > @@ -51,6 +51,27 @@ config PROC_MEM_NO_FORCE
> > >
> > >  endchoice
> > >
> > > +config MSEAL_SYSTEM_MAPPINGS
> > > +   bool "mseal system mappings"
> > > +   depends on 64BIT
> > > +   depends on ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > +   depends on !CHECKPOINT_RESTORE
> > > +   help
> > > +     Apply mseal on system mappings.
> > > +     The system mappings includes vdso, vvar, vvar_vclock,
> > > +     vectors (arm compat-mode), sigpage (arm compat-mode), uprobes.
> > > +
> > > +     A 64-bit kernel is required for the memory sealing feature.
> > > +     No specific hardware features from the CPU are needed.
> > > +
> > > +     WARNING: This feature breaks programs which rely on relocating
> > > +     or unmapping system mappings. Known broken software at the time
> > > +     of writing includes CHECKPOINT_RESTORE, UML, gVisor, rr. Theref=
ore
> > > +     this config can't be enabled universally.
> > > +
> > > +     For complete descriptions of memory sealing, please see
> > > +     Documentation/userspace-api/mseal.rst
> > > +
> > >  config SECURITY
> > >     bool "Enable different security models"
> > >     depends on SYSFS
> > > --
> > > 2.48.1.711.g2feabab25a-goog
> > >

