Return-Path: <linux-kselftest+bounces-32042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E66AA53D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 20:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D77189F8B4
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 18:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E55C266571;
	Wed, 30 Apr 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju8MzOi0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C581EEA46
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746038382; cv=none; b=XIOG2NvbHyLerhXAOMWLtGsMz22Lqbg7tEIgwHCKppckfb6cfIiEk3cBA96jJgwaslRZv3f1UBfUKAsa8ewLQna9KXYpipikTzAqa7A4uUj/1QumQw35IJkmcKyht3Dja5fPN1G5S/DWj5oKp3cvfjU8e8SzPrpGQh3EY76ld0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746038382; c=relaxed/simple;
	bh=uop7LMZYuz+EVPrsb8rncMFAD0a69RO4PcxjXzb4CH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=auBlN1aNzus+Eu/J5AS9KGhHKz8R4GUhUZCU+6ZPqNSg8yU7snbDF4+Ig5MujHixlRIVqibY34LJc7gbrheQPwDB8H7lwudV/dmSiFCXlBu7t+wdxi5heTfuIhx0cOsEX0Gv1tkgcn/rkq02qP9oxv937c6Hp7hb7nYXCJRbg2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ju8MzOi0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746038379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRjxDxDhTYKrorsZixsAP5Kxt917TzYAbdZEFQfMsaE=;
	b=Ju8MzOi0gVPKwUN/hTOvN/3OabbtNGEatok/8wuPZUgZuMgDAA7JgYEh5PvSRu2iMqi0Iz
	rovZ0GlXEl5ATxIFWRy89SiybrslUHaBmJs0sZ/9vTd4EdMIWr796NccRxKwhzo4+S3hA4
	yHxtTTtb6dDbwKbU/k0Bt00izdy0Rps=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-hbXQK8iaMzy1MWrqN4G_hQ-1; Wed, 30 Apr 2025 14:39:37 -0400
X-MC-Unique: hbXQK8iaMzy1MWrqN4G_hQ-1
X-Mimecast-MFC-AGG-ID: hbXQK8iaMzy1MWrqN4G_hQ_1746038377
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-708b13627abso3396527b3.2
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 11:39:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746038377; x=1746643177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRjxDxDhTYKrorsZixsAP5Kxt917TzYAbdZEFQfMsaE=;
        b=iKuIJc+sWuXCSOdwdgf2qXJPheTIZmit1gUhuC4/0aYDtKHmsR2OB3ZDGJgd6RbMb9
         PO4tY514n+1cd5KI3SnfE7pI3Lbyi/xeKlMY18z2C3KYl6f+CY3S6a2JiL29Hm0/gyH6
         uKOsmTomoMNDv739vCxuLAB36ZS8erut663W52n14aipZup1z2xGD0ZTvPxg53A51dkn
         tF5VY7Q58X/6MP+bhfO8qk3yb4RH4mcKbmX9KK6U8OIIGoDLM+Zry1V+8H/SpGkofCoP
         U3JwtIOpDWRz5KDXXN+RyHr8FfSVkf2sMsYUTJk+9gIOGWG/qw7djNgFOhWeK9fYr3c/
         px1w==
X-Forwarded-Encrypted: i=1; AJvYcCWXIHYQf2g9CiWtGB+RR28NpVe5N43JcVo0wP/+BOL127lJI5yqDMMvFjN60kh35DAQsI2cZnqrrSt3UW/7n4I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2COx6Zi/magBKWyVAUp5VQWFQ9HLAe5Gx3hyi/aoP1PWGRB25
	xQ2NY7Az6s+sEdNDVG4MzrBJrFKhhOzrVHV5rFrAphpkUp82QtBP6Mt7VcHCRwLPTTHrh5m0KLX
	yQKL0wM1UILPlkS44vB+ligTExLqSr7F6B8cJYpTvzeBPPSHwifm5b/ZK05zqNf+pjIyaz8DnFM
	c+CqRgFx1fqZ/lF7hrou5mEru6t3/MUbgrSjQS9UqG
X-Gm-Gg: ASbGncufcr2Z7rLIy3E2hkMuySUVS0kcV/Kuf23NAd67Pa5Fk6T9/hcuENKgOOU6tOo
	QigR7FlZnggDw+bwCcgmOOkHAW6VLVKp0IKGP03STwfkvAXAxunIh5SEj797IyD5kaLU6RZGQ4r
	78V1UsoTU=
X-Received: by 2002:a05:690c:9:b0:6fd:a226:fb6c with SMTP id 00721157ae682-708abdabf95mr62404357b3.17.1746038377149;
        Wed, 30 Apr 2025 11:39:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUG8Gr8pCuMfJMWlcmWUQoisJmUZ1EDMBMinzj6P3MiMpx3S+K06g4TgDXVqU9n7uNHGfUH5de6C068UnlTA0=
