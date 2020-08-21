Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330DC24D25F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Aug 2020 12:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgHUKar (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Aug 2020 06:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgHUKa3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Aug 2020 06:30:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F38C06138B
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Aug 2020 03:30:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x5so1351236wmi.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Aug 2020 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ljj6mTtU91lq7b/TfTSVrxl5C/pW9YScENl9tsdXqbE=;
        b=R6p7I49mAyk1+W/1Y8Pnkj+mPEMAav3VZSQytD31wbItfpPh1Qs0BJRa8ngMSMmjVq
         lsT3jzTRAxyRpyrFWE4AEx/R/OIiq4h52+GF1ZVtXGRHSjxdRyzllAiImC/uBP6TtXnM
         wkVWRM2JUBizEGV5pleLWeCgkBHVUm4VjMoLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ljj6mTtU91lq7b/TfTSVrxl5C/pW9YScENl9tsdXqbE=;
        b=Hb4ra90ZAkIXAp0SinTlFLN86X1MrP2rDWX95qzup86I32DtWREleCY9aDch+6Qj8I
         BOMojIrVZ1W8EIhj5Wt2TEpw+u0lJywR4Vt88LIG8DzlLJuQRDlFTTuNtUPVwGwudRbm
         k9bQUTFr/xfPMEa4P0WTZvz8NwQdk5kNcHF8S+o3cXYI0LMl1PmJcYhGcmvkkRFFRhC0
         audZ5KRZ9MIy2dTV4cWDWP7IttfAh7tbcWeso9eIW3oq1cJyiNaFbUrKIcodVBpqyTSz
         c4CwgWdut0UAzVMoiir7j4TJenMoSc1iZI6gQWCp0sbks1fTCo1UbttPmMNe4NpzS19I
         Qc/A==
X-Gm-Message-State: AOAM532GT46fojxF4ZEa0WoTSC/ycuYqfXblvelwPM1uqMrOgI2Gvb5L
        67epWFPuea+6mwzAHgBP4xMNoA==
X-Google-Smtp-Source: ABdhPJz9f3ah9Zo/6HnA8IeHmu273+Rifoigfi0sKLMZW8R0SQvk9WprxK0NUVRIpTs//b2yLmRzdg==
X-Received: by 2002:a1c:9803:: with SMTP id a3mr2979278wme.57.1598005817804;
        Fri, 21 Aug 2020 03:30:17 -0700 (PDT)
Received: from antares.lan (2.2.9.a.d.9.4.f.6.1.8.9.f.9.8.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:589f:9816:f49d:a922])
        by smtp.gmail.com with ESMTPSA id o2sm3296885wrj.21.2020.08.21.03.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:30:17 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     jakub@cloudflare.com, john.fastabend@gmail.com, yhs@fb.com,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] selftests: bpf: test sockmap update from BPF
Date:   Fri, 21 Aug 2020 11:29:48 +0100
Message-Id: <20200821102948.21918-7-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821102948.21918-1-lmb@cloudflare.com>
References: <20200821102948.21918-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a test which copies a socket from a sockmap into another sockmap
or sockhash. This excercises bpf_map_update_elem support from BPF
context. Compare the socket cookies from source and destination to
ensure that the copy succeeded.

Also check that the verifier rejects map_update from unsafe contexts.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 78 +++++++++++++++++++
 .../bpf/progs/test_sockmap_invalid_update.c   | 23 ++++++
 .../selftests/bpf/progs/test_sockmap_update.c | 48 ++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_invalid_update.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_update.c

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 96e7b7f84c65..65ce7c289534 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -4,6 +4,8 @@
 
 #include "test_progs.h"
 #include "test_skmsg_load_helpers.skel.h"
+#include "test_sockmap_update.skel.h"
+#include "test_sockmap_invalid_update.skel.h"
 
 #define TCP_REPAIR		19	/* TCP sock is under repair right now */
 
@@ -101,6 +103,76 @@ static void test_skmsg_helpers(enum bpf_map_type map_type)
 	test_skmsg_load_helpers__destroy(skel);
 }
 
