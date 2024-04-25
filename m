Return-Path: <linux-kselftest+bounces-8849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A1F8B1BF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 09:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CFAB22DD8
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Apr 2024 07:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC97978C7F;
	Thu, 25 Apr 2024 07:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mf+6aaZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9B76EB7C
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030410; cv=none; b=cz6IkOQYjkvreCxOSG9jWLrZUEzvf42ALHXnMrPa0LFrnNbOUKuC+k/zUhsyz5zckbrcElafX3aZyH+udCrLYmFxCDIRuY9t8WxmY2+O6N+zvxVFKLOSI2J3DVh1ZcCLxKdkeJFzzV7Sx8nFkBfXtE5UhUAIR7UzU1Tm+RYAyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030410; c=relaxed/simple;
	bh=mHN9hs8IGVejgkls9jR3iaBoc87nNEzT105MD6zHbm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WW8w/j/5TDAUO3oLx2zp0f9P/fu2tbzihkQFJezXGocFIlraS7b/FuA9Uo3CG+5Vh7+PeOLjAXC/dS2NZFK2CQ89YmGXiSNBYy8YWMCKld2RbI3VlAVzzt3LD/kHx7oBGwOph02Ck2itlwOTeeJXJQy6XmpLk0qWJyR4cfnBYoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mf+6aaZK; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D68B33F8DE
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 07:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714030406;
	bh=/dNvDnYrusTnWvle5YeikJ1eJyd4ePVKnyqmYISNV5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=mf+6aaZKin3AH5k8upDI8xst2qd5u7kda4nVtB29fp8Xj9QE6IZDj5QVwWvSbwOlH
	 a1jk/igNroGBJLKlwfeUMnm+zbbwrGXZlaAvPop04G812dWdKsACKKfuS+Q0GvXE5R
	 Tp/qAbbHE6VsTpd8XZF4jSHNPqrbYrPCE/v5IYKztz69k4RhiO6IPyqcci7PaMk5wP
	 YSRVHZOA9EZ4mJEeOyyGpqThYokSlOQF6KKwTwyRTcmF+cDpstWxdc7SB3jj1dH6nW
	 HhpsiKhRmN2SQOeYJ2bu18LVaGYDJ5h9vQMiBlsuhcdtMgv98mtDJXSksgiDElUz9x
	 Q6u7t7CV3vk0w==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d87257c610so6135411fa.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Apr 2024 00:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714030406; x=1714635206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dNvDnYrusTnWvle5YeikJ1eJyd4ePVKnyqmYISNV5Q=;
        b=H7vLEei3twqc9a2r+Ex5eZ7UhmtNGbouYr5zyR6RO3VYh1FTbeuohq8tPKlLGc6azn
         eKEcZOi+Nuh8XEvtRthVl+BVj/3vLMU4NImwv/SCqCL45JX34jReQeOG8XfFwL1mN/lw
         XssTzafMKuUf9+mPT5jujgnXuS5Asm7atibSwVk9TMnBZTLlzDNFOeQmBIpVEKpIjTmg
         Nl+GQzn6WG/8EVUdG69rtdrPnD0poZVMsMoHyv2PYBuIJxjeecWKFQ3iTNszsoN6mOSW
         9n3LvX3Idb/0JGp3xue4eJl9wZFyOwp/uPxwKIgy6I15u8L81d68YYJoQi7m0462GpmR
         tMMw==
X-Forwarded-Encrypted: i=1; AJvYcCXnkoHzVvUGdbveF8z6FdWguUPuxukSbrI919H7KCrZTguyH+s0UQgVEMkcfaZh24Cq7NwOA2TU+Cpu94I3pxLYoUV3gRL2F+EsayHY9j3P
X-Gm-Message-State: AOJu0Yxvee3fyvZxgWWzDgIcPqrEDPscJB5Ysf4Jd48Hc5EFZ84ElWHL
	pvjOIjYrJx6eDpo3Z6MPFcbuquLKF3odg+atgDb3aIxYium9+1lX6uWMggIzJR/vyNKHLujjXit
	yc9Zgte9TKSzCOJWSa5ETgitJNApVGp8OxiyVjiDosE+i2aiTkMsMJSbXlMi/en8/b8kFh/wqvS
	2+OBVZkw==
X-Received: by 2002:a2e:a443:0:b0:2d6:f5c6:e5a1 with SMTP id v3-20020a2ea443000000b002d6f5c6e5a1mr3734850ljn.12.1714030406067;
        Thu, 25 Apr 2024 00:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQJtnvVjGkoBiH1AcBJyrCRFzXR25CaKZuxuIct87H/8ZtDjstKzHj+iLLTF07OP2hJibrQ==
X-Received: by 2002:a2e:a443:0:b0:2d6:f5c6:e5a1 with SMTP id v3-20020a2ea443000000b002d6f5c6e5a1mr3734811ljn.12.1714030405402;
        Thu, 25 Apr 2024 00:33:25 -0700 (PDT)
Received: from localhost.localdomain (host-82-49-69-7.retail.telecomitalia.it. [82.49.69.7])
        by smtp.gmail.com with ESMTPSA id f1-20020a170906ef0100b00a587cfd7a37sm3065742ejs.84.2024.04.25.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:33:24 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH v2] selftests/bpf: Add ring_buffer__consume_n test.
Date: Thu, 25 Apr 2024 09:33:19 +0200
Message-ID: <20240425073319.75389-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a testcase for the ring_buffer__consume_n() API.

The test produces multiple samples in a ring buffer, using a
sys_getpid() fentry prog, and consumes them from user-space in batches,
rather than consuming all of them greedily, like ring_buffer__consume()
does.

