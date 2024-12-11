Return-Path: <linux-kselftest+bounces-23197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD29ED6D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 20:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC1C28200D
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2D7200BA9;
	Wed, 11 Dec 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH/EZ2AE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16EF1C3F27;
	Wed, 11 Dec 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946813; cv=none; b=XmC+aKajN7IA45K0VCb2RBx5A/+mbfk/KWxa3U+Oj+gjTgwB35qgkQshSZNsghCl2FJOBCo5l9j7wtpW8RIg6lqqYqmyhcCDHX3cCdH4/zHlWpJYweQ1ARf05tcURQxgwbe6D7o9jhZHJbSYLgLIhqvrfA/XpOrtqeclvSmrPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946813; c=relaxed/simple;
	bh=/Islhx5QPnsZFTF/qi0yWZBLeMxaGO8x2YhrOZpsYTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csMhw6pnwor5oBuraItcCkliGCCwZUekZ22Yf4YMLU7DxRPig8SbyzjVpfJAbkYcYAwmDjjfK1mUz66EEjJP63zFS9ooQjGacgliJp3BKGr4p4VEnTF9N3TQFt8LtqeCrFKMqKOL0WobsaHhsM6zhGzij7UZAzpESuWunKpqdg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH/EZ2AE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F412C4CED2;
	Wed, 11 Dec 2024 19:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733946813;
	bh=/Islhx5QPnsZFTF/qi0yWZBLeMxaGO8x2YhrOZpsYTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fH/EZ2AE2pqH53MRSScd31eG/ObA/GfsrmQtufCSl4yPoy+MCOaa72mq2tTkS/Ptt
	 MElV3mKuCIyouF7O4TeLksAGyBsjRyyLeNIyCIB3ew5+d2s/AoWfVhNt6/nEerEueP
	 lsEbi36/ME73ZGwcBD9JV1emQNX/HjB79qiLo2p2jp4Vd5vSmEtM1AlVEEISmjaB/v
	 g4N+HiAvMqiueLdx51+uGAUPUuNsOAH5p5tavAZcJm5094U4UxAJwv9624a8nmihmv
	 POMTYqt3LTct+4Fgrr5FfhhslujOt5dVSWkZOavas1KrgLzaRfknHtIs9GeNbFzjQX
	 QNnQ+32ufo7aw==
From: SeongJae Park <sj@kernel.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	Henry Huang <henry.hj@antgroup.com>,
	Yu Zhao <yuzhao@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gregory.price@memverge.com>,
	Huang Ying <ying.huang@intel.com>,
	Lance Yang <ioworker0@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Daniel Watson <ozzloy@each.do>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/9] mm: workingset reporting
Date: Wed, 11 Dec 2024 11:53:29 -0800
Message-Id: <20241211195329.60224-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAJj2-QFdP6DKVQJ4Tw6rdV+XtgDihe=UOnvm4cm-q61K0hq6CQ@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 6 Dec 2024 11:57:55 -0800 Yuanchu Xie <yuanchu@google.com> wrote:

> Thanks for the response Johannes. Some replies inline.
> 
> On Tue, Nov 26, 2024 at 11:26\u202fPM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Nov 26, 2024 at 06:57:19PM -0800, Yuanchu Xie wrote:
> > > This patch series provides workingset reporting of user pages in
> > > lruvecs, of which coldness can be tracked by accessed bits and fd
> > > references. However, the concept of workingset applies generically to
> > > all types of memory, which could be kernel slab caches, discardable
> > > userspace caches (databases), or CXL.mem. Therefore, data sources might
> > > come from slab shrinkers, device drivers, or the userspace.
> > > Another interesting idea might be hugepage workingset, so that we can
> > > measure the proportion of hugepages backing cold memory. However, with
> > > architectures like arm, there may be too many hugepage sizes leading to
> > > a combinatorial explosion when exporting stats to the userspace.
> > > Nonetheless, the kernel should provide a set of workingset interfaces
> > > that is generic enough to accommodate the various use cases, and extensible
> > > to potential future use cases.
> >
> > Doesn't DAMON already provide this information?
> >
> > CCing SJ.
> Thanks for the CC. DAMON was really good at visualizing the memory
> access frequencies last time I tried it out!

