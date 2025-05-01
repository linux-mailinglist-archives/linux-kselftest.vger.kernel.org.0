Return-Path: <linux-kselftest+bounces-32109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6722AA6654
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 00:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A74175F11
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 May 2025 22:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EC0243969;
	Thu,  1 May 2025 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1KlAiHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCEA3D6A
	for <linux-kselftest@vger.kernel.org>; Thu,  1 May 2025 22:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746139151; cv=none; b=dwurb+q3J/dS1O1mxa1xiBnoyjiJ9ypbtMRtmHVwqOQhIwJS/6BNeOn1vTV7Gti75V0PfY/H7Inhf8MikmnK6dB49JcNnLx6byX3daHV+RMSs52W/0qt220bOjHwiCjvym8GCaG8ux7FtUIZh7uchoyrzBX1sGNmZIngrghYgoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746139151; c=relaxed/simple;
	bh=RppbyNb+qAjiwhRJhzZp/IaAnH9uKer2OYkwMPfo2Lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diT25z4FSWVcjKsGvm+rPVyP9eyJFg4loeFHvLxZmCPQxsrdCIQs5i9o+nWJW4hjwmhmvrtSVDLaYY5QEFsn8M7gasEAisTW3VhUkS832YQcOey3sAR/nDrXvfk319oEkJURa6AsX4/tV9MHR7VphQmdtIwTSG0LmXzEOSh0EyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1KlAiHA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746139148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2yBC5E3ys3Bg3BEEddT6jmOEedb3warWq8gjnxAXG4=;
	b=E1KlAiHAeOkPhQUuw4f7UqdZtxuDGBPAD21wE3/sDozVJwAtoZsah/E1FI9JWBqd7s0PPQ
	p/TjL4PUUErE4wy0S/Whlu0hXgn7hYEstTEP1S7r7L40qsX0gl2MS/SXQlwTWQ1Aswapog
	tDKfGXJ8t90mh9PAFRNcta5VKW6/PIE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-vZgFfv3xMw2lz3X0sUzi2A-1; Thu, 01 May 2025 18:39:07 -0400
X-MC-Unique: vZgFfv3xMw2lz3X0sUzi2A-1
X-Mimecast-MFC-AGG-ID: vZgFfv3xMw2lz3X0sUzi2A_1746139147
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-70267bb7ed8so17973647b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 01 May 2025 15:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746139147; x=1746743947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2yBC5E3ys3Bg3BEEddT6jmOEedb3warWq8gjnxAXG4=;
        b=qLYNC55+angxP6Mcxu/GYvczp7tVYyeu38iotj5A/RU4cbfXtwYwODhnBGmeP8LCu5
         UbvOISgsuQv2iXF+2KNe68yoYMGcJr86igLZcsHFdDXuc2BYLCZ1XMpTC89oABmRZ9i/
         JPAH3a5R/SQbGb9fwgAMelBItNVTRS2Wjq41GkIS1mHuQ0sFzh/Ds29yDz5DKnzqdG0k
         /armW0qbOSatYZ7/mJGIybNgQNQP4Lk/NiJu2c29sK/cUDQ8CYoFSlCsOWsV+MOKgcBa
         S/+JPEprPqL4/Fw+5PupQz8ZK0Sr72fJIR9JfsUBXDkmdqUtq/WfIso8tGJzbITfrcGw
         xI0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWt5nUhWjbr55kztdlSHwN98XDpjg0+tM8LnvxMeza6d/3YMgAtc5OanEaJg4KDP50TZ7xv9Sv1GIX9VjsqKAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrvqTZtZw2dRKcom/C3xP64GxIrJSsCQa9RgaUSl94zVwfLAn
	ZiYPYZawknENbFNMpSlumkoXXn7e/Wu4248VfrFd7KbOnAgQ3kPlR76jJbqs8qH5bcRkt5JF6QO
	SZgP8U2kEM6+A5OHxAvJc3Ics+5DZdBvXJmHpuFZBEeK507+qAYCMdgNVJ07U4jArDIFGKbmLPr
	NUud2Tc5KE9KWUZqqqs5H5njAs2ZOg4zyP+r51syMJ
X-Gm-Gg: ASbGncuEt44AwGjeesRKjBiouBl0cIcFi6GgxmnRhESv9+KeB14/7XEv3MiCNYF9hG4
	rkVz3A/kTfHOTn83aRPHeh7tEQcSal8CBHEh7ILhBUjSk7JXzbmTuSsmBwjijQq80azeWp56cDY
	DDemVA5Ck=
X-Received: by 2002:a05:690c:6308:b0:6ef:5c57:904 with SMTP id 00721157ae682-708cf00ed15mr13683897b3.7.1746139146852;
        Thu, 01 May 2025 15:39:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC4nzuGXKdm9CCi+P25QqFR3ZjYmkRkmMsqhwNxWF55OkciYyJXlzGZMiLbmTkRuoE+fiMnrmpXm4MtSlf8YI=
X-Received: by 2002:a05:690c:6308:b0:6ef:5c57:904 with SMTP id
 00721157ae682-708cf00ed15mr13683527b3.7.1746139146514; Thu, 01 May 2025
 15:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428182904.93989-1-npache@redhat.com> <20250428182904.93989-3-npache@redhat.com>
 <C7A07691-E8D8-436F-AEED-8825608880CE@nvidia.com>
