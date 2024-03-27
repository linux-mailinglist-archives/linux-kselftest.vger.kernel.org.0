Return-Path: <linux-kselftest+bounces-6734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2C88F0ED
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 22:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A4B1F29A91
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Mar 2024 21:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE610153591;
	Wed, 27 Mar 2024 21:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJ9tFCuE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FF5131E4F
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711575091; cv=none; b=S/pLTHOpRH2t1n7o+fnBq2sc9iD5jp4f8l1O7XmM1ov6vg7FekFjTsqJzIoMQldaK0YHZYhb6XRqv0hD4jechHTzrdbLJJkaRtFymBHjsJ4oXoiqIcRRQ7kALFcQSX6DVs/YpdhLuNecPgQRJ/RNpiGbp8W4Cee+ZIYTrgh9smg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711575091; c=relaxed/simple;
	bh=G1xjtCwsE5TyJpVtDYihKDzXG3ZXcnzrS1aBTofQBcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mHVjyS/Mkf0ZJYEyPAAKY+b1aaJjKawPO5rpdLQm8ScQx7BECw4saGro46Ii4xnt68QPNwJ2fDK7taCag89Ka4hrPZ/93hp/hGxq+Yd27LiQk8NbIOEKhv+ggG2JmkUPU18VYgY8fhtvZ0qvKegailGuK7ZoejlXfETkcxP8gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VJ9tFCuE; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so318515276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Mar 2024 14:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711575088; x=1712179888; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j1WkldVevb55Hs0T4InQAALOIu6zVUWaR4B4A3EAoAg=;
        b=VJ9tFCuE6SHosieGf6Y797K3Msd0s+1vEvqUMM24r+awggGQWVfpoEP/Kg8EFOy6a1
         qM4kampCUfCBs7o4XHeVQM9+vUHselrR6QsQo44ReI13NEacHu2cetVN7pLiXr0ru+fq
         W6na2bw7UmrorRri4Y49lEQf99EsujLOEEcXV1pi7Ju5GdmaRcMIYNpzkOlu1VSxGXWl
         3EFEA1ie57jR3gICJBVLZK/x1t2xFwrSy3WBYBaRYn2y2/gsTHMS4BJpESsGgiVeJpr0
         7x2ubR+GpKXSEBSPujU/3R5xP8ClAmcgH++sH+jLy/sp4ZKrdzxFc/adJVxGPtDomZDh
         WUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711575088; x=1712179888;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j1WkldVevb55Hs0T4InQAALOIu6zVUWaR4B4A3EAoAg=;
        b=v3rMvZU1uhLoM78guzRQMLgI00MV+QoasCPYhsoFpzkYums8maTsh67kYyLZPFn8Nr
         BUX9GCYVMIGvYzD1ctqOs9QKG4djS+smjXXKZb1FjLBkKkxI3t75amDeGGrMjRUJetM2
         X/A+3SXvMLlLj+E6KjsCO4OoifzePYb/A/4qk2T+AY6M4+vQwEdN+RZ5vAHtzE3JriiW
         pyd5P/WCNUPH627F1nuwSsfnvsgQAfAKLFLm8F0KVRDsJ/BQus5OHDMHmfUjO4kgYVZk
         oD80/M43THWIfyGFVVXZX/XUd7uVwH8BVeCIVw/foq3W/B53qBAuDudb1K89D6pZTdXG
         l0SA==
X-Forwarded-Encrypted: i=1; AJvYcCV2+ORoeh99+Up9yPEssnruho30gwwQ7lmHIGUWsg3TQYcyS2s3ZUEfIRLD6EDH+hkiCYFhOsNmiQf7E/cENUKlp3vMs9aPVeJLw8NC2pFc
X-Gm-Message-State: AOJu0YyFFQRwiisViKELtbiSdMrvhkrOgUfyhncJS5X9WNDph21FGbo3
	+TYfiDqZdgeDeqe5OzzH1HkVlXayeF1gDXu0eI0eb3sIAuSBdulX1psIqaHv0qX3phYGCuA/ukT
	rRYYb2Q==
X-Google-Smtp-Source: AGHT+IEadIRNrv0swKBdpi8F8A66pEpu8qyXv3IJO389bzVqRmj7ZSDORZJUPOnrxxSqDEOUJMJJc78lWKDl
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:6df3:ef42:a58e:a6b1])
 (user=yuanchu job=sendgmr) by 2002:a05:6902:1145:b0:dce:5218:c89b with SMTP
 id p5-20020a056902114500b00dce5218c89bmr119024ybu.5.1711575087927; Wed, 27
 Mar 2024 14:31:27 -0700 (PDT)
Date: Wed, 27 Mar 2024 14:30:59 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327213108.2384666-1-yuanchu@google.com>
Subject: [RFC PATCH v3 0/8] mm: workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>
Cc: Wei Xu <weixugc@google.com>, David Rientjes <rientjes@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
	Yosry Ahmed <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yuanchu Xie <yuanchu@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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
For data center machines, workingset information allows the job scheduler
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
much, workingset reporting enables the policy to be more accurate and
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

--
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

Yuanchu Xie (8):
  mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
  mm: aggregate working set information into histograms
  mm: use refresh interval to rate-limit workingset report aggregation
  mm: report workingset during memory pressure driven scanning
  mm: extend working set reporting to memcgs
  mm: add per-memcg reaccess histogram
  mm: add kernel aging thread for workingset reporting
  mm: test system-wide workingset reporting

 drivers/base/node.c                           |   3 +
 include/linux/memcontrol.h                    |   5 +
 include/linux/mmzone.h                        |   4 +
 include/linux/workingset_report.h             | 107 +++
 mm/Kconfig                                    |  15 +
 mm/Makefile                                   |   2 +
 mm/internal.h                                 |  45 ++
 mm/memcontrol.c                               | 386 ++++++++-
 mm/mmzone.c                                   |   2 +
 mm/vmscan.c                                   |  95 ++-
 mm/workingset.c                               |   9 +-
 mm/workingset_report.c                        | 757 ++++++++++++++++++
 mm/workingset_report_aging.c                  | 127 +++
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 .../testing/selftests/mm/workingset_report.c  | 315 ++++++++
 .../testing/selftests/mm/workingset_report.h  |  37 +
 .../selftests/mm/workingset_report_test.c     | 328 ++++++++
 18 files changed, 2231 insertions(+), 10 deletions(-)
 create mode 100644 include/linux/workingset_report.h
 create mode 100644 mm/workingset_report.c
 create mode 100644 mm/workingset_report_aging.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.h
 create mode 100644 tools/testing/selftests/mm/workingset_report_test.c

-- 
2.44.0.396.g6e790dbe36-goog


