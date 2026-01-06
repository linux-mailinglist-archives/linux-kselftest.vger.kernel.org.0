Return-Path: <linux-kselftest+bounces-48316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF8BCF9800
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 18:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B7A7302353D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 17:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2BD289376;
	Tue,  6 Jan 2026 17:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ndIwL2ut"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DA19258E
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767718811; cv=none; b=OaYxBUK4Tt1fJr/in36+13i2r2vygXCqChWa5Yw1DMNwoJtO+XfXuw/Bu0yqSgS8LLVJ2GsZjzngqpahVuVrOHTCJFPers0o9oGrp2BSb1xDXZKOvVyEP8UVhnv9+QvOX082DP1QWF7095p6rPek3V3TAenzcOJkg8/5eg1mubk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767718811; c=relaxed/simple;
	bh=ed6J4D+h4aAzS3v0l3t0IYccwfe7jU9Ro84by4sLbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UbRLwbeuW/uik6hF57fiJ/nNutWS+0sIxVhyLMEKS3SKjdYp2G1xTidpiSquc/MrRpo9SYE0MNZQYKqFgsbN1rS0Rsa/90eCgNYbZkw4XZ93N2D9oGu7RmtaKXDLsXEJCds5lvH75CNndkFI0w1mslvKuGX+cLfKAP6SgxidZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ndIwL2ut; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767718794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OEOvyGDso56BwexNC9olhG5cNctIEBpuqHitobdOpOQ=;
	b=ndIwL2utog3RcHO5x+wROXXc7GTD+/LwKd86lX+sLm8O4Kp2V34h8kW2TalWL5iaN/vnxX
	k8KvTxMSWTkpYNR02nx7rhCmu6NIkr4UBxQi+wX5XUgl7PjBTxOyvIji9ih4MjaFQpRPDq
	YAuTDNwwbWtutAQicv+3wuE0XlPCnOM=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Christian Brauner <brauner@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Seth Forshee <sforshee@kernel.org>,
	Yuichiro Tsuji <yuichtsu@amazon.com>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Rong Tao <rongtao@cestc.cn>,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v4 0/9] bpf: Extend bpf syscall with common attributes support
Date: Wed,  7 Jan 2026 00:58:58 +0800
Message-ID: <20260106165907.53631-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch series builds upon the discussion in
"[PATCH bpf-next v4 0/4] bpf: Improve error reporting for freplace attachment failure" [1].

This patch series introduces support for *common attributes* in the BPF
syscall, providing a unified mechanism for passing shared metadata across
all BPF commands.

The initial set of common attributes includes:

1. 'log_buf': User-provided buffer for storing log output.
2. 'log_size': Size of the provided log buffer.
3. 'log_level': Verbosity level for logging.
4. 'log_true_size': The size of log reported by kernel.

With this extension, the BPF syscall will be able to return meaningful
error messages (e.g., failures of creating map), improving debuggability
and user experience.

Changes:
RFC v3 -> v4:
* Drop RFC.
* Address comments from Andrii:
  * Add parentheses in 'sys_bpf_ext()'.
  * Avoid creating new fd in 'probe_sys_bpf_ext()'.
  * Add a new struct to wrap log fields in libbpf.
* Address comments from Alexei:
  * Do not skip writing to user space when log_true_size is zero.
  * Do not use 'bool' arguments.
  * Drop the adding WARN_ON_ONCE()'s.

RFC v2 -> RFC v3:
* Rename probe_sys_bpf_extended to probe_sys_bpf_ext.
* Refactor reporting 'log_true_size' for prog_load.
* Refactor reporting 'btf_log_true_size' for btf_load.
* Add warnings for internal bugs in map_create.
* Check log_true_size in test cases.
* Address comment from Alexei:
  * Change kvzalloc/kvfree to kzalloc/kfree.
* Address comments from Andrii:
  * Move BPF_COMMON_ATTRS to 'enum bpf_cmd' alongside brief comment.
  * Add bpf_check_uarg_tail_zero() for extra checks.
  * Rename sys_bpf_extended to sys_bpf_ext.
  * Rename sys_bpf_fd_extended to sys_bpf_ext_fd.
  * Probe the new feature using NULL and -EFAULT.
  * Move probe_sys_bpf_ext to libbpf_internal.h and drop LIBBPF_API.
  * Return -EUSERS when log attrs are conflict between bpf_attr and
    bpf_common_attr.
  * Avoid touching bpf_vlog_init().
  * Update the reason messages in map_create.
  * Finalize the log using __cleanup().
  * Report log size to users.
  * Change type of log_buf from '__u64' to 'const char *' and cast type
    using ptr_to_u64() in bpf_map_create().
  * Do not return -EOPNOTSUPP when kernel doesn't support this feature
    in bpf_map_create().
  * Add log_level support for map creation for consistency.
* Address comment from Eduard:
  * Use common_attrs->log_level instead of BPF_LOG_FIXED.

RFC v1 -> RFC v2:
* Fix build error reported by test bot.
* Address comments from Alexei:
  * Drop new uapi for freplace.
  * Add common attributes support for prog_load and btf_load.
  * Add common attributes support for map_create.

Links:
[1] https://lore.kernel.org/bpf/20250224153352.64689-1-leon.hwang@linux.dev/

Leon Hwang (9):
  bpf: Extend bpf syscall with common attributes support
  libbpf: Add support for extended bpf syscall
  bpf: Refactor reporting log_true_size for prog_load
  bpf: Add common attr support for prog_load
  bpf: Refactor reporting btf_log_true_size for btf_load
  bpf: Add common attr support for btf_load
  bpf: Add common attr support for map_create
  libbpf: Add common attr support for map_create
  selftests/bpf: Add tests to verify map create failure log

 include/linux/bpf.h                           |   2 +-
 include/linux/btf.h                           |   2 +-
 include/linux/syscalls.h                      |   3 +-
 include/uapi/linux/bpf.h                      |   8 +
 kernel/bpf/btf.c                              |  25 +-
 kernel/bpf/syscall.c                          | 223 ++++++++++++++++--
 kernel/bpf/verifier.c                         |  12 +-
 tools/include/uapi/linux/bpf.h                |   8 +
 tools/lib/bpf/bpf.c                           |  49 +++-
 tools/lib/bpf/bpf.h                           |  17 +-
 tools/lib/bpf/features.c                      |   8 +
 tools/lib/bpf/libbpf_internal.h               |   3 +
 .../selftests/bpf/prog_tests/map_init.c       | 143 +++++++++++
 13 files changed, 448 insertions(+), 55 deletions(-)

--
2.52.0


