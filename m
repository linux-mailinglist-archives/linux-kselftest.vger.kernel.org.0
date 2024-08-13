Return-Path: <linux-kselftest+bounces-15249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C6D950ADD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFD328187D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 16:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C887B1A255D;
	Tue, 13 Aug 2024 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YXUsElVn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB555892
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723568378; cv=none; b=Thox2CRhQVWRhjcsaDSvQnqE4rrFKMh2pxzGtw/brZAlIDLEve1I1FkHfmEt2cXOib+tl/n7ZEU77ek7QibDqEGTLRAOyBKiWjfprNjbTPEulVJB5odKQyyK/r6foIRgqSldowdqNqv0VPRhkdGtEfy/ksz47bqfsvORkqb/um4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723568378; c=relaxed/simple;
	bh=qfKOwpt8OZsB6if97prZ2PbPUwEsMQoPfwGvCamgHOs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qgOECHVOKv4SKdCPH8DaZn7ZHpIFVdhE5ny7H/uCuuTQmVFaWtF7eiWuh0tDqGVqD4P9/18aZq5V9Uutn5xbU78IYgbfQoWRljWhRM0sfdWZOutoQmKInMab0P8Vx04efRQf3IIivQVKhp2RjOUoWPSspMGd8duj+yYzQJD/qQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YXUsElVn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02a4de4f4eso9998274276.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Aug 2024 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723568376; x=1724173176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bv4SVjHgUZOhoTb1OWwMYpUDeJnXwVqeg4+bbTG2FbM=;
        b=YXUsElVnZI2R17MGGaC+AkC4usx1O9rshSJyj3aw2U+Eb0K/rpH33i5N5oYn0zKY9D
         mcNCtw+PoBEVWRbHARX0/Zln/cBex5p9S5iUzX+NI6kuaoQ33baLuZkVtNAh9yEu0uBw
         A/rFNLUmd3MgkgdGECChf87NBFYKN+6IkVREKJFLMMykEeCwfpp0mISxldzG7iRPmIZl
         ldZFhl2Mngug2u2/VbhCFKIWwiBrFoT/vmlspTse/gs3uEkoVGhIGk4g2a4z4kjcxLXg
         yVN0Sf3PZpphtGR6A/IWZMzM5qV6udypRSlAojZTP2GD/rlWAsMAIkpSvsj3sacRvuYs
         KgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723568376; x=1724173176;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bv4SVjHgUZOhoTb1OWwMYpUDeJnXwVqeg4+bbTG2FbM=;
        b=K9M+0nq5BiyLnTb/eo8A1w3TjWqbm+zZeWyallAZqcCRZ3stifnn0Wtr/ANzeboFlZ
         rK8/CDY5wByRS1fSsJvIpzVjO1/BOWKtnJeziEsP/v29omVfOdGaSgnSDWgbo97QZgzl
         p9glJaE+kRrysx5pS5u+8//kSW6Q0Sw9G996YmKyCBrnvlHMa9fqiPwSMpjlURupVe1Q
         S7clkAWJXoAwI/zOX/hvcwCFueCMEoWUhzmkLtuL/qr+4sWqLwlcACHC7NXtFHPHwsv7
         2D+4hC9ltD//bIQDbpJ3z85RvOvrM0CA378fgLeR3+VL7KvHWcCkMfSA5ypb4I1CT0Lf
         fhTA==
X-Forwarded-Encrypted: i=1; AJvYcCWcs3cH2bSJfKRremaEguv/Sbh6CO9I1TQoY0R+kTPEA5qU3nA1sPQnjYsZM4P9xh9Fm9jU+RfWCE2H9L98d0fQI6FX89nXPkrSxrzxq2+W
X-Gm-Message-State: AOJu0Yzk9vGjNRi11gkXuaz/SmJCLN9XCboP6IW0hEQe/fofZqt4zgI7
	X8kjA+uN1EN+0HFnPb85oKXHi/FrnD1X1fiE278BJOfS8Cw5Hxv+O2EpMpbYOtKQ25CTNCsppUZ
	aMcY5bw==
