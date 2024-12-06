Return-Path: <linux-kselftest+bounces-22929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D989E7957
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 20:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7425282E56
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 19:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47081F3D2A;
	Fri,  6 Dec 2024 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zE9SDQxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158B61D9359
	for <linux-kselftest@vger.kernel.org>; Fri,  6 Dec 2024 19:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515094; cv=none; b=NSpXaAxkYjQB0NlgCbpTyMIdxgVUemzm/VFIwre6HgLQdWuWGfz4Wal0buASJeCKCVcs4F94IfHlZrCLmcETWCdmjYTHdsRRS4HPv8l764PPxWeRLfmvL3V0cYy/So+VVa7oqZjBfgyVlDn4uxJKOOiuAqUyYqVvz5HyVUmbntc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515094; c=relaxed/simple;
	bh=8gWvy5zGQ4r6v8YrdHYM6ddRzdaCisV+xhxtXzwPYYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzws+72KaZc22iW8st7h/G3bb1gSO8e55WqRqTt5Qhax7YS6qqdl7+ugjsPhbm5NoXZO+rVjMgTgd2jmKql1ZO5jwr8JfVx0ChAq1wyhbnPnUgiA12yGyQ0tr+tjjpiGm+cmh1manJp9mO+cY/OhIO4GpYbp1YfEACSMFA6ipZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zE9SDQxR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21625b4f978so19785ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 06 Dec 2024 11:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733515092; x=1734119892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A82gvr7sDzCugWZNh93f0M6gJn7XxjisLQmLnxRt2mE=;
        b=zE9SDQxRrNMvgT5AOn4wLnG+bekRarlMrudzpfoD4oXu83ct0Zw9R2vz5SBHRj7o3s
         flpz0nwH+6msQoCHXt/SwF93d9LhBX1mJimAtG/SfSvpdYWvggr0ObZg/ol/G66k/+sw
         alEZKZEx7AuCpZt49Gyoe0CphnFrswQfWb3nCKyCLWB0Qvbmuq+CTNa6Z9vC8t2L7ESu
         LEsFN6Mvyn1hgR9083z54Zfij1UowlugiuOZX1hD3rNzEB7YchIZaoKtkzh39xJ4OlCJ
         wq1qiWmb8ML31HlIJ1xJ1I/tNDAzsTukT3p9usAfZxpMJRUgYSsMo2uijrhE7P9dI7/V
         ljqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515092; x=1734119892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A82gvr7sDzCugWZNh93f0M6gJn7XxjisLQmLnxRt2mE=;
        b=rTSJFW5LbXcOfJe9Gk52bya7BbM0+m/E+etg5gPzHDU0a6kLK89GPUQ4gPhQiTxadJ
         /9ZcDFkM2afmYe0LCIf6dAm8xCtor9Y4nT6lRCDulxw3b19m8CSdvOB9jNww/J6U9lCr
         IMDEqPozEZ8qBPLVw8bT8yNCENyj3JwdaaIPWMy3RjH+O3F7KaR7agdZj80mc51nPNuK
         K/7eYD6w9iFoq6o9yT472NSVSfcTguLl3c0pEyg7o0M2SBMMljhZe/fQZqaqkVXfYuas
         /+De1oI3ylzzMWt6z+1grl+wZfC72FxBZaqSo9naveE4Z9V99PtvpJ7wmkbey4uiVzDa
         2R+g==
X-Forwarded-Encrypted: i=1; AJvYcCVaSfHq6+OMeyGd8DDfEyl/4ICG7vq704gVL4Enz6l1Jbf84GLPtd+e9M6+xhlj8hNMDE+50XATFtabL+IBdHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUGl1Ls14sdGbCWte9YuDDi7mQ5pVB/ZDWxs4O154LoudP5TG
	wzbnKuTVbUZvo4bz+CcoP1BeP6EwG4StBeiDJj4u66BEWWgCZF7rwt/UegRFGzCOUWnA8byGoq/
	lJB5fYLNhIXLDJ1f7CC8gDNTr3LDo3hvl9H49
