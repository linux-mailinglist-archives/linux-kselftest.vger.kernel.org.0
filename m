Return-Path: <linux-kselftest+bounces-44361-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98633C1D94B
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 23:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 856864E26D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 22:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F28318133;
	Wed, 29 Oct 2025 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="d/Y8YxX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA6B29B216
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761776606; cv=none; b=OdVFCxw46D+aEkBqlOy6LHLlzKVpjwPNipfabl+hqlm/rIoumk4acehdMfw0q94R21lJO52YfSF8IN5AJKAjkSbV885vHQ/AFyY/bYjQ949O8Nc/H00IBqmF3+7l+qLoe6+g4iIHmfOLvSAe5M1lCIcjK1CQazfFaN2WpkajSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761776606; c=relaxed/simple;
	bh=0Y78CioIXcFYqCT7J2U6NFL9zXeL/myq9J1+6AArRCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XlVpbfkKzDcqmhSyOcA882ohoN0GGt370+WUdDPQVZh3+LFrfVrKHWn5jCKpLwfT6eaah5bAQqcgA51KWyPi+eGBvxW9YABLp3wJcGkBJroTs01XoKiRygDqenO0BbcmVSmayCSdbpi70TBntQ9vlrbDL+3/I0KIFGmlI5cxrlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=d/Y8YxX1; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so79276266b.3
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Oct 2025 15:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761776603; x=1762381403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpv6Bu1gRrUbx52oNEm6LTdZ6YidJrARd+ghcU8tGMU=;
        b=d/Y8YxX1VAiOmpiGt3Ue0chFji5sf3GJonQNt5/XOkqwB20wHfYB6mEKMYe5tI792u
         6wDsIf2IuH6Hk7J0mF98aRquNvwi3u7OyO1kGnjg5tSa1ghm5RB/0gAAPJB+dT2efM7n
         mvqDhL8WUKoJNuCtE11MqByHdzA4wivQsgb8PvL0u0snM95mDS67G8zT1ct5YuCZ2634
         JuQnZB64xoi0nuz+1XNqOV2h5Zjve8VPtPcS3Cg7//evwQufRApn8q2AqCRbVFowO1JZ
         JRfs6iy2UWyYFgec/V/wPXw4S+f6EXZ2eDlQZAq2LiBjUa2khZhT7UCm6p+BIiZ2oWia
         EWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761776603; x=1762381403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpv6Bu1gRrUbx52oNEm6LTdZ6YidJrARd+ghcU8tGMU=;
        b=BQKfxlk06ensbWR99eOzwpX+TZkDDph4l1gtKgqnM+rtGh2dUP3Aa4lanc1UKS2NAT
         rNQ+bTdmODmn2j6+rRJBDmnLfi7HmlNx88Wf2CW6FhNRaeuNrZqkSLNDUKcnFfGIKYJZ
         uab2fsd8gRKomBGox/yB5WSpEaZlP2jH2Jpk66A3POS+qTW0qK0uKf6AXlOrGXkzsewc
         x0uCyZe88tgpvuaEORqAUESEbBw4UbgcvaKqmXBIdzeq+VeTfzvAhX8j2oEMjD/d7owH
         CxYxm42w6Pu9+T/v97r0J4irhCZMk5/P9QrMmXbbtt+ii3/9CjH9+kGhwKzoZ71sAric
         1RyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcq6WzKNg9V+fqb7lBvarB0SVFYmLyGVo9UD4juibzqXVw2KXLOPgz1h2XWAumWCPeyqseO1fivYYTg4dELaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxcTrIOqLZv4KtrGyCPNWrn+EIaaSRHYR+h1u+LU1wv/YxriC
	0VpLzaD5+66+f94r9SY+SDNUv74qjKuuSwsPk29XSXnOa6Jl0A4wlnupZSrBVyLTKYkETdDkkdR
	qZWrNNaSxPD+JQLb9gKH/4S12LA/MonzafM4cv2OH6A==
X-Gm-Gg: ASbGncu/pF053oxgFNBfCXPsqc7cNBNiBVABVW0OyCXbMa5sACMCx4LV7O5fpFCzUqC
	deoa8tLKMd3AbU431pOFOjwa28ZEEAifZbTrmS7P1O4icP58D+ACETQSdcLwii7I1n3gUx/tmXZ
	XAOTXFiykn48fZERRAaoJGu9spcTowJA238uVYTo6VfRj5R8agG1gp8CFCxZyBwfrshpuDlMgnm
	uu5QXgtxiTs41GBuQtKT4xJpoa+WpX879mzGv/+Z0y3FrT+IbAw08Mqp+0IP0shnpIx
