Return-Path: <linux-kselftest+bounces-14094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B466593A7C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 21:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDBA11C2256D
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 19:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6B1419A9;
	Tue, 23 Jul 2024 19:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="WMC34r1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2530713DDA8
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721763971; cv=none; b=XwkMVBtM3+mbkKlpYxSruH/rmEuPi+PezajkHNzFbaCeMtxs/UiBaPshSxM3dqLZ8i/EoPuNVknUbst5tdyCQsKLtkH1WHS+9u3+1OtuoBAkIyz4YP0d+qQWnxK0lBdjyBBPPcDlYeWBKH6kKnazZJkFoonuzbEWTzBHgr4oe+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721763971; c=relaxed/simple;
	bh=zQo/BeU7ZJmDX2rVmM+YZ046rRWbyUPe9g152Ch5+yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUC4V0QhlQWtRx0fDIDdj3bGW/R3HZfvo64zSkB0vNxdRXOfxNydKUIlQqlDTZRahvXxZcJcrorRaN+5u9wIJmqZND32NaSSn8ylFQkYeZQgr7HOUtPF+82gGvNld9an0U07KV6VAZ/u4WSsPWPjRxasK7NB0tP6EjFBa8Iu6UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=WMC34r1I; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso2327149b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1721763968; x=1722368768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/qoSrcKP2dKBbT3yRh61Zf7itz7zeZaJ4QLe4Dv+Zw=;
        b=WMC34r1Iz89fVFmMdTSJqCgbPFd/DHUOlQ02OKVoudAtZKXWTumtXjhp0erd3rIMbU
         9ZnMwr7LRou5seMsoNInJqq7dyadRoN40h+yBXgKdDANuE5PlUdoYz8V4LZSbSW+2BHf
         zriPhcPFQCz9eZYfP7Wv5xPkzaA4oN+/TvGu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721763968; x=1722368768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/qoSrcKP2dKBbT3yRh61Zf7itz7zeZaJ4QLe4Dv+Zw=;
        b=sRYxeF/n3ZaOclSEgsh/f+e2NIkm5s4opBKoRN9z7YnTOFiGAH7A4twwWQPEWehcX3
         BzZccbtdRr0ed8FYKqfr16RhqwRO5tqJ9pF3ZfvYf90ny2wpFlGd7ehYtE7v3VaYSDgS
         nxnvpF+4fPF4v+QafhCkl96ExwAiz5fY0TGcr3tuXPSGEU5GpE+9hMr5rLVgIbKqLnkh
         5cvvhzQ0KQSS2Ms9NKSe8SasY9NCGuQc1rXZlkFQxM3Gbf/bdrCHkqnvEE10Mr4t5zdX
         x0s1TCpC0NGsVQJ38gIMun19qMBzugz0RN3rDe7acdnvHhYW0zYcuK4N2ZkjbcpIuZQA
         VkiA==
X-Forwarded-Encrypted: i=1; AJvYcCXTkSUDVogy1uEv/6Slwcm9emTFxWw32h4U7QYCaWV4u5+/zu/0YXVnWzP5HSat4TencMp2p86V6o6UqIo3+DyzY3GyfC95omFuOkhNbtrU
X-Gm-Message-State: AOJu0Ywg9mTfHSP591SEAem12CqPB2G5wp69b0XYiFmHP/HhqUgl0RSb
	uPEfB9iWfqkNKkB3w/1GlOynX/AY0NCqMM1kP6aLkS/DxhK/WMdUwRFa+u5BhFhP7shHyNsKZY0
	h5UweAhkafCfTiuwrodXACN52oWloMFfcpHv/dH+M67l/IGJ4UKc=
X-Google-Smtp-Source: AGHT+IEL5HyNzk2uLVja41grpBiyNCgiZgj+hAvvGWH7WBHjgfqSzSjxEemxHymWX1H5Bts7KKJ+pel+MKfPys146d4=
X-Received: by 2002:a05:6a00:2d09:b0:70b:260:3e2c with SMTP id
 d2e1a72fcca58-70e9dba5e39mr50315b3a.28.1721763968300; Tue, 23 Jul 2024
 12:46:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722235554.2911971-1-davidf@vimeo.com> <20240722235554.2911971-2-davidf@vimeo.com>
 <20240723142950.GA389003@cmpxchg.org>
