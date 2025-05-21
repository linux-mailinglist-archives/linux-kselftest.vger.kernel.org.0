Return-Path: <linux-kselftest+bounces-33452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FA0ABF2EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 13:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19E01B67E5C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 11:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D002F2638BA;
	Wed, 21 May 2025 11:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp2dTmtt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430521D585;
	Wed, 21 May 2025 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827374; cv=none; b=X9y++8vAERCLSDRA/DiY6vTkOQwK6QI1ZBlDI5TyyyTUDzsPtVOjMHnyNbHbOOK6EsQnJNauf4wWKtnvU+2HBhu+kP4yvOeZXyZ5V1PvM6Ag1DORJV1gFPYmy03AzCbI7ppyKho46yeEftvQeyFqdHYS9GJmzsLvXp48rHE7QHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827374; c=relaxed/simple;
	bh=9Ef79o5yBUit9XL3M4Px4rdgyAc4s1/1oAG8IcTcFms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+RIehKBGlvdHpWTcN7ruu6FjgdlGayY6g4ReL/JV/WLBs2/2H3xllkCWGT361DP24VdDo0iFNR7ppAUkt+6bnl4RhSoUMMFzxmZAKxdkARl5t76nWkVZy2y9rITYXFRsUu+E2L9A2CWNcNx9TinOHDmnBgpQJuxw28hfrLCVoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp2dTmtt; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c55500d08cso741013285a.0;
        Wed, 21 May 2025 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747827372; x=1748432172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYdOgdcjYPnCY9yhLEBUShjQzNMS1iD03XTdqPSE560=;
        b=jp2dTmttzkOs/8NtZlKmgqLYmnrnPFGTXLwO40Iu+DLzFELsMrpqQeysCSk6IB88Dq
         d3aclT3cHyQdZqf0tKzZ6ZPvRaeeDsJi3itDBucznRAxqZor8fnluEELu7bPGIeUakgF
         YYu/gEXo41y76r97mQVAW9f/ZxeR4bHAV1/lbFDgf+AvmxZd76mttqmSU3XOmMkICpVz
         I5ZgYS49fnyL2uHJHF49OtF3bQw/I3ceHHZRciSHxX5S3nF4+0sQlLZCfcWv2fCCpYru
         0fnyh5Hd4A8hl6mJ/c+3L0L/XykpoUrYXJFkvQpXn+mpSpEN64W7h4x2WbdrZmB2JoRg
         dAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827372; x=1748432172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYdOgdcjYPnCY9yhLEBUShjQzNMS1iD03XTdqPSE560=;
        b=B2NL3H0A3mMsE52jGWGhHsZ9RrWNWEK/7SAS++Exsv4TFYkWJbWn7USMBX+oQElt4V
         vvWg8O7O9iTGLPJIKQo25r1DRvmOOdE74G/lNsLg+KfBCGosi5lcl86FZJm7eJ7irptT
         lUMw+6Sa0atYoQpeG1cjEIwJlox/nsHNApbtHi2Z9zBpz9jNnmJ9J5tfgjWsMsqkN5S0
         js/YdnNJHL4nV+IX3K+2S8UG+b88FqGOZbtaD7FEslB1T42uvzvPEYQYOw4jVZIJplaC
         57Rpdi2bUxeENxHHjL3IPeV7UVX4IXBgjFv3ws9y5XI5YY8h4nQCPYH4Zcmi5mxuFdEo
         gEgA==
X-Forwarded-Encrypted: i=1; AJvYcCUTKlDhX4qdRfuj1jYIRWhRxqf/UU+349akalG6AVUuk+s/CRmOUK1M5QIENamkYQlohDId3Pl7NSU90IfK@vger.kernel.org, AJvYcCVA86SE85Ha9vV9RJfGxRlAYYpCBkzZLbA1yz6NMycJz23YxBOHSZXcHtJN6cgBtvQ6wc1S1WU3kks=@vger.kernel.org, AJvYcCVX9dvk25hVN8IEqJVV2nqHOcAiuyijs1Gf03V+xZweCCTEEavXtKNq2T6oUBOUmcNFxNEc+uI0MlfZ58i2QkeM@vger.kernel.org
X-Gm-Message-State: AOJu0YxW27+H46d6kPpyOaunfjm6faa5NknZLIMnUjR98pvNnTTf1Ru0
	/Mc9w8xMwqDLo/4j13jiLTXyqwy3coyPzc7J1omxJ473lo2ZhvKFUyQ4A/TJ4Dc7LGcvv0JhCue
	XRelpeCWfkNLX7c8v38XgPdS3kAt6kJc=
