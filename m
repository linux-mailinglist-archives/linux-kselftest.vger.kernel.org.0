Return-Path: <linux-kselftest+bounces-22584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B53D9DADF9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 20:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385D91644DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 19:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20593201272;
	Wed, 27 Nov 2024 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4OdQFkp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32A8201029;
	Wed, 27 Nov 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732736443; cv=none; b=Y+W1I2jSqCURNE2RhdUXC2MFb3Dm+dhjHv77mPeBz6DEV705br8qL2SV1+Tvqz8nQz6smi+Ec3tQaUT9qqiyIpxEy9y8/lnMmuBj0oPXeIuHuZYwPtNPnI4dplyR2tfzidfw34+uVBrU+n3HkPp65QyEmmtF5nsGpFDKc+Ub0MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732736443; c=relaxed/simple;
	bh=FNpsPBymSvEX1rHGNSh2J+QjHOLtO8xKZwskRMfxD8A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ml0rorp8PFSyXPj5pByRryRAlUke8xraZGozdhQs9tRMG1ITDaOCb3i2B8OTPYPiSnMqhPxxMrUzIhgiK8tH1/vMj1QvcGdhFqbkc6FAYxBF+RcbGwZXiJsKIKZZJLQPxSVRuAiE3yAohUeietKviaq4Czyi45idcQeegAUrPVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4OdQFkp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF0AC4CECC;
	Wed, 27 Nov 2024 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732736441;
	bh=FNpsPBymSvEX1rHGNSh2J+QjHOLtO8xKZwskRMfxD8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4OdQFkp2nt/VvgqWAzMb+U036mIXv7j2LJHKF/dpUn954h4y4SzH9pfQm5Llm4xC
	 Xn3EHI2RFYk+gF5oK9ediPguZG96lc468mGXVKDVabS6zPzl3wbCS/MnXPq9wNWUoD
	 88QCHf1aG6/UUPTBoYdYVcG4036FWpAv+gaqp53RLXgsDDy3Z7Nu4AVunbRKleiL8c
	 4+D8sjtuIsIxt+phU4/VoCafcBznr1o2zDnmKGhv34cusEtthtKdEUJGBXWRWILSOo
	 OA57OHPSkfugMlhiW2Ny9LvwIpITFIFKLXiw77pynSGgenHRCGTb3GbcimZ9kP5jMT
	 7BPLErjejFueQ==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>,
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
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
	linux-kselftest@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: [PATCH v4 0/9] mm: workingset reporting
Date: Wed, 27 Nov 2024 11:40:38 -0800
Message-Id: <20241127194038.84382-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241127072604.GA2501036@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

+ damon@lists.linux.dev

I haven't thoroughly read any version of this patch series due to my laziness,
sorry.  So I may saying something completely wrong.  My apology in advance, and
please correct me in the case.

> On Tue, Nov 26, 2024 at 06:57:19PM -0800, Yuanchu Xie wrote:
> > This patch series provides workingset reporting of user pages in
> > lruvecs, of which coldness can be tracked by accessed bits and fd
> > references.

DAMON provides data access patterns of user pages.  It is not exactly named as
workingset but a superset of the information.  Users can therefore get the
workingset from DAMON-provided raw data.  So I feel I have to ask if DAMON can
be used for, or help at achieving the purpose of this patch series.

Depending on the detailed definition of workingset, of course, the workingset
we can get from DAMON might not be technically same to what this patch series
aim to provide, and the difference could be somewhat that makes DAMON unable to
be used or help here.  But I cannot know if this is the case with only this
cover letter.

> > However, the concept of workingset applies generically to
> > all types of memory, which could be kernel slab caches, discardable
> > userspace caches (databases), or CXL.mem. Therefore, data sources might
> > come from slab shrinkers, device drivers, or the userspace.
> > Another interesting idea might be hugepage workingset, so that we can
> > measure the proportion of hugepages backing cold memory. However, with
> > architectures like arm, there may be too many hugepage sizes leading to
> > a combinatorial explosion when exporting stats to the userspace.
> > Nonetheless, the kernel should provide a set of workingset interfaces
> > that is generic enough to accommodate the various use cases, and extensible
> > to potential future use cases.

This again sounds similar to what DAMON aims to provide, to me.  DAMON is
designed to be easy to extend for vairous use cases and internal mechanisms.
Specifically, it separates access check mechanisms and core logic into
different layers, and provides an interface to use for implementing extending
DAMON with new mechanisms.  DAMON's two access check mechanisms for virtual
address spaces and the physical address space are made using the interface,
indeed.  Also there were RFC patch series extending DAMON for NUMA-specific and
write-only access monitoring using NUMA hinting fault and soft-dirty PTEs as
the internal mechanisms.

My humble understanding of the major difference between DAMON and workingset
reporting is the internal mechanism.  Workingset reporting uses MGLRU as the
access check mechanism, while current access check mechanisms for DAMON are
using page table accessed bits checking as the major mechanism.  I think DAMON
can be extended to use MGLRU as its another internal access check mechanism,
but I understand that there could be many things that I overseeing.

Yuanchu, I think it would help me and other reviewers better understand this
patch series if you could share that.  And I will also be more than happy to
help you and others better understanding what DAMON can do or not with the
discussion.

> 
> Doesn't DAMON already provide this information?
> 
> CCing SJ.

Thank you for adding me, Johannes :)

[...]
> It does provide more detailed insight into userspace memory behavior,
> which could be helpful when trying to make sense of applications that
> sit on a rich layer of libraries and complicated runtimes. But here a
> comparison to DAMON would be helpful.

100% agree.


Thanks,
SJ

[...]

