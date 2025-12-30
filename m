Return-Path: <linux-kselftest+bounces-48000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20119CE89B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 04:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD560300EE7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 03:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1F288D6;
	Tue, 30 Dec 2025 03:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdVuWYHU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE9EEC0
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Dec 2025 03:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767063773; cv=none; b=nP6KhSKLMRikasSDkcx1IAgqapqg/QmP1z3l2BD/rKiEVI5VYkjFAKUoz4eOSbffE6HGaK5eIQhgoFPemf0kTJjFWsXdkbVdtjgwiqA4TKJhdTu4Eof5o2EPs3j5kYrv/wo1MkYuszQc/ZZeaBk7Hu2Qi9YfAp3a+328O52n02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767063773; c=relaxed/simple;
	bh=SZuLog+8zVtTBnqpgJMZKh/MPhflPf1t+4j6HdwPIsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bygDKJ8KMHMGt/iRFVQnm5hQm+k+jID7Ctt0hM7BC/4tolsqyZqpnvkaUhRxwOiEYDwF5S/2NteJfUywXJpJMUpdZFjLRfEfTWw1RsZLIoRFlhUk0lKLNO7ZNe68LiygKhUWB9y72215S98IJ6KUBNp3mAnztsHKKBpKa3fKQcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdVuWYHU; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767063766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pqmSOMk9I68wh+LqBe0FNnFTYilwTyQt9JRYBSNWNew=;
	b=MdVuWYHUfUZCtXsZAm8CRBrdIlaKOT4mDyDHc51JD6524QDnJeyfeqkA3Zf2SZG1UtScCq
	Bxxm34bHC5rkGc6V2irbKX8oxW37xLEQx/2Dm5juxHCbnGCgnSsflj/kfmthSa/qCCZ0KC
	kikuQG26m+J2OfUehSfDfBIp3vOEGuI=
From: Hui Zhu <hui.zhu@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [RFC PATCH v2 0/3] Memory Controller eBPF support
Date: Tue, 30 Dec 2025 11:01:58 +0800
Message-ID: <cover.1767012332.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This series adds BPF struct_ops support to the memory controller,
enabling dynamic control over memory pressure through the
memcg_nr_pages_over_high mechanism. This allows administrators to
suppress low-priority cgroups' memory usage based on custom
policies implemented in BPF programs.

Background and Motivation

The memory controller provides memory.high limits to throttle
cgroups exceeding their soft limit. However, the current
implementation applies the same policy across all cgroups
without considering priority or workload characteristics.

This series introduces a BPF hook that allows reporting
additional "pages over high" for specific cgroups, effectively
increasing memory pressure and throttling for lower-priority
workloads when higher-priority cgroups need resources.

Use Case: Priority-Based Memory Management

Consider a system running both latency-sensitive services and
batch processing workloads. When the high-priority service
experiences memory pressure (detected via page scan events),
the BPF program can artificially inflate the "over high" count
for low-priority cgroups, causing them to be throttled more
aggressively and freeing up memory for the critical workload.

Implementation

This series builds upon Roman Gushchin's BPF OOM patch series in [1].

The implementation adds:
1. A memcg_bpf_ops struct_ops type with memcg_nr_pages_over_high
   hook
2. Integration into memory pressure calculation paths
3. Cgroup hierarchy management (inheritance during online/offline)
4. SRCU protection for safe concurrent access

Why Not PSI?

This implementation does not use PSI for triggering, as discussed
in [2].
Instead, the sample code monitors PGSCAN events via tracepoints,
which provides more direct feedback on memory pressure.

Example Results

