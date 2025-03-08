Return-Path: <linux-kselftest+bounces-28530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C84A5773D
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 02:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF193ACDBD
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 01:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD19D4EB38;
	Sat,  8 Mar 2025 01:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kjGOAZKs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66AB918E1F;
	Sat,  8 Mar 2025 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397620; cv=none; b=Ibt4zQZTjbeZgO6MTFu9BOr3FPBllyEIcvKkk4uj/xmb3Gv+aGf3moLIzu4MzXQtVlLnzFbl4DCZR8KjJR4uCgjeyNu44eeTvOCeIc5Pw7ekivIHIJ4MMYsNRQ7oF8lHFSFjQEx7kfTDM2/4/9uljRYqtue0BEUSafbeztuuE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397620; c=relaxed/simple;
	bh=9Tu9MNQ20MU9ryHQ+lzeNvmDACUzqpt87yCnr9vd2Wg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZNdWWrBMeEmcus77DpgJWYCf18UImkKh2IwKLfRyvAXZhwGNYBVbWTOFadcYee0gUjzDYRn12Tuvw2Y+VRQEny7LuM7dZH01C5e7jqs3+dz03ahHAt1LHhfMg5uIeO9RkXGp6Nloc6inNQyrZnYjiU/jIhddUzC4eMYV6StSySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kjGOAZKs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3444C2038F3E;
	Fri,  7 Mar 2025 17:33:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3444C2038F3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741397618;
	bh=qd4Osz5w4VvQO7bT3fnJ0XRzQh4tZmm42Ehz0azZH48=;
	h=From:To:Subject:Date:From;
	b=kjGOAZKs2Jospm+WhQ8/bQdNPIfkdKq/X17vBZv6hFbhEU9P5VtdTBuRStO8+35EE
	 GgeaKMtLL8DyJxNKMVNZNsXZtyne+3j0eQFs5HfGef7WpHplKasI4O6M+7zF5dRbq0
	 RYhmJZs5AlHfp3KlDgHhnpkNYWLVtxu+AeA045Eg=
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
Subject: [PATCH v6 bpf-next 0/2] security: Propagate caller information in bpf hooks
Date: Fri,  7 Mar 2025 17:32:33 -0800
Message-ID: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
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


