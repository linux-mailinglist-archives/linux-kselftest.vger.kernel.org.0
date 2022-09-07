Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36045B07CF
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 17:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIGPA7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Sep 2022 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiIGPAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Sep 2022 11:00:42 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1989A98C;
        Wed,  7 Sep 2022 08:00:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4MN51T3C6sz9y0jm;
        Wed,  7 Sep 2022 22:56:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwDXzpLssRhjiXMsAA--.45146S2;
        Wed, 07 Sep 2022 16:00:10 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     memxor@gmail.com
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, deso@posteo.net, dhowells@redhat.com,
        haoluo@google.com, jarkko@kernel.org, jmorris@namei.org,
        john.fastabend@gmail.com, jolsa@kernel.org,
        keyrings@vger.kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, martin.lau@linux.dev,
        mingo@redhat.com, mykolal@fb.com, paul@paul-moore.com,
        roberto.sassu@huawei.com, roberto.sassu@huaweicloud.com,
        rostedt@goodmis.org, sdf@google.com, serge@hallyn.com,
        shuah@kernel.org, song@kernel.org, yhs@fb.com
Subject: [PATCH v17 12/12] selftests/bpf: Add tests for dynamic pointers parameters in kfuncs
Date:   Wed,  7 Sep 2022 16:59:39 +0200
Message-Id: <20220907145939.489784-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAP01T74L7C+F7oiBx3fL9SahdvU-9rHpQ=GaLTj0XAfeOKaXrA@mail.gmail.com>
References: <CAP01T74L7C+F7oiBx3fL9SahdvU-9rHpQ=GaLTj0XAfeOKaXrA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwDXzpLssRhjiXMsAA--.45146S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JryUJryxurWUCFy5ur48JFb_yoWftr1kpa
        yrWryj9r40q3W3Xrn8JFs7ur4fKr48Zw17CrZI9FyxZr1DXFZ3XF18KFy3t3Z8K395Xw45
        Z3ySqFWruw4UJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUva14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
        0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
        XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyT
        uYvjfUFfHUDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAIBF1jj365JQAAsd
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

Add tests to ensure that only supported dynamic pointer types are accepted,
that the passed argument is actually a dynamic pointer, that the passed
argument is a pointer to the stack, and that bpf_verify_pkcs7_signature()
correctly handles dynamic pointers with data set to NULL.

The tests are currently in the deny list for s390x (JIT does not support
calling kernel function).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tools/testing/selftests/bpf/DENYLIST.s390x    |   1 +
 .../bpf/prog_tests/kfunc_dynptr_param.c       | 164 ++++++++++++++++++
 .../bpf/progs/test_kfunc_dynptr_param.c       |  99 +++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c

diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
index 4e305baa5277..9a6dc3671c65 100644
--- a/tools/testing/selftests/bpf/DENYLIST.s390x
+++ b/tools/testing/selftests/bpf/DENYLIST.s390x
@@ -71,3 +71,4 @@ cgroup_hierarchical_stats                # JIT does not support calling kernel f
 htab_update                              # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
 lookup_key                               # JIT does not support calling kernel function                                (kfunc)
 verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
+kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
new file mode 100644
index 000000000000..c210657d4d0a
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+
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
+	const char *expected_verifier_err_msg;
+	int expected_runtime_err;
+} kfunc_dynptr_tests[] = {
+	{"dynptr_type_not_supp",
+	 "arg#0 pointer type STRUCT bpf_dynptr_kern points to unsupported dynamic pointer type", 0},
+	{"not_valid_dynptr",
+	 "arg#0 pointer type STRUCT bpf_dynptr_kern must be valid and initialized", 0},
+	{"not_ptr_to_stack", "arg#0 pointer type STRUCT bpf_dynptr_kern not to stack", 0},
+	{"dynptr_data_null", NULL, -EBADMSG},
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
+static void verify_success(const char *prog_name, int expected_runtime_err)
+{
+	struct test_kfunc_dynptr_param *skel;
+	libbpf_print_fn_t old_print_cb;
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	__u32 next_id;
+	int err;
+
+	skel = test_kfunc_dynptr_param__open();
+	if (!ASSERT_OK_PTR(skel, "test_kfunc_dynptr_param__open"))
+		return;
+
+	skel->bss->pid = getpid();
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
+	if (!ASSERT_OK(err, "test_kfunc_dynptr_param__load"))
+		goto cleanup;
+
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach"))
+		goto cleanup;
+
+	err = bpf_prog_get_next_id(0, &next_id);
+
+	bpf_link__destroy(link);
+
+	if (!ASSERT_OK(err, "bpf_prog_get_next_id"))
+		goto cleanup;
+
+	ASSERT_EQ(skel->bss->err, expected_runtime_err, "err");
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
+		if (kfunc_dynptr_tests[i].expected_verifier_err_msg)
+			verify_fail(kfunc_dynptr_tests[i].prog_name,
+			  kfunc_dynptr_tests[i].expected_verifier_err_msg);
+		else
+			verify_success(kfunc_dynptr_tests[i].prog_name,
+				kfunc_dynptr_tests[i].expected_runtime_err);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
new file mode 100644
index 000000000000..d7d39ea009a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_kfunc_dynptr_param.c
@@ -0,0 +1,99 @@
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
+extern struct bpf_key *bpf_lookup_system_key(__u64 id) __ksym;
+extern void bpf_key_put(struct bpf_key *key) __ksym;
+extern int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_ptr,
+				      struct bpf_dynptr *sig_ptr,
+				      struct bpf_key *trusted_keyring) __ksym;
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} array_map SEC(".maps");
+
+int err, pid;
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
+
+SEC("lsm.s/bpf")
+int BPF_PROG(dynptr_data_null, int cmd, union bpf_attr *attr, unsigned int size)
+{
+	struct bpf_key *trusted_keyring;
+	struct bpf_dynptr ptr;
+	__u32 *value;
+	int ret, zero = 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 0;
+
+	value = bpf_map_lookup_elem(&array_map, &zero);
+	if (!value)
+		return 0;
+
+	/* Pass invalid flags. */
+	ret = bpf_dynptr_from_mem(value, sizeof(*value), 1, &ptr);
+	if (ret != -EINVAL)
+		return 0;
+
+	trusted_keyring = bpf_lookup_system_key(0);
+	if (!trusted_keyring)
+		return 0;
+
+	err = bpf_verify_pkcs7_signature(&ptr, &ptr, trusted_keyring);
+
+	bpf_key_put(trusted_keyring);
+
+	return 0;
+}
-- 
2.25.1

