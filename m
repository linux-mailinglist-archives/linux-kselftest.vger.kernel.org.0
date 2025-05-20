Return-Path: <linux-kselftest+bounces-33382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCF8ABD349
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 11:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D491A1895051
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E62265CAC;
	Tue, 20 May 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfGvtzNB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6DF25B1C5;
	Tue, 20 May 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747733096; cv=none; b=uQjATmDwsI3e9UzrE3xvVtvoFSc4XPBzGIz3sCySoaxj+Sw66OYhBUrhabx+5HjFVpgZxhhvsHKTfirZ6jDN6DiVe7P+qFOCugJ9mabRKGNTm1Kz3W6MLGsuWzWBHUVCXIINhp9FixKh8naFOdW+ACp9PNOa4yiVtfP6Sfn6zgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747733096; c=relaxed/simple;
	bh=8lqQQP4T8U24N8XgiVMBAB9dvBkyWQckbVdZ4ZEwckU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgsawpDf4yuLwQEUHFyTFAfAU75eh+j6RW15bf+0G8raxUHD1q93Z+EJhpOPYCfz2hxlVgLaMNmuoNJ23KR69JAQ+5XvK0xyrODPCu1QHatxpDLnKS2+Uw/Ycdn+5P4eehLVACJcCxvuzitkhuwiN/ElAfBep2GYnofp1d7UdBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfGvtzNB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f8cb6b3340so45299006d6.1;
        Tue, 20 May 2025 02:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747733093; x=1748337893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx//TkYKG/87T6qfujpj4GQczz4RSpoekiQT+JUTLAs=;
        b=mfGvtzNBMuMptWP++LSaQ1dMlqMX/AQ5CSVcMOohu4y+gIsyv7tHZDqVsE1CkBy8Bx
         qj6lOiZO15AMLWCG0sMXDPQGls71ayREZq6m6l9U4G58QU1aPXAQWwk1cz6/qklCmf4j
         mEGOEMzjkIbGZhHPbbDQAOIwQgxGj2BQP87kjeJXEDzJB4xzqA6I1w4ik9wx20Dvsbml
         b5jEdu3LezhA3lSgyoQXA0tBvoRRhpMFnPchvHjwZRo0QssOSXieffKk/mxpp/MCC44W
         ju/nI3d0udaZ/rjMp5X0zXCJ+1DkG1iY2DFOfdkQ8TuxULh8IXIL7XtDWE8jtBwuy/x/
         sgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747733093; x=1748337893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xx//TkYKG/87T6qfujpj4GQczz4RSpoekiQT+JUTLAs=;
        b=CFfZi+oAouBeo/R8F3gVyKRaXNkB7A5AiWEDJ16GoE6sEtMRTHhxABHJi+yYXX2J2N
         cOeS4tzhuicGt8tXG713ZxOnsm6zfI0ndct2jl8Kyw+Nmneh8IfPBiJ3fQE7ougwsBPT
         8woSeLCP5gTxe9XP8AozPUNusflIfENeOe3rMf9RGP/1ooqBwTwOIX2aFpHBd4Swp9Sw
         ii7nrQCTu1SJ4Lv1ZGAimDCY8IG8kk9Tfgx+0j1fhheFYigoMbsciNSllqwi68wmdvq8
         fozZdXPfCwZ3Yv7ylGnUzo8pkqQ1DpErYWSkMTtLb5mgkDH+daQN2zjKOMWRgjWH0Qsa
         PXyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmqr487JOZtRYOPzco+RT2KAHjpx+Os9hcrHBAt+wBfMGhpqfPM0Pw4MmyCnnGG37EhhIFDb4235q9MwTPx4Kc@vger.kernel.org, AJvYcCVyIQiOmWoXolyT6IeebjKnC7HNf3EqwezrBD5yoEQXTfgwVp6qp/najBp9I51VRIc1XSFxyTgCvWReQO3I@vger.kernel.org, AJvYcCWW9feh+uweAYJMc5/Uiapn3tBmYG7rixCu8BuiU8R6vPp0K+pdvN0RIbphHBIuNx3fTZ6s/dkclzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydMj/DUzC+vly4eA1i8KkdjKJhtXLyMjaVhf+Xu8xttiDJu4U2
	mmhN0KL7KslJL/Um/SXmVunTwSZ1bk4aa4vRFXeG0raKgES0H2u1j7XbaG8NTjktm3+TeH+/2Zf
	hgtameIHv9GzQNYUgW02gZ8F+jJOx9I4=
X-Gm-Gg: ASbGncvTp5K7HGWFuzvee+fijXTwy9MiUP60bdoiBmrw3s/TMlIWzWvVZgpO5CB+q3d
	tKuzdBDDtUTOt+8ntAksfLgWpEHYR7p9SwzV9VThvkZ9vfilU2PFwarmsUdwxLAEApBdHZRDHBt
	HV791qHdV+bpW5L4I3Mr95jEpGH6LsOCHq7g==
X-Google-Smtp-Source: AGHT+IGgparnaxmNvuHM/lrDoY1fvAKD0ORwmu9fSSm7EZPsILX0++SVjr2wKYyuavU6HNxWcE8IYtysoLY8rG5k1Go=
X-Received: by 2002:ad4:5aa3:0:b0:6f5:38a2:52dd with SMTP id
 6a1803df08f44-6f8b2d12d21mr267363036d6.31.1747733093356; Tue, 20 May 2025
 02:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515033857.132535-1-npache@redhat.com>
