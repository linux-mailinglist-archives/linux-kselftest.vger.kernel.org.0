Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5896745AAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jul 2023 12:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjGCK6o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Jul 2023 06:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjGCK6n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Jul 2023 06:58:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBB6D2;
        Mon,  3 Jul 2023 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688381922; x=1719917922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GZZoC3iTyzrkENAoUyx8fll+6b0qjLWSGcIt+67G8aY=;
  b=fW1iZcWuyOmDiB/8SOMcQDjgOnV/B6ct4zUBiILa6IASr0RVj7lJ0qml
   qGOv/J3bpW7AbGYA7hzSKszzPQftRhnmcsANkcqD9I2urtghP7ovYIA7u
   wpArnjG0y5xWLbXQ92AWrHOTlQvCIZzCgg7Ve1IzW/UdJEj8oV6KIttLG
   4vJ0OAJpNMuN+vH2BZLQlGwYclBbt7AokCw0pkmIvxntQIaazEjxYVIsk
   R5h09GKPy4r/6xyjiTPqj3Bukg85zAyA+VCXpj9qaAzq/R3ct6PGdsRJg
   F5ERYdM0clAnbDbUE67gOSIqb/s4BOvKrl9Q9TsxloaSo/guv2eQ2huDx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="360329731"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="360329731"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10759"; a="748108266"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="748108266"
Received: from agrabezh-mobl1.ccr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.252.48.27])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 03:58:30 -0700
From:   Tero Kristo <tero.kristo@linux.intel.com>
To:     shuah@kernel.org, tglx@linutronix.de, x86@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
Subject: [PATCH 2/2] selftests/bpf: Add test for bpf_rdtsc
Date:   Mon,  3 Jul 2023 13:57:45 +0300
Message-Id: <20230703105745.1314475-3-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftest for bpf_rdtsc() which reads the TSC (Time Stamp Counter) on
x86_64 architectures. The test reads the TSC from both userspace and the
BPF program, and verifies the TSC values are in incremental order as
expected. The test is automatically skipped on architectures that do not
support the feature.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 .../selftests/bpf/prog_tests/test_rdtsc.c     | 67 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_rdtsc.c  | 21 ++++++
 2 files changed, 88 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_rdtsc.c

diff --git a/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
new file mode 100644
index 000000000000..2b26deb5b35a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/test_rdtsc.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation */
+
+#include "test_progs.h"
+#include "test_rdtsc.skel.h"
+
+#ifdef __x86_64__
+
+static inline u64 _rdtsc(void)
+{
+	u32 low, high;
+
+	__asm__ __volatile__("rdtscp" : "=a" (low), "=d" (high));
+	return ((u64)high << 32) | low;
+}
+
+static int rdtsc(struct test_rdtsc *skel)
+{
+	int err, prog_fd;
+	u64 user_c1, user_c2;
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	err = test_rdtsc__attach(skel);
+	if (!ASSERT_OK(err, "test_rdtsc_attach"))
+		return err;
+
+	user_c1 = _rdtsc();
+
+	prog_fd = bpf_program__fd(skel->progs.test1);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+
+	user_c2 = _rdtsc();
+
+	ASSERT_OK(err, "test_run");
+	ASSERT_EQ(topts.retval, 0, "test_run");
+
+	test_rdtsc__detach(skel);
+
+	ASSERT_GE(skel->bss->c1, user_c1, "bpf c1 > user c1");
+	ASSERT_GE(user_c2, skel->bss->c2, "user c2 > bpf c2");
+	ASSERT_GE(skel->bss->c2, user_c1, "bpf c2 > bpf c1");
+	ASSERT_GE(user_c2, user_c1, "user c2 > user c1");
+
+	return 0;
+}
+#endif
+
+void test_rdtsc(void)
+{
+#ifdef __x86_64__
+	struct test_rdtsc *skel;
+	int err;
+
+	skel = test_rdtsc__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_rdtsc_skel_load"))
+		goto cleanup;
+	err = rdtsc(skel);
+	ASSERT_OK(err, "rdtsc");
+
+cleanup:
+	test_rdtsc__destroy(skel);
+#else
+	printf("%s:SKIP:bpf_rdtsc() kfunc not supported\n", __func__);
+	test__skip();
+#endif
+}
diff --git a/tools/testing/selftests/bpf/progs/test_rdtsc.c b/tools/testing/selftests/bpf/progs/test_rdtsc.c
new file mode 100644
index 000000000000..14776b83bd3e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_rdtsc.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation */
+#include <linux/bpf.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u64 c1;
+__u64 c2;
+
+extern __u64 bpf_rdtsc(void) __ksym;
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG2(test1, int, a)
+{
+	c1 = bpf_rdtsc();
+	c2 = bpf_rdtsc();
+
+	return 0;
+}
-- 
2.25.1

