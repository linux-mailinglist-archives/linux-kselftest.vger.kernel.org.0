Return-Path: <linux-kselftest+bounces-33449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C81ABF15F
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBA51BC2359
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8B625C819;
	Wed, 21 May 2025 10:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iUo/f5AY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F7125CC5D
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 10:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747822785; cv=none; b=UgHccFQGa9ZxdmrTBqLObZvvG3rKKlcpOJh8D8Kgv5cGg6+rgc5HBmjBO2lIbpFLaGWJ/V5lMEK9z2tB6zFMYNbibBgTRFSoA3Hd4LbslaLnvIW/dsHw9w2yNSs2G75O8L2zL4ULzTW2n0a029mPkmaVyv7IY+t5euKYt86WFNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747822785; c=relaxed/simple;
	bh=BB3LHArpcfYsstaRcsL9MySryll43PrdWMkxjVQceyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KApOuk9XoLR7CAcgDk3HWlyEuwIpSyYCxmVOV2lINWh/rNAGu2fuLT/b908OnoucPjAWSV3CzCsr72mIsZR1XViyEKWJgA8Dip+prdEvP+ogkfn6LKfIYlLx6HPMgvmHQ/fwu4bXfrYk+/G2Gzyqhk7KMd2aSbFT1Bv4876+fmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUo/f5AY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747822782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFbADfTcJ1Mqu56Znoijkofx/Ou7bzVTUZ2Ck/a24Y4=;
	b=iUo/f5AYt1ggh1ALAoy8A4iG423eUtwBx/8SWT8EOysRH3UI/gMcXRF6JxhtNYP5/LTupc
	xStlUTmd5Q+AC99ycEMZWBRU+xUjSxDaOa/18COxDDT8HTjqa+FWUoBkbMULtYscMT21+n
	AlFGsm5yz6eRGD4N/70vw4AUaf5jb4I=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-VZ3UwebYMIedGi9v1EuQ8g-1; Wed, 21 May 2025 06:19:41 -0400
X-MC-Unique: VZ3UwebYMIedGi9v1EuQ8g-1
X-Mimecast-MFC-AGG-ID: VZ3UwebYMIedGi9v1EuQ8g_1747822781
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70de25bb419so27156057b3.1
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 03:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747822781; x=1748427581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jFbADfTcJ1Mqu56Znoijkofx/Ou7bzVTUZ2Ck/a24Y4=;
        b=AzNlN0O2/Fv0JLeDBY9jhGQZzNDuKemDddGCDQXfZ8LzNUPHSInqGvka93lqkHW5GH
         6dNPGJBr4Wss3lJgFpuqGzbhZ9NqxVf77ZG0gSWi/SAfb5zOfTscCuq9gA6cp5G81tH3
         QIeGQmFyJbI3PaxujqK8+Rq9DmJUudR9r6L92ZE4/DRLpxR799Z8vg6DrI8YHL7y/qtQ
         J/9g63vmMLWuPd3YVqXzch5VrURStM+k70SEU1zT08fk1BGw64ppNwXyy2asQsGDTm1M
         982JiOKGrO7zQZ4/uDp/WQkrnEFe++qtRrr8IeTN4rlXRM6OJjaB3ikOnYMbZAP+Itfz
         MD6A==
X-Forwarded-Encrypted: i=1; AJvYcCUqs2CRx52DcfcXTegJkVGZaewUEqqnwv52pEx6K8/0FZMls6KfLujjMJ6n+KM6a67H8o5zxdtLEWYS/IejBwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEByDxPI1bfHcnxRezCmJLdBzp5AcSfQ9YVo6nl0mz7WrC1d4o
	KwyzPOodu87C9hrBiIh3rboYqAThihpoeX2mqkdMGqG/r6JanF92Uz+q7Mtm49QAzvM1X28VNUW
	RECkluCQmQqet/Icc9Blx9gw3I3wAk0KhCP90VTh3ncQb2ieJw83/bqUzq06KFwZH5obI2Or25p
	5wFeaWk7z3iCTbSbaPDmwu3DM9rZhR4yeyUH/4c/usI0s1
X-Gm-Gg: ASbGncu8m8JO5TtqKAMwEW0BMaNET67icVpIXfc0dQetzC7oRiyxl+n2NNgZpq8Ppks
	eAGNbNWaVLkFqvLhIerKOqmfJhKMyvO4+WvMFR16uNa5rm5s5o6NYi1/J7JmEsgPN76UkTtE=
X-Received: by 2002:a05:690c:a04e:b0:706:cc6b:855e with SMTP id 00721157ae682-70ca7b8764dmr240921987b3.30.1747822780971;
        Wed, 21 May 2025 03:19:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKhbiolXpBTRSOEIXOuEEKTBfMQMLWXYpKNf3Zd9a7dND1eGBOvZeq9FrcbaSbw9Tu7iUlktcgRTOwZw4Z3ww=
X-Received: by 2002:a05:690c:a04e:b0:706:cc6b:855e with SMTP id
 00721157ae682-70ca7b8764dmr240921757b3.30.1747822780529; Wed, 21 May 2025
 03:19:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515033857.132535-1-npache@redhat.com> <CALOAHbAa7DY6+hO4RJtjg-MS+cnUmsiPXX8KS1MKSfgy6HLYAQ@mail.gmail.com>
