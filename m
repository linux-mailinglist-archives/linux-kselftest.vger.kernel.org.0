Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB62E77BA5F
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 15:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjHNNmq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 09:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjHNNmg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 09:42:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BD1BD;
        Mon, 14 Aug 2023 06:42:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68842ebdcf7so269987b3a.0;
        Mon, 14 Aug 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692020552; x=1692625352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8S8IoAhjbFZeofOhQRb5ODQBnSkFGF/yd2MFLkn/fE=;
        b=I0dLowdTQdHKSHgkvEK4Dy/3mwTjxxTRjYbgNNSZkCUeoJ4H7AxNEDzQ+zDX0goFdU
         VUdBzZ7zui94u3Si2K0bQvJop4c6/dSY3iX3mLzDLmT5V9n62ikWHTxTDyOawZ7HC4qk
         LUx6VStjWBpBELyB758D5VZ4HKdx6japHeT76yzaK75UItOnegoFmdMXqOoABb54+C69
         /bpqhT6Tj8WuaeXRPQjWCFq4bGZvllezVUS5DOfdrRctWYjzS3yRfuY+1sJ9rI9z+I8z
         7NpmY6UiwmuToFpW1ngzzfTHYWvRFUvG2CqVRn7P+LhANgBu56AMC2a9RDWZyvt52rhW
         1SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692020552; x=1692625352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8S8IoAhjbFZeofOhQRb5ODQBnSkFGF/yd2MFLkn/fE=;
        b=X8OgtKoH02mAjaEyDHXplEc/B5Il4kdmd/QXaEtnvXyAYhy3SElf0Dv+GEfgG65++S
         Eyku0upohRrYgCNnJCVHIeMunzDZzppViprpG3RAJ7MUovUQnQNhEwinaQQJXSC33DtN
         nh4N62+Ez0s9J4e7WXgT4YkDT6wD6e6Fmwb3JoZqdIeMZQ9q5Oo122BzQnDpgSvj27qs
         Zm1tJ79PYDN8/64s8eO3EcFXzvBADDMFEMhdXqomPX8keNBmRs4prvSDCQ+rjqQzkwq3
         WyVejkVowqwzV1cZRyUdgBqXmf47UN8CyW4wYHLoZ7Td0lvI1gFQPWmhw3VhAnLNieA4
         fF3w==
X-Gm-Message-State: AOJu0Yzh0UrnX61fbWW2nCUU2JRO6lGpyrxielcTVbGjmPs4WxAyDStW
        n7I1H5BJKF7KzLxgtv1Qw9o02SS5/1ViO1fQ
X-Google-Smtp-Source: AGHT+IEV1d5fwX8DghcP8CHXnc7XJ9KzT5DT5LX+tmxNOjKb3CrerxZ5zgrDevusRPaRVTG7RV4I/w==
X-Received: by 2002:a05:6a20:3d23:b0:138:64d4:b055 with SMTP id y35-20020a056a203d2300b0013864d4b055mr14531418pzi.55.1692020551693;
        Mon, 14 Aug 2023 06:42:31 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id m3-20020a638c03000000b0055c02b8688asm8555583pgd.20.2023.08.14.06.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:42:31 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, x86@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mykolal@fb.com,
        shuah@kernel.org, davem@davemloft.net, dsahern@kernel.org,
        hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, maciej.fijalkowski@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH bpf-next 2/2] selftests/bpf: Add testcases for tailcall infinite loop bug fixing
Date:   Mon, 14 Aug 2023 21:41:47 +0800
Message-ID: <20230814134147.70289-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814134147.70289-1-hffilwlqm@gmail.com>
References: <20230814134147.70289-1-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add 3 test cases to confirm the tailcall infinite loop bug has been fixed.

Like tailcall_bpf2bpf cases, do fentry/fexit on the bpf2bpf, and then
check the final count result.

tools/testing/selftests/bpf/test_progs -t tailcalls
226/13  tailcalls/tailcall_bpf2bpf_fentry:OK
226/14  tailcalls/tailcall_bpf2bpf_fexit:OK
226/15  tailcalls/tailcall_bpf2bpf_fentry_fexit:OK
226     tailcalls:OK
Summary: 1/15 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/tailcalls.c      | 194 +++++++++++++++++-
 .../bpf/progs/tailcall_bpf2bpf_fentry.c       |  18 ++
 .../bpf/progs/tailcall_bpf2bpf_fexit.c        |  18 ++
 3 files changed, 229 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c

