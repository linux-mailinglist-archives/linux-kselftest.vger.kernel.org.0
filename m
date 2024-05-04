Return-Path: <linux-kselftest+bounces-9454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1408BB9BD
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 09:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 296C6B21765
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 May 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354855258;
	Sat,  4 May 2024 07:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RKbaZSu8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7676D4C8D
	for <linux-kselftest@vger.kernel.org>; Sat,  4 May 2024 07:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714807847; cv=none; b=RF5CDrLuCxt4cv6sGU7W6Ie4H/YlwW8IbQg6VH5FrzIEJGm/Wwm+/QO1KL5nC4IPO0Sxj3dnVo1pZesB+JKYcAyPW6n6XQGBkaTLoU0mjtjCielUQbzKhOzZmF9CnJQh4UvsZpX3IWz1gVTco6CT9MWAtHYBtPFSXqKerAbRJsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714807847; c=relaxed/simple;
	bh=5stJ9da450qa80ywyURzS+csuwoFs5l3Ac6/1RKt3r0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gmFoQcj+3xDoS03jCBKGOn5eTcW2HEh7mV7e23+xB9DLt9TdznmYdos7bouE9079j9jT+k2YvbewRrpX0INn6C/rb+srvd77NuUkl6diTUPr2DGN7PiOKV5X6IXEAMZKAAdJh3w8n7hXqdee91u+cgvkEqpqwJGnYBbcKVXhUhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RKbaZSu8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de60321ce6cso853482276.1
        for <linux-kselftest@vger.kernel.org>; Sat, 04 May 2024 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714807844; x=1715412644; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZEhqL1CqjynIxdH2JX4K2zUhUQiHbpFFJcUISKJLIbM=;
        b=RKbaZSu8qR9gQ+IbONjZzUXgVYyYbIlJDic6fnHLwTXSyGqrnpR3peq+LLDb2eEMab
         x9ApjU3tsPZN6H8JtlBs9Jm0JelfUYscL4BxPRPrOH6/M/jUVMo57IjpGeKZTAziWg6j
         LR6IkjP7sr9M1VtdUcuzWloyCaaP3W7O07nce5Kpf/gg2/yr8MidP70Eqj+AnONwSV0J
         otc7x/89JXcB1BKgAzPT2HWwFHlkbWrIh3m9GddZJ1V0VtalqXIEFVwLKS+hFKhKaelB
         omnGY0l2GyTlk1RjtwyEAaXHWHW3LsJLw0i//mVfQDpBPd9IqP8ogJzAsVtXi+VUI5x9
         +pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714807844; x=1715412644;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZEhqL1CqjynIxdH2JX4K2zUhUQiHbpFFJcUISKJLIbM=;
        b=DegZfB8RTh+pQW15tFwJ7w9mcOOwiAP/qEUmeD93F+dsq8qmqy9/F/nXXD3jA0a/ZK
         6eiATiWcEO9f686uKNKZrEySN/SvAuC9VxJ9xJ5XSDqMgGGXtYcdjBvLaZGcvoCPS+Bh
         LvJBIUyoYhjZhHY7t5niyNTSxwH4ZSPnGXyrJN1dRpO0ElHfioAQ28qR77U5HOuiJcbw
         3SgRIGidfifUKBgNjz8zmyLo/vlG4d+KK8ttxOZOVCTe25VhtgsgSINAbjGD2sCbBGtw
         8k3IdRxcl8FT5UwU9qSgnFB9063mtUnSCoPsPFi01MLFzGOxh1sxDBUfjRhDXOjO/EmC
         DfCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWw/EBPG2WYhzRABzoKbFoSei/yy+ImIaPUCpBX9XyU3tMazh3uhY82nC9HQ/hkcjRR/6hrJEMDlANX2K6v+/3vQEcNhbecvvW9P/m1scW2
X-Gm-Message-State: AOJu0YyLFmkMg/yn6zMzwHRbgFRKmOXnDWl8uQgb9EkOUS7MbetFkiOc
	4MZYkSNLZdI+wyRPUs8VrYF0yyWsDXiG6vRtrYxloR8NhvDI2CnvRrmzzbYpwKTKEKlMVki70Lv
	lEXs/eA==
X-Google-Smtp-Source: AGHT+IFP46rvcozU6JIIDCEu+DKrbHJU9uxcDlUFqWs1yPYFcfhx8EqiHxmm9strVpEXBTixcF5vXf03mKao
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:da8f:bd07:9977:eb21])
 (user=yuanchu job=sendgmr) by 2002:a25:ad85:0:b0:dcb:b9d7:2760 with SMTP id
 z5-20020a25ad85000000b00dcbb9d72760mr1376164ybi.13.1714807844528; Sat, 04 May
 2024 00:30:44 -0700 (PDT)
Date: Sat,  4 May 2024 00:30:04 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240504073011.4000534-1-yuanchu@google.com>
Subject: [PATCH v1 0/7] mm: workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Changes from RFC v3 -> PATCH v1:
- Updated selftest to use ksft_print_msg instead of fprintf(stderr, ...)
  (Muhammad Usama Anjum)
- Included more detail in patch skipping pmd_young with force_scan
  (Huang, Ying)
