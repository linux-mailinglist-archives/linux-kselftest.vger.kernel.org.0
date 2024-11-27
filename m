Return-Path: <linux-kselftest+bounces-22546-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A79DA0C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 03:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB57168316
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Nov 2024 02:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F672558A5;
	Wed, 27 Nov 2024 02:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKgpeksc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F32481CD
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Nov 2024 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732676265; cv=none; b=Yh1D2K0ww6Tv6Xs2lSF86aBT7/8RabAWkQ0oJXouvq3mBsLiI6gl2f5CjIm3+oka1XxoE+VffCpBFFzZx0DNDmpwiiJdB3eBfbgnvzXtEqZ71basNTigPqb3LpCc7O/qFs26EbbFGg1ba2XWjiKnloZWW+6gA3PNL2tIEWQzXNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732676265; c=relaxed/simple;
	bh=J+/Huvhsfc118Oam0hQkPuciIgmlsWd1BaZaWzY7JbY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PPwZpm3DPT6+AmtS5roRlsJ57O0Qca9mw/XF1UJvTGrqgtyFwWmPG3NTT5PgJvAwYSd87qlxXzbq/3cKpLcleeo9rULjF8Y5eYBtNEozVh5OCv7Q5sBM+r5TGxdtI4S3mhPSrQGH20Gg/Y8dCvIDdUTJ0pV3GK+rdZrjKIVW39k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKgpeksc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2e9ff7aa7eeso333215a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Nov 2024 18:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732676263; x=1733281063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DOATy7sDz8DTD8Z4AoICwdWQAcaTwjKHPvi099XhNks=;
        b=rKgpekscPgzpKvPNYH3RzuTc/3KJlpPog9hPHb5CB8AW+dkC1UddH1tvpDl+qNztnp
         u8VoN8tOgVP06ODc68wYc3Us3pMSYKKYUjXqyygKniKo1PKjyZS/9IhQ9TN/8f9BqXuB
         8pxX3cpBuKwVDNhV500Nvb1YcUh6D318AoPeqz60Z9Md/4iV4OofTMjcjfVrT2XBzzW0
         KT0SxX0sCeyzijlQvfFleuTestkwGPFQeToO7zuYDv9w6cqYnm+BYkGz76mYLcc1pcKy
         5r+P+zulMOWQuLLU3i0o+TgDBmOvng1Ob8Vz80eBwQmH4dRyoLDobLx9x3PsMKIIDVZQ
         bLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732676263; x=1733281063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DOATy7sDz8DTD8Z4AoICwdWQAcaTwjKHPvi099XhNks=;
        b=lteNeH6F2YUWxmaF5DhDlx8JXXL+1SC0UCs3iTzEzCtBahye01/suMg5nDPGa6ttWg
         5m/fem18LI5CI/F2JG029/pl2ct19dwhhJkPKuZdRRR7xK3tjtF7KNfasSZWbBL74MRx
         4QdJ/n6KEUyGjtmF33MVxDMeTJaAAWym15lG9/PQenZlpHaNsMRBCzYa6JLsAPjAghnE
         SHAHXIiYEAqjP5q83zUez7GiH21AFGlstTaVLxo1fmWe0tEXxp2cFh37HTKgEUe+UYbq
         kxYOsCrJP74KsXfjlX4g00mQPQQLjuh4SOU+w5kDEu4dJ/g2b5DPxysurg/HiZh4FSZ/
         p3Yw==
X-Forwarded-Encrypted: i=1; AJvYcCWwm11el7rgtq1QYS8vlgSJtzQPRSwfUW+dyz+MDti57bWa2ZnQ2h57pfhc/LFEqfUAjKkGfe3UWlaDq28GZHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEr3Hn/fxpiAxFC8dQycDghHjpgu4DbhLYeXZgg+DUGwBzfSh4
	8vuTlDUA2/oFnEpMg6fqaFXbEenDjcvU99Dku4d16hH+1j5gN5i/tm0hy0ncLD+NosH3CrbSlOK
	l9vOH5Q==
