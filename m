Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA8E5A6836
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 18:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiH3QVG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 12:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiH3QUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 12:20:25 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863336E894;
        Tue, 30 Aug 2022 09:20:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MHC7T6LVTz9v7VY;
        Wed, 31 Aug 2022 00:14:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDHQl0ZOA5jLmYNAA--.2866S12;
        Tue, 30 Aug 2022 17:19:45 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v14 10/12] selftests/bpf: Add additional tests for bpf_lookup_*_key()
Date:   Tue, 30 Aug 2022 18:17:14 +0200
Message-Id: <20220830161716.754078-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDHQl0ZOA5jLmYNAA--.2866S12
X-Coremail-Antispam: 1UD129KBjvJXoW3XF13Gr13Zr13Kw1fZr17Awb_yoWxJFyUpa
        48Ga4YkryI9r1Uta93JrsrZF1rKF48uw4IywsrWr13uwn7AFyxGw4xKF4agasxWrZ8uwn3
        ua1Yga1Ykw48Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
        W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
        0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
        U0189tUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAABF1jj35w-QABsF
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

The test is currently blacklisted for s390x (JIT does not support calling
kernel function).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../selftests/bpf/prog_tests/lookup_key.c     | 112 ++++++++++++++++++
 .../selftests/bpf/progs/test_lookup_key.c     |  46 +++++++
 3 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lookup_key.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_lookup_key.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 736b65f61022..50edce0de0b0 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -68,3 +68,4 @@ unpriv_bpf_disabled                      # fentry
 setget_sockopt                           # attach unexpected error: -524                                               (trampoline)
 cb_refs                                  # expected error message unexpected error: -524                               (trampoline)
 cgroup_hierarchical_stats                # JIT does not support calling kernel function                                (kfunc)
+lookup_key                               # JIT does not support calling kernel function                                (kfunc)
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