In-Reply-To: <C7A07691-E8D8-436F-AEED-8825608880CE@nvidia.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 1 May 2025 16:38:40 -0600
X-Gm-Features: ATxdqUFzODQv7UTouMhQXgLjZb7TpWvXSrXYOvh_44TpwgiqkNeUNgkUVT4KXdQ
Message-ID: <CAA1CXcAsS9VpwXir0eBvLPsdEzT369OjFqq4jMzg7CGTFGgF3w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] mm: document (m)THP defer usage
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
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 30, 2025 at 2:15=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On 28 Apr 2025, at 14:29, Nico Pache wrote:
>
> > The new defer option for (m)THPs allows for a more conservative
> > approach to (m)THPs. Document its usage in the transhuge admin-guide.
> >
> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  Documentation/admin-guide/mm/transhuge.rst | 31 ++++++++++++++++------
> >  1 file changed, 23 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index 5c63fe51b3ad..c50253357793 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -88,8 +88,9 @@ In certain cases when hugepages are enabled system wi=
de, application
> >  may end up allocating more memory resources. An application may mmap a
> >  large region but only touch 1 byte of it, in that case a 2M page might
> >  be allocated instead of a 4k page for no good. This is why it's
> > -possible to disable hugepages system-wide and to only have them inside
> > -MADV_HUGEPAGE madvise regions.
> > +possible to disable hugepages system-wide, only have them inside
> > +MADV_HUGEPAGE madvise regions, or defer them away from the page fault
> > +handler to khugepaged.
> >
> >  Embedded systems should enable hugepages only inside madvise regions
> >  to eliminate any risk of wasting any precious byte of memory and to
> > @@ -99,6 +100,15 @@ Applications that gets a lot of benefit from hugepa=
ges and that don't
> >  risk to lose memory by using hugepages, should use
> >  madvise(MADV_HUGEPAGE) on their critical mmapped regions.
> >
> > +Applications that would like to benefit from THPs but would still like=
 a
> > +more memory conservative approach can choose 'defer'. This avoids
> > +inserting THPs at the page fault handler unless they are MADV_HUGEPAGE=
.
> > +Khugepaged will then scan the mappings for potential collapses into (m=
)THP
>
> How about the text below? It explicitly states khugepaged behavior.
>
> Khugepaged will then scan all mappings, even those not explicitly marked
> with MADV_HUGEPAGE, for potential collapses into (m)THPs.

I agree, this reads better. I can modify it on the V6 :)
>
> > +pages. Admins using this the 'defer' setting should consider
> > +tweaking khugepaged/max_ptes_none. The current default of 511 may
> > +aggressively collapse your PTEs into PMDs. Lower this value to conserv=
e
> > +more memory (i.e., max_ptes_none=3D64).
> > +
> >  .. _thp_sysfs:
> >
> >  sysfs
> > @@ -109,11 +119,14 @@ Global THP controls
> >
> >  Transparent Hugepage Support for anonymous memory can be entirely disa=
bled
> >  (mostly for debugging purposes) or only enabled inside MADV_HUGEPAGE
> > -regions (to avoid the risk of consuming more memory resources) or enab=
led
> > -system wide. This can be achieved per-supported-THP-size with one of::
> > +regions (to avoid the risk of consuming more memory resources), deferr=
ed to
> > +khugepaged, or enabled system wide.
> > +
> > +This can be achieved per-supported-THP-size with one of::
> >
> >       echo always >/sys/kernel/mm/transparent_hugepage/hugepages-<size>=
kB/enabled
> >       echo madvise >/sys/kernel/mm/transparent_hugepage/hugepages-<size=
>kB/enabled
> > +     echo defer >/sys/kernel/mm/transparent_hugepage/hugepages-<size>k=
B/enabled
> >       echo never >/sys/kernel/mm/transparent_hugepage/hugepages-<size>k=
B/enabled
> >
> >  where <size> is the hugepage size being addressed, the available sizes
> > @@ -136,6 +149,7 @@ The top-level setting (for use with "inherit") can =
be set by issuing
> >  one of the following commands::
> >
> >       echo always >/sys/kernel/mm/transparent_hugepage/enabled
> > +     echo defer >/sys/kernel/mm/transparent_hugepage/enabled
> >       echo madvise >/sys/kernel/mm/transparent_hugepage/enabled
> >       echo never >/sys/kernel/mm/transparent_hugepage/enabled
> >
> > @@ -286,7 +300,8 @@ of small pages into one large page::
> >  A higher value leads to use additional memory for programs.
> >  A lower value leads to gain less thp performance. Value of
> >  max_ptes_none can waste cpu time very little, you can
> > -ignore it.
> > +ignore it. Consider lowering this value when using
> > +``transparent_hugepage=3Ddefer``
> >
> >  ``max_ptes_swap`` specifies how many pages can be brought in from
> >  swap when collapsing a group of pages into a transparent huge page::
> > @@ -311,14 +326,14 @@ Boot parameters
> >
> >  You can change the sysfs boot time default for the top-level "enabled"
> >  control by passing the parameter ``transparent_hugepage=3Dalways`` or
> > -``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Dnever``=
 to the
> > -kernel command line.
> > +``transparent_hugepage=3Dmadvise`` or ``transparent_hugepage=3Ddefer``=
 or
> > +``transparent_hugepage=3Dnever`` to the kernel command line.
> >
> >  Alternatively, each supported anonymous THP size can be controlled by
> >  passing ``thp_anon=3D<size>[KMG],<size>[KMG]:<state>;<size>[KMG]-<size=
>[KMG]:<state>``,
> >  where ``<size>`` is the THP size (must be a power of 2 of PAGE_SIZE an=
d
> >  supported anonymous THP)  and ``<state>`` is one of ``always``, ``madv=
ise``,
> > -``never`` or ``inherit``.
> > +``defer``, ``never`` or ``inherit``.
> >
> >  For example, the following will set 16K, 32K, 64K THP to ``always``,
> >  set 128K, 512K to ``inherit``, set 256K to ``madvise`` and 1M, 2M
>
> Otherwise, LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> --
> Best Regards,
> Yan, Zi
>


