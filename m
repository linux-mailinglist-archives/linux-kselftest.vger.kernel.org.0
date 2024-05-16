Return-Path: <linux-kselftest+bounces-10282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A0C8C7179
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 07:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4D47B20C50
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 05:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358C1C695;
	Thu, 16 May 2024 05:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8TmgJGB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C77529CEA;
	Thu, 16 May 2024 05:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715838920; cv=none; b=YvDQ+zcAiA8CaUPVnlQmPHWICdOZjej6IMKiTWCIhoNlsyyyolzQt/p0KQLegOZ+UTaE2EodHjU0xQTbeHmYI3Dj+SvnPt4vzbbXkCF3t9yaoAHmNE4J1Vcb8CvI+QGQ2ZpnTko6BDwuRJfghknmGL6T7kAjs5IBxf6TrvsndAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715838920; c=relaxed/simple;
	bh=xMvyt0Z5g7e3xmtO9PR6aw0WgugOD1OHXY3O55x0INQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Prov8jnZ01j4ClxkdGoikI17xa3Tk/4AzggEsmwEPahhyRfehdYB4/SdF4LLS28LmX9Dt6/t0IUQZ+80rE+q0c73AngmH2ea6D/mqdxFM7197Dakhuxwe9YmUvS8+JidWVtGu7uk2axRqZblrTaVW7DASk3l+TPzR03gQpLOo4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8TmgJGB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715838918; x=1747374918;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=xMvyt0Z5g7e3xmtO9PR6aw0WgugOD1OHXY3O55x0INQ=;
  b=n8TmgJGBCALq1e0HEUgrg9ESdrJBAEw7avnZvcmR4kPlXpUDBoytMTL4
   9CJGkH+FJYkHDkPTE9Qww5dRWpLvSj2LPhy15R2IZy0YQ602ZLMV4f0ll
   jE/ZC6n5KY6u5oCJMdMjRez9v8YMA8zk4ONu0mGClO0XFPXOQKFmRU09k
   mqyodWw+zjQb4QXd3MxamFEcL8hTZWF1TiCXj6bT6UAYAuKC53J3Riukr
   l349sYQDnnIpYqnMNzKj6NFMy4x0OJz4I9JACpwQF9MkVNWH57i5mMKDk
   oyuVx14ozPtBO3mXgxchudtCikTp3Tamfv/Pc0TAmT6QWoypLuQvDdIrg
   w==;
X-CSE-ConnectionGUID: I36hOh0jQP+IO5xavYaRJQ==
X-CSE-MsgGUID: xaPDt0urQT6pyyyaguoXRQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15754318"
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="15754318"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 22:55:17 -0700
X-CSE-ConnectionGUID: KTBMe29zTS+0c4w5wkmLoQ==
X-CSE-MsgGUID: xc3VgJ2pQMe1HxnSw9hpOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,163,1712646000"; 
   d="scan'208";a="31306965"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 22:55:10 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>,  Khalid Aziz <khalid.aziz@oracle.com>,
  Henry Huang <henry.hj@antgroup.com>,  Yu Zhao <yuzhao@google.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Gregory Price
 <gregory.price@memverge.com>,  Kalesh Singh <kaleshsingh@google.com>,  Wei
 Xu <weixugc@google.com>,  David Rientjes <rientjes@google.com>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Andrew Morton <akpm@linux-foundation.org>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Michal Hocko <mhocko@kernel.org>,  Roman
 Gushchin <roman.gushchin@linux.dev>,  Muchun Song <muchun.song@linux.dev>,
  Shuah Khan <shuah@kernel.org>,  Yosry Ahmed <yosryahmed@google.com>,
  Matthew Wilcox <willy@infradead.org>,  Sudarshan Rajagopalan
 <quic_sudaraja@quicinc.com>,  Kairui Song <kasong@tencent.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Vasily Averin <vasily.averin@linux.dev>,
  Nhat Pham <nphamcs@gmail.com>,  Miaohe Lin <linmiaohe@huawei.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Abel Wu <wuyun.abel@bytedance.com>,
  "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  linux-kernel@vger.kernel.org,
  linux-mm@kvack.org,  cgroups@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 0/7] mm: workingset reporting
In-Reply-To: <20240504073011.4000534-1-yuanchu@google.com> (Yuanchu Xie's
	message of "Sat, 4 May 2024 00:30:04 -0700")
References: <20240504073011.4000534-1-yuanchu@google.com>
Date: Thu, 16 May 2024 13:53:17 +0800
Message-ID: <87v83eb8vm.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Yuanchu,

Yuanchu Xie <yuanchu@google.com> writes:

