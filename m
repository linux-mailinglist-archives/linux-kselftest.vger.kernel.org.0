Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B2176B75C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 16:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjHAO04 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 10:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjHAO0w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 10:26:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D703E1FC6;
        Tue,  1 Aug 2023 07:26:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bb775625e2so37517725ad.1;
        Tue, 01 Aug 2023 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690900009; x=1691504809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sU+jnsfF3qd3Nicz0CmetjFrKuzZhIcjZbK3uCZNd0U=;
        b=WtYp1UWv6iwV0u/y76mh23hRQ+a0MNn6Pn38CQD4z6ZZc4/RZxkex9OVflI/6/Ct7i
         tqKkDxwKY2WWtL/mMlKIV9zttLYSrHnaFZwvtuxDP5hFImvSTU0cdSnztu2dKJP5xGHt
         1kqbBnDmY7V+QTrQI6QV7/V9Qv9zLQA0Umxj2TksIqEL7mOAXMwEKGwNbZevm4r/h8Wc
         J6P3DRglIt0aPVkH1obSgi1Nioaw0Aa6vj/HmhFvIefVdkDrQsdzQbUbCCQZDMCg4U9V
         XLnlWUHsI69ow/9XGw3K0/tlQ2uwZsuiy+Sb9DSDzMBhvlsTWNeMm8UoGB/RSUum3nce
         nrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690900009; x=1691504809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sU+jnsfF3qd3Nicz0CmetjFrKuzZhIcjZbK3uCZNd0U=;
        b=egwOrjpkg1uUZXXDjvs/uG1Nia3005wkoh07VYpKe9Zc0llc/vqxiX9jpAHKv+vv/q
         J2h5WNLPgOvvTr4W3wvkAGMUpXcvvfGCcj3/MKf1/FtyWwtSP9TZ3SX4XkOQfi04Oyjt
         OWP3i7driF72rumn9BZdB/ORBNzeVM8MK2OT+KGrDYiH2s8BY4vsQzipHvTVjx9XnUjr
         Exb4ANIc0JzCCdqgQ2AE/JM0Sz/YwJPugW7CQxKJYEPaZKptIfjcS2xCCQWn4DPcEFYq
         1+ts1pvxl5n+OmAxdusFLS2wIzkYKx5ZehH5mSZSEkT3zXEVbISnVQZLJ6jAGOKmyCVv
         uJDw==
X-Gm-Message-State: ABy/qLY2HAyxW2yjGDuUXp1JZzu4gYz3q8O3nwtPBWP563dxNRcfN2qi
        xXukMNYAIx22XCGJT06VsEfwSrC/cRiHHYn8
X-Google-Smtp-Source: APBJJlGXWNmDSziieGkGGouNt5Btt4C/CtFHJdxcZK3q6fe/xi8wEMStSsy7be02mHeJq8nBSocA1w==
X-Received: by 2002:a17:902:ce83:b0:1bc:17ab:8d68 with SMTP id f3-20020a170902ce8300b001bc17ab8d68mr7037501plg.16.1690900008864;
        Tue, 01 Aug 2023 07:26:48 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c10600b001b8a00d4f7asm10565100pli.9.2023.08.01.07.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 07:26:48 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        hawk@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mykolal@fb.com, shuah@kernel.org, hffilwlqm@gmail.com,
        tangyeechou@gmail.com, kernel-patches-bot@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add testcase for xdp attaching failure tracepoint
Date:   Tue,  1 Aug 2023 22:26:21 +0800
Message-ID: <20230801142621.7925-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801142621.7925-1-hffilwlqm@gmail.com>
References: <20230801142621.7925-1-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test case for the tracepoint of xdp attaching failure by bpf
tracepoint when attach XDP to a device with invalid flags option.

The bpf tracepoint retrieves error message from the tracepoint, and
then put the error message to a perf buffer. The testing code receives
error message from perf buffer, and then ASSERT "Invalid XDP flags for
BPF link attachment".

Signed-off-by: Leon Hwang <hffilwlqm@gmail.com>
---
 .../selftests/bpf/prog_tests/xdp_attach.c     | 65 +++++++++++++++++++
 .../bpf/progs/test_xdp_attach_fail.c          | 54 +++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
index fa3cac5488f5d..e6bcb6051402d 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_attach.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
+#include "test_xdp_attach_fail.skel.h"
 
 #define IFINDEX_LO 1
 #define XDP_FLAGS_REPLACE		(1U << 4)
@@ -85,10 +86,74 @@ static void test_xdp_attach(const char *file)
 	bpf_object__close(obj1);
 }
 
