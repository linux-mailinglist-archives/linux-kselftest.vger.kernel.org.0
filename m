Return-Path: <linux-kselftest+bounces-14002-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC4C93943B
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 21:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C7031C215B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 19:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A2416EBE9;
	Mon, 22 Jul 2024 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="Fc+uyHVT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09222EE3
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721676625; cv=none; b=GH+JNMlLiV50FiGRyqByC2jHNx2KKF3xD8v9eGWKzr3w/11HkWCfRejq1woUUnkEUByjA+yQH5o50a0xaG6HQ3mLZrN1IxVw2bI/Q4RAWUYiwP6ctYi250zhX/eoL/tJSMRs6bL6Gf63qIHCD+Li53YIOaa//5y7FiLajGhD6Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721676625; c=relaxed/simple;
	bh=mTBF6eCO7MOvjqpNiFncv3e78JXo++O4qjJeT+uWEQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lOS98O2j5iM7nyR9OnWxP9gdLaggjuxvW3zbq2Mc5o/yk9JWWJ5168zbN/5/s+j5acH9qzdkSMr6BYjIdm0IfitOGawghk3iIQuYVj2e/FaZkZuP+K3u84oZmWNj4VmkxNdhP5dN8tj+VVhLOjg8IeFeArNJ4bq6EmnLdPyED3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=Fc+uyHVT; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-398039f8b7bso15453485ab.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 12:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721676622; x=1722281422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCogWQ6hD/OeHGvYBDDWltl6r0cm0G7fpS+PKDrNV4U=;
        b=Fc+uyHVTCT+UY5RIcf3uEoHNB8066n0WvYjyVJOSM7yQsGZjQyho+k8poVVtqXEki6
         tjzEqBl+M7nRq3gq8zo3fxx2BmeHaWcZSUschrOjCZ8YyUAq7Yf9Qbx7aN+ntK1v/nYW
         X5fLWBMJMy8Ya0qTc6mNkh7LBPfFdCjqtP55c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721676622; x=1722281422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCogWQ6hD/OeHGvYBDDWltl6r0cm0G7fpS+PKDrNV4U=;
        b=h4Ea3IIT1e0GL9yLsmuTo67b7MB860ikB1mSP1URxtfZyTsrvWf7wOr1zl4lr1BfOW
         1siXz41KxcIFRHiNmMjzNdijhqVv2gob8F+zzpaOD5f7aZ0YvDs6BBZ+yzPjPLI6sotD
         H/KPTIAYlW8rqOZwWHsBwbae3WTtDU0iL0cETK47DlhGmyWeKlB8EnHIxnYEylpaIikq
         w0lWzTno0Bj+WbYGYY7R0KyEj/ORR/HRfdlbhI6ldpo5Uz/Jb7XWXPAQkTGXjlYygFd+
         L6Iuo6NJ1Q+GQAlsBNMtHMU6y6NNBOBTSHSDx1vsIAYWsJAq9keUWa3hsHI5L7c6V3DR
         QRmg==
X-Forwarded-Encrypted: i=1; AJvYcCXIpBPB8AdAFPbEbCIRAsUbhWr64VhK8PUmCfEWBELS5Cq+IoPMrTnZWe++ivL3yecoiOTmyxUan9jGuM5vOm8K5sBU4Tuqp5JZBFEg4Q8a
X-Gm-Message-State: AOJu0YxLLQ9cQ94JNm4bZwbm9gZn3XILvEf7HBHgUGUy+MHn+NXtHdq5
	Vus3jRMWAWXWMdvJK0ZFKWlIuRCbForvwFuZnOp+nBPgO0Jchmry8KYt8qNxZanzXvgCrEp4HFJ
	VJuGyoyDPp9Xt3RIaqp6EVlKXSRo+0yQhpeRVBg==
X-Google-Smtp-Source: AGHT+IF83ZXQr0fLbPoe7YkT770l6Q11YsMxlH/S2dgN5UrF5ZGga78MK5/YZxlwRWucw7FDi2La/ul03GNvdq2T69M=
X-Received: by 2002:a05:6e02:1a6a:b0:375:cad3:5eb2 with SMTP id
 e9e14a558f8ab-3993ff8ad77mr81167355ab.13.1721676622334; Mon, 22 Jul 2024
 12:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722151713.2724855-1-davidf@vimeo.com> <20240722151713.2724855-2-davidf@vimeo.com>
 <Zp6jSoB14boeGhWH@google.com>
