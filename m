Return-Path: <linux-kselftest+bounces-14380-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 373C693F6C4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4C2B20CC0
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 13:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678C149015;
	Mon, 29 Jul 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b="B1JWRcRj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D32148853
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 13:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722260077; cv=none; b=l5YufOxGWc6DqBt7jTpeM/1AL52OhGy/WDkeOq6qu9Qa9RKHWPJuiWyZFsUmYGeR5PG7cUmFY4sqefUeiH7wEHHv576kPmmtCJFPFMIgBlKOIdHwmIUBggTWx1+DfDR20vwKwf95LWlPVEiWAzAx+8H73D3OY9z1YtAmZU8gjuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722260077; c=relaxed/simple;
	bh=ZRRAXAL2qzerQWENWGXjykSCIR3Xt52xsCDhhqLF8Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYzDPdnqBv/ZGznz05ZMCCHeaOyW6jN0Lqi8xkwfKLZmDmNotXQ2Ki6WmFGUjBO0MmPOQwEVyrGAtpMWW7Em3wt+dg4NVQlz91lBcy+Q0KV1zjQDgtNofTrnfSSaLUQkZuE9Yid9hrZ8juC3rgjWBjB1qUGkLmW6LUdpnhVBZNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com; spf=fail smtp.mailfrom=vimeo.com; dkim=pass (1024-bit key) header.d=vimeo.com header.i=@vimeo.com header.b=B1JWRcRj; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vimeo.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vimeo.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d2b921c48so2383669b3a.1
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 06:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vimeo.com; s=google; t=1722260075; x=1722864875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvWuoWcBz1GpvEecxVauV4qhtqCu4z7eC3CZ78S9mDw=;
        b=B1JWRcRjN0TOOog2M6MrG6MRpGe69yVUFsaGYdVGKtl1YET0dcSQB8KbA+rvOk3OOQ
         KUsqEXv5adjfmN2OG5xXIcWa5sEJ7gBBkUbxereXJ+HK0Y8+Xtn2em29ErBXYtbI/hDT
         d/4pLxLXJkEQQaGMVkSNVW5EobatiXn4eN6eM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722260075; x=1722864875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvWuoWcBz1GpvEecxVauV4qhtqCu4z7eC3CZ78S9mDw=;
        b=o6wNpdfNLjoDCK/LBU0fmQ32YHTxfiRzFVjoIvPKKKMvZYYee7PI8ljL+j+gtqjkzn
         vh5X5obyeoC6kb0t9inDYUmLB5guwYbuHjyxktNzTvARNDFl6mnPFu7epWt9VidETwAu
         XQbjBKHysv8sImZnkjcFZpIBRfdaV1Wz1RTGnUi7oFosyESxAOP9hIP3KLrT6qC/qKpp
         ZLB4AKB6mrsJ4RMNlgSDW66BDmeCM1WHb3XgZ7KWxvlGlkS/NkO/UKouB1s6B/drpirr
         +hUxxNUS7anTGQTfqVFNQUZHRnQsT9SisJNXN4QKhgdBpiP1JEaMXmBKtqwsdJDEVOJY
         MJuw==
X-Forwarded-Encrypted: i=1; AJvYcCXDgVIk019J82IhE7k8xHtMzu3j7Wzdb3tLRFMcVtpef4oi+s6T9bI5m9+Hj9ul1ilRwSK7jVjjofxv+UMAQgPa07UnYv/AWloTB9HkPhVQ
X-Gm-Message-State: AOJu0YxY+tOnho2GqpRfHsvdDDUfSTJN4A03kwvTOyVS20ZUNWlb3r1V
	ty4zLBPbYt26ehWfHk8IcOv8B/Me6EVeoqGPO822InDyw2GYuG9KENJhCdJo2acYplBC5ppufP1
	qBTRWrDsjzRm8v12B9i68XhQmIxC7+A3yMY/GmQ==
X-Google-Smtp-Source: AGHT+IHL1B4yv7dqzfE+at5TpW8qgzJgJa+v3PgxakxDfs21btY8jOQ0oemCyPqsr1+gTZTemCP0UAlXrEYN68qF1k4=
X-Received: by 2002:a05:6a00:807:b0:70d:3587:c665 with SMTP id
 d2e1a72fcca58-70ece9fc3d9mr6189837b3a.2.1722260074510; Mon, 29 Jul 2024
 06:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724161942.3448841-1-davidf@vimeo.com> <20240724161942.3448841-2-davidf@vimeo.com>
 <5xlwzzz3gs4rk5df32kfh7fx5ftj3a4iwryqxdb4c3oniuehwk@d5kum5xr4uw6>
