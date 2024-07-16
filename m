Return-Path: <linux-kselftest+bounces-13766-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F93E93211B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 09:20:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 062F7B215EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 07:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03D3225A8;
	Tue, 16 Jul 2024 07:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="X45JPT+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D2E224DD
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721114414; cv=none; b=KmHqrlkeTOmZ2k1uYxeIFj9jamvKNAlwc9XR0YbKSgAoTnw1i52InR1S1xInEMtKADvDcr4UGzyavvrU2uThaU19peLCXhyBFmWCAucgBIvre2f8DWzax4HC9rr2i0RSaVVQUFBITZxEUW+7cx6plepV7PnOma7ay5hWCxTKjZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721114414; c=relaxed/simple;
	bh=ALc31W3uCWR9Lj90vJOo0hS+MiAERAOjPCudFEnehiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZG0EBBRsO98bTIpdvo1fGaE2HvGCYmoKbhK/K1BTsLeNKy4Fm3TWGIrhE8soHMpFQETTQQUN+GIxjgjxW/14w3oIycwummf2bU62zmy/1uxtCHjyOf+1X/s4cY8LSPDy5ZdBfou8xIBAcTvgyvDbZwgwIufVnDse/rM/h8X26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=X45JPT+l; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58c2e5e8649so9189221a12.1
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Jul 2024 00:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721114409; x=1721719209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ryz13jWMVfVyvMNCAq2D9GKM+ZrB7awLhm0ebTfWLrE=;
        b=X45JPT+lWTv8rZv7AX8dSaoryrvqvZEm0c6I/iavHHezAE+F/PlQ14MH53bE1y+DkZ
         eDkNvqqNVx1t6sHI/4KCua9AgrT2XHRu7anGDWc+s+RKtEEPZOf77vUthb/TbGba4fw9
         ovGJ3vRmarMJdAyTZkOM35adZth2rCa+VV8/K5S7LH5Ojl3Qfru+una0bvdEOtSI1Jnm
         fqIFplLxnJhCn/wYvm6NdSa5ld7BV2IU26erwLwsoaEOypM8E/1dXIjqZN9kxZA1AfMG
         bpS0iBGmah/oYI7VJ5VSQ/x8eXhBMzQM0GxMoUdnt7Bfk1gOyUpiKvqE2nKFWck5Jhx+
         TwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721114409; x=1721719209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ryz13jWMVfVyvMNCAq2D9GKM+ZrB7awLhm0ebTfWLrE=;
        b=RyaBY6owEc3U1MlxtPEruyYx8GoH9zZ/idxTDh+uy4ISvYR8sbOkpnZVTaBLs+2PcH
         upBxS2hOv9aBgBYEWl61yEbSbOhDgRlbHExG2S7aw5TqdUuY66N/64vEUs/7xeex0I7o
         Ae4VrcYrDW2hco0xKf+7CwGpUnfb/TcBu9UbV6AlMPzdbsMwxCGSbU4h8JGBE0yXH1yF
         o4GLHckxMv2W/zFjlUaY1SbGo9iFTZqTED7uGDNpQZbXXxdeox0apgckLfGZGc0s+H2G
         wNMfIJNkJ58fQC2PoKstJGESw7Rq/8VeH5E8BSn0cl96hBuSkN4Csvm2ZZNBDYfLLYCJ
         mqvA==
X-Forwarded-Encrypted: i=1; AJvYcCUxzJCPIYtUisDVtNCD5ybVHZdv1rLueqYdFjrh0Q5f+EfaD1sMobF/jaW0zAtgh3riRsvrEORtwg7yLkiUR7FSAT/hby0Q8FrIDo8Mlglg
X-Gm-Message-State: AOJu0YxmjtP6whcEqjYrv5tVmwsAVFMRaZGKC2xTS0xWv64RA7jGva7I
	1S3AOlRJ8Mz4jhDYyggZjpfMU2aoxU8g6bHoGccXh+GLrkSkRjxLPKvYAjqJt8A=
X-Google-Smtp-Source: AGHT+IF7KAqVc8tB1cq8XGEqVn4hBgytdxCDM1K+wyDBEAdRIboXhu5uwo7R0OApSSiVBd/NbepQxQ==
X-Received: by 2002:a17:906:4a4d:b0:a72:afd9:6109 with SMTP id a640c23a62f3a-a79edbfb0c9mr77909566b.16.1721114409305;
        Tue, 16 Jul 2024 00:20:09 -0700 (PDT)
