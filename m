Return-Path: <linux-kselftest+bounces-28676-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA92AA5A6ED
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 23:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4336B7A7B1D
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 22:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1272A1EF398;
	Mon, 10 Mar 2025 22:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dK52eV9D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC71E885C;
	Mon, 10 Mar 2025 22:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645095; cv=none; b=dvN75p9OpC7cFdaJ61JD5TursvMB3qnfIZkSWg50fYkJ9PPpyIasudR5PO2FW6KBZKDug+QGTjDtGtzR35U2AxGvFZW9r9xj2z5w2XSfgW9/GiDDXFWTceoA9CnY2gMMZrXj+X8AZrF/cLZHe/sH7+elLM8xvE56LfBwKlpHD9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645095; c=relaxed/simple;
	bh=SN3qRmp2VsH+hfZzbschHT13b+7JeCD/f0E1AXv3ATw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRmXWkpN+t/7fenzISf4SkQ9TZ2QluzufrKMFxdDaJyPiqmUsK8FA2nalhR5sfDc9hm7/gNkYjc5L80KDfnmA6+g+HaxyahrON5lnRonNmz3FCvyGPgu7b3C3Lx7tecvOg/XSRnlhf/IACIpHYfNkWqcx4XsBWJdHkbv6LEnxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dK52eV9D; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5CFA2111421;
	Mon, 10 Mar 2025 15:18:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5CFA2111421
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741645093;
	bh=MrftlxeEFs9Mx0mFvTjVrigQo9uOdYagfaYRGPfbOKw=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dK52eV9DWfe7TBQSD7aqqx8TJ30fFtxC/Cmv6vrVTtwBqYqmdavIqpSd9K0LTuivJ
	 7D9vi8zuASSTi2F18Tnt42dmGnxWiCQfxCTgiTG02a7GmX19VRaYtaSpv5AIP/JLLB
	 noz0r8BvFIMi2SP4NQJwHbHYSS4TSJ5KiGQBJmJw=
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
Subject: [PATCH v7 bpf-next 2/2] selftests/bpf: Add a kernel flag test for LSM bpf hook
Date: Mon, 10 Mar 2025 15:17:12 -0700
Message-ID: <20250310221737.821889-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310221737.821889-1-bboscaccy@linux.microsoft.com>
References: <20250310221737.821889-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test exercises the kernel flag added to security_bpf by
effectively blocking light-skeletons from loading while allowing
normal skeletons to function as-is. Since this should work with any
arbitrary BPF program, an existing program from LSKELS_EXTRA was
used as a test payload.

Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 .../selftests/bpf/prog_tests/kernel_flag.c    | 43 +++++++++++++++++++
 .../selftests/bpf/progs/test_kernel_flag.c    | 28 ++++++++++++
 2 files changed, 71 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kernel_flag.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kernel_flag.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kernel_flag.c b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
new file mode 100644
index 0000000000000..a133354ac9bc2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kernel_flag.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Microsoft */
+#include <test_progs.h>
+#include "kfunc_call_test.skel.h"
+#include "kfunc_call_test.lskel.h"
+#include "test_kernel_flag.skel.h"
+
+void test_kernel_flag(void)
+{
+	struct test_kernel_flag *lsm_skel;
+	struct kfunc_call_test *skel = NULL;
+	struct kfunc_call_test_lskel *lskel = NULL;
+	int ret;
+
+	lsm_skel = test_kernel_flag__open_and_load();
+	if (!ASSERT_OK_PTR(lsm_skel, "lsm_skel"))
+		return;
+
+	lsm_skel->bss->monitored_tid = gettid();
+
+	ret = test_kernel_flag__attach(lsm_skel);
+	if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
+		goto close_prog;
+
+	/* Test with skel. This should pass the gatekeeper */
+	skel = kfunc_call_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel"))
+		goto close_prog;
+
+	/* Test with lskel. This should fail due to blocking kernel-based bpf() invocations */
+	lskel = kfunc_call_test_lskel__open_and_load();
+	if (!ASSERT_ERR_PTR(lskel, "lskel"))
+		goto close_prog;
+
+close_prog:
+	if (skel)
+		kfunc_call_test__destroy(skel);
+	if (lskel)
+		kfunc_call_test_lskel__destroy(lskel);
+
+	lsm_skel->bss->monitored_tid = 0;
+	test_kernel_flag__destroy(lsm_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kernel_flag.c b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
new file mode 100644
index 0000000000000..b45fab3be3528
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2025 Microsoft Corporation
+ *
+ * Author: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
+ */
+
+#include "vmlinux.h"
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_tid;
+
+SEC("lsm.s/bpf")
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
+{
+	__u32 tid;
+
+	tid = bpf_get_current_pid_tgid() & 0xFFFFFFFF;
+	if (!kernel || tid != monitored_tid)
+		return 0;
+	else
+		return -EINVAL;
+}
-- 
2.48.1