In-Reply-To: <Zp6jSoB14boeGhWH@google.com>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 22 Jul 2024 15:30:10 -0400
Message-ID: <CAFUnj5MF4nKq0B7aWWyBpK3b5EZh7W4+xAmeg5SMwpd7gHptsA@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com, 
	Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Roman,

Thanks for the review.

On Mon, Jul 22, 2024 at 2:22=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Mon, Jul 22, 2024 at 11:17:13AM -0400, David Finkel wrote:
> > Other mechanisms for querying the peak memory usage of either a process
> > or v1 memory cgroup allow for resetting the high watermark. Restore
> > parity with those mechanisms, but with a less racy API.
> >
> > For example:
> >  - Any write to memory.max_usage_in_bytes in a cgroup v1 mount resets
> >    the high watermark.
> >  - writing "5" to the clear_refs pseudo-file in a processes's proc
> >    directory resets the peak RSS.
> >
> > This change is an evolution of a previous patch, which mostly copied th=
e
> > cgroup v1 behavior, however, there were concerns about races/ownership
> > issues with a global reset, so instead this change makes the reset
> > filedescriptor-local.
> >
> > Writing a specific string to the memory.peak and memory.swap.peak
> > pseudo-files reset the high watermark to the current usage for
> > subsequent reads through that same fd.
> >
> > Notably, following Johannes's suggestion, this implementation moves the
> > O(fds that have written) behavior onto the fd write(2) path. Instead, o=
n
> > the page-allocation path, we simply add one additional watermark to
> > conditionally bump per-hierarchy level in the page-counter.
> >
> > This behavior is particularly useful for work scheduling systems that
> > need to track memory usage of worker processes/cgroups per-work-item.
> > Since memory can't be squeezed like CPU can (the OOM-killer has
> > opinions), these systems need to track the peak memory usage to compute
> > system/container fullness when binpacking workitems.
> >
> > Most notably, Vimeo's use-case involves a system that's doing global
> > binpacking across many Kubernetes pods/containers, and while we can use
> > PSI for some local decisions about overload, we strive to avoid packing
> > workloads too tightly in the first place. To facilitate this, we track
> > the peak memory usage. However, since we run with long-lived workers (t=
o
> > amortize startup costs) we need a way to track the high watermark while
> > a work-item is executing. Polling runs the risk of missing short spikes
> > that last for timescales below the polling interval, and peak memory
> > tracking at the cgroup level is otherwise perfect for this use-case.
> >
> > As this data is used to ensure that binpacked work ends up with
> > sufficient headroom, this use-case mostly avoids the inaccuracies
> > surrounding reclaimable memory.
> >
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: David Finkel <davidf@vimeo.com>
> > ---
> >  Documentation/admin-guide/cgroup-v2.rst       |  26 +-
> >  include/linux/cgroup.h                        |   7 +
> >  include/linux/memcontrol.h                    |   5 +
> >  include/linux/page_counter.h                  |   6 +
> >  kernel/cgroup/cgroup-internal.h               |   2 +
> >  kernel/cgroup/cgroup.c                        |   7 +
> >  mm/memcontrol.c                               | 165 ++++++++++++-
> >  mm/page_counter.c                             |   4 +
> >  tools/testing/selftests/cgroup/cgroup_util.c  |  22 ++
> >  tools/testing/selftests/cgroup/cgroup_util.h  |   2 +
> >  .../selftests/cgroup/test_memcontrol.c        | 227 +++++++++++++++++-
> >  11 files changed, 448 insertions(+), 25 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/ad=
min-guide/cgroup-v2.rst
> > index 8fbb0519d556..10a2f919128f 100644
> > --- a/Documentation/admin-guide/cgroup-v2.rst
> > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > @@ -1322,11 +1322,16 @@ PAGE_SIZE multiple when read back.
> >       reclaim induced by memory.reclaim.
> >
> >    memory.peak
> > -     A read-only single value file which exists on non-root
> > -     cgroups.
> > +     A read-write single value file which exists on non-root cgroups.
> > +
> > +     The max memory usage recorded for the cgroup and its descendants =
since
> > +     either the creation of the cgroup or the most recent reset for th=
at fd.
> >
> > -     The max memory usage recorded for the cgroup and its
> > -     descendants since the creation of the cgroup.
> > +     A write of the string "fd_local_reset" to this file resets it to =
the
> > +     current memory usage for subsequent reads through the same
>
> Hi David!
>
> Not a very strong preference, but with the current design, do we really e=
xpect
> to have a non-local reset? If not, can we agree on a "reset" string inste=
ad
> for a sake of simplicity?