Thank you for this kind acknowledgement, Yuanchu!

> For server use cases,
> DAMON would benefit from integrations with cgroups.  The key then would be a
> standard interface for exporting a cgroup's working set to the user.

I show two ways to make DAMON supports cgroups for now.  First way is making
another DAMON operations set implementation for cgroups.  I shared a rough idea
for this before, probably on kernel summit.  But I haven't had a chance to
prioritize this so far.  Please let me know if you need more details.  The
second way is extending DAMOS filter to provide more detailed statistics per
DAMON-region, and adding another DAMOS action that does nothing but only
accounting the detailed statistics.  Using the new DAMOS action, users will be
able to know how much of specific DAMON-found regions are filtered out by the
given filter.  Because we have DAMOS filter type for cgroups, we can know how
much of workingset (or, warm memory) belongs to specific groups.  This can be
applied to not only cgroups, but for any DAMOS filter types that exist (e.g.,
anonymous page, young page).

I believe the second way is simpler to implement while providing information
that sufficient for most possible use cases.  I was anyway planning to do this.

> It would be good to have something that will work for different
> backing implementations, DAMON, MGLRU, or active/inactive LRU.

I think we can do this using the filter statistics, with new filter types.  For
example, we can add new DAMOS filter that filters pages if it is for specific
range of MGLRU-gen of the page, or whether the page belongs to active or
inactive LRU lists.

> 
> >
> > > Use cases
> > > ==========
[...]
> > Access frequency is only half the picture. Whether you need to keep
> > memory with a given frequency resident depends on the speed of the
> > backing device.
[...]
> > > Benchmarks
> > > ==========
> > > Ghait Ouled Amar Ben Cheikh has implemented a simple policy and ran Linux
> > > compile and redis benchmarks from openbenchmarking.org. The policy and
> > > runner is referred to as WMO (Workload Memory Optimization).
> > > The results were based on v3 of the series, but v4 doesn't change the core
> > > of the working set reporting and just adds the ballooning counterpart.
> > >
> > > The timed Linux kernel compilation benchmark shows improvements in peak
> > > memory usage with a policy of "swap out all bytes colder than 10 seconds
> > > every 40 seconds". A swapfile is configured on SSD.
[...]
> > You can do this with a recent (>2018) upstream kernel and ~100 lines
> > of python [1]. It also works on both LRU implementations.
> >
> > [1] https://github.com/facebookincubator/senpai
> >
> > We use this approach in virtually the entire Meta fleet, to offload
> > unneeded memory, estimate available capacity for job scheduling, plan
> > future capacity needs, and provide accurate memory usage feedback to
> > application developers.
> >
> > It works over a wide variety of CPU and storage configurations with no
> > specific tuning.
> >
> > The paper I referenced above provides a detailed breakdown of how it
> > all works together.
> >
> > I would be curious to see a more in-depth comparison to the prior art
> > in this space. At first glance, your proposal seems more complex and
> > less robust/versatile, at least for offloading and capacity gauging.
> We have implemented TMO PSI-based proactive reclaim and compared it to
> a kstaled-based reclaimer (reclaiming based on 2 minute working set
> and refaults). The PSI-based reclaimer was able to save more memory,
> but it also caused spikes of refaults and a lot higher
> decompressions/second. Overall the test workloads had better
> performance with the kstaled-based reclaimer. The conclusion was that
> it was a trade-off.

I agree it is only half of the picture, and there could be tradeoff.  Motivated
by those previous works, DAMOS provides PSI-based aggressiveness auto-tuning to
use both ways.

> I do agree there's not a good in-depth comparison
> with prior art though.

I would be more than happy to help the comparison work agains DAMON of current
implementation and future plans, and any possible collaborations.


Thanks,
SJ

