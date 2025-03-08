Return-Path: <linux-kselftest+bounces-28532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29C5A57747
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 02:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29765172556
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Mar 2025 01:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F363146D6A;
	Sat,  8 Mar 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XVX/p+uQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90A33987;
	Sat,  8 Mar 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741397637; cv=none; b=EKX2pZ1nbulawp1WEC2TLCVsrjdy+i71l0OCAqk936Tyt1B488yf+X2h14/xN+tvJGlGQDhHoQMcfsT19Oqv0daAlmhUwlhbtWpLUkDgee83wZQl5SvhF/0T/p6ZHCJgCBb9Ymk55ZeU6C2T1lyR1HlKG0ErgOpncncPMhE2/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741397637; c=relaxed/simple;
	bh=JjUKUFdE7JsuOeOMyd9/iTw1+idX++Iy87pV8kzk2Ko=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aCcFKKgDMegBjeMnsl0uH7bpsYQ3QXOUmT2nODIgiaxRMksmGiTYWc4xqA3ZDqMb2021cdIUTzDIJHf7gIynw2qLZyJShngn3xQZE0pYaVxsQn00tRfzEIi7bZvqMaRimu9ZVwUXA9gBxeWuTNrlqHzfknPycMQla80bpCriUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XVX/p+uQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia.corp.microsoft.com (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 07F5D2038F43;
	Fri,  7 Mar 2025 17:33:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 07F5D2038F43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741397635;
	bh=KgNysdb+YD7YcMoVAkbZNtHFWh6xJ6N4PzgqutHta8k=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XVX/p+uQZfM3CGvdbJGB2+k0r74nNHh5fHiJtOLlXZxvP4Wwi7OlDGKriiN7zVioA
	 kmGGh0q1WSnwWnhqvl4sei3ir+xmNbhk9Cak26B2Cwi03WlLiv6/Gl7nkItxiiv9Ch
	 JO/Au7of7MUtmR2yhTr7MOn424Jb2XCnG0DeACqs=
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
Subject: [PATCH v6 bpf-next 2/2] selftests/bpf: Add a kernel flag test for LSM bpf hook
Date: Fri,  7 Mar 2025 17:32:35 -0800
Message-ID: <20250308013314.719150-3-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
References: <20250308013314.719150-1-bboscaccy@linux.microsoft.com>
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
index 0000000000000..479ad5de3737e
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
+	ret = test_kernel_flag__attach(lsm_skel);
+	if (!ASSERT_OK(ret, "test_kernel_flag__attach"))
+		goto close_prog;
+
+	lsm_skel->bss->monitored_pid = getpid();
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
+	lsm_skel->bss->monitored_pid = 0;
+	test_kernel_flag__destroy(lsm_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kernel_flag.c b/tools/testing/selftests/bpf/progs/test_kernel_flag.c
new file mode 100644
index 0000000000000..9ca01aadb6656
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
+__u32 monitored_pid;
+
+SEC("lsm.s/bpf")
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
+{
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (!kernel || pid != monitored_pid)
+		return 0;
+	else
+		return -EINVAL;
+}
-- 
2.48.1