I put in "fd_local_reset" as a bit of a straw-man. I'm fine with
changing it to "reset"
since the consensus seemed to be that a global reset was problematic.

>
> > +     file descriptor.
> > +     Attempts to write any other string will return EINVAL
> > +     (modulo leading and trailing whitespace).
> >
> >    memory.oom.group
> >       A read-write single value file which exists on non-root
> > @@ -1652,11 +1657,16 @@ PAGE_SIZE multiple when read back.
> >       Healthy workloads are not expected to reach this limit.
> >
> >    memory.swap.peak
> > -     A read-only single value file which exists on non-root
> > -     cgroups.
> > +     A read-write single value file which exists on non-root cgroups.
> > +
> > +     The max swap usage recorded for the cgroup and its descendants si=
nce
> > +     the creation of the cgroup or the most recent reset for that fd.
> >
> > -     The max swap usage recorded for the cgroup and its
> > -     descendants since the creation of the cgroup.
> > +     A write of the string "fd_local_reset" to this file resets it to =
the
> > +     current memory usage for subsequent reads through the same
> > +     file descriptor.
> > +     Attempts to write any other string will return EINVAL
> > +     (modulo leading and trailing whitespace).
> >
> >    memory.swap.max
> >       A read-write single value file which exists on non-root
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index 2150ca60394b..9bda441227ea 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -855,4 +855,11 @@ static inline void cgroup_bpf_put(struct cgroup *c=
grp) {}
> >
> >  struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy=
_id);
> >
> > +struct memcg_peak_mem_ctx {
> > +     long                            local_watermark;
> > +     struct memcg_peak_mem_ctx       *next, *prev;
>
> Please, take a look at include/linux/list.h and use it instead of
> re-implementing list operations from scratch.

I clearly didn't look hard enough for that.
Thanks! I'll port this to use those helpers/macros.

>
> > +};
> > +
> > +struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_op=
en_file *of);
> > +
> >  #endif /* _LINUX_CGROUP_H */
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 030d34e9d117..6be7507c6fd3 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -198,6 +198,11 @@ struct mem_cgroup {
> >       struct page_counter kmem;               /* v1 only */
> >       struct page_counter tcpmem;             /* v1 only */
> >
> > +     /* lists of memcg peak watching contexts on swap and memory */
> > +     struct memcg_peak_mem_ctx *peak_memory_local_watermark_watchers;
> > +     struct memcg_peak_mem_ctx *peak_swap_local_watermark_watchers;
> > +     spinlock_t pagecounter_peak_watchers_lock;
> > +
> >       /* Range enforcement for interrupt charges */
> >       struct work_struct high_work;
> >
> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.=
h
> > index 8cd858d912c4..047ceaece258 100644
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -26,6 +26,7 @@ struct page_counter {
> >       atomic_long_t children_low_usage;
> >
> >       unsigned long watermark;
> > +     unsigned long local_watermark; /* track min of fd-local resets */
> >       unsigned long failcnt;
> >
> >       /* Keep all the read most fields in a separete cacheline. */
> > @@ -81,4 +82,9 @@ static inline void page_counter_reset_watermark(struc=
t page_counter *counter)
> >       counter->watermark =3D page_counter_read(counter);
> >  }
> >
> > +static inline void page_counter_reset_local_watermark(struct page_coun=
ter *counter)
> > +{
> > +     counter->local_watermark =3D page_counter_read(counter);
> > +}
> > +
> >  #endif /* _LINUX_PAGE_COUNTER_H */
> > diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-int=
ernal.h
> > index 520b90dd97ec..5a97ba08e976 100644
> > --- a/kernel/cgroup/cgroup-internal.h
> > +++ b/kernel/cgroup/cgroup-internal.h
> > @@ -81,6 +81,8 @@ struct cgroup_file_ctx {
> >       struct {
> >               struct cgroup_pidlist   *pidlist;
> >       } procs1;
> > +
> > +     struct memcg_peak_mem_ctx peak;
> >  };
> >
> >  /*
> > diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> > index e32b6972c478..38b935ffa6cf 100644
> > --- a/kernel/cgroup/cgroup.c
> > +++ b/kernel/cgroup/cgroup.c
> > @@ -1964,6 +1964,13 @@ static int cgroup2_parse_param(struct fs_context=
 *fc, struct fs_parameter *param
> >       return -EINVAL;
> >  }
> >
> > +struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_op=
en_file *of)
> > +{
> > +     struct cgroup_file_ctx *ctx =3D of->priv;
> > +
> > +     return &ctx->peak;
> > +}
> > +
> >  static void apply_cgroup_root_flags(unsigned int root_flags)
> >  {
> >       if (current->nsproxy->cgroup_ns =3D=3D &init_cgroup_ns) {
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 8f2f1bb18c9c..eb6614236371 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -25,6 +25,7 @@
> >   * Copyright (C) 2020 Alibaba, Inc, Alex Shi
> >   */
> >
> > +#include <linux/cgroup-defs.h>
> >  #include <linux/page_counter.h>
> >  #include <linux/memcontrol.h>
> >  #include <linux/cgroup.h>
> > @@ -5745,6 +5746,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct=
 mem_cgroup *parent)
