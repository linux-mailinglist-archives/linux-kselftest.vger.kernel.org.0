Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9105A83E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 18:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiHaQ7U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 12:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232454AbiHaQ6m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 12:58:42 -0400
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE03DB07E;
        Wed, 31 Aug 2022 09:58:05 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4MHqwg2fsnz9xHvF;
        Thu,  1 Sep 2022 00:52:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBX0lxfkg9jJXIRAA--.5993S14;
        Wed, 31 Aug 2022 17:57:35 +0100 (CET)
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
Subject: [PATCH v15 12/12] selftests/bpf: Add tests for dynamic pointers parameters in kfuncs
Date:   Wed, 31 Aug 2022 18:54:45 +0200
Message-Id: <20220831165445.1071641-13-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
References: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBX0lxfkg9jJXIRAA--.5993S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1rtr1fWFW8GF48WFW5trb_yoW7uw1xpa
        1rGryj9r40q3W3Wr13JF4xur4fKr4kZw17CrZIv34xZr1DXrWrXF18KFW5J3Z8K395Xw45
        Z3ySqFWruw48Ja7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owCI42IY
        6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aV
        CY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7IUbGXdUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj357FgADsm
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Add tests to ensure that only supported dynamic pointer types are accepted,
that the passed argument is actually a dynamic pointer, and that the passed
argument is a pointer to the stack.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 .../bpf/prog_tests/kfunc_dynptr_param.c       | 102 ++++++++++++++++++
 .../bpf/progs/test_kfunc_dynptr_param.c       |  57 ++++++++++
 2 files changed, 159 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c

diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
new file mode 100644
index 000000000000..732897faf36b
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Facebook
+ * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ */
+
+#include <test_progs.h>
+#include "test_kfunc_dynptr_param.skel.h"
+
+static size_t log_buf_sz = 1048576; /* 1 MB */
+static char obj_log_buf[1048576];
+
+static struct {
+	const char *prog_name;
+	const char *expected_err_msg;
+} kfunc_dynptr_tests[] = {
+	{"dynptr_type_not_supp",
+	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type"},
+	{"not_valid_dynptr",
+	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized"},
+	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack"},
+};
+
+static bool kfunc_not_supported;
+
+static int libbpf_print_cb(enum libbpf_print_level level, const char *fmt,
+			   va_list args)
+{
+	if (strcmp(fmt, "libbpf: extern (func ksym) '%s': not found in kernel or module BTFs\n"))
+		return 0;
+
+	if (strcmp(va_arg(args, char *), "bpf_verify_pkcs7_signature"))
+		return 0;
+
+	kfunc_not_supported = true;
+	return 0;
+}
+
+static void verify_fail(const char *prog_name, const char *expected_err_msg)
+{
+	struct test_kfunc_dynptr_param *skel;
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	libbpf_print_fn_t old_print_cb;
+	struct bpf_program *prog;
+	int err;
+
+	opts.kernel_log_buf = obj_log_buf;
+	opts.kernel_log_size = log_buf_sz;
+	opts.kernel_log_level = 1;
+
+	skel = test_kfunc_dynptr_param__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open_opts"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	bpf_program__set_autoload(prog, true);
+
+	bpf_map__set_max_entries(skel->maps.ringbuf, getpagesize());
+
+	kfunc_not_supported = false;
+
+	old_print_cb = libbpf_set_print(libbpf_print_cb);
+	err = test_kfunc_dynptr_param__load(skel);
+	libbpf_set_print(old_print_cb);
+
+	if (err < 0 && kfunc_not_supported) {
+		fprintf(stderr,
+		  "%s:SKIP:bpf_verify_pkcs7_signature() kfunc not supported\n",
+		  __func__);
+		test__skip();
+		goto cleanup;
+	}
+
+	if (!ASSERT_ERR(err, "unexpected load success"))
+		goto cleanup;
+
+	if (!ASSERT_OK_PTR(strstr(obj_log_buf, expected_err_msg), "expected_err_msg")) {
+		fprintf(stderr, "Expected err_msg: %s\n", expected_err_msg);
+		fprintf(stderr, "Verifier output: %s\n", obj_log_buf);
+	}
+
+cleanup:
+	test_kfunc_dynptr_param__destroy(skel);
+}
+
+void test_kfunc_dynptr_param(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(kfunc_dynptr_tests); i++) {
+		if (!test__start_subtest(kfunc_dynptr_tests[i].prog_name))
+			continue;
+
+		verify_fail(kfunc_dynptr_tests[i].prog_name,
+			    kfunc_dynptr_tests[i].expected_err_msg);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
new file mode 100644
index 000000000000..2f09f91a1576
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -0,0 +1,57 @@
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
+struct bpf_dynptr {
+	__u64 :64;
+	__u64 :64;
+} __attribute__((aligned(8)));
+
+extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
+				      struct bpf_dynptr *sig_ptr,
+				      struct bpf_key *trusted_keyring) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+char _license[] SEC("license") = "GPL";
+
+SEC("?lsm.s/bpf")
+int BPF_PROG(dynptr_type_not_supp, int cmd, union bpf_attr *attr,
+	     unsigned int size)
+{
+	char write_data[64] = "hello there, world!!";
+	struct bpf_dynptr ptr;
+
+	bpf_ringbuf_reserve_dynptr(&ringbuf, sizeof(write_data), 0, &ptr);
+
+	return bpf_verify_pkcs7_signature(&ptr, &ptr, NULL);
+}
+
+SEC("?lsm.s/bpf")
+int BPF_PROG(not_valid_dynptr, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	unsigned long val;
+
+	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)&val,
+					  (struct bpf_dynptr *)&val, NULL);
+}
+
+SEC("?lsm.s/bpf")
+int BPF_PROG(not_ptr_to_stack, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	unsigned long val;
+
+	return bpf_verify_pkcs7_signature((struct bpf_dynptr *)val,
+					  (struct bpf_dynptr *)val, NULL);
+}
-- 
2.25.1