Testing on x86_64 QEMU (10 CPU, 4GB RAM, cache=none swap):
root@ubuntu:~# cat /proc/sys/vm/swappiness
60
root@ubuntu:~# mkdir /sys/fs/cgroup/high
root@ubuntu:~# mkdir /sys/fs/cgroup/low
root@ubuntu:~# ./memcg /sys/fs/cgroup/low /sys/fs/cgroup/high 100 1024
Successfully attached!
root@ubuntu:~# cgexec -g memory:low stress-ng --vm 4 --vm-keep --vm-bytes 80% \
--vm-method all --seed 2025 --metrics -t 60 \
& cgexec -g memory:high stress-ng --vm 4 --vm-keep --vm-bytes 80% \
--vm-method all --seed 2025 --metrics -t 60
[1] 1075
stress-ng: info:  [1075] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1076] setting to a 1 min, 0 secs run per stressor
stress-ng: info:  [1075] dispatching hogs: 4 vm
stress-ng: info:  [1076] dispatching hogs: 4 vm
stress-ng: metrc: [1076] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1076]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1076] vm             21033377     60.47    158.04      3.66    347825.55      130076.67        66.85        834836
stress-ng: info:  [1076] skipped: 0
stress-ng: info:  [1076] passed: 4: vm (4)
stress-ng: info:  [1076] failed: 0
stress-ng: info:  [1076] metrics untrustworthy: 0
stress-ng: info:  [1076] successful run completed in 1 min, 0.72 secs
root@ubuntu:~# stress-ng: metrc: [1075] stressor       bogo ops real time  usr time  sys time   bogo ops/s     bogo ops/s CPU used per       RSS Max
stress-ng: metrc: [1075]                           (secs)    (secs)    (secs)   (real time) (usr+sys time) instance (%)          (KB)
stress-ng: metrc: [1075] vm                11568     65.05      0.00      0.21       177.83       56123.74         0.08          3200
stress-ng: info:  [1075] skipped: 0
stress-ng: info:  [1075] passed: 4: vm (4)
stress-ng: info:  [1075] failed: 0
stress-ng: info:  [1075] metrics untrustworthy: 0
stress-ng: info:  [1075] successful run completed in 1 min, 5.06 secs

Results show the low-priority cgroup (/sys/fs/cgroup/low) was
significantly throttled:
- High-priority cgroup: 21,033,377 bogo ops at 347,825 ops/s
- Low-priority cgroup: 11,568 bogo ops at 177 ops/s

The stress-ng process in the low-priority cgroup experienced a
~99.9% slowdown in memory operations compared to the
high-priority cgroup, demonstrating effective priority
enforcement through BPF-controlled memory pressure.

Patch Overview

PATCH 1/3: Core kernel implementation
  - Adds memcg_bpf_ops struct_ops support
  - Implements cgroup lifecycle management
  - Integrates hook into pressure calculation

PATCH 2/3: Selftest suite
  - Validates attach/detach behavior
  - Tests hierarchy inheritance
  - Verifies throttling effectiveness

PATCH 3/3: Sample programs
  - Demonstrates PGSCAN-based triggering
  - Shows priority-based throttling
  - Provides reference implementation

Changelog:
v2:
According to the comments of Tejun Heo, rebased on Roman Gushchin's BPF
OOM patch series [1] and added hierarchical delegation support.
According to the comments of Roman Gushchin and Michal Hocko, Designed
concrete use case scenarios and provided test results.

[1] https://lore.kernel.org/lkml/20251027231727.472628-1-roman.gushchin@linux.dev/
[2] https://lore.kernel.org/lkml/1d9a162605a3f32ac215430131f7745488deaa34@linux.dev/

Hui Zhu (3):
  mm: memcontrol: Add BPF struct_ops for memory  pressure control
  selftests/bpf: Add tests for memcg_bpf_ops
  samples/bpf: Add memcg priority control example

 MAINTAINERS                                   |   5 +
 include/linux/memcontrol.h                    |   2 +
 mm/bpf_memcontrol.c                           | 241 ++++++++++++-
 mm/bpf_memcontrol.h                           |  73 ++++
 mm/memcontrol.c                               |  27 +-
 samples/bpf/.gitignore                        |   1 +
 samples/bpf/Makefile                          |   9 +-
 samples/bpf/memcg.bpf.c                       |  95 +++++
 samples/bpf/memcg.c                           | 204 +++++++++++
 .../selftests/bpf/prog_tests/memcg_ops.c      | 340 ++++++++++++++++++
 .../selftests/bpf/progs/memcg_ops_over_high.c |  95 +++++
 11 files changed, 1082 insertions(+), 10 deletions(-)
 create mode 100644 mm/bpf_memcontrol.h
 create mode 100644 samples/bpf/memcg.bpf.c
 create mode 100644 samples/bpf/memcg.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops_over_high.c

-- 
2.43.0


