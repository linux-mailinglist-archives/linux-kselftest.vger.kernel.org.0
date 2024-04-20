Return-Path: <linux-kselftest+bounces-8558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE38C8ABC49
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 17:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C7C8B20D36
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 15:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B2374F7;
	Sat, 20 Apr 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="IaQxaafP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B22B2CCD7
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628761; cv=none; b=qfrPkeqXHYK8i+zRhwmrsu25tDcnl2Y0ND4eWZf0RbpR5IorioP36X4wo7zIYm9bA0bsVQbgcsJqlAdCVsXXHu6L5Pe4mZ6NAbi4BG3q/OaTrKJ+F2Gvh1xYA2Fc8fHk8YbC0xhZiOArGuL3Du95MFZC4U+s1Hc8IJ4P7igbJKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628761; c=relaxed/simple;
	bh=nNRohb4TCqxwIK1Y/PiM1fnTGVi7tniX1l39w0EWGdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lzKo8a3Z4Bc7+PD7tHqF+PSz4JHZfghllHVs6DydoRDYQA0/Q/LfEAA2ro8okkIDEawmYmGSgduHV2gvyRbaGkqLcvwTSFTPu8agNT/e8mDO+XmgL+IUdyd389F13mc8WYoZ80R+lhGY8Q+CDwfj0aVrcA1a2uDgXIHMoj3Es+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=IaQxaafP; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 780573FE52
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713628757;
	bh=L2v1NeYeJE3K4VQPmxfg+80DARtMgvysXIKgeUBdR7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=IaQxaafP0RI6w+LhjF/CtgcNSL2QeYTInK56J0Ct6tN33b1Id/CGFJ5rINkBfmYXv
	 H/nYgI5yoKWgbeJqEo3LfuK1cFbndwkh4oooMOZIxiv6CBLOlsUv5+8FXb+38HymiU
	 OThpOYkWw0KaozsJq7ZL1OMJg5tSf+ITMJZta8cuArjfKwxtTbVF8IZ5urbmImdKfz
	 er4oVvVZpUjTCpZu48To22HG9JvH6XXJy/7g42Wt6+9sviT4DErQe6HeO/rblufJCa
	 jqzzisd7TodJ3JX/XMS6kUA5VOFeElOQoW4SkwIg7oIIu23Bqv2Qc5gipICI4R/LJu
	 +ArQ0gFgPfgAg==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-419e3f83aeeso4124995e9.1
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Apr 2024 08:59:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713628755; x=1714233555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L2v1NeYeJE3K4VQPmxfg+80DARtMgvysXIKgeUBdR7A=;
        b=XsWNE670fSUgmWo8mXlZkcWRrJUCxU2JPDps5H65XVL5C8d+EDmF2Odz3eMSswU0RY
         T41xnBPsYjg2BsEd4DiGVcMr0KDROtItzF074q+iINAkJZ2W/xdhVtpp6xxz9dZlRy8q
         46WgR0dd+Zm6r3MZp359gsOjSg82C+8FDBMIwYqtfFHt9vy+5n0FsGG9bjLtrukRrJfX
         uQdhEXOnHOZ5kfpWt1j7GEDXMviM23hUW8nDAAsjOfn5dJRbA9WBvqLaNUgX0atdg+8I
         lcQ2ClPjTHIX7Ys14NWocY8cEklYSwveGettQnvmK8dHwT0zgI1FOeg+pdwvxcxjgRZZ
         cHaw==
X-Forwarded-Encrypted: i=1; AJvYcCVIWv7BUOMp9Y0DFQWv2MV0BzOD2QoT8JndDur3HHGuorLe8c+DDuUQyv726mmUlHBi1gjBuAJy5ugpnN/c6zQDqLp8MRxnZ6/1gbH2oXH2
X-Gm-Message-State: AOJu0Yyv9f7Cs93192Qa+/oDbPhSVwuwk/KB65fZXBY2f+swy7u/txW/
	qj0/IcDvzucwMhdV370SPrxUxGkUUr8Bq8Zt92a6CaASlB3l2wTcHWG0K5ECROlQGcnbOdalapD
	hHtcYpZVrXLTP7PIbf/MNXqFZin+dpNAXpenMdxNybzfsoy2k0l4T+3gNd8FM7LlikABOO1Mt6q
	ksssFGeg==
X-Received: by 2002:a05:600c:5008:b0:419:db01:f391 with SMTP id n8-20020a05600c500800b00419db01f391mr2064599wmr.12.1713628755025;
        Sat, 20 Apr 2024 08:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IES1yNyzlrb+9WaiK0MZQfB1d9PfHUIaT+JsnQy9N4roDXlEI01EQiBXdSmC1jsqyYTOTc6dQ==
X-Received: by 2002:a05:600c:5008:b0:419:db01:f391 with SMTP id n8-20020a05600c500800b00419db01f391mr2064560wmr.12.1713628754198;
        Sat, 20 Apr 2024 08:59:14 -0700 (PDT)
Received: from gpd.. ([151.57.165.71])
        by smtp.gmail.com with ESMTPSA id r16-20020a5d6950000000b003477d26736dsm7154350wrw.94.2024.04.20.08.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Apr 2024 08:59:13 -0700 (PDT)
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
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] selftests/bpf: Add ring_buffer__consume_n test.
Date: Sat, 20 Apr 2024 17:59:04 +0200
Message-ID: <20240420155904.1450768-1-andrea.righi@canonical.com>
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
 .../selftests/bpf/prog_tests/ringbuf.c        | 65 +++++++++++++++++++
 .../selftests/bpf/progs/test_ringbuf_n.c      | 52 +++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_n.c

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
index 48c5695b7abf..7e085bfce9b5 100644
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
 
@@ -326,6 +328,67 @@ static void ringbuf_subtest(void)
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
+	CHECK(s->value != SAMPLE_VALUE,
+	      "sample_value", "exp %ld, got %ld\n", SAMPLE_VALUE, s->value);
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
+	skel->bss->value = SAMPLE_VALUE;
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
@@ -384,6 +447,8 @@ void test_ringbuf(void)
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
index 000000000000..b98b5bb20699
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_ringbuf_n.c
@@ -0,0 +1,52 @@
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
+	int seq;
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
+/* inner state */
+long seq = 0;
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
+	sample->seq = seq++;
+	sample->value = value;
+	bpf_get_current_comm(sample->comm, sizeof(sample->comm));
+
+	bpf_ringbuf_submit(sample, 0);
+
+	return 0;
+}
-- 
2.43.0