> Changes from RFC v3 -> PATCH v1:
> - Updated selftest to use ksft_print_msg instead of fprintf(stderr, ...)
>   (Muhammad Usama Anjum)
> - Included more detail in patch skipping pmd_young with force_scan
>   (Huang, Ying)
> - Deferred reaccess histogram as a followup
> - Removed per-memcg page age interval configs for simplicity
>
> Changes from RFC v2 -> RFC v3:
> - Update to v6.8
> - Added an aging kernel thread (gated behind config)
> - Added basic selftests for sysfs interface files
> - Track swapped out pages for reaccesses
> - Refactoring and cleanup
> - Dropped the virtio-balloon extension to make things manageable
>
> Changes from RFC v1 -> RFC v2:
> - Refactored the patchs into smaller pieces
> - Renamed interfaces and functions from wss to wsr (Working Set Reporting)
> - Fixed build errors when CONFIG_WSR is not set
> - Changed working_set_num_bins to u8 for virtio-balloon
> - Added support for per-NUMA node reporting for virtio-balloon
>
> [rfc v1]
> https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/
> [rfc v2]
> https://lore.kernel.org/linux-mm/20230621180454.973862-1-yuanchu@google.com/
> [rfc v3]
> https://lore.kernel.org/linux-mm/20240327213108.2384666-1-yuanchu@google.com/
>
> This patch series provides workingset reporting of user pages in
> lruvecs, of which coldness can be tracked by accessed bits and fd
> references. However, the concept of workingset applies generically to
> all types of memory, which could be kernel slab caches, discardable
> userspace caches (databases), or CXL.mem. Therefore, data sources might
> come from slab shrinkers, device drivers, or the userspace. IMO, the
> kernel should provide a set of workingset interfaces that should be
> generic enough to accommodate the various use cases, and be extensible
> to potential future use cases. The current proposed interfaces are not
> sufficient in that regard, but I would like to start somewhere, solicit
> feedback, and iterate.
>
> Use cases
> ==========
> Job scheduling
> On overcommitted hosts, workingset information allows the job scheduler
> to right-size each job and land more jobs on the same host or NUMA node,
> and in the case of a job with increasing workingset, policy decisions
> can be made to migrate other jobs off the host/NUMA node, or oom-kill
> the misbehaving job. If the job shape is very different from the machine
> shape, knowing the workingset per-node can also help inform page
> allocation policies.
>
> Proactive reclaim
> Workingset information allows the a container manager to proactively
> reclaim memory while not impacting a job's performance. While PSI may
> provide a reactive measure of when a proactive reclaim has reclaimed too
> much, workingset reporting allows the policy to be more accurate and
> flexible.
>
> Ballooning (similar to proactive reclaim)
> While this patch series does not extend the virtio-balloon device,
> balloon policies benefit from workingset to more precisely determine
> the size of the memory balloon. On desktops/laptops/mobile devices where
> memory is scarce and overcommitted, the balloon sizing in multiple VMs
> running on the same device can be orchestrated with workingset reports
> from each one.
>
> Promotion/Demotion
> Similar to proactive reclaim, a workingset report enables demotion to a
> slower tier of memory.
> For promotion, the workingset report interfaces need to be extended to
> report hotness and gather hotness information from the devices[1].
>
> [1]
> https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1

This mechanism can also provide a way to control the pages ping-pong
caused by promotion and demotion.  If different methods are used for
promotion and demotion, some pages may be migrated between the fast and
slow memory back and forth.  Because there's no connection between
promotion side and demotion side.  For example, if we use NUMA balancing
based promotion and MGLRU based demotion.

If we use workingset reporting on the fast memory nodes, then we can
establish the connection between demotion and promotion with it.  For
example, the promotion hot pages threshold (determined as accessed every
N seconds) should be set to make 80% of the fast memory pages pass the
threshold.  This can be calculated with the workingset reporting
statistics.

> Sysfs and Cgroup Interfaces
> ==========
> The interfaces are detailed in the patches that introduce them. The main
> idea here is we break down the workingset per-node per-memcg into time
> intervals (ms), e.g.
>
> 1000 anon=137368 file=24530
> 20000 anon=34342 file=0
> 30000 anon=353232 file=333608
> 40000 anon=407198 file=206052
> 9223372036854775807 anon=4925624 file=892892
>
> I realize this does not generalize well to hotness information, but I
> lack the intuition for an abstraction that presents hotness in a useful
> way. Please advise.
>
> Implementation
> ==========
> Currently, the reporting of user pages is based off of MGLRU, and
> therefore requires CONFIG_LRU_GEN=y. We would benefit from more MGLRU
> generations for a more fine-grained workingset report. I will make the
> generation count configurable in the next version. The workingset
> reporting mechanism is gated behind CONFIG_WORKINGSET_REPORT, and the
> aging thread is behind CONFIG_WORKINGSET_REPORT_AGING.
>
> Yuanchu Xie (7):
>   mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
>   mm: aggregate working set information into histograms
>   mm: use refresh interval to rate-limit workingset report aggregation
>   mm: report workingset during memory pressure driven scanning
>   mm: extend working set reporting to memcgs
>   mm: add kernel aging thread for workingset reporting
>   selftest: test system-wide workingset reporting
>
>  drivers/base/node.c                           |   6 +
>  include/linux/memcontrol.h                    |   5 +
>  include/linux/mmzone.h                        |   9 +
>  include/linux/workingset_report.h             |  97 ++++
>  mm/Kconfig                                    |  15 +
>  mm/Makefile                                   |   2 +
>  mm/internal.h                                 |  17 +
>  mm/memcontrol.c                               | 184 +++++-
>  mm/mm_init.c                                  |   2 +
>  mm/mmzone.c                                   |   2 +
>  mm/vmscan.c                                   |  85 ++-
>  mm/workingset_report.c                        | 545 ++++++++++++++++++
>  mm/workingset_report_aging.c                  | 127 ++++
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   3 +
>  .../testing/selftests/mm/workingset_report.c  | 317 ++++++++++
>  .../testing/selftests/mm/workingset_report.h  |  39 ++
>  .../selftests/mm/workingset_report_test.c     | 332 +++++++++++
>  18 files changed, 1786 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/workingset_report.h
>  create mode 100644 mm/workingset_report.c
>  create mode 100644 mm/workingset_report_aging.c
>  create mode 100644 tools/testing/selftests/mm/workingset_report.c
>  create mode 100644 tools/testing/selftests/mm/workingset_report.h
>  create mode 100644 tools/testing/selftests/mm/workingset_report_test.c

--
Best Regards,
Huang, Ying