+#define ERRMSG_LEN 64
+
+struct xdp_errmsg {
+	char msg[ERRMSG_LEN];
+};
+
+static void on_xdp_errmsg(void *ctx, int cpu, void *data, __u32 size)
+{
+	struct xdp_errmsg *ctx_errmg = ctx, *tp_errmsg = data;
+
+	memcpy(&ctx_errmg->msg, &tp_errmsg->msg, ERRMSG_LEN);
+}
+
+static const char tgt_errmsg[] = "Invalid XDP flags for BPF link attachment";
+
+static void test_xdp_attach_fail(const char *file)
+{
+	struct test_xdp_attach_fail *skel = NULL;
+	struct xdp_errmsg errmsg = {};
+	struct perf_buffer *pb = NULL;
+	struct bpf_object *obj = NULL;
+	int err, fd_xdp;
+
+	LIBBPF_OPTS(bpf_link_create_opts, opts);
+
+	skel = test_xdp_attach_fail__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "test_xdp_attach_fail__open_and_load"))
+		goto out_close;
+
+	err = test_xdp_attach_fail__attach(skel);
+	if (!ASSERT_EQ(err, 0, "test_xdp_attach_fail__attach"))
+		goto out_close;
+
+	/* set up perf buffer */
+	pb = perf_buffer__new(bpf_map__fd(skel->maps.xdp_errmsg_pb), 1,
+			      on_xdp_errmsg, NULL, &errmsg, NULL);
+	if (!ASSERT_OK_PTR(pb, "perf_buffer__new"))
+		goto out_close;
+
+	err = bpf_prog_test_load(file, BPF_PROG_TYPE_XDP, &obj, &fd_xdp);
+	if (!ASSERT_EQ(err, 0, "bpf_prog_test_load"))
+		goto out_close;
+
+	opts.flags = 0xFF; // invalid flags to fail to attach XDP prog
+	err = bpf_link_create(fd_xdp, IFINDEX_LO, BPF_XDP, &opts);
+	if (!ASSERT_EQ(err, -EINVAL, "bpf_link_create"))
+		goto out_close;
+
+	/* read perf buffer */
+	err = perf_buffer__poll(pb, 100);
+	if (!ASSERT_GT(err, -1, "perf_buffer__poll"))
+		goto out_close;
+
+	ASSERT_STRNEQ((const char *) errmsg.msg, tgt_errmsg,
+		      42 /* strlen(tgt_errmsg) */, "check error message");
+
+out_close:
+	perf_buffer__free(pb);
+	bpf_object__close(obj);
+	test_xdp_attach_fail__destroy(skel);
+}
+
 void serial_test_xdp_attach(void)
 {
 	if (test__start_subtest("xdp_attach"))
 		test_xdp_attach("./test_xdp.bpf.o");
 	if (test__start_subtest("xdp_attach_dynptr"))
 		test_xdp_attach("./test_xdp_dynptr.bpf.o");
+	if (test__start_subtest("xdp_attach_failed"))
+		test_xdp_attach_fail("./xdp_dummy.bpf.o");
 }
diff --git a/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c b/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
new file mode 100644
index 0000000000000..2ff1b596e87ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_xdp_attach_fail.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Leon Hwang */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+#define ERRMSG_LEN 64
+
+struct xdp_errmsg {
+	char msg[ERRMSG_LEN];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
+	__type(key, int);
+	__type(value, int);
+} xdp_errmsg_pb SEC(".maps");
+
+struct xdp_attach_error_ctx {
+	unsigned long unused;
+
+	/*
+	 * bpf does not support tracepoint __data_loc directly.
+	 *
+	 * Actually, this field is a 32 bit integer whose value encodes
+	 * information on where to find the actual data. The first 2 bytes is
+	 * the size of the data. The last 2 bytes is the offset from the start
+	 * of the tracepoint struct where the data begins.
+	 * -- https://github.com/iovisor/bpftrace/pull/1542
+	 */
+	__u32 msg; // __data_loc char[] msg;
+};
+
+/*
+ * Catch the error message at the tracepoint.
+ */
+
+SEC("tp/xdp/bpf_xdp_link_attach_failed")
+int tp__xdp__bpf_xdp_link_attach_failed(struct xdp_attach_error_ctx *ctx)
+{
+	char *msg = (void *)(__u64) ((void *) ctx + (__u16) ctx->msg);
+	struct xdp_errmsg errmsg = {};
+
+	bpf_probe_read_kernel_str(&errmsg.msg, ERRMSG_LEN, msg);
+	bpf_perf_event_output(ctx, &xdp_errmsg_pb, BPF_F_CURRENT_CPU, &errmsg,
+			      ERRMSG_LEN);
+	return 0;
+}
+
+/*
+ * Reuse the XDP program in xdp_dummy.c.
+ */
+
+char LICENSE[] SEC("license") = "GPL";
-- 
2.41.0