In-Reply-To: <20240723142950.GA389003@cmpxchg.org>
From: David Finkel <davidf@vimeo.com>
Date: Tue, 23 Jul 2024 15:45:57 -0400
Message-ID: <CAFUnj5NSEpEUOi2CF6Y78ryv9ZS7+FG9qF4o1vCaLFX3KE9LAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Thanks for the thorough review!

I'll send a rebased version addressing your comments in a moment.

On Tue, Jul 23, 2024 at 10:29=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> Hi David,
>
> thanks for pursuing this! A couple of comments below.
>
> On Mon, Jul 22, 2024 at 07:55:53PM -0400, David Finkel wrote:
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
at FD.
> >
> > -     The max memory usage recorded for the cgroup and its
> > -     descendants since the creation of the cgroup.
> > +     A write of the string "reset" to this file resets it to the
> > +     current memory usage for subsequent reads through the same
> > +     file descriptor.
> > +     Attempts to write any other non-empty string will return EINVAL
> > +     (modulo leading and trailing whitespace).
>
> Why not allow any write to reset? This makes it harder to use, and I'm
> not sure accidental writes are a likely mistake to make.

Accepting any string is a rather wide interface, and since actually empty w=
rites
get dropped before this handler is invoked, I think allowing any write
is more confusing.

I figured that a narrower interface is a better starting point, as
long as it's correctly
documented.

We can always widen it to all writes later, but we can't go the other way.

>
> > diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> > index 2150ca60394b..7001ed74e339 100644
> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/cpumask.h>
> >  #include <linux/nodemask.h>
> > +#include <linux/list.h>
> >  #include <linux/rculist.h>
> >  #include <linux/cgroupstats.h>
> >  #include <linux/fs.h>
> > @@ -855,4 +856,11 @@ static inline void cgroup_bpf_put(struct cgroup *c=
grp) {}
> >
> >  struct cgroup *task_get_cgroup1(struct task_struct *tsk, int hierarchy=
_id);
> >
> > +struct memcg_peak_mem_ctx {
> > +     long                            local_watermark;
> > +     struct list_head                peers;
> > +};
>
> Since this is generic cgroup code, and can be conceivably used by
> other controllers, let's keep the naming generic as well. How about:
>
> struct cgroup_of_peak {
>         long                    value;
>         struct list_head        list;
> };
>
> cgroup-defs.h would be a better place for it.
That is much less jarring.