Received: from localhost (109-81-86-75.rct.o2.cz. [109.81.86.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5d1f57sm275518966b.72.2024.07.16.00.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:20:09 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:20:08 +0200
From: Michal Hocko <mhocko@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
	Jonathan Corbet <corbet@lwn.net>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-ID: <ZpYfKI6W1uSMkt5i@tiehlicka>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com>
 <CAFUnj5Oh_OsP4TikWTGT6cKKTnWLaBYpE5PGzcxLTp7b=UqLkQ@mail.gmail.com>
 <CAFUnj5MahNvM+B2zynVtcnYKJ7LZHwBNEcPKGAdz-tesDeOXcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUnj5MahNvM+B2zynVtcnYKJ7LZHwBNEcPKGAdz-tesDeOXcw@mail.gmail.com>

On Mon 15-07-24 16:46:36, David Finkel wrote:
> > On Mon, Jul 15, 2024 at 4:38 PM David Finkel <davidf@vimeo.com> wrote:
> > >
> > > Other mechanisms for querying the peak memory usage of either a process
> > > or v1 memory cgroup allow for resetting the high watermark. Restore
> > > parity with those mechanisms.
> > >
> > > For example:
> > >  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
> > >    the high watermark.
> > >  - writing "5" to the clear_refs pseudo-file in a processes's proc
> > >    directory resets the peak RSS.
> > >
> > > This change copies the cgroup v1 behavior so any write to the
> > > memory.peak and memory.swap.peak pseudo-files reset the high watermark
> > > to the current usage.
> > >
> > > This behavior is particularly useful for work scheduling systems that
> > > need to track memory usage of worker processes/cgroups per-work-item.
> > > Since memory can't be squeezed like CPU can (the OOM-killer has
> > > opinions),

I do not understand the OOM-killer reference here. Why does it matter?
Could you explain please?

> > > these systems need to track the peak memory usage to compute
> > > system/container fullness when binpacking workitems.

Could you elaborate some more on how you are using this please? I expect
you recycle memcgs for different runs of workers and reset peak
consumptions before a new run and record it after it is done. The thing
which is not really clear to me is how the peak value really helps if it
can vary a lot among different runs. But maybe I misunderstand.

> > >
> > > Signed-off-by: David Finkel <davidf@vimeo.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst       | 20 +++---
> > >  mm/memcontrol.c                               | 23 ++++++
> > >  .../selftests/cgroup/test_memcontrol.c        | 72 ++++++++++++++++---
> > >  3 files changed, 99 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> > > index 8fbb0519d556..201d8e5d9f82 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1322,11 +1322,13 @@ PAGE_SIZE multiple when read back.
> > >         reclaim induced by memory.reclaim.
> > >
> > >    memory.peak
> > > -       A read-only single value file which exists on non-root
> > > -       cgroups.
> > > +       A read-write single value file which exists on non-root cgroups.
> > > +
> > > +       The max memory usage recorded for the cgroup and its descendants since
> > > +       either the creation of the cgroup or the most recent reset.
> > >
> > > -       The max memory usage recorded for the cgroup and its
> > > -       descendants since the creation of the cgroup.
> > > +       Any non-empty write to this file resets it to the current memory usage.
> > > +       All content written is completely ignored.
> > >
> > >    memory.oom.group
> > >         A read-write single value file which exists on non-root
> > > @@ -1652,11 +1654,13 @@ PAGE_SIZE multiple when read back.
> > >         Healthy workloads are not expected to reach this limit.
> > >
> > >    memory.swap.peak
> > > -       A read-only single value file which exists on non-root
> > > -       cgroups.
> > > +       A read-write single value file which exists on non-root cgroups.
> > > +
> > > +       The max swap usage recorded for the cgroup and its descendants since
> > > +       the creation of the cgroup or the most recent reset.
> > >
> > > -       The max swap usage recorded for the cgroup and its
> > > -       descendants since the creation of the cgroup.
> > > +       Any non-empty write to this file resets it to the current swap usage.
> > > +       All content written is completely ignored.
> > >
> > >    memory.swap.max
> > >         A read-write single value file which exists on non-root
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 8f2f1bb18c9c..abfa547615d6 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -25,6 +25,7 @@
> > >   * Copyright (C) 2020 Alibaba, Inc, Alex Shi
> > >   */
> > >
> > > +#include <linux/cgroup-defs.h>
> > >  #include <linux/page_counter.h>
> > >  #include <linux/memcontrol.h>
> > >  #include <linux/cgroup.h>
> > > @@ -6915,6 +6916,16 @@ static u64 memory_peak_read(struct cgroup_subsys_state *css,
> > >         return (u64)memcg->memory.watermark * PAGE_SIZE;
> > >  }
> > >
> > > +static ssize_t memory_peak_write(struct kernfs_open_file *of,
> > > +                                char *buf, size_t nbytes, loff_t off)
> > > +{
> > > +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > > +
> > > +       page_counter_reset_watermark(&memcg->memory);
> > > +
> > > +       return nbytes;
> > > +}
> > > +
> > >  static int memory_min_show(struct seq_file *m, void *v)
> > >  {
> > >         return seq_puts_memcg_tunable(m,
> > > @@ -7232,6 +7243,7 @@ static struct cftype memory_files[] = {
> > >                 .name = "peak",
> > >                 .flags = CFTYPE_NOT_ON_ROOT,
> > >                 .read_u64 = memory_peak_read,
> > > +               .write = memory_peak_write,
> > >         },
> > >         {
> > >                 .name = "min",
> > > @@ -8201,6 +8213,16 @@ static u64 swap_peak_read(struct cgroup_subsys_state *css,
> > >         return (u64)memcg->swap.watermark * PAGE_SIZE;
> > >  }
> > >
> > > +static ssize_t swap_peak_write(struct kernfs_open_file *of,
> > > +                                char *buf, size_t nbytes, loff_t off)
> > > +{
> > > +       struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
> > > +
> > > +       page_counter_reset_watermark(&memcg->swap);
> > > +
> > > +       return nbytes;
> > > +}
> > > +
> > >  static int swap_high_show(struct seq_file *m, void *v)
> > >  {
> > >         return seq_puts_memcg_tunable(m,
> > > @@ -8283,6 +8305,7 @@ static struct cftype swap_files[] = {
> > >                 .name = "swap.peak",
> > >                 .flags = CFTYPE_NOT_ON_ROOT,
> > >                 .read_u64 = swap_peak_read,
> > > +               .write = swap_peak_write,
> > >         },
> > >         {
> > >                 .name = "swap.events",
> > > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > index 41ae8047b889..681972de673b 100644
> > > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > > @@ -161,12 +161,12 @@ static int alloc_pagecache_50M_check(const char *cgroup, void *arg)
> > >  /*
> > >   * This test create a memory cgroup, allocates
> > >   * some anonymous memory and some pagecache
> > > - * and check memory.current and some memory.stat values.
> > > + * and checks memory.current, memory.peak, and some memory.stat values.
> > >   */
> > > -static int test_memcg_current(const char *root)
> > > +static int test_memcg_current_peak(const char *root)
> > >  {
> > >         int ret = KSFT_FAIL;
> > > -       long current;
> > > +       long current, peak, peak_reset;
> > >         char *memcg;
> > >
> > >         memcg = cg_name(root, "memcg_test");
> > > @@ -180,12 +180,32 @@ static int test_memcg_current(const char *root)
> > >         if (current != 0)
> > >                 goto cleanup;
> > >
> > > +       peak = cg_read_long(memcg, "memory.peak");
> > > +       if (peak != 0)
> > > +               goto cleanup;
> > > +
> > >         if (cg_run(memcg, alloc_anon_50M_check, NULL))
> > >                 goto cleanup;
> > >
> > > +       peak = cg_read_long(memcg, "memory.peak");
> > > +       if (peak < MB(50))
> > > +               goto cleanup;
> > > +
> > > +       peak_reset = cg_write(memcg, "memory.peak", "\n");
> > > +       if (peak_reset != 0)
> > > +               goto cleanup;
> > > +
> > > +       peak = cg_read_long(memcg, "memory.peak");
> > > +       if (peak > MB(30))
> > > +               goto cleanup;
> > > +
> > >         if (cg_run(memcg, alloc_pagecache_50M_check, NULL))
> > >                 goto cleanup;
> > >
> > > +       peak = cg_read_long(memcg, "memory.peak");
> > > +       if (peak < MB(50))
> > > +               goto cleanup;
> > > +
> > >         ret = KSFT_PASS;
> > >
> > >  cleanup:
> > > @@ -817,13 +837,14 @@ static int alloc_anon_50M_check_swap(const char *cgroup, void *arg)
> > >
> > >  /*
> > >   * This test checks that memory.swap.max limits the amount of
> > > - * anonymous memory which can be swapped out.
> > > + * anonymous memory which can be swapped out. Additionally, it verifies that
> > > + * memory.swap.peak reflects the high watermark and can be reset.
> > >   */
> > > -static int test_memcg_swap_max(const char *root)
> > > +static int test_memcg_swap_max_peak(const char *root)
> > >  {
> > >         int ret = KSFT_FAIL;
> > >         char *memcg;
> > > -       long max;
> > > +       long max, peak;
> > >
> > >         if (!is_swap_enabled())
> > >                 return KSFT_SKIP;
> > > @@ -840,6 +861,12 @@ static int test_memcg_swap_max(const char *root)
> > >                 goto cleanup;
> > >         }
> > >
> > > +       if (cg_read_long(memcg, "memory.swap.peak"))
> > > +               goto cleanup;
> > > +
> > > +       if (cg_read_long(memcg, "memory.peak"))
> > > +               goto cleanup;
> > > +
> > >         if (cg_read_strcmp(memcg, "memory.max", "max\n"))
> > >                 goto cleanup;
> > >
> > > @@ -862,6 +889,27 @@ static int test_memcg_swap_max(const char *root)
> > >         if (cg_read_key_long(memcg, "memory.events", "oom_kill ") != 1)
> > >                 goto cleanup;
> > >
> > > +       peak = cg_read_long(memcg, "memory.peak");
> > > +       if (peak < MB(29))
> > > +               goto cleanup;
> > > +
> > > +       peak = cg_read_long(memcg, "memory.swap.peak");
> > > +       if (peak < MB(29))
> > > +               goto cleanup;
> > > +
> > > +       if (cg_write(memcg, "memory.swap.peak", "\n"))
> > > +               goto cleanup;
> > > +
> > > +       if (cg_read_long(memcg, "memory.swap.peak") > MB(10))
> > > +               goto cleanup;
> > > +
> > > +
> > > +       if (cg_write(memcg, "memory.peak", "\n"))
> > > +               goto cleanup;
> > > +
> > > +       if (cg_read_long(memcg, "memory.peak"))
> > > +               goto cleanup;
> > > +
> > >         if (cg_run(memcg, alloc_anon_50M_check_swap, (void *)MB(30)))
> > >                 goto cleanup;
> > >
> > > @@ -869,6 +917,14 @@ static int test_memcg_swap_max(const char *root)
> > >         if (max <= 0)
> > >                 goto cleanup;
> > >
> > > +       peak = cg_read_long(memcg, "memory.peak");
> > > +       if (peak < MB(29))
> > > +               goto cleanup;
> > > +
> > > +       peak = cg_read_long(memcg, "memory.swap.peak");
> > > +       if (peak < MB(19))
> > > +               goto cleanup;
> > > +
> > >         ret = KSFT_PASS;
> > >
> > >  cleanup:
> > > @@ -1295,7 +1351,7 @@ struct memcg_test {
> > >         const char *name;
> > >  } tests[] = {
> > >         T(test_memcg_subtree_control),
> > > -       T(test_memcg_current),
> > > +       T(test_memcg_current_peak),
> > >         T(test_memcg_min),
> > >         T(test_memcg_low),
> > >         T(test_memcg_high),
> > > @@ -1303,7 +1359,7 @@ struct memcg_test {
> > >         T(test_memcg_max),
> > >         T(test_memcg_reclaim),
> > >         T(test_memcg_oom_events),
> > > -       T(test_memcg_swap_max),
> > > +       T(test_memcg_swap_max_peak),
> > >         T(test_memcg_sock),
> > >         T(test_memcg_oom_group_leaf_events),
> > >         T(test_memcg_oom_group_parent_events),
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > David Finkel
> > Senior Principal Software Engineer, Core Services
> 
> 
> 
> -- 
> David Finkel
> Senior Principal Software Engineer, Core Services

-- 
Michal Hocko
SUSE Labs

