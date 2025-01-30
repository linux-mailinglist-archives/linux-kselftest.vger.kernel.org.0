Return-Path: <linux-kselftest+bounces-25408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9CA2280A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 05:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D173A4020
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 04:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1525D7404E;
	Thu, 30 Jan 2025 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvFPOePl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4632770C;
	Thu, 30 Jan 2025 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738210303; cv=none; b=Sw4w9zaKRZjlmNGAIcvEJVCjDjxJMi9yGT+6rUGRY5OLG/QcBenJ89dJ0EjIw5DUC35uRSNduUnKBLH4RQFf1hmsAx352patq53+EvvcVU+gwAY4Bbx/98n0ZKBAHwGBm8szTvxcrG/XXY9vLHHAuoaI7SQqBc6PR1E6gv6LXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738210303; c=relaxed/simple;
	bh=UC8IeBBKFfPBafCFr4kyUFlVe382D2VnfBipiZRaeRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qWC1bJy9QN8MO4h2j6so3CiBFfaabUjSYxEYK3Pvk4Y/L/stGCnw2Z8dPsN7dZ6z+Rqa5VY/W9wqwNXxZpEBgEjsX840VGq5xKwX3md9Zca6rByW28oQmev6Sxfdta4dCR2fbeaCJ2rE2+s3GNkDp4MYJnkWR8pABXaJZGWptXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvFPOePl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142C8C4CED2;
	Thu, 30 Jan 2025 04:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738210301;
	bh=UC8IeBBKFfPBafCFr4kyUFlVe382D2VnfBipiZRaeRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FvFPOePlZwb+q7p6VAdWvFNtAW3tP1nHg6WW2zcJaU4NBd7tkRrFawMA/8C7BVKNG
	 avNXIc291RJYKtb21lcaVNzFUTmGc5vV1aU3QRNrNmu8Q1jLa4VXBHSzRiYuAPZv1l
	 gzi3AAm1a55/2ZTre2qX6zQBFJKDzfm5yJc9JKoT6RZNMwmr4U2C1a4zYCTEJ6R7b4
	 ZR3IOq9yYN4nJGJGt4UWdBiWuXACHW9fk0T1xLslstiVWWKaN3EMcatUlLBePbEL74
	 udgZylVrsFyKyefsc0ConnfYje20wF64jkfAOJtPMg6sLxytwIat3xeR8ynGMZJpGt
	 lnapa7ShDYaDw==
From: SeongJae Park <sj@kernel.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: SeongJae Park <sj@kernel.org>,
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
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
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
Date: Wed, 29 Jan 2025 20:11:39 -0800
Message-Id: <20250130041139.49594-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAJj2-QEaLTasfQgb=VFfnbOmkcXU3kw2VbsNummNEq0V3b9jdw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Yuanchu,

On Wed, 29 Jan 2025 18:02:26 -0800 Yuanchu Xie <yuanchu@google.com> wrote:

> On Wed, Dec 11, 2024 at 11:53 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Fri, 6 Dec 2024 11:57:55 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
> >
> > > Thanks for the response Johannes. Some replies inline.
> > >
> > > On Tue, Nov 26, 2024 at 11:26\u202fPM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Tue, Nov 26, 2024 at 06:57:19PM -0800, Yuanchu Xie wrote:
> > > > > This patch series provides workingset reporting of user pages in
> > > > > lruvecs, of which coldness can be tracked by accessed bits and fd
> > > > > references. However, the concept of workingset applies generically to
> > > > > all types of memory, which could be kernel slab caches, discardable
> > > > > userspace caches (databases), or CXL.mem. Therefore, data sources might
> > > > > come from slab shrinkers, device drivers, or the userspace.
> > > > > Another interesting idea might be hugepage workingset, so that we can
> > > > > measure the proportion of hugepages backing cold memory. However, with
> > > > > architectures like arm, there may be too many hugepage sizes leading to
> > > > > a combinatorial explosion when exporting stats to the userspace.
> > > > > Nonetheless, the kernel should provide a set of workingset interfaces
> > > > > that is generic enough to accommodate the various use cases, and extensible
> > > > > to potential future use cases.
> > > >
> > > > Doesn't DAMON already provide this information?
> > > >
> > > > CCing SJ.
> > > Thanks for the CC. DAMON was really good at visualizing the memory
> > > access frequencies last time I tried it out!
> >
> > Thank you for this kind acknowledgement, Yuanchu!
> >
> > > For server use cases,
> > > DAMON would benefit from integrations with cgroups.  The key then would be a
> > > standard interface for exporting a cgroup's working set to the user.
> >
> > I show two ways to make DAMON supports cgroups for now.  First way is making
> > another DAMON operations set implementation for cgroups.  I shared a rough idea
> > for this before, probably on kernel summit.  But I haven't had a chance to
> > prioritize this so far.  Please let me know if you need more details.  The
> > second way is extending DAMOS filter to provide more detailed statistics per
> > DAMON-region, and adding another DAMOS action that does nothing but only
> > accounting the detailed statistics.  Using the new DAMOS action, users will be
> > able to know how much of specific DAMON-found regions are filtered out by the
> > given filter.  Because we have DAMOS filter type for cgroups, we can know how
> > much of workingset (or, warm memory) belongs to specific groups.  This can be
> > applied to not only cgroups, but for any DAMOS filter types that exist (e.g.,
> > anonymous page, young page).
> >
> > I believe the second way is simpler to implement while providing information
> > that sufficient for most possible use cases.  I was anyway planning to do this.

I implemented the feature for the second approach I mentioned above.  The
initial version of the feature has recently merged[1] into the mainline as a
part of 6.14-rc1 MM pull request.  DAMON user-space tool (damo) is also updated
for baisc support of it.  I forgot updating that on this thread, sorry.

> For a container orchestrator like kubernetes, the node agents need to
> be able to gather the working set stats at a per-job level. Some jobs
> can create sub-hierarchies as well, so it's important that we have
> hierarchical stats.

This makes sense to me.  And yes, I believe DAMOS filters for memcg could also
be used for this use case, since we can install and use multiple DAMOS filters
in combinations.

The documentation of the feature is not that good and there are many rooms to
improve.  You might not be able to get what you want in a perfect way with the
current implementation.  But we will continue improving it, and I believe we
can make it faster if efforts are gathered.  Of course, I could be wrong, and
whether to use it or not is up to each person :)

Anyway, please feel free to ask me questions or any help about the feature if
you want.

> 
> Do you think it's a good idea to integrate DAMON to provide some
> aggregate stats in a memory controller file? With the DAMOS cgroup
> filter, there can be some kind of interface that a DAMOS action or the
> damo tool could call into. I feel that would be a straightforward and
> integrated way to support cgroups.

DAMON basically exposes its internal information via DAMON sysfs, and DAMON
user-space tool (damo) uses it.  In this case, per-memcg working set could also
be retrieved in the way (directly from DAMON sysfs or indirectly from damo).

But, yes, I think we could make new and optimized ABIs for exposing the
information to user-space in more efficient way depending on the use case, if
needed.  DAMON modules such as DAMON_RECLAIM and DAMON_LRU_SORT provides their
own ABIs that simplified and optimized for their usages.

[1] https://git.kernel.org/torvalds/c/626ffabe67c2


Thanks,
SJ

[...]