>
> > +struct memcg_peak_mem_ctx *memcg_extract_peak_mem_ctx(struct kernfs_op=
en_file *of);
>
> of_peak()
>
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 030d34e9d117..cbc390234605 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -198,6 +198,11 @@ struct mem_cgroup {
> >       struct page_counter kmem;               /* v1 only */
> >       struct page_counter tcpmem;             /* v1 only */
> >
> > +     /* lists of memcg peak watching contexts on swap and memory */
> > +     struct list_head peak_memory_local_watermark_watchers;
> > +     struct list_head peak_swap_local_watermark_watchers;
> > +     spinlock_t swap_memory_peak_watchers_lock;
>
> These names are too long. How about:
>
>         /* Registered local usage peak watchers */
>         struct list_head        memory_peaks;
>         struct list_head        swap_peaks;
>         spinlock_t              peaks_lock;
>
That's much better.
(sometimes when I'm unsure about a name, I default to a terrible, long name
with way too much information)

> > diff --git a/include/linux/page_counter.h b/include/linux/page_counter.=
h
> > index 8cd858d912c4..06bb84218960 100644
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
> > @@ -78,7 +79,15 @@ int page_counter_memparse(const char *buf, const cha=
r *max,
> >
> >  static inline void page_counter_reset_watermark(struct page_counter *c=
ounter)
> >  {
> > -     counter->watermark =3D page_counter_read(counter);
> > +     unsigned long cur =3D page_counter_read(counter);
>
> cur -> usage
That's a better name.

>
> > @@ -6907,12 +6912,109 @@ static u64 memory_current_read(struct cgroup_s=
ubsys_state *css,
> >       return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
> >  }
> >
> > -static u64 memory_peak_read(struct cgroup_subsys_state *css,
> > -                         struct cftype *cft)
> > +inline int swap_memory_peak_show(
> > +     struct seq_file *sf, void *v, bool swap_cg)
> >  {
>
> Leave inlining to the compiler. Just static int.
>
> The name can be simply peak_show().

Oh, right, I forgot that since this is local to the translation-unit
it doesn't need to be globally unique.

>
> Customary coding style is to line wrap at the last parameter that
> fits. Don't wrap if the line fits within 80 cols.
>
> static int peak_show(struct seq_file *sf, void *v, ...,
>                      ...)
> {
>         ...
> }
>
Oh yeah, I forgot to move those back to one line when I got rid of the
callback args
while addressing Roman's comments.
Thanks for pointing that out.

> > +     struct cgroup_subsys_state *css =3D seq_css(sf);
> >       struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
> > +     struct page_counter *pc;
> > +     struct kernfs_open_file *of =3D sf->private;
> > +     struct memcg_peak_mem_ctx *ctx =3D memcg_extract_peak_mem_ctx(of)=
;
> > +     s64 fd_peak =3D ctx->local_watermark;
> >
> > -     return (u64)memcg->memory.watermark * PAGE_SIZE;
> > +     if (swap_cg)
> > +             pc =3D &memcg->swap;
> > +     else
> > +             pc =3D &memcg->memory;
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
>
> As per Roman's feedback, don't mix decls and code.

Sorry, that one slipped through. (I've now fixed my syntax highlighting
to recognize s64 as a type)

>
> You can simplify it by extracting css and memcg in the callers, then
> pass the right struct page counter *pc directly.
>
> That should eliminate most local variables as well.
>
> static int peak_show(struct seq_file *sf, void *v, struct page_counter *p=
c)
> {
>         struct cgroup_of_peak *ofp =3D of_peak(sf->private);
>         u64 peak;
>
>         /* User wants global or local peak? */
>         if (ofp->value =3D=3D -1)
>                 peak =3D pc->watermark;
>         else
>                 peak =3D max(ofp->value, pc->local_watermark);
>
>         seq_printf(sf, "%lld\n", peak * PAGE_SIZE);
> }
>
> > +static int memory_peak_show(struct seq_file *sf, void *v)
> > +{
> > +     return swap_memory_peak_show(sf, v, false);
>
> And then do:
>
>         struct mem_cgroup *memcg =3D mem_cgroup_from_css(seq_css(sf));
>
>         return peak_show(sf, v, &memcg->memory);
>
> Then do the same with ... &memcg->swap.
That is much cleaner!
Thanks!
>
> > +inline ssize_t swap_memory_peak_write(
> > +     struct kernfs_open_file *of,
> > +     char *buf, size_t nbytes, loff_t off, bool swap_cg)
> > +{
>
> Same feedback as above. Please don't inline explicitly (unless it
> really is measurably a performance improvement in a critical path),
> and stick to surrounding coding style.
>
> Here too, pass page_counter directly and save the branches.
>
> > +     unsigned long cur;
> > +     struct memcg_peak_mem_ctx *peer_ctx;
> > +     struct mem_cgroup *memcg =3D mem_cgroup_from_css(of_css(of));
> > +     struct memcg_peak_mem_ctx *ctx =3D memcg_extract_peak_mem_ctx(of)=
;
> > +     struct page_counter *pc;
> > +     struct list_head *watchers, *pos;
> > +
> > +     buf =3D strstrip(buf);
> > +     /* Only allow "reset" to keep the API clear */
> > +     if (strcmp(buf, "reset"))
> > +             return -EINVAL;
> > +
> > +     if (swap_cg) {
> > +             pc =3D &memcg->swap;
> > +             watchers =3D &memcg->peak_swap_local_watermark_watchers;
> > +     } else {
> > +             pc =3D &memcg->memory;
> > +             watchers =3D &memcg->peak_memory_local_watermark_watchers=
;
> > +     }
> > +
> > +     spin_lock(&memcg->swap_memory_peak_watchers_lock);
> > +
> > +     page_counter_reset_local_watermark(pc);
> > +     cur =3D pc->local_watermark;
> > +
> > +     list_for_each(pos, watchers) {
>
>         list_for_each_entry()
Oh, I missed that one. Thanks!

>
> > +             peer_ctx =3D list_entry(pos, typeof(*ctx), peers);
> > +             if (cur > peer_ctx->local_watermark)
> > +                     peer_ctx->local_watermark =3D cur;
> > +     }
>
> I don't think this is quite right. local_peak could be higher than the
> current usage when a new watcher shows up. The other watchers should
> retain the higher local_peak, not the current usage.

Since we have to iterate over the list entries while holding the spinlock,
I think we avoid that kind of mismatch by keeping the assignments
inside that critical section as well. (and eliminate a few other races)

As-is, we get a snapshot value of the current usage and use that for
the rest of the function while holding the lock, so, those fd-local
watermarks will only change by assignments in this function.

On the other hand, pc->local_watermark may keep increasing, but that's fine=
.

>
> > +
> > +     if (ctx->local_watermark =3D=3D -1)
> > +             /* only append to the list if we're not already there */
> > +             list_add_tail(&ctx->peers, watchers);
> > +
> > +     ctx->local_watermark =3D cur;
>
> This makes me think that page_counter_reset_local_watermark() is not a
> good helper. It obscures what's going on. Try without it.
>
> AFAICS the list ordering doesn't matter, so keep it simple and use a
> plain list_add().
>
>         /*
>          * A new local peak is being tracked in pc->local_watermark.
>          * Save current local peak in all watchers.
>          */
>         list_for_each_entry(pos, ...)
>                 if (pc->local_watermark > pos->value)
>                         pos->value =3D pc->local_watermark;
>
>         pc->local_watermark =3D page_counter_read(pc);
>
>         /* Initital write, register watcher */
>         if (ofp->value =3D=3D -1)
>                 list_add()
>
>         ofp->value =3D pc->local_watermark;
>
> > diff --git a/mm/page_counter.c b/mm/page_counter.c
> > index db20d6452b71..724d31508664 100644
> > --- a/mm/page_counter.c
> > +++ b/mm/page_counter.c
> > @@ -79,9 +79,22 @@ void page_counter_charge(struct page_counter *counte=
r, unsigned long nr_pages)
> >               /*
> >                * This is indeed racy, but we can live with some
> >                * inaccuracy in the watermark.
> > +              *
> > +              * Notably, we have two watermarks to allow for both a gl=
obally
> > +              * visible peak and one that can be reset at a smaller sc=
ope.
> > +              *
> > +              * Since we reset both watermarks when the global reset o=
ccurs,
> > +              * we can guarantee that watermark >=3D local_watermark, =
so we
> > +              * don't need to do both comparisons every time.
> > +              *
> > +              * On systems with branch predictors, the inner condition=
 should
> > +              * be almost free.
> >                */
> > -             if (new > READ_ONCE(c->watermark))
> > -                     WRITE_ONCE(c->watermark, new);
> > +             if (new > READ_ONCE(c->local_watermark)) {
> > +                     WRITE_ONCE(c->local_watermark, new);
> > +                     if (new > READ_ONCE(c->watermark))
> > +                             WRITE_ONCE(c->watermark, new);
> > +             }
> >       }
> >  }
> >
> > @@ -131,10 +144,23 @@ bool page_counter_try_charge(struct page_counter =
*counter,
> >               propagate_protected_usage(c, new);
> >               /*
> >                * Just like with failcnt, we can live with some
> > -              * inaccuracy in the watermark.
> > +              * inaccuracy in the watermarks.
> > +              *
> > +              * Notably, we have two watermarks to allow for both a gl=
obally
> > +              * visible peak and one that can be reset at a smaller sc=
ope.
> > +              *
> > +              * Since we reset both watermarks when the global reset o=
ccurs,
> > +              * we can guarantee that watermark >=3D local_watermark, =
so we
> > +              * don't need to do both comparisons every time.
> > +              *
> > +              * On systems with branch predictors, the inner condition=
 should
> > +              * be almost free.
>
>                 /* See comment in page_counter_charge() */
Even better!
>
> > diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testi=
ng/selftests/cgroup/cgroup_util.c
> > index 432db923bced..1e2d46636a0c 100644
> > --- a/tools/testing/selftests/cgroup/cgroup_util.c
> > +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> > @@ -141,6 +141,16 @@ long cg_read_long(const char *cgroup, const char *=
control)
> >       return atol(buf);
> >  }
>
> This should be in patch #2.
:facepalm: that's what I get for trying to split this and send it out
at the end of the day.



--=20
David Finkel
Senior Principal Software Engineer, Core Services

