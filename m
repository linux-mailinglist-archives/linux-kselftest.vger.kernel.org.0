Return-Path: <linux-kselftest+bounces-35222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3127ADDAE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 19:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 075A07A185A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F3C23B600;
	Tue, 17 Jun 2025 17:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VWY51kPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2F231837
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182778; cv=none; b=CU5kgXY3PrsgfbVtJjSh2GqawMo/ZkQ0EQ/sLFprqr5/ek/sYIdU8dKZvtQpGkCRXm3jj/+QyqtvsDtlAsjzvBcjbyryVCUzpiObNXi+nwZNgqnU7tL/mav9BBuJ0jZLlzHiuu3rGKKUHVdL8cD5b9dGT/Paf9RNZXFsYt7mGVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182778; c=relaxed/simple;
	bh=t+06naoVmVF2AOSXqBSYrJu3yXVIfw+vx5pfjOIVMmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DBYP5uJs+nI4DnxSZCDOMTkzLNbT1dlQQzFTJBhrDDTiDRARwhDE87fAq8tAJSkJ7F8i5gY3fv1oHaVFqAp4i2Tv1zhyHj5sHL7UkKDMj8BdlyA9QtD5YbYC/HK4CwjcvBxE2UJSlamslVpOoSgvomLuV2cndXVD4Q2/Do8ctzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VWY51kPc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750182775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VHVlghtOwl1iYTRYeyXrEKqXKy+rGsdhH54hG2oPsxQ=;
	b=VWY51kPcMLewrs0lCjf8YUK7r8bvORhnPRsKcyMqDt8BRhcvzFnEDUxeyx+DqLs+6h6ngM
	y1KmdD0GNUnwsFN+bVUVxsOt+6i6NtyxRL4QbKgzPhEi42znYMdogu8IP7KB/v3v5TX/4l
	7PlAPc8EW/Pl+TiRgclw++mzlXcNpjc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-iaydsiu0NZ2_8chS_PpYkg-1; Tue, 17 Jun 2025 13:52:54 -0400
X-MC-Unique: iaydsiu0NZ2_8chS_PpYkg-1
X-Mimecast-MFC-AGG-ID: iaydsiu0NZ2_8chS_PpYkg_1750182774
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e5e6ab756so84488417b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jun 2025 10:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750182774; x=1750787574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VHVlghtOwl1iYTRYeyXrEKqXKy+rGsdhH54hG2oPsxQ=;
        b=FXwlpxxDgaXGftbpL0+DtFP/xBVB5WEAXGZC+rTs0tPzToQKmePMDnn6QC3lYE8law
         Bz6yA0/bh5jMLyuNSosUAxoSHq35JoKnlYTcag5rDECJonIa4PKv2fNxpk4t1d5K0iJK
         Jvjr0vjefhWi4pJP3n5xOsYiryoJYE44pgw3h18hv346MyDr1PsviCt5l6FLyOCEWFH8
         kNUFubO0PEemJJtkp842buTk4hS+dxvZXmA9xrHITISuZt/9smp5HSyMnW9Eq8mG+2hh
         yBV8sv7YMZPWCnysObCIXNP7/ivYNyddDd6EMbl9ykExv47LIixcC0tDODDWcvCWOh88
         No9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXx+hOX45ZzUIEjGOMpriCSlZqfqCACAjHwV48kj32AnPmDi8+YxBPuwj8ZvsrDSwl+9F4J+UggzlQrtvSoeDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEm6M+803Tk2yZ60ACPhEzXH7wdpZrri1dS20oJugjoV8A/NE
	+YTf+iBzD8d6DO6ZfqKfadazCtpaD2qBj+VXictX+vXNIyntHYut8/IQiS4pwqD49LYmrp8vkSM
	BRt6lgwZdp0NmIeLnVpxhwcj7WC+DnNSN46uYvHe0SUfwT4VP8z45hHmkfsMzkW0hw6ik2IYq+X
	z7wDkN6QvYxZlfdYiL4xMmswgvzngze/qyXb/HX1IOIlBO
X-Gm-Gg: ASbGncuTrlCkowGoed6bfkj3gG80WjAbs43AvFtoC2ltHL1K5nCcDf59so9jvY18OzT
	Gi15/IOS4g3wpt5d/B87HYd79MqSKsPgnMP0JB3jz4myZ0ooCePtfvSdpzkYadwvxAqMJjBkJz7
	hMAEggvA==
X-Received: by 2002:a05:690c:9a07:b0:703:b3b8:1ca1 with SMTP id 00721157ae682-7117536e5f3mr174054427b3.5.1750182773984;
        Tue, 17 Jun 2025 10:52:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsuDUpqbT4Zm+fDNYLZyRvnIomvlXs1lgyYMEYTlPSDFNwpQpbOwB39H6AdaylUKoeEGHtBp3S/5ilov+jo+Q=
X-Received: by 2002:a05:690c:9a07:b0:703:b3b8:1ca1 with SMTP id
 00721157ae682-7117536e5f3mr174053697b3.5.1750182773635; Tue, 17 Jun 2025
 10:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515033857.132535-1-npache@redhat.com> <20250515033857.132535-2-npache@redhat.com>
 <fcd3phzewpgzghrzse3stxi7jz7b6l5uwnhqtswcfnqvuvktip@apqh2achkutn>
