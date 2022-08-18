Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F0A5987EC
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiHRPvD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 11:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344442AbiHRPue (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 11:50:34 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E55C373;
        Thu, 18 Aug 2022 08:50:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4M7pjX2WXTz9v7Yk;
        Thu, 18 Aug 2022 23:30:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwB3MhqAW_5ilLIyAA--.42520S6;
        Thu, 18 Aug 2022 16:33:15 +0100 (CET)
From:   roberto.sassu@huaweicloud.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v12 09/10] selftests/bpf: Add additional tests for bpf_lookup_*_key()
Date:   Thu, 18 Aug 2022 17:29:28 +0200
Message-Id: <20220818152929.402605-10-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
References: <20220818152929.402605-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwB3MhqAW_5ilLIyAA--.42520S6
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13WF17try8WFyrXFykGrg_yoW7AryDpF
        yUGa4Fyry09r1Utan3AF17AF1rKF4Uu3W2ywnrWr13uw1kZFy8Gw4xKa1agasxWrZ8Zwn3
        ua1Yga1jkr4UZa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1j6r18M7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwAKzVCY07
        xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
        67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
        IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
        14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
        4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        wXo7DUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj34XLQAAs7
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

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