diff --git a/tools/testing/selftests/bpf/prog_tests/tailcalls.c b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
index 58fe2c586ed76..a47c2fd6b8d37 100644
--- a/tools/testing/selftests/bpf/prog_tests/tailcalls.c
+++ b/tools/testing/selftests/bpf/prog_tests/tailcalls.c
@@ -634,7 +634,7 @@ static void test_tailcall_bpf2bpf_2(void)
 		return;
 
 	data_fd = bpf_map__fd(data_map);
-	if (CHECK_FAIL(map_fd < 0))
+	if (CHECK_FAIL(data_fd < 0))
 		return;
 
 	i = 0;
@@ -884,6 +884,191 @@ static void test_tailcall_bpf2bpf_6(void)
 	tailcall_bpf2bpf6__destroy(obj);
 }
 
+static void __tailcall_bpf2bpf_fentry_fexit(bool test_fentry, bool test_fexit)
+{
+	struct bpf_object *tgt_obj = NULL, *fentry_obj = NULL, *fexit_obj = NULL;
+	struct bpf_link *fentry_link = NULL, *fexit_link = NULL;
+	int err, map_fd, prog_fd, main_fd, data_fd, i, val;
+	struct bpf_map *prog_array, *data_map;
+	struct bpf_program *prog;
+	char buff[128] = {};
+
+	LIBBPF_OPTS(bpf_test_run_opts, topts,
+		.data_in = buff,
+		.data_size_in = sizeof(buff),
+		.repeat = 1,
+	);
+
+	err = bpf_prog_test_load("tailcall_bpf2bpf2.bpf.o",
+				 BPF_PROG_TYPE_SCHED_CLS,
+				 &tgt_obj, &prog_fd);
+	if (!ASSERT_OK(err, "load tgt_obj"))
+		return;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "entry");
+	if (!ASSERT_OK_PTR(prog, "find entry prog"))
+		goto out;
+
+	main_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(main_fd < 0, "find entry prog fd"))
+		goto out;
+
+	prog_array = bpf_object__find_map_by_name(tgt_obj, "jmp_table");
+	if (!ASSERT_OK_PTR(prog_array, "find jmp_table map"))
+		goto out;
+
+	map_fd = bpf_map__fd(prog_array);
+	if (!ASSERT_FALSE(map_fd < 0, "find jmp_table map fd"))
+		goto out;
+
+	prog = bpf_object__find_program_by_name(tgt_obj, "classifier_0");
+	if (!ASSERT_OK_PTR(prog, "find classifier_0 prog"))
+		goto out;
+
+	prog_fd = bpf_program__fd(prog);
+	if (!ASSERT_FALSE(prog_fd < 0, "find classifier_0 prog fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_update_elem(map_fd, &i, &prog_fd, BPF_ANY);
+	if (!ASSERT_OK(err, "update jmp_table"))
+		goto out;
+
+	if (test_fentry) {
+		fentry_obj = bpf_object__open_file("tailcall_bpf2bpf_fentry.bpf.o",
+						   NULL);
+		if (!ASSERT_OK_PTR(fentry_obj, "open fentry_obj file"))
+			goto out;
+
+		prog = bpf_object__find_program_by_name(fentry_obj, "fentry");
+		if (!ASSERT_OK_PTR(prog, "find fentry prog"))
+			goto out;
+
+		err = bpf_program__set_attach_target(prog, prog_fd,
+						     "subprog_tail");
+		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
+			goto out;
+
+		err = bpf_object__load(fentry_obj);
+		if (!ASSERT_OK(err, "load fentry_obj"))
+			goto out;
+
+		fentry_link = bpf_program__attach_trace(prog);
+		if (!ASSERT_OK_PTR(fentry_link, "attach_trace"))
+			goto out;
+	}
+
+	if (test_fexit) {
+		fexit_obj = bpf_object__open_file("tailcall_bpf2bpf_fexit.bpf.o",
+						  NULL);
+		if (!ASSERT_OK_PTR(fexit_obj, "open fexit_obj file"))
+			goto out;
+
+		prog = bpf_object__find_program_by_name(fexit_obj, "fexit");
+		if (!ASSERT_OK_PTR(prog, "find fexit prog"))
+			goto out;
+
+		err = bpf_program__set_attach_target(prog, prog_fd,
+						     "subprog_tail");
+		if (!ASSERT_OK(err, "set_attach_target subprog_tail"))
+			goto out;
+
+		err = bpf_object__load(fexit_obj);
+		if (!ASSERT_OK(err, "load fexit_obj"))
+			goto out;
+
+		fexit_link = bpf_program__attach_trace(prog);
+		if (!ASSERT_OK_PTR(fexit_link, "attach_trace"))
+			goto out;
+	}
+
+	err = bpf_prog_test_run_opts(main_fd, &topts);
+	ASSERT_OK(err, "tailcall");
+	ASSERT_EQ(topts.retval, 1, "tailcall retval");
+
+	data_map = bpf_object__find_map_by_name(tgt_obj, "tailcall.bss");
+	if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+			  "find tailcall.bss map"))
+		goto out;
+
+	data_fd = bpf_map__fd(data_map);
+	if (!ASSERT_FALSE(data_fd < 0, "find tailcall.bss map fd"))
+		goto out;
+
+	i = 0;
+	err = bpf_map_lookup_elem(data_fd, &i, &val);
+	ASSERT_OK(err, "tailcall count");
+	ASSERT_EQ(val, 33, "tailcall count");
+
+	if (test_fentry) {
+		data_map = bpf_object__find_map_by_name(fentry_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find tailcall_bpf2bpf_fentry.bss.bss map"))
+			goto out;
+
+		data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_FALSE(data_fd < 0,
+				  "find tailcall_bpf2bpf_fentry.bss.bss map fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_lookup_elem(data_fd, &i, &val);
+		ASSERT_OK(err, "fentry count");
+		ASSERT_EQ(val, 33, "fentry count");
+	}
+
+	if (test_fexit) {
+		data_map = bpf_object__find_map_by_name(fexit_obj, ".bss");
+		if (!ASSERT_FALSE(!data_map || !bpf_map__is_internal(data_map),
+				  "find tailcall_bpf2bpf_fexit.bss map"))
+			goto out;
+
+		data_fd = bpf_map__fd(data_map);
+		if (!ASSERT_FALSE(data_fd < 0,
+				  "find tailcall_bpf2bpf_fexit.bss map fd"))
+			goto out;
+
+		i = 0;
+		err = bpf_map_lookup_elem(data_fd, &i, &val);
+		ASSERT_OK(err, "fexit count");
+		ASSERT_EQ(val, 33, "fexit count");
+	}
+
+out:
+	bpf_link__destroy(fentry_link);
+	bpf_link__destroy(fexit_link);
+	bpf_object__close(fentry_obj);
+	bpf_object__close(fexit_obj);
+	bpf_object__close(tgt_obj);
+}
+
+/* test_tailcall_bpf2bpf_fentry checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fentry.
+ */
+static void test_tailcall_bpf2bpf_fentry(void)
+{
+	__tailcall_bpf2bpf_fentry_fexit(true, false);
+}
+
+/* test_tailcall_bpf2bpf_fexit checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by fexit.
+ */
+static void test_tailcall_bpf2bpf_fexit(void)
+{
+	__tailcall_bpf2bpf_fentry_fexit(false, true);
+}
+
+/* test_tailcall_bpf2bpf_fentry_fexit checks that the count value of the tail call
+ * limit enforcement matches with expectations when tailcall is preceded with
+ * bpf2bpf call, and the bpf2bpf call is traced by both fentry and fexit.
+ */
+static void test_tailcall_bpf2bpf_fentry_fexit(void)
+{
+	__tailcall_bpf2bpf_fentry_fexit(true, true);
+}
+
 void test_tailcalls(void)
 {
 	if (test__start_subtest("tailcall_1"))
@@ -910,4 +1095,11 @@ void test_tailcalls(void)
 		test_tailcall_bpf2bpf_4(true);
 	if (test__start_subtest("tailcall_bpf2bpf_6"))
 		test_tailcall_bpf2bpf_6();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry"))
+		test_tailcall_bpf2bpf_fentry();
+	if (test__start_subtest("tailcall_bpf2bpf_fexit"))
+		test_tailcall_bpf2bpf_fexit();
+	if (test__start_subtest("tailcall_bpf2bpf_fentry_fexit"))
+		test_tailcall_bpf2bpf_fentry_fexit();
 }
+
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
new file mode 100644
index 0000000000000..8436c6729167c
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fentry.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int count = 0;
+
+SEC("fentry/subprog_tail")
+int BPF_PROG(fentry, struct sk_buff *skb)
+{
+	count++;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
new file mode 100644
index 0000000000000..fe16412c6e6e9
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf_fexit.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+int count = 0;
+
+SEC("fexit/subprog_tail")
+int BPF_PROG(fexit, struct sk_buff *skb)
+{
+	count++;
+
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.41.0