Link: https://lore.kernel.org/lkml/CAEf4BzaR4zqUpDmj44KNLdpJ=Tpa97GrvzuzVNO5nM6b7oWd1w@mail.gmail.com
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/bpf/Makefile          |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        | 64 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_n.c      | 47 ++++++++++++++
 3 files changed, 112 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c

ChangeLog v1 -> v2:
 - replace CHECK() with ASSERT_EQ()
 - fix skel -> skel_n
 - drop unused "seq" field from struct sample

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index edc73f8f5aef..6332277edeca 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -455,7 +455,7 @@ LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 LSKELS := fentry_test.c fexit_test.c fexit_sleep.c atomics.c 		\
 	trace_printk.c trace_vprintk.c map_ptr_kern.c 			\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
-	test_ringbuf_map_key.c
+	test_ringbuf_n.c test_ringbuf_map_key.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
index 48c5695b7abf..d59500d13a41 100644
--- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
+++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
@@ -13,6 +13,7 @@
 #include <linux/perf_event.h>
 #include <linux/ring_buffer.h>
 #include "test_ringbuf.lskel.h"
+#include "test_ringbuf_n.lskel.h"
 #include "test_ringbuf_map_key.lskel.h"
 
 #define EDONE 7777
@@ -60,6 +61,7 @@ static int process_sample(void *ctx, void *data, size_t len)
 }
 
 static struct test_ringbuf_map_key_lskel *skel_map_key;
+static struct test_ringbuf_n_lskel *skel_n;
 static struct test_ringbuf_lskel *skel;
 static struct ring_buffer *ringbuf;
 
@@ -326,6 +328,66 @@ static void ringbuf_subtest(void)
 	test_ringbuf_lskel__destroy(skel);
 }
 
+/*
+ * Test ring_buffer__consume_n() by producing N_TOT_SAMPLES samples in the ring
+ * buffer, via getpid(), and consuming them in chunks of N_SAMPLES.
+ */
+#define N_TOT_SAMPLES	32
+#define N_SAMPLES	4
+
+/* Sample value to verify the callback validity */
+#define SAMPLE_VALUE	42L
+
+static int process_n_sample(void *ctx, void *data, size_t len)
+{
+	struct sample *s = data;
+
+	ASSERT_EQ(s->value, SAMPLE_VALUE, "sample_value");
+
+	return 0;
+}
+
+static void ringbuf_n_subtest(void)
+{
+	int err, i;
+
+	skel_n = test_ringbuf_n_lskel__open();
+	if (!ASSERT_OK_PTR(skel_n, "test_ringbuf_n_lskel__open"))
+		return;
+
+	skel_n->maps.ringbuf.max_entries = getpagesize();
+	skel_n->bss->pid = getpid();
+
+	err = test_ringbuf_n_lskel__load(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__load"))
+		goto cleanup;
+
+	ringbuf = ring_buffer__new(skel_n->maps.ringbuf.map_fd,
+				   process_n_sample, NULL, NULL);
+	if (!ASSERT_OK_PTR(ringbuf, "ring_buffer__new"))
+		goto cleanup;
+
+	err = test_ringbuf_n_lskel__attach(skel_n);
+	if (!ASSERT_OK(err, "test_ringbuf_n_lskel__attach"))
+		goto cleanup_ringbuf;
+
+	/* Produce N_TOT_SAMPLES samples in the ring buffer by calling getpid() */
+	skel_n->bss->value = SAMPLE_VALUE;
+	for (i = 0; i < N_TOT_SAMPLES; i++)
+		syscall(__NR_getpgid);
+
+	/* Consume all samples from the ring buffer in batches of N_SAMPLES */
+	for (i = 0; i < N_TOT_SAMPLES; i += err) {
+		err = ring_buffer__consume_n(ringbuf, N_SAMPLES);
+		ASSERT_EQ(err, N_SAMPLES, "rb_consume");
+	}
+
+cleanup_ringbuf:
+	ring_buffer__free(ringbuf);
+cleanup:
+	test_ringbuf_n_lskel__destroy(skel_n);
+}
+
 static int process_map_key_sample(void *ctx, void *data, size_t len)
 {
 	struct sample *s;
@@ -384,6 +446,8 @@ void test_ringbuf(void)
 {
 	if (test__start_subtest("ringbuf"))
 		ringbuf_subtest();
+	if (test__start_subtest("ringbuf_n"))
+		ringbuf_n_subtest();
 	if (test__start_subtest("ringbuf_map_key"))
 		ringbuf_map_key_subtest();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_n.c b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
new file mode 100644
index 000000000000..8669eb42dbe0
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2024 Andrea Righi <andrea.righi@canonical.com>
+
+#include <linux/bpf.h>
+#include <sched.h>
+#include <unistd.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define TASK_COMM_LEN 16
+
+struct sample {
+	int pid;
+	long value;
+	char comm[16];
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+} ringbuf SEC(".maps");
+
+int pid = 0;
+long value = 0;
+
+SEC("fentry/" SYS_PREFIX "sys_getpgid")
+int test_ringbuf_n(void *ctx)
+{
+	int cur_pid = bpf_get_current_pid_tgid() >> 32;
+	struct sample *sample;
+
+	if (cur_pid != pid)
+		return 0;
+
+	sample = bpf_ringbuf_reserve(&ringbuf, sizeof(*sample), 0);
+	if (!sample)
+		return 0;
+
+	sample->pid = pid;
+	sample->value = value;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
-- 
2.43.0