> >       vmpressure_init(&memcg->vmpressure);
> >       INIT_LIST_HEAD(&memcg->event_list);
> >       spin_lock_init(&memcg->event_list_lock);
> > +     spin_lock_init(&memcg->pagecounter_peak_watchers_lock);
> >       memcg->socket_pressure =3D jiffies;
> >  #ifdef CONFIG_MEMCG_KMEM
> >       memcg->kmemcg_id =3D -1;
> > @@ -6907,12 +6909,130 @@ static u64 memory_current_read(struct cgroup_s=
ubsys_state *css,
> >       return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
> >  }
> >
> > -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> > -                         struct cftype *cft)
> > +static struct page_counter *memcg_memory_extract_page_counter(struct m=
em_cgroup *memcg)
> >  {
> > +     return &memcg->memory;
> > +}
> > +
> > +static struct memcg_peak_mem_ctx **memcg_memory_extract_peak_watchers(=
struct mem_cgroup *memcg)
> > +{
> > +     return &memcg->peak_memory_local_watermark_watchers;
> > +}
> > +
> > +inline int swap_memory_peak_show(
> > +     struct seq_file *sf, void *v,
> > +     struct page_counter *(*extract_pc)(struct mem_cgroup *memcg))
> > +{
> > +     struct cgroup_subsys_state *css =3D seq_css(sf);
> >       struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
> > +     struct page_counter *pc =3D extract_pc(memcg);
> > +
> > +     struct kernfs_open_file *of =3D sf->private;
> > +     struct memcg_peak_mem_ctx *ctx =3D memcg_extract_peak_mem_ctx(of)=
;
> > +     s64 fd_peak =3D ctx->local_watermark;
> > +
> > +     if (fd_peak =3D=3D -1) {
> > +             seq_printf(sf, "%llu\n", (u64)pc->watermark * PAGE_SIZE);
> > +             return 0;
> > +     }
> > +
> > +     s64 pc_peak =3D pc->local_watermark;
> > +     s64 wm =3D fd_peak > pc_peak ? fd_peak : pc_peak;
> > +
> > +     seq_printf(sf, "%lld\n", wm * PAGE_SIZE);
> > +     return 0;
> > +}
> > +
> > +static int memory_peak_show(struct seq_file *sf, void *v)
> > +{
> > +     return swap_memory_peak_show(sf, v, memcg_memory_extract_page_cou=
nter);
>
> I think it's really too complex. Why not pass a single boolean argument
> which will define to use memory page_counter or swap page_counter?
> It will eliminate a need to pass pointers to functions and also eliminate
> a need for introducing these helper functions in general.

Yeah, that's definitely a cleaner option with only two alternatives.
I'll make that change.

>
> > +}
> > +
> > +static int swap_memory_peak_open(struct kernfs_open_file *of)
> > +{
> > +     struct memcg_peak_mem_ctx *ctx =3D memcg_extract_peak_mem_ctx(of)=
;
> > +
> > +     ctx->local_watermark =3D -1;
> > +     return 0;
> > +}
> > +
> > +inline void swap_memory_peak_release(
> > +     struct kernfs_open_file *of,
> > +     struct memcg_peak_mem_ctx **(*extract_watchers)(struct mem_cgroup=
 *memcg))