X-Gm-Gg: ASbGncugb8PTcBZw9WCYHZksW8Qh/p67OhvtQMIOA3p+I/jrZ9u2Czp5jwz9ZL9qOiL
	KclE3ngXcI1JYlg3Gn8faSYyJMEzSzYSHKcV64d7lWZNBHEfvlx/QkTMBvy0=
X-Google-Smtp-Source: AGHT+IHZdlpKcu54llf+M0CD9QkcB0RHZTeLren1vYJvc90nzNmtuhq9YRRgqZ68LMma3iPfL32X7Vz6IZrABpYfBzY=
X-Received: by 2002:a17:902:ce06:b0:215:3e48:2b17 with SMTP id
 d9443c01a7336-2162ad6a092mr200125ad.5.1733515091991; Fri, 06 Dec 2024
 11:58:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127025728.3689245-1-yuanchu@google.com> <20241127072604.GA2501036@cmpxchg.org>
In-Reply-To: <20241127072604.GA2501036@cmpxchg.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Fri, 6 Dec 2024 11:57:55 -0800
Message-ID: <CAJj2-QFdP6DKVQJ4Tw6rdV+XtgDihe=UOnvm4cm-q61K0hq6CQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] mm: workingset reporting
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the response Johannes. Some replies inline.

On Tue, Nov 26, 2024 at 11:26=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Nov 26, 2024 at 06:57:19PM -0800, Yuanchu Xie wrote:
> > This patch series provides workingset reporting of user pages in
> > lruvecs, of which coldness can be tracked by accessed bits and fd
> > references. However, the concept of workingset applies generically to
> > all types of memory, which could be kernel slab caches, discardable
> > userspace caches (databases), or CXL.mem. Therefore, data sources might
> > come from slab shrinkers, device drivers, or the userspace.
> > Another interesting idea might be hugepage workingset, so that we can
> > measure the proportion of hugepages backing cold memory. However, with
> > architectures like arm, there may be too many hugepage sizes leading to
> > a combinatorial explosion when exporting stats to the userspace.
> > Nonetheless, the kernel should provide a set of workingset interfaces
> > that is generic enough to accommodate the various use cases, and extens=
ible
> > to potential future use cases.
>
> Doesn't DAMON already provide this information?
>
> CCing SJ.
Thanks for the CC. DAMON was really good at visualizing the memory
access frequencies last time I tried it out! For server use cases,
DAMON would benefit from integrations with cgroups. The key then would
be a standard interface for exporting a cgroup's working set to the
user. It would be good to have something that will work for different
backing implementations, DAMON, MGLRU, or active/inactive LRU.

>
> > Use cases
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Job scheduling
> > On overcommitted hosts, workingset information improves efficiency and
> > reliability by allowing the job scheduler to have better stats on the
> > exact memory requirements of each job. This can manifest in efficiency =
by
> > landing more jobs on the same host or NUMA node. On the other hand, the
> > job scheduler can also ensure each node has a sufficient amount of memo=
ry
> > and does not enter direct reclaim or the kernel OOM path. With workings=
et
> > information and job priority, the userspace OOM killing or proactive
> > reclaim policy can kick in before the system is under memory pressure.
> > If the job shape is very different from the machine shape, knowing the
> > workingset per-node can also help inform page allocation policies.
> >
> > Proactive reclaim
> > Workingset information allows the a container manager to proactively
> > reclaim memory while not impacting a job's performance. While PSI may
> > provide a reactive measure of when a proactive reclaim has reclaimed to=
o
> > much, workingset reporting allows the policy to be more accurate and
> > flexible.
>
> I'm not sure about more accurate.
>
> Access frequency is only half the picture. Whether you need to keep
> memory with a given frequency resident depends on the speed of the
> backing device.
>
> There is memory compression; there is swap on flash; swap on crappy
> flash; swapfiles that share IOPS with co-located filesystems. There is
> zswap+writeback, where avg refault speed can vary dramatically.
>
> You can of course offload much more to a fast zswap backend than to a
> swapfile on a struggling flashdrive, with comparable app performance.
>
> So I think you'd be hard pressed to achieve a high level of accuracy
> in the usecases you list without taking the (often highly dynamic)
> cost of paging / memory transfer into account.
>
> There is a more detailed discussion of this in a paper we wrote on
> proactive reclaim/offloading - in 2.5 Hardware Heterogeneity:
>
> https://www.cs.cmu.edu/~dskarlat/publications/tmo_asplos22.pdf
>
Yes, PSI takes into account the paging cost. I'm not claiming that
Workingset reporting provides a superset of information, but rather it
can complement PSI. Sorry for the bad wording here.

