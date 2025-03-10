Return-Path: <linux-kselftest+bounces-28674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38017A5A6E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 23:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE7518931ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 22:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F991E5B63;
	Mon, 10 Mar 2025 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NV4OumkG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DAE36B;
	Mon, 10 Mar 2025 22:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645077; cv=none; b=PjOJByNgEXZenXvODXlIzvtzwfCaHGIdf8tqJmBVhJ/E81mcBkeBEn6cWpsmZx5Q77P/kcOpXol6cp1JtKZiBwzUY408AC4PW38mVZnGQCb7XZhhFDPDZfzD9FnKz7FPtJnEbZ4rlNALg8guowEMv9hZ8gSHKvd/x9kzZRko4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645077; c=relaxed/simple;
	bh=1gJ8Px/hXdYSeOk/2qSjeq5whelRrLVeV0FCdhmv5dI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s8QFb62g2Je7CmUnbROAD7LcPjlu6q9k4z0dD7FI84Ux0/5G0WndPFRt07QE4cdT7m1y6w4fxHOzswkrI4Nuy8LeDNkorl8O6uHXjLDF0V0R0cMkTjreoHb8xJxhkecU+wg3v3TXitcmf6gGuxYCiBNmQH49K1ihx1629Yi8LwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NV4OumkG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id E638F205492E;
	Mon, 10 Mar 2025 15:17:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E638F205492E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741645075;
	bh=S/hVMZ/Tm5pXhLhAqS9Ia0x+kWvutUUZYfnhEAxVL54=;
	h=From:To:Subject:Date:From;
	b=NV4OumkGGIKHmOv4uU63g9E6HukS9pYi5qYcIRCL554+GWmkSS2gA40WRj1GGphNh
	 UyYTAkuW3vAukLpALywFGBDNicIYDKk8XPhDJtbg+CLVFD5PDLR4P6g8x5PtAOcBod
	 91r+sbc8pgOVmlUyLd9YtnzbvurGHmSTp5YzXYEo=
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
Subject: [PATCH v7 bpf-next 0/2] security: Propagate caller information in bpf hooks
Date: Mon, 10 Mar 2025 15:17:10 -0700
Message-ID: <20250310221737.821889-1-bboscaccy@linux.microsoft.com>
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
- v6 -> v7
  - use gettid/pid in lieu of getpid/tgid in test condition
- v5 -> v6
  - fix regression caused by is_kernel renaming
  - simplify test logic
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
- v6
  https://lore.kernel.org/bpf/20250308013314.719150-1-bboscaccy@linux.microsoft.com/
- v5
  https://lore.kernel.org/bpf/20250307213651.3065714-1-bboscaccy@linux.microsoft.com/
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
 .../selftests/bpf/progs/test_kernel_flag.c    | 28 ++++++++++++
 .../bpf/progs/test_kfunc_dynptr_param.c       |  6 +--
 .../selftests/bpf/progs/test_lookup_key.c     |  2 +-
 .../selftests/bpf/progs/test_ptr_untrusted.c  |  2 +-
 .../bpf/progs/test_task_under_cgroup.c        |  2 +-
 .../bpf/progs/test_verify_pkcs7_sig.c         |  2 +-
 14 files changed, 108 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag.c

-- 
2.48.1