In-Reply-To: <5xlwzzz3gs4rk5df32kfh7fx5ftj3a4iwryqxdb4c3oniuehwk@d5kum5xr4uw6>
From: David Finkel <davidf@vimeo.com>
Date: Mon, 29 Jul 2024 09:34:23 -0400
Message-ID: <CAFUnj5O9bijcu6grPoFh0h7mTVAP-bajeJDq1-jtqWuaJbv8XQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal,

On Fri, Jul 26, 2024 at 10:16=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.c=
om> wrote:
>
> Hello David.
>
> On Wed, Jul 24, 2024 at 12:19:41PM GMT, David Finkel <davidf@vimeo.com> w=
rote:
> > Writing a specific string to the memory.peak and memory.swap.peak
> > pseudo-files reset the high watermark to the current usage for
> > subsequent reads through that same fd.
>
> This is elegant and nice work! (Caught my attention, so a few nits below.=
)

Thanks!

You can thank Johannes for the algorithm.
>
> > --- a/include/linux/cgroup-defs.h
> > +++ b/include/linux/cgroup-defs.h
> > @@ -775,6 +775,11 @@ struct cgroup_subsys {
> >
> >  extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
> >
> > +struct cgroup_of_peak {
> > +     long                    value;
>
> Wouldn't this better be unsigned like watermarks themselves?

Hmm, interesting question.
I originally set that to be signed to handle the special value of -1.
However, that's kind of irrelevant if I'm casting it to an unsigned
u64 in the only place that value's being handled.

I've switched this over now.

>
> > +     struct list_head        list;
> > +};
>
>
> > --- a/include/linux/page_counter.h
> > +++ b/include/linux/page_counter.h
> > @@ -26,6 +26,7 @@ struct page_counter {
> >       atomic_long_t children_low_usage;
> >
> >       unsigned long watermark;
> > +     unsigned long local_watermark;
>
> At first, I struggled understading what the locality is (when the local
> value is actually in of_peak), IIUC, it's more about temporal position.
>
> I'd suggest a comment (if not a name) like:
>         /* latest reset watermark */
> > +     unsigned long local_watermark;

Yeah, I had a comment before that was a bit inaccurate, and was
advised to remove it instead of trying to fix it in a previous round.

I've added one that says "Latest cg2 reset watermark".

>
>
> > +
> > +     /* User wants global or local peak? */
> > +     if (fd_peak =3D=3D -1UL)
>
> Here you use typed -1UL but not in other places. (Maybe define an
> explicit macro value ((unsigned long)-1)?)
Good idea!

>
> > +static ssize_t peak_write(struct kernfs_open_file *of, char *buf, size=
_t nbytes,
> > +                       loff_t off, struct page_counter *pc,
> > +                       struct list_head *watchers)
> > +{
> ...
> > +     list_for_each_entry(peer_ctx, watchers, list)
> > +             if (usage > peer_ctx->value)
> > +                     peer_ctx->value =3D usage;
>
> The READ_ONCE() in peak_show() suggests it could be WRITE_ONCE() here.

Good point. I've sprinkled a few more READ_ONCE and WRITE_ONCE calls.

>
> > +
> > +     /* initial write, register watcher */
> > +     if (ofp->value =3D=3D -1)
> > +             list_add(&ofp->list, watchers);
> > +
> > +     ofp->value =3D usage;
>
> Move the registration before iteration and drop the extra assignment?
My original reason is that I could avoid an extra list hop and conditional,
but at this point I see two reasons to keep it separate:
 - We need to reset this value either way. If it's already been reset, it m=
ay
   not get reset by the loop.
 - since these are now unsigned ints, -1 compares greater than everything,
   so it would need a special case (or an additional cast). (Assuming we're
   on a system that uses twos complement)
- I think it's a bit clearer this way

>
> Thanks,
> Michal

Thanks for the review!

--
David Finkel
Senior Principal Software Engineer, Core Services