- Deferred reaccess histogram as a followup
- Removed per-memcg page age interval configs for simplicity

Changes from RFC v2 -> RFC v3:
- Update to v6.8
- Added an aging kernel thread (gated behind config)
- Added basic selftests for sysfs interface files
- Track swapped out pages for reaccesses
- Refactoring and cleanup
- Dropped the virtio-balloon extension to make things manageable

Changes from RFC v1 -> RFC v2:
- Refactored the patchs into smaller pieces
- Renamed interfaces and functions from wss to wsr (Working Set Reporting)
- Fixed build errors when CONFIG_WSR is not set
- Changed working_set_num_bins to u8 for virtio-balloon
- Added support for per-NUMA node reporting for virtio-balloon

[rfc v1]
https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@google.com/
[rfc v2]
https://lore.kernel.org/linux-mm/20230621180454.973862-1-yuanchu@google.com/
[rfc v3]
https://lore.kernel.org/linux-mm/20240327213108.2384666-1-yuanchu@google.com/

This patch series provides workingset reporting of user pages in
lruvecs, of which coldness can be tracked by accessed bits and fd
references. However, the concept of workingset applies generically to
all types of memory, which could be kernel slab caches, discardable
userspace caches (databases), or CXL.mem. Therefore, data sources might
come from slab shrinkers, device drivers, or the userspace. IMO, the
kernel should provide a set of workingset interfaces that should be
generic enough to accommodate the various use cases, and be extensible
to potential future use cases. The current proposed interfaces are not
sufficient in that regard, but I would like to start somewhere, solicit
feedback, and iterate.

Use cases
==========
Job scheduling
On overcommitted hosts, workingset information allows the job scheduler
to right-size each job and land more jobs on the same host or NUMA node,
and in the case of a job with increasing workingset, policy decisions
can be made to migrate other jobs off the host/NUMA node, or oom-kill
the misbehaving job. If the job shape is very different from the machine
shape, knowing the workingset per-node can also help inform page
allocation policies.

Proactive reclaim
Workingset information allows the a container manager to proactively
reclaim memory while not impacting a job's performance. While PSI may
provide a reactive measure of when a proactive reclaim has reclaimed too
much, workingset reporting allows the policy to be more accurate and
flexible.

Ballooning (similar to proactive reclaim)
While this patch series does not extend the virtio-balloon device,
balloon policies benefit from workingset to more precisely determine
the size of the memory balloon. On desktops/laptops/mobile devices where
memory is scarce and overcommitted, the balloon sizing in multiple VMs
running on the same device can be orchestrated with workingset reports
from each one.

Promotion/Demotion
Similar to proactive reclaim, a workingset report enables demotion to a
slower tier of memory.
For promotion, the workingset report interfaces need to be extended to
report hotness and gather hotness information from the devices[1].

[1]
https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1

Sysfs and Cgroup Interfaces
==========
The interfaces are detailed in the patches that introduce them. The main
idea here is we break down the workingset per-node per-memcg into time
intervals (ms), e.g.

1000 anon=137368 file=24530
20000 anon=34342 file=0
30000 anon=353232 file=333608
40000 anon=407198 file=206052
9223372036854775807 anon=4925624 file=892892

I realize this does not generalize well to hotness information, but I
lack the intuition for an abstraction that presents hotness in a useful
way. Please advise.

Implementation
==========
Currently, the reporting of user pages is based off of MGLRU, and
therefore requires CONFIG_LRU_GEN=y. We would benefit from more MGLRU
generations for a more fine-grained workingset report. I will make the
generation count configurable in the next version. The workingset
reporting mechanism is gated behind CONFIG_WORKINGSET_REPORT, and the
aging thread is behind CONFIG_WORKINGSET_REPORT_AGING.

Yuanchu Xie (7):
  mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
  mm: aggregate working set information into histograms
  mm: use refresh interval to rate-limit workingset report aggregation
  mm: report workingset during memory pressure driven scanning
  mm: extend working set reporting to memcgs
  mm: add kernel aging thread for workingset reporting
  selftest: test system-wide workingset reporting

 drivers/base/node.c                           |   6 +
 include/linux/memcontrol.h                    |   5 +
 include/linux/mmzone.h                        |   9 +
 include/linux/workingset_report.h             |  97 ++++
 mm/Kconfig                                    |  15 +
 mm/Makefile                                   |   2 +
 mm/internal.h                                 |  17 +
 mm/memcontrol.c                               | 184 +++++-
 mm/mm_init.c                                  |   2 +
 mm/mmzone.c                                   |   2 +
 mm/vmscan.c                                   |  85 ++-
 mm/workingset_report.c                        | 545 ++++++++++++++++++
 mm/workingset_report_aging.c                  | 127 ++++
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 .../testing/selftests/mm/workingset_report.c  | 317 ++++++++++
 .../testing/selftests/mm/workingset_report.h  |  39 ++
 .../selftests/mm/workingset_report_test.c     | 332 +++++++++++
 18 files changed, 1786 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/workingset_report.h
 create mode 100644 mm/workingset_report.c
 create mode 100644 mm/workingset_report_aging.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.h
 create mode 100644 tools/testing/selftests/mm/workingset_report_test.c

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