X-Google-Smtp-Source: AGHT+IGwtdBa6yhIuRJSWPEXoNp2VYNlKPrafpXUgul1cMSxbPMT+mgSuRvlqTMnr3isKES25GDLRo275izi
X-Received: from pjbnd9.prod.google.com ([2002:a17:90b:4cc9:b0:2ea:5fc2:b503])
 (user=yuanchu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1004:b0:2ea:9f3a:7d9
 with SMTP id 98e67ed59e1d1-2edeb68cff8mr8628929a91.3.1732676262751; Tue, 26
 Nov 2024 18:57:42 -0800 (PST)
Date: Tue, 26 Nov 2024 18:57:19 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127025728.3689245-1-yuanchu@google.com>
Subject: [PATCH v4 0/9] mm: workingset reporting
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, 
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, 
	Dan Williams <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>, 
	Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Daniel Watson <ozzloy@each.do>, Yuanchu Xie <yuanchu@google.com>, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This patch series provides workingset reporting of user pages in
lruvecs, of which coldness can be tracked by accessed bits and fd
references. However, the concept of workingset applies generically to
all types of memory, which could be kernel slab caches, discardable
userspace caches (databases), or CXL.mem. Therefore, data sources might
come from slab shrinkers, device drivers, or the userspace.
Another interesting idea might be hugepage workingset, so that we can
measure the proportion of hugepages backing cold memory. However, with
architectures like arm, there may be too many hugepage sizes leading to
a combinatorial explosion when exporting stats to the userspace.
Nonetheless, the kernel should provide a set of workingset interfaces
that is generic enough to accommodate the various use cases, and extensible
to potential future use cases.

Use cases
==========
Job scheduling
On overcommitted hosts, workingset information improves efficiency and
reliability by allowing the job scheduler to have better stats on the
exact memory requirements of each job. This can manifest in efficiency by
landing more jobs on the same host or NUMA node. On the other hand, the
job scheduler can also ensure each node has a sufficient amount of memory
and does not enter direct reclaim or the kernel OOM path. With workingset
information and job priority, the userspace OOM killing or proactive
reclaim policy can kick in before the system is under memory pressure.
If the job shape is very different from the machine shape, knowing the
workingset per-node can also help inform page allocation policies.

Proactive reclaim
Workingset information allows the a container manager to proactively
reclaim memory while not impacting a job's performance. While PSI may
provide a reactive measure of when a proactive reclaim has reclaimed too
much, workingset reporting allows the policy to be more accurate and
flexible.

Ballooning (similar to proactive reclaim)
The last patch of the series extends the virtio-balloon device to report
the guest workingset.
Balloon policies benefit from workingset to more precisely determine the
size of the memory balloon. On end-user devices where memory is scarce and
overcommitted, the balloon sizing in multiple VMs running on the same
device can be orchestrated with workingset reports from each one.
On the server side, workingset reporting allows the balloon controller to
inflate the balloon without causing too much file cache to be reclaimed in
the guest.

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

Implementation
==========
The reporting of user pages is based off of MGLRU, and therefore requires
CONFIG_LRU_GEN=y. We would benefit from more MGLRU generations for a more
fine-grained workingset report, but we can already gather a lot of data
with just four generations. The workingset reporting mechanism is gated
behind CONFIG_WORKINGSET_REPORT, and the aging thread is behind
CONFIG_WORKINGSET_REPORT_AGING.

Benchmarks
==========
Ghait Ouled Amar Ben Cheikh has implemented a simple policy and ran Linux
compile and redis benchmarks from openbenchmarking.org. The policy and
runner is referred to as WMO (Workload Memory Optimization).
The results were based on v3 of the series, but v4 doesn't change the core
of the working set reporting and just adds the ballooning counterpart.

The timed Linux kernel compilation benchmark shows improvements in peak
memory usage with a policy of "swap out all bytes colder than 10 seconds
every 40 seconds". A swapfile is configured on SSD.
--------------------------------------------
peak memory usage (with WMO): 4982.61328 MiB
peak memory usage (control): 9569.1367 MiB
peak memory reduction: 47.9%
--------------------------------------------
Benchmark                                           | Experimental     |Control         | Experimental_Std_Dev | Control_Std_Dev
Timed Linux Kernel Compilation - allmodconfig (sec) | 708.486 (95.91%) | 679.499 (100%) | 0.6%                 | 0.1%
--------------------------------------------
Seconds, fewer is better

The redis benchmark shows employs the same policy:
--------------------------------------------
peak memory usage (with WMO): 375.9023 MiB
peak memory usage (control): 509.765 MiB
peak memory reduction: 26%
--------------------------------------------
Benchmark               | Experimental     | Control          | Experimental_Std_Dev | Control_Std_Dev
Redis - LPOP (Reqs/sec) | 2023130 (98.22%) | 2059849 (100%)   | 1.2%                 | 2%
Redis - SADD (Reqs/sec) | 2539662 (98.63%) | 2574811 (100%)   | 2.3%                 | 1.4%
Redis - LPUSH (Reqs/sec)| 2024880 (100%)   | 2000884 (98.81%) | 1.1%                 | 0.8%
Redis - GET (Reqs/sec)  | 2835764 (100%)   | 2763722 (97.46%) | 2.7%                 | 1.6%
Redis - SET (Reqs/sec)  | 2340723 (100%)   | 2327372 (99.43%) | 2.4%                 | 1.8%
--------------------------------------------
Reqs/sec, more is better

The detailed report and benchmarking results are in Ghait's repo:
https://github.com/miloudi98/WMO

Changelog
==========

Changes from PATCH v3 -> v4:
- Added documentation for cgroup-v2
  (Waiman Long)
- Fixed types in documentation
  (Randy Dunlap)
- Added implementation for the ballooning use case
- Added detailed description of benchmark results
  (Andrew Morton)

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

[v1] https://lore.kernel.org/linux-mm/20240504073011.4000534-1-yuanchu@google.com/
[v2] https://lore.kernel.org/linux-mm/20240604020549.1017540-1-yuanchu@google.com/
[v3] https://lore.kernel.org/linux-mm/20240813165619.748102-1-yuanchu@google.com/

Yuanchu Xie (9):
  mm: aggregate workingset information into histograms
  mm: use refresh interval to rate-limit workingset report aggregation
  mm: report workingset during memory pressure driven scanning
  mm: extend workingset reporting to memcgs
  mm: add kernel aging thread for workingset reporting
  selftest: test system-wide workingset reporting
  Docs/admin-guide/mm/workingset_report: document sysfs and memcg
    interfaces
  Docs/admin-guide/cgroup-v2: document workingset reporting
  virtio-balloon: add workingset reporting

 Documentation/admin-guide/cgroup-v2.rst       |  35 +
 Documentation/admin-guide/mm/index.rst        |   1 +
 .../admin-guide/mm/workingset_report.rst      | 105 +++
 drivers/base/node.c                           |   6 +
 drivers/virtio/virtio_balloon.c               | 390 ++++++++++-
 include/linux/balloon_compaction.h            |   1 +
 include/linux/memcontrol.h                    |  21 +
 include/linux/mmzone.h                        |  13 +
 include/linux/workingset_report.h             | 167 +++++
 include/uapi/linux/virtio_balloon.h           |  30 +
 mm/Kconfig                                    |  15 +
 mm/Makefile                                   |   2 +
 mm/internal.h                                 |  19 +
 mm/memcontrol.c                               | 162 ++++-
 mm/mm_init.c                                  |   2 +
 mm/mmzone.c                                   |   2 +
 mm/vmscan.c                                   |  56 +-
 mm/workingset_report.c                        | 653 ++++++++++++++++++
 mm/workingset_report_aging.c                  | 127 ++++
 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   3 +
 tools/testing/selftests/mm/run_vmtests.sh     |   5 +
 .../testing/selftests/mm/workingset_report.c  | 306 ++++++++
 .../testing/selftests/mm/workingset_report.h  |  39 ++
 .../selftests/mm/workingset_report_test.c     | 330 +++++++++
 25 files changed, 2482 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/workingset_report.rst
 create mode 100644 include/linux/workingset_report.h
 create mode 100644 mm/workingset_report.c
 create mode 100644 mm/workingset_report_aging.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.c
 create mode 100644 tools/testing/selftests/mm/workingset_report.h
 create mode 100644 tools/testing/selftests/mm/workingset_report_test.c

-- 
2.47.0.338.g60cca15819-goog


