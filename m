Return-Path: <linux-kselftest+bounces-38427-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12C8B1D0E8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 04:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391AD3AF6EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 02:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3077199949;
	Thu,  7 Aug 2025 02:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j71oCll4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAC3524F;
	Thu,  7 Aug 2025 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754534104; cv=none; b=LmxeIVhSJnJATUTIfpPLGXscWYHNMO4dWCOoKuIlA6RREywi5IpldGzMZCMVlKcyteoWqWzn7K+SzfRGsKlcp/hin89YXTEERTl5fjzmEyX38JPTlEDiBzslyFCnJCypWOM0X5x3ebLmD9hfkygm+fwQz94+1hZqzuSCQldFHbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754534104; c=relaxed/simple;
	bh=nieYC9c+249BW7EG1qD6ENgERSYGNbMzbTwbnbkvNmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HnguGhV3zNLPbz5RDFGdFgkvPfugw7aPdvP+gsd7Q49uUwVC/nPJ5+lBKDNP7nQawVIYxUK6pqmIatxrOD4jMHpaJsjTo6niy15kZYyYu8JZl9HPI90UUvDzDb2A7GT3ebFNr+VKeuB1YwF8CBUN1WOVkgGSZ3YjT6369Lf3Bys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j71oCll4; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mL
	R5OmI3/KOhZo6YRssu1xcudMwJC+vZQUkPh7Xha2c=; b=j71oCll4LiTEQFOOrl
	tqVEgvhdWtyq6XH3wtrvXCv8GkLhRZllRBF/22nZR3yRlqyxdJJ+CDIpWvLgmPq5
	SYS5XOHgI3o9OYSZ4a2wuQ9N0Oj8qjTOr9SnRGvjYXLjJE2g7MER0Dz3cEWRJC2Y
	FpYrxbhAmcI+beKreIP9fNPFI=
Received: from phoenix.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD331O2EJRoF+MEAQ--.33482S4;
	Thu, 07 Aug 2025 10:34:32 +0800 (CST)
From: Jiawei Zhao <phoenix500526@163.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v8 2/2] selftests/bpf: Add an usdt_o2 test case in selftests to cover SIB handling logic
Date: Thu,  7 Aug 2025 02:34:28 +0000
Message-ID: <20250807023430.4566-3-phoenix500526@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807023430.4566-1-phoenix500526@163.com>
References: <20250807023430.4566-1-phoenix500526@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD331O2EJRoF+MEAQ--.33482S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF15CryUAFWrXry5CF43GFg_yoW7Gw1xpa
	48Xw1YkrWIqF43Kr1SqF4Utr4rKanayrW8JFykXFyavr48JF92qr1xKry7Kas3G395XF1r
	A39xtan8Gr48Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: pskrv0dl0viiqvswqiywtou0bp/xtbBgA+iiGiUDBSB4AAAsg

When using GCC on x86-64 to compile an usdt prog with -O1 or higher
optimization, the compiler will generate SIB addressing mode for global
array and PC-relative addressing mode for global variable,
e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".

In this patch:
- add usdt_o2 test case to cover SIB addressing usdt argument spec
  handling logic

Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
---
 tools/testing/selftests/bpf/Makefile          |  8 +++
 .../selftests/bpf/prog_tests/usdt_o2.c        | 71 +++++++++++++++++++
 .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
 3 files changed, 116 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 910d8d6402ef..68cf6a9cf05f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -759,6 +759,14 @@ TRUNNER_BPF_BUILD_RULE := $$(error no BPF objects should be built)
 TRUNNER_BPF_CFLAGS :=
 $(eval $(call DEFINE_TEST_RUNNER,test_maps))
 
+# Use -O2 optimization to generate SIB addressing usdt argument spec
+# Only apply on x86 architecture where SIB addressing is relevant
+ifeq ($(ARCH), x86)
+$(OUTPUT)/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/cpuv4/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+$(OUTPUT)/no_alu32/usdt_o2.test.o: CFLAGS:=$(subst O0,O2,$(CFLAGS))
+endif
+
 # Define test_verifier test runner.
 # It is much simpler than test_maps/test_progs and sufficiently different from
 # them (e.g., test.h is using completely pattern), that it's worth just
diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
new file mode 100644
index 000000000000..f04b756b3640
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
+#include <test_progs.h>
+
+#define _SDT_HAS_SEMAPHORES 1
+#include "../sdt.h"
+#include "test_usdt_o2.skel.h"
+
+int lets_test_this(int);
+
+#define test_value 0xFEDCBA9876543210ULL
+#define SEC(name) __attribute__((section(name), used))
+
+
+static volatile __u64 array[1] = {test_value};
+unsigned short test_usdt1_semaphore SEC(".probes");
+
+static __always_inline void trigger_func(void)
+{
+	/* Base address + offset + (index * scale) */
+	if (test_usdt1_semaphore) {
+		for (volatile int i = 0; i <= 0; i++)
+			STAP_PROBE1(test, usdt1, array[i]);
+	}
+}
+
+static void basic_sib_usdt(void)
+{
+	LIBBPF_OPTS(bpf_usdt_opts, opts);
+	struct test_usdt_o2 *skel;
+	struct test_usdt_o2__bss *bss;
+	int err;
+
+	skel = test_usdt_o2__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	bss = skel->bss;
+	bss->my_pid = getpid();
+
+	err = test_usdt_o2__attach(skel);
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
+	test_usdt_o2__destroy(skel);
+}
+
+
+
+void test_usdt_o2(void)
+{
+	basic_sib_usdt();
+}
diff --git a/tools/testing/selftests/bpf/progs/test_usdt_o2.c b/tools/testing/selftests/bpf/progs/test_usdt_o2.c
new file mode 100644
index 000000000000..14602aa54578
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_usdt_o2.c
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