X-Received: by 2002:a05:690c:9:b0:6fd:a226:fb6c with SMTP id
 00721157ae682-708abdabf95mr62403917b3.17.1746038376803; Wed, 30 Apr 2025
 11:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428182904.93989-1-npache@redhat.com> <20250428182904.93989-2-npache@redhat.com>
 <B76CC5A1-D4DC-4E8B-BF5A-DFBEF13E02F5@nvidia.com>
In-Reply-To: <B76CC5A1-D4DC-4E8B-BF5A-DFBEF13E02F5@nvidia.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 30 Apr 2025 12:39:10 -0600
X-Gm-Features: ATxdqUFWpWLVzjLTZtwA2dC3DeeBs_qZQ8boE4jqqynD0FM3HxwqQb_YeWEGAHg
Message-ID: <CAA1CXcAHzLZaiEf+uXPqoOMWyhDsW8D23vtouGWKGdkeSdaTow@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm: defer THP insertion to khugepaged
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, 
	willy@infradead.org, peterx@redhat.com, shuah@kernel.org, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 7:49=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>
> On 28 Apr 2025, at 14:29, Nico Pache wrote:
>
> > setting /transparent_hugepages/enabled=3Dalways allows applications
> > to benefit from THPs without having to madvise. However, the pf handler
>
> s/pf/page fault
>
> > takes very few considerations to decide weather or not to actually use =
a
>
> s/weather/whether
>
> > THP. This can lead to a lot of wasted memory. khugepaged only operates
> > on memory that was either allocated with enabled=3Dalways or MADV_HUGEP=
AGE.
> >
> > Introduce the ability to set enabled=3Ddefer, which will prevent THPs f=
rom
> > being allocated by the page fault handler unless madvise is set,
> > leaving it up to khugepaged to decide which allocations will collapse t=
o a
> > THP. This should allow applications to benefits from THPs, while curbin=
g
> > some of the memory waste.
> >
> > Co-developed-by: Rafael Aquini <raquini@redhat.com>
> > Signed-off-by: Rafael Aquini <raquini@redhat.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  include/linux/huge_mm.h | 15 +++++++++++++--
> >  mm/huge_memory.c        | 31 +++++++++++++++++++++++++++----
> >  2 files changed, 40 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index e3d15c737008..57e6c962afb1 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -48,6 +48,7 @@ enum transparent_hugepage_flag {
> >       TRANSPARENT_HUGEPAGE_UNSUPPORTED,
> >       TRANSPARENT_HUGEPAGE_FLAG,
> >       TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> > +     TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG,
>
> What does INST mean here? Can you add one sentence on this new flag
> in the commit log to explain what it is short for?
"INSERT". Someone else commented on the length of this FLAG name. I
forgot to update it.
I can shorten it to something like ..DEFER_FLAG or DEFER_PF_FLAG
>
>
> >       TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG,
> >       TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_FLAG,
> >       TRANSPARENT_HUGEPAGE_DEFRAG_KSWAPD_OR_MADV_FLAG,
> > @@ -186,6 +187,7 @@ static inline bool hugepage_global_enabled(void)
> >  {
> >       return transparent_hugepage_flags &
> >                       ((1<<TRANSPARENT_HUGEPAGE_FLAG) |
> > +                     (1<<TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG) |
> >                       (1<<TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG));
> >  }
> >
> > @@ -195,6 +197,12 @@ static inline bool hugepage_global_always(void)
> >                       (1<<TRANSPARENT_HUGEPAGE_FLAG);
> >  }
> >
> > +static inline bool hugepage_global_defer(void)
> > +{
> > +     return transparent_hugepage_flags &
> > +                     (1<<TRANSPARENT_HUGEPAGE_DEFER_PF_INST_FLAG);
> > +}
> > +
> >  static inline int highest_order(unsigned long orders)
> >  {
> >       return fls_long(orders) - 1;
> > @@ -291,13 +299,16 @@ unsigned long thp_vma_allowable_orders(struct vm_=
area_struct *vma,
> >                                      unsigned long tva_flags,
> >                                      unsigned long orders)
> >  {
> > +     if ((tva_flags & TVA_IN_PF) && hugepage_global_defer() &&
> > +                     !(vm_flags & VM_HUGEPAGE))
> > +             return 0;
> > +
> >       /* Optimization to check if required orders are enabled early. */
> >       if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
> >               unsigned long mask =3D READ_ONCE(huge_anon_orders_always)=
;
> > -
>
> This newline should stay, right?
Yes, I can fix that.
>
> The rest looks good to me. Thanks. Acked-by: Zi Yan <ziy@nvidia.com>
Thank you!
-- Nico
>
> Best Regards,
> Yan, Zi
>