X-Google-Smtp-Source: AGHT+IEGXWbi1zL2MYQq1jWo5fkcmj13mveE6SjemKqwCk4bOIMfIzJadEzaXl9lawQXtRHdx+HKvLwQpuN1CFTNwBw=
X-Received: by 2002:a17:907:7292:b0:b33:a2ef:c7 with SMTP id
 a640c23a62f3a-b703d5cb7efmr522068666b.55.1761776603191; Wed, 29 Oct 2025
 15:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-2-pasha.tatashin@soleen.com> <aQHUyyFtiNZhx8jo@kernel.org>
In-Reply-To: <aQHUyyFtiNZhx8jo@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 18:22:46 -0400
X-Gm-Features: AWmQ_bmdWz_K-6x0FqPYXVy37hUITH8KVofabeFsr0NG2wwGh65pPSXncqtE7HQ
Message-ID: <CA+CK2bB=k6ZxeEuLC9Xwtzmgm5MZdpH2sRgk84WQVm4uoeHsVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
To: Mike Rapoport <rppt@kernel.org>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net, 
	graf@amazon.com, jgg@ziepe.ca, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, masahiroy@kernel.org, 
	ojeda@kernel.org, pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org, 
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Would you like me to resend the series with the "+       depends on
KEXEC_HANDOVER" fix from Mike, or would you apply it into your tree
directly?

Thank you,
Pasha

On Wed, Oct 29, 2025 at 4:48=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Pasha,
>
> On Mon, Oct 20, 2025 at 08:08:50PM -0400, Pasha Tatashin wrote:
> > It is invalid for KHO metadata or preserved memory regions to be locate=
d
> > within the KHO scratch area, as this area is overwritten when the next
> > kernel is loaded, and used early in boot by the next kernel. This can
> > lead to memory corruption.
> >
> > Adds checks to kho_preserve_* and KHO's internal metadata allocators
> > (xa_load_or_alloc, new_chunk) to verify that the physical address of th=
e
> > memory does not overlap with any defined scratch region. If an overlap
> > is detected, the operation will fail and a WARN_ON is triggered. To
> > avoid performance overhead in production kernels, these checks are
> > enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/Kconfig.kexec             |  9 ++++++
> >  kernel/Makefile                  |  1 +
> >  kernel/kexec_handover.c          | 53 ++++++++++++++++++++++----------
> >  kernel/kexec_handover_debug.c    | 25 +++++++++++++++
> >  kernel/kexec_handover_internal.h | 16 ++++++++++
> >  5 files changed, 87 insertions(+), 17 deletions(-)
> >  create mode 100644 kernel/kexec_handover_debug.c
> >  create mode 100644 kernel/kexec_handover_internal.h
> >
> > diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> > index 422270d64820..c94d36b5fcd9 100644
> > --- a/kernel/Kconfig.kexec
> > +++ b/kernel/Kconfig.kexec
> > @@ -109,6 +109,15 @@ config KEXEC_HANDOVER
> >         to keep data or state alive across the kexec. For this to work,
> >         both source and target kernels need to have this option enabled=
.
> >
> > +config KEXEC_HANDOVER_DEBUG
> > +     bool "Enable Kexec Handover debug checks"
> > +     depends on KEXEC_HANDOVER_DEBUGFS
>
> I missed that in the earlier review, should be "depends on KEXEC_HANDOVER=
"
>
> @Andrew, can you please fold this into what's now commit 0e0faeffd144
> ("kho: warn and fail on metadata or preserved memory in scratch area")
>
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index c94d36b5fcd9..54e581072617 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -111,7 +111,7 @@ config KEXEC_HANDOVER
>
>  config KEXEC_HANDOVER_DEBUG
>         bool "Enable Kexec Handover debug checks"
> -       depends on KEXEC_HANDOVER_DEBUGFS
> +       depends on KEXEC_HANDOVER
>         help
>           This option enables extra sanity checks for the Kexec Handover
>           subsystem. Since, KHO performance is crucial in live update
>
> > +     help
> > +       This option enables extra sanity checks for the Kexec Handover
> > +       subsystem. Since, KHO performance is crucial in live update
> > +       scenarios and the extra code might be adding overhead it is
> > +       only optionally enabled.
> > +
> >  config CRASH_DUMP
> >       bool "kernel crash dumps"
> >       default ARCH_DEFAULT_CRASH_DUMP
>
> --
> Sincerely yours,
> Mike.