> > Ballooning (similar to proactive reclaim)
> > The last patch of the series extends the virtio-balloon device to repor=
t
> > the guest workingset.
> > Balloon policies benefit from workingset to more precisely determine th=
e
> > size of the memory balloon. On end-user devices where memory is scarce =
and
> > overcommitted, the balloon sizing in multiple VMs running on the same
> > device can be orchestrated with workingset reports from each one.
> > On the server side, workingset reporting allows the balloon controller =
to
> > inflate the balloon without causing too much file cache to be reclaimed=
 in
> > the guest.
The ballooning use case is an important one. Having working set
information would allow us to inflate a balloon of the right size in
the guest.

> >
> > Promotion/Demotion
> > If different mechanisms are used for promition and demotion, workingset
> > information can help connect the two and avoid pages being migrated bac=
k
> > and forth.
> > For example, given a promotion hot page threshold defined in reaccess
> > distance of N seconds (promote pages accessed more often than every N
> > seconds). The threshold N should be set so that ~80% (e.g.) of pages on
> > the fast memory node passes the threshold. This calculation can be done
> > with workingset reports.
> > To be directly useful for promotion policies, the workingset report
> > interfaces need to be extended to report hotness and gather hotness
> > information from the devices[1].
> >...
> >
> > Benchmarks
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Ghait Ouled Amar Ben Cheikh has implemented a simple policy and ran Lin=
ux
> > compile and redis benchmarks from openbenchmarking.org. The policy and
> > runner is referred to as WMO (Workload Memory Optimization).
> > The results were based on v3 of the series, but v4 doesn't change the c=
ore
> > of the working set reporting and just adds the ballooning counterpart.
> >
> > The timed Linux kernel compilation benchmark shows improvements in peak
> > memory usage with a policy of "swap out all bytes colder than 10 second=
s
> > every 40 seconds". A swapfile is configured on SSD.
> > --------------------------------------------
> > peak memory usage (with WMO): 4982.61328 MiB
> > peak memory usage (control): 9569.1367 MiB
> > peak memory reduction: 47.9%
> > --------------------------------------------
> > Benchmark                                           | Experimental     =
|Control         | Experimental_Std_Dev | Control_Std_Dev
> > Timed Linux Kernel Compilation - allmodconfig (sec) | 708.486 (95.91%) =
| 679.499 (100%) | 0.6%                 | 0.1%
> > --------------------------------------------
> > Seconds, fewer is better
>
> You can do this with a recent (>2018) upstream kernel and ~100 lines
> of python [1]. It also works on both LRU implementations.
>
> [1] https://github.com/facebookincubator/senpai
>
> We use this approach in virtually the entire Meta fleet, to offload
> unneeded memory, estimate available capacity for job scheduling, plan
> future capacity needs, and provide accurate memory usage feedback to
> application developers.
>
> It works over a wide variety of CPU and storage configurations with no
> specific tuning.
>
> The paper I referenced above provides a detailed breakdown of how it
> all works together.
>
> I would be curious to see a more in-depth comparison to the prior art
> in this space. At first glance, your proposal seems more complex and
> less robust/versatile, at least for offloading and capacity gauging.
We have implemented TMO PSI-based proactive reclaim and compared it to
a kstaled-based reclaimer (reclaiming based on 2 minute working set
and refaults). The PSI-based reclaimer was able to save more memory,
but it also caused spikes of refaults and a lot higher
decompressions/second. Overall the test workloads had better
performance with the kstaled-based reclaimer. The conclusion was that
it was a trade-off. Since we have some app classes that we don't want
to induce pressure but still want to proactively reclaim from, there's
a missing piece. I do agree there's not a good in-depth comparison
with prior art though.