In-Reply-To: <CALOAHbAa7DY6+hO4RJtjg-MS+cnUmsiPXX8KS1MKSfgy6HLYAQ@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 21 May 2025 04:19:14 -0600
X-Gm-Features: AX0GCFuidlomjiU6Y6zHYcAbv39I0OnROGONj5SNbJ9Knl6lj4JOxI3ty2Mr2c8
Message-ID: <CAA1CXcA0WX+qGKvL4VcTM_bazFxRyDmp5DK60ycoS4OCDUnH-Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
To: Yafang Shao <laoar.shao@gmail.com>
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

On Tue, May 20, 2025 at 3:25=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, May 15, 2025 at 11:41=E2=80=AFAM Nico Pache <npache@redhat.com> w=
rote:
> >
> > This series is a follow-up to [1], which adds mTHP support to khugepage=
d.
> > mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
> > configs to make sense. Without it global=3D"defer" and  mTHP=3D"inherit=
" case
> > is "undefined" behavior.
> >
> > We've seen cases were customers switching from RHEL7 to RHEL8 see a
> > significant increase in the memory footprint for the same workloads.
> >
> > Through our investigations we found that a large contributing factor to
> > the increase in RSS was an increase in THP usage.
> >
> > For workloads like MySQL, or when using allocators like jemalloc, it is
> > often recommended to set /transparent_hugepages/enabled=3Dnever. This i=
s
> > in part due to performance degradations and increased memory waste.
> >
> > This series introduces enabled=3Ddefer, this setting acts as a middle
> > ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
> > page fault handler will act normally, making a hugepage if possible. If
> > the allocation is not MADV_HUGEPAGE, then the page fault handler will
> > default to the base size allocation. The caveat is that khugepaged can
> > still operate on pages that are not MADV_HUGEPAGE.
> >
> > This allows for three things... one, applications specifically designed=
 to
> > use hugepages will get them, and two, applications that don't use
> > hugepages can still benefit from them without aggressively inserting
> > THPs at every possible chance. This curbs the memory waste, and defers
> > the use of hugepages to khugepaged. Khugepaged can then scan the memory
> > for eligible collapsing. Lastly there is the added benefit for those wh=
o
> > want THPs but experience higher latency PFs. Now you can get base page
> > performance at the PF handler and Hugepage performance for those mappin=
gs
> > after they collapse.
> >
> > Admins may want to lower max_ptes_none, if not, khugepaged may
> > aggressively collapse single allocations into hugepages.
> >
> > TESTING:
> > - Built for x86_64, aarch64, ppc64le, and s390x
> > - selftests mm
> > - In [1] I provided a script [2] that has multiple access patterns
> > - lots of general use.
> > - redis testing. This test was my original case for the defer mode. Wha=
t I
> >    was able to prove was that THP=3Dalways leads to increased max_laten=
cy
> >    cases; hence why it is recommended to disable THPs for redis servers=
.
> >    However with 'defer' we dont have the max_latency spikes and can sti=
ll
> >    get the system to utilize THPs. I further tested this with the mTHP
> >    defer setting and found that redis (and probably other jmalloc users=
)
> >    can utilize THPs via defer (+mTHP defer) without a large latency
> >    penalty and some potential gains. I uploaded some mmtest results
> >    here[3] which compares:
> >        stock+thp=3Dnever
> >        stock+(m)thp=3Dalways
> >        khugepaged-mthp + defer (max_ptes_none=3D64)
> >
> >   The results show that (m)THPs can cause some throughput regression in
> >   some cases, but also has gains in other cases. The mTHP+defer results
> >   have more gains and less losses over the (m)THP=3Dalways case.
> >
> > V6 Changes:
> > - nits
> > - rebased dependent series and added review tags
> >
> > V5 Changes:
> > - rebased dependent series
> > - added reviewed-by tag on 2/4
> >
> > V4 Changes:
> > - Minor Documentation fixes
> > - rebased the dependent series [1] onto mm-unstable
> >     commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relaxed()=
")
> >
> > V3 Changes:
> > - Combined the documentation commits into one, and moved a section to t=
he
> >   khugepaged mthp patchset
> >
> > V2 Changes:
> > - base changes on mTHP khugepaged support
> > - Fix selftests parsing issue
> > - add mTHP defer option
> > - add mTHP defer Documentation
> >
> > [1] - https://lore.kernel.org/all/20250515032226.128900-1-npache@redhat=
.com/
> > [2] - https://gitlab.com/npache/khugepaged_mthp_test
> > [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput=
2/output.html
> >
> > Nico Pache (4):
> >   mm: defer THP insertion to khugepaged
> >   mm: document (m)THP defer usage
> >   khugepaged: add defer option to mTHP options
> >   selftests: mm: add defer to thp setting parser
> >
> >  Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
> >  include/linux/huge_mm.h                    | 18 +++++-
> >  mm/huge_memory.c                           | 69 +++++++++++++++++++---
> >  mm/khugepaged.c                            |  8 +--
> >  tools/testing/selftests/mm/thp_settings.c  |  1 +
> >  tools/testing/selftests/mm/thp_settings.h  |  1 +
> >  6 files changed, 106 insertions(+), 22 deletions(-)
> >
> > --
> > 2.49.0
> >
> >
>
> Hello Nico,
>
> Upon reviewing the series, it occurred to me that BPF could solve this
> more cleanly. Adding a 'tva_flags' parameter to the BPF hook would
> handle this case and future scenarios without requiring new modes. The
> BPF mode could then serve as a unified solution.
Hi Yafang,

I dont see how this is the case? This would require users to
modify/add functionality rather than configuring the system in this
manner. What if BPF is not configured or being used? Having to use an
additional technology that requires precise configuration doesn't seem
cleaner.

Either way, thank you for taking a look into the series !

-- Nico
>
> --
> Regards
> Yafang
>


