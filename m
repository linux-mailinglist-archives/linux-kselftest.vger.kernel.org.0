Return-Path: <linux-kselftest+bounces-11918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37EE908664
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 10:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EC1B2490D
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 08:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B431190068;
	Fri, 14 Jun 2024 08:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEadpkbK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0B190044;
	Fri, 14 Jun 2024 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354123; cv=none; b=HHEwvY/JjJKyAwzXyHY9jlB2MuW1/ajuepz8D4wQpPDXMMcfzzdEtGLjd8ApJrTsT+UDAeOB+/ayAYF2luESv1F2SZ78tX45t4SPRZ0c5pNaj4NqTtGSxjcZTQ1jnBUNU0+mZ/Khi+tr7sU2FNbkV7xyQUdD7L8jthv/uJIh05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354123; c=relaxed/simple;
	bh=a5UwVV67a2jLUz2GPxUMVFlQhY06wFG1TwJdC7MdDFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OIemyxWxxyFg16SZqNQIF7traYozctxlp/d9ncTY6rgCPQcrJJTUJ03uVkBV8wJFS7sogwSCkLrhEaOEkSNXS3994WmJi8rc4rMhh48pkzfsQufa2EchQUB7yGd7tpM3fpJMdPqYvLubzzreQ5PYmXVDLRS9vpyE/TZGnSU+vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEadpkbK; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4ed09e0141bso77220e0c.2;
        Fri, 14 Jun 2024 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718354120; x=1718958920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBD23S6qCIO944R+FXPTl9o8IozbKBuB6Ed3Es8CaDg=;
        b=QEadpkbKsGDLcBPXmZuVWLLsC+th99e5eei1yFkASESzCgW2H3wjTTDCSXWyx8kRFE
         hLWrZY4i/ewGqMgxq7REYw8bG75+SDbmsMu40WW17IMINC4VIbbuX1A4zyN4CjlY0PYQ
         /lFGHPToNCdi5y0vwIKIoWiF/PYz/GqvH9Re28+Ir+Anco4YrBiN80Olo7S77BSqIYmU
         623Dfb1LFMpbWpSjqmgtbVfv66XBVhcBs1DOFgR1AfiRLDJrcY4iipbZTpWVye8gbp6y
         8zshWBICwx530+7smbWUrl+c/ED9ZGilFIQTr3iRx9UBlNfrZOnGY92IkS0Q8KlzpaGM
         d/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354120; x=1718958920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UBD23S6qCIO944R+FXPTl9o8IozbKBuB6Ed3Es8CaDg=;
        b=PHuHDJtkbxuL7QLxkNR/71NncFPLITHGqWRY4FJGUBy8kuOkdA2LSevRhvUJQyK7hO
         xGOqp98RsOxS41SWqfoVbxZ3kyZXibHbFcW4mDadoL/R5pIlqC5HJ/IHUeE0cRgv7kWh
         2ibYrcEEQRq1MTLLVIvu5UrZHDbf/ybz+dr+EBA/Rir7VjwZ78EciaEP8QfcGxdO9K6j
         TY6dmsxYPUy9vLMUWhkkzIO3+oWFp8IKBx8ch9jsfjNko7Yp5Gyc786MnnDZrGtkwpnx
         o3tPU6c6twwu5KSDOxgSWx7oUgLjlNyIairNIUJOv7Yp/GLJtBWR+yYBx+tMzC6DHJax
         +Cmg==
X-Forwarded-Encrypted: i=1; AJvYcCWaBv1py8K9ZAAKdYtOFtgbhHolJ3aXK0Q09iW8Qgfk33KHJ5HuNyCgNEQ/mvE1Zv7plQo55u3iyut1Eabs07BlBWI/CgFu1k0ha9+QzSjYF2Oa9M/Lj0Kx8TW5QJu+NzqXkGnZY6S9+aJ6
X-Gm-Message-State: AOJu0YxS3nt25SpkzdvLcWBiNSMD6O8YWoa91aqvBAZfQxXm4mA+BuPn
	xlEr3Eu/r4Iu6585NJQj/osWQoGPNSR4VOcjj/6xi8K30EZAaIEDKCDfk3GlYwnkCqJcyOGGS6M
	16cOatN76NmvtRLBg66zj7HL2Veo=
