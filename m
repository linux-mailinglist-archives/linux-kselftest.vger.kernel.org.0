Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11576768524
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Jul 2023 13:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjG3LuX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 30 Jul 2023 07:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjG3LuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 30 Jul 2023 07:50:23 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A531BCA;
        Sun, 30 Jul 2023 04:50:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-79095499a17so60476739f.3;
        Sun, 30 Jul 2023 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690717818; x=1691322618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfr1Y42UBgl3e0tdEuSJS6cxP3FzYxJ2E6D2Od/ZUJI=;
        b=q34ZyETJxnkUKVtdAl87ZXCQRaPMBnMUnOOoxaJxzg+uQDfIJ2fFXCP4ggLtXfQgmL
         U7JH9j+64DlOHzMa3hohOIPsVt+eEOxDerQTSkQObRrCVMa8PytKTWx+4lgb7tvkzCZG
         8arhBnIhtje5LdTOUPKqDyOhvlw5v1RaG6GBnzvNImmtF7svcWZ2D9CsZq6QAhO4fxkJ
         FaGpP0/9Rw+Iu6xSPBOT7NHeyVQBPG6H3CKWzaoRwqL6R00Res8y5RdpzbN6zdYvs3J6
         Newe68YaSJui0oNP3tSxYDrVab4mqnjm2LAxp69rhItX5iW93R/Casml3udemOWjUsAN
         TwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690717818; x=1691322618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfr1Y42UBgl3e0tdEuSJS6cxP3FzYxJ2E6D2Od/ZUJI=;
        b=Ry95Q6OPxBbT9qnJBmzw+IBKK1AAvJ148D9UsR7dEDRp3gLH/msKcx0KkXc60RpdwB
         GdtVWfJ80TMDxwl88OUqwhmPAs3fDi49dKVUDY6GPjn/9q+S+fNCE5XcG6uIhBrewExV
         sjlbptliMovjNyLmpx00LSJgZIfaWu5DJFEqTZeA9HVlF2tWNGRwF+RB2UIGp5ZrfgkJ
         2RMAUjV9tg/zrWESPd78BymMhRyl4EW8HIvKZUlb2zksiSmBjVPpY6bzH9noH2wkbsJU
         Rb36JvUm1QCDR+kqKIotPRsxiqCyYDcZSOugVW7+MfbNZksmiEDwRY04dHrfPThN/Mz1
         gXAw==
X-Gm-Message-State: ABy/qLbfHWJGgq3+BoJLjp2aNK5W/9CuxOC3k5u13K7k1H53pICLK3Ih
        XqV8pO+iY/XXBt7JT9jtMJ0=
X-Google-Smtp-Source: APBJJlHYabs5d+521Nt3ZmEBSUfIhJwIRO3dedJjoRuAR1wcLTNZF6om6dhc5zYP+nd+ls+RoJ03Bw==
X-Received: by 2002:a05:6602:392:b0:790:8b8a:e616 with SMTP id f18-20020a056602039200b007908b8ae616mr5560708iov.10.1690717818140;
        Sun, 30 Jul 2023 04:50:18 -0700 (PDT)
Received: from localhost.localdomain (bb219-74-209-211.singnet.com.sg. [219.74.209.211])
        by smtp.gmail.com with ESMTPSA id z9-20020aa791c9000000b00640dbbd7830sm6044479pfa.18.2023.07.30.04.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jul 2023 04:50:17 -0700 (PDT)
From:   Leon Hwang <hffilwlqm@gmail.com>
To:     ast@kernel.org
Cc:     daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, hawk@kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, mykolal@fb.com,
        shuah@kernel.org, hffilwlqm@gmail.com, tangyeechou@gmail.com,
        kernel-patches-bot@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 2/2] selftests/bpf: Add testcase for xdp attaching failure tracepoint
Date:   Sun, 30 Jul 2023 19:49:51 +0800
Message-ID: <20230730114951.74067-3-hffilwlqm@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230730114951.74067-1-hffilwlqm@gmail.com>
References: <20230730114951.74067-1-hffilwlqm@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
index fa3cac5488f5d..8c1cde74e9cd6 100644
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
+	int err, fd_xdp;
+	struct bpf_object *obj = NULL;
+	struct test_xdp_attach_fail *skel = NULL;
+	struct perf_buffer *pb = NULL;
+	struct xdp_errmsg errmsg = {};
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
index 0000000000000..d7149bbd95f75
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
+	struct xdp_errmsg errmsg;
+	char *msg = (void *)(__u64) ((void *) ctx + (__u16) ctx->msg);
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