In-Reply-To: <fcd3phzewpgzghrzse3stxi7jz7b6l5uwnhqtswcfnqvuvktip@apqh2achkutn>
From: Nico Pache <npache@redhat.com>
Date: Tue, 17 Jun 2025 11:52:26 -0600
X-Gm-Features: AX0GCFswQblbC-fUl4LgnBDpA9J_EkZ2hl0iyVshZHwGMIbdVVRH-b1apF1auqA
Message-ID: <CAA1CXcDgu3bT-aUEXoFrVVYaTy_rAbdNmwMhzrkwb0+VxQM47w@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] mm: defer THP insertion to khugepaged
To: Klara Modin <klarasmodin@gmail.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	rientjes@google.com, hannes@cmpxchg.org, lorenzo.stoakes@oracle.com, 
	rdunlap@infradead.org, mhocko@suse.com, Liam.Howlett@oracle.com, 
	zokeefe@google.com, surenb@google.com, jglisse@google.com, cl@gentwo.org, 
	jack@suse.cz, dave.hansen@linux.intel.com, will@kernel.org, tiwai@suse.de, 
	catalin.marinas@arm.com, anshuman.khandual@arm.com, dev.jain@arm.com, 
	raquini@redhat.com, aarcange@redhat.com, kirill.shutemov@linux.intel.com, 
	yang@os.amperecomputing.com, thomas.hellstrom@linux.intel.com, 
	vishal.moola@gmail.com, sunnanyong@huawei.com, usamaarif642@gmail.com, 
	wangkefeng.wang@huawei.com, ziy@nvidia.com, shuah@kernel.org, 
	peterx@redhat.com, willy@infradead.org, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, baohua@kernel.org, david@redhat.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org, 
	corbet@lwn.net, akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 5:25=E2=80=AFAM Klara Modin <klarasmodin@gmail.com>=
 wrote:
>
> Hi,
>
> On 2025-05-14 21:38:54 -0600, Nico Pache wrote:
> > setting /transparent_hugepages/enabled=3Dalways allows applications
> > to benefit from THPs without having to madvise. However, the page fault
> > handler takes very few considerations to decide weather or not to actua=
lly
> > use a THP. This can lead to a lot of wasted memory. khugepaged only
> > operates on memory that was either allocated with enabled=3Dalways or
> > MADV_HUGEPAGE.
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
> > Acked-by: Zi Yan <ziy@nvidia.com>
> > Co-developed-by: Rafael Aquini <raquini@redhat.com>
> > Signed-off-by: Rafael Aquini <raquini@redhat.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> ...
>
> > @@ -315,13 +318,20 @@ static ssize_t enabled_store(struct kobject *kobj=
,
> >
> >       if (sysfs_streq(buf, "always")) {
> >               clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparen=
t_hugepage_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparen=
t_hugepage_flags);
> >               set_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepage_=
flags);
> > +     } else if (sysfs_streq(buf, "defer")) {
> > +             clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepag=
e_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparen=
t_hugepage_flags);
> > +             set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparent_=
hugepage_flags);
> >       } else if (sysfs_streq(buf, "madvise")) {
> >               clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepag=
e_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparen=
t_hugepage_flags);
> >               set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparent_=
hugepage_flags);
> >       } else if (sysfs_streq(buf, "never")) {
> >               clear_bit(TRANSPARENT_HUGEPAGE_FLAG, &transparent_hugepag=
e_flags);
> >               clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG, &transparen=
t_hugepage_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG, &transparen=
t_hugepage_flags);
> >       } else
> >               ret =3D -EINVAL;
> >
> > @@ -954,18 +964,31 @@ static int __init setup_transparent_hugepage(char=
 *str)
> >                       &transparent_hugepage_flags);
> >               clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> >                         &transparent_hugepage_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> > +                       &transparent_hugepage_flags);
> >               ret =3D 1;
> > +     } else if (!strcmp(str, "defer")) {
> > +             clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
> > +                       &transparent_hugepage_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> > +                       &transparent_hugepage_flags);
> > +             set_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> > +                       &transparent_hugepage_flags);
>
> There should probably be a corresponding
>                 ret =3D 1;
> here. Otherwise the cannot parse message will displayed even if defer
> was set.
Thanks Klara-- I will make sure to add it on the next version!
>
> >       } else if (!strcmp(str, "madvise")) {
> >               clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
> >                         &transparent_hugepage_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> > +                       &transparent_hugepage_flags);
> >               set_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> > -                     &transparent_hugepage_flags);
> > +                       &transparent_hugepage_flags);
> >               ret =3D 1;
> >       } else if (!strcmp(str, "never")) {
> >               clear_bit(TRANSPARENT_HUGEPAGE_FLAG,
> >                         &transparent_hugepage_flags);
> >               clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
> >                         &transparent_hugepage_flags);
> > +             clear_bit(TRANSPARENT_HUGEPAGE_DEFER_PF_FLAG,
> > +                       &transparent_hugepage_flags);
> >               ret =3D 1;
> >       }
> >  out:
> > --
> > 2.49.0
> >
>
> Regards,
> Klara Modin
>