+static void test_sockmap_update(enum bpf_map_type map_type)
+{
+	struct bpf_prog_test_run_attr tattr;
+	int err, prog, src, dst, duration = 0;
+	struct test_sockmap_update *skel;
+	__u64 src_cookie, dst_cookie;
+	const __u32 zero = 0;
+	char dummy[14] = {0};
+	__s64 sk;
+
+	sk = connected_socket_v4();
+	if (CHECK(sk == -1, "connected_socket_v4", "cannot connect\n"))
+		return;
+
+	skel = test_sockmap_update__open_and_load();
+	if (CHECK(!skel, "open_and_load", "cannot load skeleton\n")) {
+		close(sk);
+		return;
+	}
+
+	prog = bpf_program__fd(skel->progs.copy_sock_map);
+	src = bpf_map__fd(skel->maps.src);
+	if (map_type == BPF_MAP_TYPE_SOCKMAP)
+		dst = bpf_map__fd(skel->maps.dst_sock_map);
+	else
+		dst = bpf_map__fd(skel->maps.dst_sock_hash);
+
+	err = bpf_map_update_elem(src, &zero, &sk, BPF_NOEXIST);
+	if (CHECK(err, "update_elem(src)", "errno=%u\n", errno))
+		goto out;
+
+	err = bpf_map_lookup_elem(src, &zero, &src_cookie);
+	if (CHECK(err, "lookup_elem(src, cookie)", "errno=%u\n", errno))
+		goto out;
+
+	tattr = (struct bpf_prog_test_run_attr){
+		.prog_fd = prog,
+		.repeat = 1,
+		.data_in = dummy,
+		.data_size_in = sizeof(dummy),
+	};
+
+	err = bpf_prog_test_run_xattr(&tattr);
+	if (CHECK_ATTR(err || !tattr.retval, "bpf_prog_test_run",
+		       "errno=%u retval=%u\n", errno, tattr.retval))
+		goto out;
+
+	err = bpf_map_lookup_elem(dst, &zero, &dst_cookie);
+	if (CHECK(err, "lookup_elem(dst, cookie)", "errno=%u\n", errno))
+		goto out;
+
+	CHECK(dst_cookie != src_cookie, "cookie mismatch", "%llu != %llu\n",
+	      dst_cookie, src_cookie);
+
+out:
+	close(sk);
+	test_sockmap_update__destroy(skel);
+}
+
+static void test_sockmap_invalid_update(void)
+{
+	struct test_sockmap_invalid_update *skel;
+	int duration = 0;
+
+	skel = test_sockmap_invalid_update__open_and_load();
+	CHECK(skel, "open_and_load", "verifier accepted map_update\n");
+	if (skel)
+		test_sockmap_invalid_update__destroy(skel);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -111,4 +183,10 @@ void test_sockmap_basic(void)
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKMAP);
 	if (test__start_subtest("sockhash sk_msg load helpers"))
 		test_skmsg_helpers(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sockmap update"))
+		test_sockmap_update(BPF_MAP_TYPE_SOCKMAP);
+	if (test__start_subtest("sockhash update"))
+		test_sockmap_update(BPF_MAP_TYPE_SOCKHASH);
+	if (test__start_subtest("sockmap update in unsafe context"))
+		test_sockmap_invalid_update();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_invalid_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_invalid_update.c
new file mode 100644
index 000000000000..02a59e220cbc
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_invalid_update.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Cloudflare
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} map SEC(".maps");
+
+SEC("sockops")
+int bpf_sockmap(struct bpf_sock_ops *skops)
+{
+	__u32 key = 0;
+
+	if (skops->sk)
+		bpf_map_update_elem(&map, &key, skops->sk, 0);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_sockmap_update.c b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
new file mode 100644
index 000000000000..9d0c9f28cab2
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_sockmap_update.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2020 Cloudflare
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} src SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKMAP);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst_sock_map SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_SOCKHASH);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u64);
+} dst_sock_hash SEC(".maps");
+
+SEC("classifier/copy_sock_map")
+int copy_sock_map(void *ctx)
+{
+	struct bpf_sock *sk;
+	bool failed = false;
+	__u32 key = 0;
+
+	sk = bpf_map_lookup_elem(&src, &key);
+	if (!sk)
+		return SK_DROP;
+
+	if (bpf_map_update_elem(&dst_sock_map, &key, sk, 0))
+		failed = true;
+
+	if (bpf_map_update_elem(&dst_sock_hash, &key, sk, 0))
+		failed = true;
+
+	bpf_sk_release(sk);
+	return failed ? SK_DROP : SK_PASS;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.25.1