> > +{
> > +     struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> > +     struct memcg_peak_mem_ctx *ctx =3D memcg_extract_peak_mem_ctx(of)=
;
> > +
> > +     if (ctx->local_watermark =3D=3D -1) {
> > +             /* fast path (no writes on this fd)*/
> > +             return;
> > +     }
> > +     spin_lock(&memcg->pagecounter_peak_watchers_lock);
> > +     if (ctx->next) {
> > +             ctx->next->prev =3D ctx->prev;
> > +     }
> > +     if (ctx->prev) {
> > +             ctx->prev->next =3D ctx->next;
> > +     } else {
> > +             struct memcg_peak_mem_ctx **watchers =3D extract_watchers=
(memcg);
> > +
> > +             *watchers =3D ctx->next;
> > +     }
> > +     spin_unlock(&memcg->pagecounter_peak_watchers_lock);
> > +}
> >
> > -     return (u64)memcg->memory.watermark * PAGE_SIZE;
> > +static void memory_peak_release(struct kernfs_open_file *of)
> > +{
> > +     swap_memory_peak_release(of, memcg_memory_extract_peak_watchers);
> > +}
> > +
> > +inline ssize_t swap_memory_peak_write(
> > +     struct kernfs_open_file *of,
> > +     char *buf, size_t nbytes, loff_t off,
> > +     struct page_counter* (*extract_pc)(struct mem_cgroup *memcg),
> > +     struct memcg_peak_mem_ctx **(*extract_watchers)(struct mem_cgroup=
 *memcg))
