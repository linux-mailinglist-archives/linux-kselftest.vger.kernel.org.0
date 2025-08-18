Return-Path: <linux-kselftest+bounces-39199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F2B29B25
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 09:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920943A4781
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 07:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C25286415;
	Mon, 18 Aug 2025 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VGuWfVZs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E89285CBB;
	Mon, 18 Aug 2025 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755503224; cv=none; b=Ki5316OWMxsjv/FnseJXOfRp+ZQ8kgG+Y9lRmyucJ5Zpp5zUjkcPttsDxSgcslqktKL7tg7c5rb3kYu9erZP/zR4RezLWRl/AsjYAnacDqjpFZG/b1JkTjVxJ75GdaczKVOO1pMjXeotxIT2xtIuNjZ50StJhQmvj1Qke6TIyKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755503224; c=relaxed/simple;
	bh=g2jUZAuYi24+QU2qGp6Zb96EwojciRbSSB935od7Blk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbOl3XUBaJqGsAUsf3JwPLx7ER3aF/uNCPhR66JEW2cr++t4wTSFPVESdEatK6vMWbjjL3TM3hiF/wF1uFgr6X6YgOwUN2kBtHRVxdoMfKnoBnfPFoUqyJQifWZUYtpyaMk+4qSTkHIadfrJCzO3Hbcqrnvn46IQe/UK1I3P4Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VGuWfVZs; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=c9
	qrcvdxKocK0bjalVk19qiGqr1nlSGCxN8y/9RqBP4=; b=VGuWfVZswRrreXIbV3
	KHlRJBLqXrn97jnlRqQlXK4A7fygVtFUlm/5PVDAuJlCIo1j7zJPlbz5o4pghVlb
	m79lZb3a949Uu2wXI2KI7VymDfYdfNGX1y7XjBWWbrdDvQGk1Ka62LM5JBfulfka
	p8oHdBWRQIDI3lJ+A4Ds7i/tc=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBH_+VZ2qJoyxi9Cg--.52195S4;
	Mon, 18 Aug 2025 15:46:36 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v11 2/3] selftests/bpf: Add an usdt_o1 test case in selftests to cover SIB handling logic
Date: Mon, 18 Aug 2025 07:46:31 +0000
Message-ID: <20250818074632.433008-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818074632.433008-1-phoenix500526@163.com>
References: <20250818074632.433008-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH_+VZ2qJoyxi9Cg--.52195S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4ktF4fArWkKr48WFyUJrb_yoWrWFyrpa
	48XryFkFWIqF13Kw1Sqr4Uta1rtanayry8AFykXF1avr48WFWxXrn7Kr17tF93J3ykZF1r
	Aa9xtan8Kr48JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/1tbiFB+tiGii08WexQAAsp

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- add usdt_o1 test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 .../selftests/bpf/prog_tests/usdt_o1.c        | 70 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o1.c        | 37 ++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o1.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o1.c

diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o1.c b/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
new file mode 100644
index 000000000000..706168e804cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
+#include <test_progs.h>
+
+#include "../sdt.h"
+#include "test_usdt_o1.skel.h"
+
+#if (defined(__GNUC__) && !defined(__clang__))
+#pragma GCC optimize("O1")
+#else
+#pragma message("non-gcc compiler: the correct probes might not be installed")
+#endif
+
+
+#define test_value 0xFEDCBA9876543210ULL
+#define SEC(name) __attribute__((section(name), used))
+
+int lets_test_this(int);
+static volatile __u64 array[1] = {test_value};
+
+static __always_inline void trigger_func(void)
+{
+	/* Base address + offset + (index * scale) */
+	for (volatile int i = 0; i <= 0; i++)
+		STAP_PROBE1(test, usdt1, array[i]);
+}
+
+static void basic_sib_usdt(void)
+{
+	LIBBPF_OPTS(bpf_usdt_opts, opts);
+	struct test_usdt_o1 *skel;
+	struct test_usdt_o1__bss *bss;
+	int err;
+
+	skel = test_usdt_o1__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_usdt_o1__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* usdt1 won't be auto-attached */
+	opts.usdt_cookie = 0xcafedeadbeeffeed;
+	skel->links.usdt1 = bpf_program__attach_usdt(skel->progs.usdt1,
+						     0 /*self*/, "/proc/self/exe",
+						     "test", "usdt1", &opts);
+	if (!ASSERT_OK_PTR(skel->links.usdt1, "usdt1_link"))
+		goto cleanup;
+
+	trigger_func();
+
+	ASSERT_EQ(bss->usdt1_called, 1, "usdt1_called");
+	ASSERT_EQ(bss->usdt1_cookie, 0xcafedeadbeeffeed, "usdt1_cookie");
+	ASSERT_EQ(bss->usdt1_arg_cnt, 1, "usdt1_arg_cnt");
+	ASSERT_EQ(bss->usdt1_arg, test_value, "usdt1_arg");
+	ASSERT_EQ(bss->usdt1_arg_ret, 0, "usdt1_arg_ret");
+	ASSERT_EQ(bss->usdt1_arg_size, sizeof(array[0]), "usdt1_arg_size");
+
+cleanup:
+	test_usdt_o1__destroy(skel);
+}
+
+void test_usdt_o1(void)
+{
+	basic_sib_usdt();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_o1.c b/tools/testing/selftests/bpf/progs/test_usdt_o1.c
new file mode 100644
index 000000000000..14602aa54578
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt_o1.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/usdt.bpf.h>
+
+int my_pid;
+
+int usdt1_called;
+u64 usdt1_cookie;
+int usdt1_arg_cnt;
+int usdt1_arg_ret;
+u64 usdt1_arg;
+int usdt1_arg_size;
+
+SEC("usdt")
+int usdt1(struct pt_regs *ctx)
+{
+	long tmp;
+
+	if (my_pid != (bpf_get_current_pid_tgid() >> 32))
+		return 0;
+
+	__sync_fetch_and_add(&usdt1_called, 1);
+
+	usdt1_cookie = bpf_usdt_cookie(ctx);
+	usdt1_arg_cnt = bpf_usdt_arg_cnt(ctx);
+
+	usdt1_arg_ret = bpf_usdt_arg(ctx, 0, &tmp);
+	usdt1_arg = (u64)tmp;
+	usdt1_arg_size = bpf_usdt_arg_size(ctx, 0);
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0


