Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5BC590F57
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238509AbiHLKVd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 06:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiHLKVW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 06:21:22 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C944575FF7;
        Fri, 12 Aug 2022 03:21:20 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4M402d1114z67XhD;
        Fri, 12 Aug 2022 18:16:41 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 12 Aug 2022 12:21:17 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <mykolal@fb.com>,
        <corbet@lwn.net>, <dhowells@redhat.com>, <jarkko@kernel.org>,
        <rostedt@goodmis.org>, <mingo@redhat.com>, <paul@paul-moore.com>,
        <jmorris@namei.org>, <serge@hallyn.com>, <shuah@kernel.org>
CC:     <bpf@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v11 8/9] selftests/bpf: Add additional tests for bpf_lookup_*_key()
Date:   Fri, 12 Aug 2022 12:19:01 +0200
Message-ID: <20220812101902.2846182-9-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220812101902.2846182-1-roberto.sassu@huawei.com>
References: <20220812101902.2846182-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test to ensure that bpf_lookup_user_key() creates a referenced
special keyring when the KEY_LOOKUP_CREATE flag is passed to this function.

Ensure that the kfunc rejects invalid flags.

Ensure that a keyring can be obtained from bpf_lookup_system_key() when one
of the pre-determined keyring IDs is provided.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../selftests/bpf/prog_tests/lookup_key.c     | 112 ++++++++++++++++++
 .../selftests/bpf/progs/test_lookup_key.c     |  46 +++++++
 2 files changed, 158 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_key.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_key.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lookup_key.c b/tools/testing/selftests/bpf/prog_tests/lookup_key.c
new file mode 100644
index 000000000000..2e0cde729dc7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lookup_key.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <linux/keyctl.h>
+#include <test_progs.h>
+
+#include "test_lookup_key.skel.h"
+
+#define KEY_LOOKUP_CREATE	0x01
+#define KEY_LOOKUP_PARTIAL	0x02
+
+static bool kfunc_not_supported;
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
+			   va_list args)
+{
+	char *func;
+
+	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
+		return 0;
+
+	func = va_arg(args, char *);
+
+	if (strcmp(func, "bpf_lookup_user_key") && strcmp(func, "bpf_key_put") &&
+	    strcmp(func, "bpf_lookup_system_key"))
+		return 0;
+
+	kfunc_not_supported = true;
+	return 0;
+}
+
+void test_lookup_key(void)
+{
+	libbpf_print_fn_t old_print_cb;
+	struct test_lookup_key *skel;
+	u32 next_id;
+	int ret;
+
+	skel = test_lookup_key__open();
+	if (!ASSERT_OK_PTR(skel, "test_lookup_key__open"))
+		return;
+
+	old_print_cb = libbpf_set_print(libbpf_print_cb);
+	ret = test_lookup_key__load(skel);
+	libbpf_set_print(old_print_cb);
+
+	if (ret < 0 && kfunc_not_supported) {
+		printf("%s:SKIP:bpf_lookup_*_key(), bpf_key_put() kfuncs not supported\n",
+		       __func__);
+		test__skip();
+		goto close_prog;
+	}
+
+	if (!ASSERT_OK(ret, "test_lookup_key__load"))
+		goto close_prog;
+
+	ret = test_lookup_key__attach(skel);
+	if (!ASSERT_OK(ret, "test_lookup_key__attach"))
+		goto close_prog;
+
+	skel->bss->monitored_pid = getpid();
+	skel->bss->key_serial = KEY_SPEC_THREAD_KEYRING;
+
+	/* The thread-specific keyring does not exist, this test fails. */
+	skel->bss->flags = 0;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_LT(ret, 0, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	/* Force creation of the thread-specific keyring, this test succeeds. */
+	skel->bss->flags = KEY_LOOKUP_CREATE;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_OK(ret, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	/* Pass both lookup flags for parameter validation. */
+	skel->bss->flags = KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_OK(ret, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	/* Pass invalid flags. */
+	skel->bss->flags = UINT64_MAX;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_LT(ret, 0, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	skel->bss->key_serial = 0;
+	skel->bss->key_id = 1;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	if (!ASSERT_OK(ret, "bpf_prog_get_next_id"))
+		goto close_prog;
+
+	skel->bss->key_id = UINT32_MAX;
+
+	ret = bpf_prog_get_next_id(0, &next_id);
+	ASSERT_LT(ret, 0, "bpf_prog_get_next_id");
+
+close_prog:
+	skel->bss->monitored_pid = 0;
+	test_lookup_key__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_lookup_key.c b/tools/testing/selftests/bpf/progs/test_lookup_key.c
new file mode 100644
index 000000000000..c73776990ae3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_lookup_key.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
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
+__u32 key_serial;
+__u32 key_id;
+__u64 flags;
+
+extern struct bpf_key *bpf_lookup_user_key(__u32 serial, __u64 flags) __ksym;
+extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
+extern void bpf_key_put(struct bpf_key *key) __ksym;
+
+SEC("lsm.s/bpf")
+int BPF_PROG(bpf, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	struct bpf_key *bkey;
+	__u32 pid;
+
+	pid = bpf_get_current_pid_tgid() >> 32;
+	if (pid != monitored_pid)
+		return 0;
+
+	if (key_serial)
+		bkey = bpf_lookup_user_key(key_serial, flags);
+	else
+		bkey = bpf_lookup_system_key(key_id);
+
+	if (!bkey)
+		return -ENOENT;
+
+	bpf_key_put(bkey);
+
+	return 0;
+}
-- 
2.25.1