X-Gm-Gg: ASbGncsTR1DQKJjGnuzybky9JCwnvPFQslieIKPPqn+G6+jPWSDTQZiIMDvKtX/V0uW
	a7h4XOIz7DQ6zjsCA0O2LTPadzHfgE40dLxpAs0sUSDL9fV7BjP2cVjrw4tbaGj2EKl73bAFqOt
	ezmnvKbPPQEy9Vky4ZN42Kl9IgrGMR6G3H1w==
X-Google-Smtp-Source: AGHT+IG0NSqVB+WG0qBhrlsKA2H54Ax1QA3WrMlpFSukxISaFW+UsqeUomOGi6GkNqpdR+aDMSvDlBsRCUMQuSB19Xw=
X-Received: by 2002:a05:6214:1302:b0:6f8:ac7b:c1ab with SMTP id
 6a1803df08f44-6f8b08bfa84mr330355896d6.34.1747827371620; Wed, 21 May 2025
 04:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515033857.132535-1-npache@redhat.com> <CALOAHbAa7DY6+hO4RJtjg-MS+cnUmsiPXX8KS1MKSfgy6HLYAQ@mail.gmail.com>
 <CAA1CXcA0WX+qGKvL4VcTM_bazFxRyDmp5DK60ycoS4OCDUnH-Q@mail.gmail.com>
In-Reply-To: <CAA1CXcA0WX+qGKvL4VcTM_bazFxRyDmp5DK60ycoS4OCDUnH-Q@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 May 2025 19:35:35 +0800
X-Gm-Features: AX0GCFuRjloFvRQwWoX3nj3PIwElDQvn-OuuZckoV7z_HUQsvYM0MLMqgtm-VHg
Message-ID: <CALOAHbATH4+y71TfVOaGU9NV5coy9XnLfDD1pDBfniv=T-cyqw@mail.gmail.com>
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

On Wed, May 21, 2025 at 6:19=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
>
> On Tue, May 20, 2025 at 3:25=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Thu, May 15, 2025 at 11:41=E2=80=AFAM Nico Pache <npache@redhat.com>=
 wrote:
> > >
> > > This series is a follow-up to [1], which adds mTHP support to khugepa=
ged.
> > > mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
> > > configs to make sense. Without it global=3D"defer" and  mTHP=3D"inher=
it" case
> > > is "undefined" behavior.
> > >
> > > We've seen cases were customers switching from RHEL7 to RHEL8 see a
> > > significant increase in the memory footprint for the same workloads.
> > >
> > > Through our investigations we found that a large contributing factor =
to
> > > the increase in RSS was an increase in THP usage.
> > >
> > > For workloads like MySQL, or when using allocators like jemalloc, it =
is
> > > often recommended to set /transparent_hugepages/enabled=3Dnever. This=
 is