X-Google-Smtp-Source: AGHT+IHAmjFbkdS+fr6ZkZVORCPbzkeRgK12X1TuMm6vxt/E1AeV5iBgZCISuEWwsLGiP5eLuFDQttNR3nt1R6jEfL0=
X-Received: by 2002:a05:6102:1610:b0:48d:b0a3:fe34 with SMTP id
 ada2fe7eead31-48db0a40226mr1249530137.2.1718354120499; Fri, 14 Jun 2024
 01:35:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com> <20240611215544.2105970-2-jiaqiyan@google.com>
In-Reply-To: <20240611215544.2105970-2-jiaqiyan@google.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Fri, 14 Jun 2024 16:35:09 +0800
Message-ID: <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: nao.horiguchi@gmail.com, linmiaohe@huawei.com, jane.chu@oracle.com, 
	muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaqi,

On Wed, Jun 12, 2024 at 5:56=E2=80=AFAM Jiaqi Yan <jiaqiyan@google.com> wro=
te:
>
> Correctable memory errors are very common on servers with large
> amount of memory, and are corrected by ECC. Soft offline is kernel's
> additional recovery handling for memory pages having (excessive)
> corrected memory errors. Impacted page is migrated to a healthy page
> if inuse; the original page is discarded for any future use.
>
> The actual policy on whether (and when) to soft offline should be
> maintained by userspace, especially in case of an 1G HugeTLB page.
> Soft-offline dissolves the HugeTLB page, either in-use or free, into
> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> If userspace has not acknowledged such behavior, it may be surprised
> when later mmap hugepages MAP_FAILED due to lack of hugepages.
> In case of a transparent hugepage, it will be split into 4K pages
> as well; userspace will stop enjoying the transparent performance.
>
> In addition, discarding the entire 1G HugeTLB page only because of
> corrected memory errors sounds very costly and kernel better not
> doing under the hood. But today there are at least 2 such cases:
> 1. GHES driver sees both GHES_SEV_CORRECTED and
>    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> 2. RAS Correctable Errors Collector counts correctable errors per
>    PFN and when the counter for a PFN reaches threshold
> In both cases, userspace has no control of the soft offline performed
> by kernel's memory failure recovery.
>
> This commit gives userspace the control of softofflining any page:
> kernel only soft offlines raw page / transparent hugepage / HugeTLB
> hugepage if userspace has agreed to. The interface to userspace is a
> new sysctl called enable_soft_offline under /proc/sys/vm. By default
> enable_soft_line is 1 to preserve existing behavior in kernel.

s/enable_soft_line/enable_soft_offline

>
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  mm/memory-failure.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index d3c830e817e3..23415fe03318 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -68,6 +68,8 @@ static int sysctl_memory_failure_early_kill __read_most=
ly;
>
>  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
>
> +static int sysctl_enable_soft_offline __read_mostly =3D 1;
> +
>  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0);
>
>  static bool hw_memory_failure __read_mostly =3D false;
> @@ -141,6 +143,15 @@ static struct ctl_table memory_failure_table[] =3D {
>                 .extra1         =3D SYSCTL_ZERO,
>                 .extra2         =3D SYSCTL_ONE,
>         },
> +       {
> +               .procname       =3D "enable_soft_offline",
> +               .data           =3D &sysctl_enable_soft_offline,
> +               .maxlen         =3D sizeof(sysctl_enable_soft_offline),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dointvec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_ONE,
> +       }
>  };
>
>  /*
> @@ -2771,6 +2782,11 @@ int soft_offline_page(unsigned long pfn, int flags=
)
>         bool try_again =3D true;
>         struct page *page;
>
> +       if (!sysctl_enable_soft_offline) {
> +               pr_info("soft offline: %#lx: OS-wide disabled\n", pfn);
> +               return -EINVAL;

IMO, "-EPERM" might sound better ;)

Using "-EPERM" indicates that the operation is not permitted due to
the OS-wide configuration.

Thanks,
Lance

> +       }
> +
>         if (!pfn_valid(pfn)) {
>                 WARN_ON_ONCE(flags & MF_COUNT_INCREASED);
>                 return -ENXIO;
> --
> 2.45.2.505.gda0bf45e8d-goog
>
>

