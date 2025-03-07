Return-Path: <linux-kselftest+bounces-28522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59987A573B4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A94B7A529C
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 21:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2AE2405EC;
	Fri,  7 Mar 2025 21:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fPHH+qo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA4D1AA1D9;
	Fri,  7 Mar 2025 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383438; cv=none; b=YrDlmnquCsnxjZ4nFtKt6YBj26pQ7YS4ZzLPckG31GW60MSme8s6WqOy3Y6piRfHFFCoCEUWK3cUN0CpnzGt3FMpF5lWUjHfRRlVixunvojY1f9UkLG86kzGCSxlakTVVTTzeUfnxuNuPwiKwWwJgw1rTToYtec98JMREXgz/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383438; c=relaxed/simple;
	bh=4Nj6yY1WvxCcJBZEVBCXhSDX/xVmBBxSE+1+jr324J0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YFEnzUo513ZCo2mhfaTR7745V1ajWjE4BvXhX36BB/WgdFNE3fnPlPMEuGXFCjfU+XIeR9/H4DhhrTJZbVk2J5nbGdzU8f6+s89+OXZRjZWhiaMPL/HJb+bSkXC2d2f4dUYvqvjFnYF+E/wrZD8v5z9t+HeyX7qc7Nu4IHYT1pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fPHH+qo7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 196D02038F3D;
	Fri,  7 Mar 2025 13:37:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 196D02038F3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741383436;
	bh=1hg/PAQzuwdSej1TYsws23wzW4kT1Xtx2wnLIlKe9QA=;
	h=From:To:Subject:Date:From;
	b=fPHH+qo7FpphumESlG775tO5yLowOBBtHNfR2o9E0w5rwpXgkBnVUKLeepdr0Va8r
	 APzMxJtEP062V9mYMyp9zM5gCzCh2/7okIXmHwHFklwy2yRc5hmWkRAgMzrwdXN6q0
	 s9sTPhP+6v8ZRcwsLQzjkk20c8Nx/E4vgk2fgXbE=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 bpf-next 0/2] security: Propagate caller information in bpf hooks
Date: Fri,  7 Mar 2025 13:36:37 -0800
Message-ID: <20250307213651.3065714-1-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While trying to implement an eBPF gatekeeper program, we ran into an
issue whereas the LSM hooks are missing some relevant data.

Certain subcommands passed to the bpf() syscall can be invoked from
either the kernel or userspace. Additionally, some fields in the
bpf_attr struct contain pointers, and depending on where the
subcommand was invoked, they could point to either user or kernel
memory. One example of this is the bpf_prog_load subcommand and its
fd_array. This data is made available and used by the verifier but not
made available to the LSM subsystem. This patchset simply exposes that
information to applicable LSM hooks.

Change list:
- v4 -> v5
  - merge v4 selftest breakout patch back into a single patch
  - change "is_kernel" to "kernel"
  - add selftest using new kernel flag
- v3 -> v4
  - split out selftest changes into a separate patch
- v2 -> v3
  - reorder params so that the new boolean flag is the last param
  - fixup function signatures in bpf selftests
- v1 -> v2
  - Pass a boolean flag in lieu of bpfptr_t

Revisions:
- v4
  https://lore.kernel.org/bpf/20250304203123.3935371-1-bboscaccy@linux.microsoft.com/
- v3
  https://lore.kernel.org/bpf/20250303222416.3909228-1-bboscaccy@linux.microsoft.com/
- v2
  https://lore.kernel.org/bpf/20250228165322.3121535-1-bboscaccy@linux.microsoft.com/
- v1
  https://lore.kernel.org/bpf/20250226003055.1654837-1-bboscaccy@linux.microsoft.com/


Blaise Boscaccy (2):
  security: Propagate caller information in bpf hooks
  selftests/bpf: Add a kernel flag test for LSM bpf hook

 include/linux/lsm_hook_defs.h                 |  6 +--
 include/linux/security.h                      | 12 +++---
 kernel/bpf/syscall.c                          | 10 ++---
 security/security.c                           | 15 ++++---
 security/selinux/hooks.c                      |  6 +--
 .../selftests/bpf/prog_tests/kernel_flag.c    | 43 +++++++++++++++++++
 .../selftests/bpf/progs/rcu_read_lock.c       |  3 +-
 .../bpf/progs/test_cgroup1_hierarchy.c        |  4 +-
 .../selftests/bpf/progs/test_kernel_flag.c    | 32 ++++++++++++++
 .../bpf/progs/test_kfunc_dynptr_param.c       |  6 +--
 .../selftests/bpf/progs/test_lookup_key.c     |  2 +-
 .../selftests/bpf/progs/test_ptr_untrusted.c  |  2 +-
 .../bpf/progs/test_task_under_cgroup.c        |  2 +-
 .../bpf/progs/test_verify_pkcs7_sig.c         |  2 +-
 14 files changed, 112 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag.c

-- 
2.48.1