> > +{
> > +     buf =3D strstrip(buf);
> > +     /* Only allow "fd_local_reset" to keep the API clear */
> > +     if (strcmp(buf, "fd_local_reset"))
> > +             return -EINVAL;
> > +     struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> > +     struct memcg_peak_mem_ctx *ctx =3D memcg_extract_peak_mem_ctx(of)=
;
>
> Please, don't mix variable definitions and code. Also, please, use
Ok, I'll factor that out

> scripts/checkpatch.pl for checking the code before submission. I guess
> it will raise several issues in this patch.

Thanks, I did run checkpatch.pl on this patch, but I might have made a
few changes
since my last pass. (it didn't complain about mixing cod and definitions)

I'll make another pass before mailing the next version.
>
> > +
> > +     spin_lock(&memcg->pagecounter_peak_watchers_lock);
> > +
> > +     struct page_counter *pc =3D extract_pc(memcg);
> > +
> > +     page_counter_reset_local_watermark(pc);
> > +     const unsigned long cur =3D pc->local_watermark;
> > +     struct memcg_peak_mem_ctx **watchers =3D extract_watchers(memcg);
> > +     struct memcg_peak_mem_ctx *peer_ctx;
> > +
> > +     for (peer_ctx =3D *watchers; peer_ctx; peer_ctx =3D peer_ctx->nex=
t) {
> > +             if (cur > peer_ctx->local_watermark)
> > +                     peer_ctx->local_watermark =3D cur;
> > +     }
> > +     if (ctx->local_watermark =3D=3D -1) {
> > +             /* only append to the list if we're not already there */
> > +             if (peer_ctx) {
> > +                     ctx->prev =3D peer_ctx;
> > +                     peer_ctx->next =3D ctx;
> > +             } else {
> > +                     *watchers =3D ctx;
> > +             }
> > +     }
> > +     ctx->local_watermark =3D cur;
> > +     spin_unlock(&memcg->pagecounter_peak_watchers_lock);
> > +
> > +     return nbytes;
> > +}
> > +
> > +static ssize_t memory_peak_write(struct kernfs_open_file *of, char *bu=
f,
> > +                              size_t nbytes, loff_t off)
> > +{
> > +     return swap_memory_peak_write(of, buf, nbytes, off,
> > +                                   memcg_memory_extract_page_counter,
> > +                                   memcg_memory_extract_peak_watchers)=
;
> >  }
> >
> >  static int memory_min_show(struct seq_file *m, void *v)
> > @@ -7231,7 +7351,10 @@ static struct cftype memory_files[] =3D {
> >       {
> >               .name =3D "peak",
> >               .flags =3D CFTYPE_NOT_ON_ROOT,
> > -             .read_u64 =3D memory_peak_read,
> > +             .open =3D swap_memory_peak_open,
> > +             .release =3D memory_peak_release,
> > +             .seq_show =3D memory_peak_show,
> > +             .write =3D memory_peak_write,
> >       },
> >       {
> >               .name =3D "min",
> > @@ -8193,14 +8316,35 @@ static u64 swap_current_read(struct cgroup_subs=
ys_state *css,
> >       return (u64)page_counter_read(&memcg->swap) * PAGE_SIZE;
> >  }
> >
> > -static u64 swap_peak_read(struct cgroup_subsys_state *css,
> > -                       struct cftype *cft)
> > +
> > +static struct page_counter *memcg_swap_extract_page_counter(struct mem=
_cgroup *memcg)
> > +{
> > +     return &memcg->swap;
> > +}
> > +
> > +static struct memcg_peak_mem_ctx **memcg_swap_extract_peak_watchers(st=
ruct mem_cgroup *memcg)
> >  {
> > -     struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
> > +     return &memcg->peak_swap_local_watermark_watchers;
> > +}
> > +
> > +static int swap_peak_show(struct seq_file *sf, void *v)
> > +{
> > +     return swap_memory_peak_show(sf, v, memcg_swap_extract_page_count=
er);
> > +}
> >
> > -     return (u64)memcg->swap.watermark * PAGE_SIZE;
> > +static ssize_t swap_peak_write(struct kernfs_open_file *of, char *buf,
> > +                            size_t nbytes, loff_t off)
> > +{
> > +     return swap_memory_peak_write(of, buf, nbytes, off,
> > +                                   memcg_swap_extract_page_counter,
> > +                                   memcg_swap_extract_peak_watchers);
> > +}
> > +static void swap_peak_release(struct kernfs_open_file *of)
> > +{
> > +     swap_memory_peak_release(of, memcg_swap_extract_peak_watchers);
> >  }
> >
> > +
> >  static int swap_high_show(struct seq_file *m, void *v)
> >  {
> >       return seq_puts_memcg_tunable(m,
> > @@ -8282,7 +8426,10 @@ static struct cftype swap_files[] =3D {
> >       {
> >               .name =3D "swap.peak",
> >               .flags =3D CFTYPE_NOT_ON_ROOT,
> > -             .read_u64 =3D swap_peak_read,
> > +             .open =3D swap_memory_peak_open,
> > +             .release =3D swap_peak_release,
> > +             .seq_show =3D swap_peak_show,
> > +             .write =3D swap_peak_write,
> >       },
> >       {
> >               .name =3D "swap.events",
> > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > index db20d6452b71..40d5f4990218 100644
> > --- a/mm/page_counter.c
> > +++ b/mm/page_counter.c
> > @@ -82,6 +82,8 @@ void page_counter_charge(struct page_counter *counter=
, unsigned long nr_pages)
> >                */
> >               if (new > READ_ONCE(c->watermark))
> >                       WRITE_ONCE(c->watermark, new);
> > +             if (new > READ_ONCE(c->local_watermark))
> > +                     WRITE_ONCE(c->local_watermark, new);
>
> Hm, can't we have a single comparison on the hot path?
> Also, we read and write c->local_watermark speculatively here, Idk if it'=
s still
> acceptable with an ability to reset watermarks "locally". Maybe it is, bu=
t
> it definitely deserves at least a comment with an explanation.

Unfortunately, since the two watermarks may be reset at different
times I don't think we
can consolidate.
e.g. I think that if the usage peaked, dropped down a bit and then was
going back
up again when the "local_watermark" was reset, we'll continue only
bumping local_watermark,
but we don't want to touch "watermark" until we hit that watermark again.

>
> And btw thank you for including tests into the commit, it's really great =
to see.
> I'd suggest you to extract them into a separate commit and post it as a s=
eries.
Sure thing!
I'll split them off into their own commit. (the tests are about half
the line-delta)

>
> Thank you!


Thanks for the prompt review!
I'll try to get another revision out later today.


--=20
David Finkel
Senior Principal Software Engineer, Core Services

