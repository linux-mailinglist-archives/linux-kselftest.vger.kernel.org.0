Return-Path: <linux-kselftest+bounces-39504-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA6B2FC1F
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0C4562F59
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62BB241136;
	Thu, 21 Aug 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dbT5mrcS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BF623D7D7;
	Thu, 21 Aug 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785244; cv=none; b=NSl4zq34fQyE7TgPAXEXON3UNsPEuFdFNV7xcUiFJDCpUX4rgJXwOB3nJ5ultEbXNFFrMg9d4tA9GYuYPuAxSw4Yjhu4qDWQyi5PuIpuf2L2e8+frxnUY1fY4q62PEn2F3RhXkLKTZCVpV6eSpaTLCpprDUPhJy+OA0UVXWr5f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785244; c=relaxed/simple;
	bh=E8CuBKR90SksNHxzi0U2LMFbdI4lehlJSycFjpyC6cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBgBSHr+v0CsGS+uDI03I+B8QH8o7pQbZhdJFYBCiAKeM7wYBaR8oCBTrO60lysOX42zuGq/jL1wi8HVsU77oNI93mpFyGRiJ6w5RN6s2STaHh2+rZSdb2m68+PE9ei5TZJUtWCaOlS2MFwDdQE6aY+f7CWIxmHe86t342Qeqwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dbT5mrcS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ew
	MGYbKAwNZt6zSGGhDxxrHBuD4lRwPzVPfGohxtNwI=; b=dbT5mrcS0KbTEiUyXK
	szlB6SS2LJ7+B+PUF6l5eGO31xW/jrItABUdv8UgOqx04I20i0fq8j6qCk7W9jSl
	v1Rbm/1BqYb0sSLbUTRWvIJoLO3w9lDTYxHzA5W5hy7KxR73sRH05X/k9sjwVzHl
	OVdU2Wm90Hs8JF/ICT3IN9HIg=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wB3RUngJ6doG2VUDA--.41400S4;
	Thu, 21 Aug 2025 22:06:27 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v12 2/2] selftests/bpf: Enrich subtest_basic_usdt case in selftests to cover SIB handling logic
Date: Thu, 21 Aug 2025 14:06:23 +0000
Message-ID: <20250821140623.971621-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821140623.971621-1-phoenix500526@163.com>
References: <20250821140623.971621-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3RUngJ6doG2VUDA--.41400S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktF4fur4ftFWfAr1kXwb_yoWrJr45pa
	4kZ3WftFyrtF1xGr4fJr4UXw4rKFn2vrW5AFZ2qryjyrW8Grs7Jrn7K3W7tFnIg395XF45
	A39Fkan5Kw4xJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgASwiGim-6KgjQAFsH

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- enrich subtest_basic_usdt test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/prog_tests/usdt.c | 30 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/test_usdt.c | 28 +++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt.c b/tools/testing/selftests/bpf/prog_tests/usdt.c
index 9057e983cc54..56990d4b5861 100644
--- a/tools/testing/selftests/bpf/prog_tests/usdt.c
+++ b/tools/testing/selftests/bpf/prog_tests/usdt.c
@@ -25,6 +25,10 @@ unsigned short test_usdt0_semaphore SEC(".probes");
 unsigned short test_usdt3_semaphore SEC(".probes");
 unsigned short test_usdt12_semaphore SEC(".probes");
 
+#if defined(__x86_64__) || defined(__i386__)
+unsigned short test_usdt_sib_semaphore SEC(".probes");
+#endif
+
 static void __always_inline trigger_func(int x) {
 	long y = 42;
 
@@ -40,6 +44,22 @@ static void __always_inline trigger_func(int x) {
 	}
 }
 
+#if defined(__x86_64__) || defined(__i386__)
+static __attribute__((optimize("O1"))) void trigger_sib_spec(void)
+{
+	/* Base address + offset + (index * scale) */
+	/* Force SIB addressing with inline assembly */
+	asm volatile(
+		"# probe point with memory access\n"
+		STAP_PROBE_ASM(test, usdt_sib, -2@(%%rdx,%%rax,2))
+		"# end probe point"
+		:
+		: "d"(nums), "a"(0)
+		: "memory"
+	);
+}
+#endif
+
 static void subtest_basic_usdt(void)
 {
 	LIBBPF_OPTS(bpf_usdt_opts, opts);
@@ -156,6 +176,16 @@ static void subtest_basic_usdt(void)
 	ASSERT_EQ(bss->usdt3_args[1], 42, "usdt3_arg2");
 	ASSERT_EQ(bss->usdt3_args[2], (uintptr_t)&bla, "usdt3_arg3");
 
+	#if defined(__x86_64__) || defined(__i386__)
+	trigger_sib_spec();
+	ASSERT_EQ(bss->usdt_sib_called, 1, "usdt_sib_called");
+	ASSERT_EQ(bss->usdt_sib_cookie, 0, "usdt_sib_cookie");
+	ASSERT_EQ(bss->usdt_sib_arg_cnt, 1, "usdt_sib_arg_cnt");
+	ASSERT_EQ(bss->usdt_sib_arg, nums[0], "usdt_sib_arg");
+	ASSERT_EQ(bss->usdt_sib_arg_ret, 0, "usdt_sib_arg_ret");
+	ASSERT_EQ(bss->usdt_sib_arg_size, sizeof(nums[0]), "usdt_sib_arg_size");
+	#endif
+
 cleanup:
 	test_usdt__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/test_usdt.c b/tools/testing/selftests/bpf/progs/test_usdt.c
index 096488f47fbc..8b499732e6a8 100644
--- a/tools/testing/selftests/bpf/progs/test_usdt.c
+++ b/tools/testing/selftests/bpf/progs/test_usdt.c
@@ -107,4 +107,32 @@ int BPF_USDT(usdt12, int a1, int a2, long a3, long a4, unsigned a5,
 	return 0;
 }
 
+
+int usdt_sib_called;
+u64 usdt_sib_cookie;
+int usdt_sib_arg_cnt;
+int usdt_sib_arg_ret;
+u64 usdt_sib_arg;
+int usdt_sib_arg_size;
+
+SEC("usdt//proc/self/exe:test:usdt_sib")
+int usdt_sib(struct pt_regs *ctx)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt_sib_called, 1);
+
+	usdt_sib_cookie = bpf_usdt_cookie(ctx);
+	usdt_sib_arg_cnt = bpf_usdt_arg_cnt(ctx);
+
+	usdt_sib_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
+	usdt_sib_arg = (short)tmp;
+	usdt_sib_arg_size = bpf_usdt_arg_size(ctx, 0);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.0