In-Reply-To: <20250515033857.132535-1-npache@redhat.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 20 May 2025 17:24:16 +0800
X-Gm-Features: AX0GCFuzkEn4ubaObVckXJemP0oCOx73QZ9HTjLQbxewFSpT9IkcJKm3ftBH9v4
Message-ID: <CALOAHbAa7DY6+hO4RJtjg-MS+cnUmsiPXX8KS1MKSfgy6HLYAQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] mm: introduce THP deferred setting
To: Nico Pache <npache@redhat.com>
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

On Thu, May 15, 2025 at 11:41=E2=80=AFAM Nico Pache <npache@redhat.com> wro=
te:
>
> This series is a follow-up to [1], which adds mTHP support to khugepaged.
> mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
> configs to make sense. Without it global=3D"defer" and  mTHP=3D"inherit" =
case
> is "undefined" behavior.
>
> We've seen cases were customers switching from RHEL7 to RHEL8 see a
> significant increase in the memory footprint for the same workloads.
>
> Through our investigations we found that a large contributing factor to
> the increase in RSS was an increase in THP usage.
>
> For workloads like MySQL, or when using allocators like jemalloc, it is
> often recommended to set /transparent_hugepages/enabled=3Dnever. This is
> in part due to performance degradations and increased memory waste.
>
> This series introduces enabled=3Ddefer, this setting acts as a middle
> ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
> page fault handler will act normally, making a hugepage if possible. If
> the allocation is not MADV_HUGEPAGE, then the page fault handler will
> default to the base size allocation. The caveat is that khugepaged can
> still operate on pages that are not MADV_HUGEPAGE.
>
> This allows for three things... one, applications specifically designed t=
o
> use hugepages will get them, and two, applications that don't use
> hugepages can still benefit from them without aggressively inserting
> THPs at every possible chance. This curbs the memory waste, and defers
> the use of hugepages to khugepaged. Khugepaged can then scan the memory
> for eligible collapsing. Lastly there is the added benefit for those who
> want THPs but experience higher latency PFs. Now you can get base page
> performance at the PF handler and Hugepage performance for those mappings
> after they collapse.
>
> Admins may want to lower max_ptes_none, if not, khugepaged may
> aggressively collapse single allocations into hugepages.
>
> TESTING:
> - Built for x86_64, aarch64, ppc64le, and s390x
> - selftests mm
> - In [1] I provided a script [2] that has multiple access patterns
> - lots of general use.
> - redis testing. This test was my original case for the defer mode. What =
I
>    was able to prove was that THP=3Dalways leads to increased max_latency
>    cases; hence why it is recommended to disable THPs for redis servers.
>    However with 'defer' we dont have the max_latency spikes and can still
>    get the system to utilize THPs. I further tested this with the mTHP
>    defer setting and found that redis (and probably other jmalloc users)
>    can utilize THPs via defer (+mTHP defer) without a large latency
>    penalty and some potential gains. I uploaded some mmtest results
>    here[3] which compares:
>        stock+thp=3Dnever
>        stock+(m)thp=3Dalways
>        khugepaged-mthp + defer (max_ptes_none=3D64)
>
>   The results show that (m)THPs can cause some throughput regression in
>   some cases, but also has gains in other cases. The mTHP+defer results
>   have more gains and less losses over the (m)THP=3Dalways case.
>
> V6 Changes:
> - nits
> - rebased dependent series and added review tags
>
> V5 Changes:
> - rebased dependent series
> - added reviewed-by tag on 2/4
>
> V4 Changes:
> - Minor Documentation fixes
> - rebased the dependent series [1] onto mm-unstable
>     commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relaxed()")
>
> V3 Changes:
> - Combined the documentation commits into one, and moved a section to the
>   khugepaged mthp patchset
>
> V2 Changes:
> - base changes on mTHP khugepaged support
> - Fix selftests parsing issue
> - add mTHP defer option
> - add mTHP defer Documentation
>
> [1] - https://lore.kernel.org/all/20250515032226.128900-1-npache@redhat.c=
om/
> [2] - https://gitlab.com/npache/khugepaged_mthp_test
> [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/=
output.html
>
> Nico Pache (4):
>   mm: defer THP insertion to khugepaged
>   mm: document (m)THP defer usage
>   khugepaged: add defer option to mTHP options
>   selftests: mm: add defer to thp setting parser
>
>  Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
>  include/linux/huge_mm.h                    | 18 +++++-
>  mm/huge_memory.c                           | 69 +++++++++++++++++++---
>  mm/khugepaged.c                            |  8 +--
>  tools/testing/selftests/mm/thp_settings.c  |  1 +
>  tools/testing/selftests/mm/thp_settings.h  |  1 +
>  6 files changed, 106 insertions(+), 22 deletions(-)
>
> --
> 2.49.0
>
>

Hello Nico,

Upon reviewing the series, it occurred to me that BPF could solve this
more cleanly. Adding a 'tva_flags' parameter to the BPF hook would
handle this case and future scenarios without requiring new modes. The
BPF mode could then serve as a unified solution.

--=20
Regards
Yafang

