Return-Path: <linux-kselftest+bounces-11968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDF9090B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDE8B2EA73
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5017C211;
	Fri, 14 Jun 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQJMfCr6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5449638
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718383250; cv=none; b=Iy8qEw4CYnnJ8jXec7I3DnetWSt3FA8rWtOetyjDeUGRlUup6VJgHH/JDG3rJQWUsBrJ/mMqyONIK1oYJYwSj3Jh+VTWq0Mw0+jZ/idystN7+4Td5wJQpRUmWzswqCzCN0Z4Jj+/lXbk2lQuz7krDJOpd+y3joVgaOEqrJmH6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718383250; c=relaxed/simple;
	bh=VbCxgURpkKyzBtAXqrIatdiU7Sj96ybvb6ZXbDGuWnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ph5GgGqcjqKyBrlKahfzWGkNeAOvBi0Yp2pqQzEFc+HR+7gVGovgO7Sw9lFbK+sdFDoO0IQnlwy0x0HX96LVwq0faFGviKgjPGoHy/DU08DFlCx6g7WCK2wli2XecW6stewePLfgiTStZMXqEDCvol9pAxUXl60RlA8C6e/HIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NQJMfCr6; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec0f3b9cfeso12960561fa.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jun 2024 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718383247; x=1718988047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6N6pWwte8VFmLbcY/vhwWLg5RRbCqF65dXNS8n7ZcdA=;
        b=NQJMfCr6IktVcTwHU1FWYGHk8lFDSD+gLwUV6emxqROeFyuPel/ANbigDaYB3IUq1g
         CBHYOT05jeJNJPl7Jn14mC0wwRxHYgHwDH71AD94ptvMWW0OsqI4u5SjcMwrbZRe2y82
         k6IblGJedPHB2t5M/xHpgx4vJz3eb5qjzxjcIp+KIV7dQDzW9LlbjOiMC53+793kgKHq
         Jy9LDdX5/IHS6SbqNz9xgk23SFoi+OI8BDaSy44+3T7EW3qGbjm55EjAz1H9iG5T0FDP
         zS48WAlalPcyTcYuWiMoyBJrZqETiloTnN7neYRTu7iFTImi0kLw0GBxvGUj+0WcjEce
         oIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718383247; x=1718988047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6N6pWwte8VFmLbcY/vhwWLg5RRbCqF65dXNS8n7ZcdA=;
        b=j7X09VEyDey8HbqJB0SrZV766Pr8dv8ryXNGZPSTZ8BG6BL5u3UbzU2CcOFwOKdNAS
         FwE9T7e1YqeKZJ8ZDEnWn6Q2dGvmJ3uiZ/7Nms/zC239zcDoRnFLB6Nz0oiVHz2IcYSu
         m+BWoQdwCO0HdA1YUflD8o6dq6sGFxQMboc0ppetiNvvx8RPrITmmPjzZHgz3Q7WWQHR
         NeBhBQpf+bdvjkUAuUf0IKQBKprEch+pjsWyA++fkT93FKmxbyNaKR304uXWc7nP57pW
         9XSdHDniD/PyYgJwPiNDUNHtyJc4p+AClLRuZZDNFLGpbQRi7Q6Q9wmHkMOHgZ3PBTmY
         1z9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXFglhwHlkmq9tpa1sVimLsVsopUeoMhFrEb1TzfdiclMKYpwUCU9p1jyRIKeQtZVgiIw6heRNya/STaVPwW/LkieNrKLRtGJmkgLGVppe
X-Gm-Message-State: AOJu0Yxplz6qtkzXpA6xA3Bw+F1WEZkj8arKmjmGyME5BwcRT5qEBxtD
	9gA4FGX5qSbebhupRlN6KjREBvgwM8XOA76cHNsmFsM82/IMgczA7A5lZozjguBkAXlbZ9D2b5t
	WaHC5cP5tIFwD6HR0yU2ByHLYmIxH0AsMVRHS
X-Google-Smtp-Source: AGHT+IH4PaRix9qpyJ1JsEJsH3dIxJd3lDLxxYmObDN8Ly1c+eahxQ5IY2EEyAYetWZChHlpR8fSMk+66JC39s4R/Bo=
X-Received: by 2002:a2e:9dd4:0:b0:2ec:453:e46e with SMTP id
 38308e7fff4ca-2ec0e5a0442mr21871161fa.42.1718383246745; Fri, 14 Jun 2024
 09:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611215544.2105970-1-jiaqiyan@google.com> <20240611215544.2105970-2-jiaqiyan@google.com>
 <1e6ecf75-c489-7711-3289-e4a396ca9484@huawei.com>
