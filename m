Return-Path: <linux-kselftest+bounces-45939-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 051FDC6C429
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 02:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A3D6B35CBA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 01:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6752C2512DE;
	Wed, 19 Nov 2025 01:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wcb6zxRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE1C24886E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 01:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763516104; cv=none; b=udeB+R7dVSZKE4JaqIpG+jXmijXBULo0ueHRCDxdCLyB3x37cjt/boc+0X3eJL05MRgv7seXxrf+v+K5YxwRowxSyP6NW3IzPIYRKmiTVyrQldbHIBJcCNC+PZwj3IGKuCSCSddWPE6dlsKG3yX+3aBV4ghBIgF75MN/erD1cuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763516104; c=relaxed/simple;
	bh=CiQKBJl4/m9pEbLGKBsYnyhtXzDO2PTe408naUKLZXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKeFZlBHJ28+Ws152o4oUgOKf99q6LjIzbJKSyrjZmqY+gxz0nreTh6XsHX2Wj/w//sLXDbv9edZ3Yagw1AAvbVeC/+N26+biTSfl4oQLuKS6C4oZTQ6mPoq74oR5dJc+Do1PyidwyBQORujS+M1t0aRLsM2hsGLxU7pVdxlKW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wcb6zxRs; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763516090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e2EGDBgBbdB4DgQO2TbLGho5UNAFXwK5TbGKkRJZcyU=;
	b=wcb6zxRs7rat5F88XagPhY4x0Gw6BsMRBqudFzDvtr+kZdAQ0HdzJZFIb28U+8FqJ1g6fk
	PCpOQ+BrIEmrHEjQWL0JuK73P4sDppwutql3YXl4jyMJ4V/mBADmnshAVBNvNgRBojSew9
	Tt1POrat12cH3TSDmK+a4CnxIQdAPgU=
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
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Hui Zhu <zhuhui@kylinos.cn>
Subject: [RFC PATCH 0/3] Memory Controller eBPF support
Date: Wed, 19 Nov 2025 09:34:05 +0800
Message-ID: <cover.1763457705.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hui Zhu <zhuhui@kylinos.cn>

This series proposes adding eBPF support to the Linux memory
controller, enabling dynamic and extensible memory management
policies at runtime.

Background

The memory controller (memcg) currently provides fixed memory
accounting and reclamation policies through static kernel code.
This limits flexibility for specialized workloads and use cases
that require custom memory management strategies.

By enabling eBPF programs to hook into key memory control
operations, administrators can implement custom policies without
recompiling the kernel, while maintaining the safety guarantees
provided by the BPF verifier.

Use Cases

1. Custom memory reclamation strategies for specialized workloads
2. Dynamic memory pressure monitoring and telemetry
3. Memory accounting adjustments based on runtime conditions
4. Integration with container orchestration systems for
   intelligent resource management
5. Research and experimentation with novel memory management
   algorithms

Design Overview

This series introduces:

1. A new BPF struct ops type (`memcg_ops`) that allows eBPF
   programs to implement custom behavior for memory charging
   operations.

2. A hook point in the `try_charge_memcg()` fast path that
   invokes registered eBPF programs to determine if custom
   memory management should be applied.

3. The eBPF handler can inspect memory cgroup context and
   optionally modify certain parameters (e.g., `nr_pages` for
   reclamation size).

4. A reference counting mechanism using `percpu_ref` to safely
   manage the lifecycle of registered eBPF struct ops instances.

5. Configuration via `CONFIG_MEMCG_BPF` to allow disabling this
   feature at build time.

Implementation Details

- Uses BPF struct ops for a cleaner integration model
- Leverages static branch keys for minimal overhead when feature
  is unused
- RCU synchronization ensures safe replacement of handlers
- Sample eBPF program demonstrates monitoring capabilities
- Comprehensive selftest suite validates core functionality

Performance Considerations

- Zero overhead when feature is disabled or no eBPF program is
  loaded (static branch is disabled)
- Minimal overhead when enabled: one indirect function call per
  charge attempt
- eBPF programs run under the restrictions of the BPF verifier

Patch Overview

PATCH 1/3: Core kernel implementation
  - Adds eBPF struct ops support to memcg
  - Introduces CONFIG_MEMCG_BPF option
  - Implements safe registration/unregistration mechanism

PATCH 2/3: Selftest suite
  - prog_tests/memcg_ops.c: Test entry points
  - progs/memcg_ops.bpf.c: Test eBPF program
  - Validates load, attach, and single-handler constraints

PATCH 3/3: Sample userspace program
  - samples/bpf/memcg_printk.bpf.c: Monitoring eBPF program
  - samples/bpf/memcg_printk.c: Userspace loader
  - Demonstrates real-world usage and debugging capabilities

Open Questions & Discussion Points

1. Should the eBPF handler have access to additional memory
   cgroup state? Current design exposes minimal context to
   reduce attack surface.

2. Are there other memory control operations that would benefit
   from eBPF extensibility (e.g., uncharge, reclaim)?

3. Should there be permission checks or restrictions on who can
   load memcg eBPF programs? Currently inherits BPF's
   CAP_PERFMON/CAP_SYS_ADMIN requirements.

4. How should we handle multiple eBPF programs trying to
   register? Current implementation allows only one active
   handler.

5. Is the current exposed context in `try_charge_memcg` struct
   sufficient, or should additional fields be added?

Testing

The selftests provide comprehensive coverage of the core
functionality. The sample program can be used for manual
testing and as a reference for implementing additional
monitoring tools.

Hui Zhu (3):
  memcg: add eBPF struct ops support for memory charging
  selftests/bpf: add memcg eBPF struct ops test
  samples/bpf: add example memcg eBPF program

 MAINTAINERS                                   |   5 +
 init/Kconfig                                  |  38 ++++
 mm/Makefile                                   |   1 +
 mm/memcontrol.c                               |  26 ++-
 mm/memcontrol_bpf.c                           | 200 ++++++++++++++++++
 mm/memcontrol_bpf.h                           | 103 +++++++++
 samples/bpf/Makefile                          |   2 +
 samples/bpf/memcg_printk.bpf.c                |  30 +++
 samples/bpf/memcg_printk.c                    |  82 +++++++
 .../selftests/bpf/prog_tests/memcg_ops.c      | 117 ++++++++++
 tools/testing/selftests/bpf/progs/memcg_ops.c |  20 ++
 11 files changed, 617 insertions(+), 7 deletions(-)
 create mode 100644 mm/memcontrol_bpf.c
 create mode 100644 mm/memcontrol_bpf.h
 create mode 100644 samples/bpf/memcg_printk.bpf.c
 create mode 100644 samples/bpf/memcg_printk.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/memcg_ops.c
 create mode 100644 tools/testing/selftests/bpf/progs/memcg_ops.c

-- 
2.43.0