X-Google-Smtp-Source: AGHT+IFhhfIujG8uqC2QMmL5ZeYf4GNZcSGDr17DVlIcY0LVjF5xR47VsuGiOOLjceaKtQ5GHcSYn/ofKs8V
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a25:9709:0:b0:e0b:bcd2:b2ee with SMTP id
 3f1490d57ef6-e1155aa5875mr280276.6.1723568376005; Tue, 13 Aug 2024 09:59:36
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:56:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813165619.748102-1-yuanchu@google.com>
Subject: [PATCH v3 0/7] mm: workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
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

Changes from PATCH v2 -> v3:
- Fixed typos in commit messages and documentation
  (Lance Yang, Randy Dunlap)
- Split out the force_scan patch to be reviewed separately
- Added benchmarks from Ghait Ouled Amar Ben Cheikh
- Fixed reported compile error without CONFIG_MEMCG

Changes from PATCH v1 -> v2:
- Updated selftest to use ksft_test_result_code instead of switch-case
  (Muhammad Usama Anjum)
- Included more use cases in the cover letter
  (Huang, Ying)
- Added documentation for sysfs and memcg interfaces
- Added an aging-specific struct lru_gen_mm_walk in struct pglist_data
  to avoid allocating for each lruvec.

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
If different mechanisms are used for promition and demotion, workingset
information can help connect the two and avoid pages being migrated back
and forth.
For example, given a promotion hot page threshold defined in reaccess
distance of N seconds (promote pages accessed more often than every N
seconds). The threshold N should be set so that ~80% (e.g.) of pages on
the fast memory node passes the threshold. This calculation can be done
with workingset reports.
To be directly useful for promotion policies, the workingset report
interfaces need to be extended to report hotness and gather hotness
information from the devices[1].

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
way. Based on a recent proposal for move_phys_pages[2], it seems like
userspace tiering software would like to move specific physical pages,
instead of informing the kernel "move x number of hot pages to y
device". Please advise.

[2]
https://lore.kernel.org/lkml/20240319172609.332900-1-gregory.price@memverge.com/

Implementation
==========
Currently, the reporting of user pages is based off of MGLRU, and
therefore requires CONFIG_LRU_GEN=y. We would benefit from more MGLRU
generations for a more fine-grained workingset report. I will make the
generation count configurable in the next version. The workingset
reporting mechanism is gated behind CONFIG_WORKINGSET_REPORT, and the
aging thread is behind CONFIG_WORKINGSET_REPORT_AGING.

Benchmarks
==========
Ghait Ouled Amar Ben Cheikh has implemented a simple "reclaim everything
colder than 10 seconds every 40 seconds" policy and ran Linux compile
and redis from the phoronix test suite. The results are in his repo:
https://github.com/miloudi98/WMO

Yuanchu Xie (7):
  mm: aggregate working set information into histograms
  mm: use refresh interval to rate-limit workingset report aggregation
  mm: report workingset during memory pressure driven scanning
  mm: extend working set reporting to memcgs
  mm: add kernel aging thread for workingset reporting
  selftest: test system-wide workingset reporting
  Docs/admin-guide/mm/workingset_report: document sysfs and memcg
    interfaces

 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/workingset_report.rst      | 105 ++++
 drivers/base/node.c                           |   6 +
 include/linux/memcontrol.h                    |  21 +
 include/linux/mmzone.h                        |   9 +
 include/linux/workingset_report.h             |  97 +++
 mm/Kconfig                                    |  15 +
 mm/Makefile                                   |   2 +
 mm/internal.h                                 |  18 +
 mm/memcontrol.c                               | 184 +++++-
 mm/mm_init.c                                  |   2 +
 mm/mmzone.c                                   |   2 +
 mm/vmscan.c                                   |  56 +-
 mm/workingset_report.c                        | 561 ++++++++++++++++++
 mm/workingset_report_aging.c                  | 127 ++++
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 .../testing/selftests/mm/workingset_report.c  | 306 ++++++++++
 .../testing/selftests/mm/workingset_report.h  |  39 ++
 .../selftests/mm/workingset_report_test.c     | 330 +++++++++++
 21 files changed, 1885 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/workingset_report.rst
 create mode 100644 include/linux/workingset_report.h
 create mode 100644 mm/workingset_report.c
 create mode 100644 mm/workingset_report_aging.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.h
 create mode 100644 tools/testing/selftests/mm/workingset_report_test.c

-- 
2.46.0.76.ge559c4bf1a-goog