> > > in part due to performance degradations and increased memory waste.
> > >
> > > This series introduces enabled=3Ddefer, this setting acts as a middle
> > > ground between always and madvise. If the mapping is MADV_HUGEPAGE, t=
he
> > > page fault handler will act normally, making a hugepage if possible. =
If
> > > the allocation is not MADV_HUGEPAGE, then the page fault handler will
> > > default to the base size allocation. The caveat is that khugepaged ca=
n
> > > still operate on pages that are not MADV_HUGEPAGE.
> > >
> > > This allows for three things... one, applications specifically design=
ed to
> > > use hugepages will get them, and two, applications that don't use
> > > hugepages can still benefit from them without aggressively inserting
> > > THPs at every possible chance. This curbs the memory waste, and defer=
s
> > > the use of hugepages to khugepaged. Khugepaged can then scan the memo=
ry
> > > for eligible collapsing. Lastly there is the added benefit for those =
who
> > > want THPs but experience higher latency PFs. Now you can get base pag=
e
> > > performance at the PF handler and Hugepage performance for those mapp=
ings
> > > after they collapse.
> > >
> > > Admins may want to lower max_ptes_none, if not, khugepaged may
> > > aggressively collapse single allocations into hugepages.
> > >
> > > TESTING:
> > > - Built for x86_64, aarch64, ppc64le, and s390x
> > > - selftests mm
> > > - In [1] I provided a script [2] that has multiple access patterns
> > > - lots of general use.
> > > - redis testing. This test was my original case for the defer mode. W=
hat I
> > >    was able to prove was that THP=3Dalways leads to increased max_lat=
ency
> > >    cases; hence why it is recommended to disable THPs for redis serve=
rs.
> > >    However with 'defer' we dont have the max_latency spikes and can s=
till
> > >    get the system to utilize THPs. I further tested this with the mTH=
P
> > >    defer setting and found that redis (and probably other jmalloc use=
rs)
> > >    can utilize THPs via defer (+mTHP defer) without a large latency
> > >    penalty and some potential gains. I uploaded some mmtest results
> > >    here[3] which compares:
> > >        stock+thp=3Dnever
> > >        stock+(m)thp=3Dalways
> > >        khugepaged-mthp + defer (max_ptes_none=3D64)
> > >
> > >   The results show that (m)THPs can cause some throughput regression =
in
> > >   some cases, but also has gains in other cases. The mTHP+defer resul=
ts
> > >   have more gains and less losses over the (m)THP=3Dalways case.
> > >
> > > V6 Changes:
> > > - nits
> > > - rebased dependent series and added review tags
> > >
> > > V5 Changes:
> > > - rebased dependent series
> > > - added reviewed-by tag on 2/4
> > >
> > > V4 Changes:
> > > - Minor Documentation fixes
> > > - rebased the dependent series [1] onto mm-unstable
> > >     commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relaxed=
()")
> > >
> > > V3 Changes:
> > > - Combined the documentation commits into one, and moved a section to=
 the
> > >   khugepaged mthp patchset
> > >
> > > V2 Changes:
> > > - base changes on mTHP khugepaged support
> > > - Fix selftests parsing issue
> > > - add mTHP defer option
> > > - add mTHP defer Documentation
> > >
> > > [1] - https://lore.kernel.org/all/20250515032226.128900-1-npache@redh=
at.com/
> > > [2] - https://gitlab.com/npache/khugepaged_mthp_test
> > > [3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutp=
ut2/output.html
> > >
> > > Nico Pache (4):
> > >   mm: defer THP insertion to khugepaged
> > >   mm: document (m)THP defer usage
> > >   khugepaged: add defer option to mTHP options
> > >   selftests: mm: add defer to thp setting parser
> > >
> > >  Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
> > >  include/linux/huge_mm.h                    | 18 +++++-
> > >  mm/huge_memory.c                           | 69 +++++++++++++++++++-=
--
> > >  mm/khugepaged.c                            |  8 +--
> > >  tools/testing/selftests/mm/thp_settings.c  |  1 +
> > >  tools/testing/selftests/mm/thp_settings.h  |  1 +
> > >  6 files changed, 106 insertions(+), 22 deletions(-)
> > >
> > > --
> > > 2.49.0
> > >
> > >
> >
> > Hello Nico,
> >
> > Upon reviewing the series, it occurred to me that BPF could solve this
> > more cleanly. Adding a 'tva_flags' parameter to the BPF hook would
> > handle this case and future scenarios without requiring new modes. The
> > BPF mode could then serve as a unified solution.
> Hi Yafang,
>
> I dont see how this is the case? This would require users to
> modify/add functionality rather than configuring the system in this
> manner. What if BPF is not configured or being used? Having to use an
> additional technology that requires precise configuration doesn't seem
> cleaner.

The core challenge remains: while certain tasks benefit from this new
mode, others see no improvement=E2=80=94or may even regress.
For that reason, implementing it globally seems unwise=E2=80=94per-task
control would be far more effective.

--=20
Regards
Yafang