In-Reply-To: <1e6ecf75-c489-7711-3289-e4a396ca9484@huawei.com>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 14 Jun 2024 09:40:35 -0700
Message-ID: <CACw3F52SU=z-nBgSQpmKA43eFz71F1OJ655fsdjNEVP0Pzpihw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Miaohe Lin <linmiaohe@huawei.com>
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org, 
	corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com, 
	fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, nao.horiguchi@gmail.com, jane.chu@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 8:28=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> w=
rote:
>
> On 2024/6/12 5:55, Jiaqi Yan wrote:
> > Correctable memory errors are very common on servers with large
> > amount of memory, and are corrected by ECC. Soft offline is kernel's
> > additional recovery handling for memory pages having (excessive)
> > corrected memory errors. Impacted page is migrated to a healthy page
> > if inuse; the original page is discarded for any future use.
> >
>
> Thanks for your update.
>
> > The actual policy on whether (and when) to soft offline should be
> > maintained by userspace, especially in case of an 1G HugeTLB page.
> > Soft-offline dissolves the HugeTLB page, either in-use or free, into
> > chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> > If userspace has not acknowledged such behavior, it may be surprised
> > when later mmap hugepages MAP_FAILED due to lack of hugepages.
>
> s/mmap hugepages MAP_FAILED/fails to mmap hugepages/ ?
>
> > In case of a transparent hugepage, it will be split into 4K pages
> > as well; userspace will stop enjoying the transparent performance.
> >
> > In addition, discarding the entire 1G HugeTLB page only because of
> > corrected memory errors sounds very costly and kernel better not
> > doing under the hood. But today there are at least 2 such cases:
>
> s/doing/doing so/ ?
>
> > 1. GHES driver sees both GHES_SEV_CORRECTED and
> >    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> > 2. RAS Correctable Errors Collector counts correctable errors per
> >    PFN and when the counter for a PFN reaches threshold
> > In both cases, userspace has no control of the soft offline performed
> > by kernel's memory failure recovery.
> >
> > This commit gives userspace the control of softofflining any page:
> > kernel only soft offlines raw page / transparent hugepage / HugeTLB
> > hugepage if userspace has agreed to. The interface to userspace is a
> > new sysctl called enable_soft_offline under /proc/sys/vm. By default
> > enable_soft_line is 1 to preserve existing behavior in kernel.
>
> s/enable_soft_line/enable_soft_offline/

Will fix these 3 typos in v3.

>
> >
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > ---
> >  mm/memory-failure.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index d3c830e817e3..23415fe03318 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -68,6 +68,8 @@ static int sysctl_memory_failure_early_kill __read_mo=
stly;
> >
> >  static int sysctl_memory_failure_recovery __read_mostly =3D 1;
> >
> > +static int sysctl_enable_soft_offline __read_mostly =3D 1;
> > +
> >  atomic_long_t num_poisoned_pages __read_mostly =3D ATOMIC_LONG_INIT(0)=
;
> >
> >  static bool hw_memory_failure __read_mostly =3D false;
> > @@ -141,6 +143,15 @@ static struct ctl_table memory_failure_table[] =3D=
 {
> >               .extra1         =3D SYSCTL_ZERO,
> >               .extra2         =3D SYSCTL_ONE,
> >       },
> > +     {
> > +             .procname       =3D "enable_soft_offline",
> > +             .data           =3D &sysctl_enable_soft_offline,
> > +             .maxlen         =3D sizeof(sysctl_enable_soft_offline),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_dointvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D SYSCTL_ONE,
> > +     }
> >  };
> >
> >  /*
> > @@ -2771,6 +2782,11 @@ int soft_offline_page(unsigned long pfn, int fla=
gs)
> >       bool try_again =3D true;
> >       struct page *page;
> >
> > +     if (!sysctl_enable_soft_offline) {
> > +             pr_info("soft offline: %#lx: OS-wide disabled\n", pfn);
> > +             return -EINVAL;
> > +     }
> > +
>
> IMHO, callers might reach here with page refcnt increased. So we have to =
take care of releasing it first?

Ah, I think you are right when MF_COUNT_INCREASED.

I will move this after the pfn_to_online_page check, and release if disable=
d.

> Also will it be better to return -EOPNOTSUPP or some other better errno?
>
> Thanks.
> .

