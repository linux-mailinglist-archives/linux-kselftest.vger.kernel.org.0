Return-Path: <linux-kselftest+bounces-37580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B6BB0A6D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 17:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F087F1C48307
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878C82DD5E2;
	Fri, 18 Jul 2025 15:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Ss5YrYCf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D42DCF43
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851163; cv=none; b=VNQCVQ/iuf8UtIvcy69fkCnXD3vegePBKt825UKDMp4nzdwoeMmLUzGr+RJRwdDTptPwODG0kn9GhC/Xzwfv1telF0qipe8Dr2unhp1mkC9StGQfxwiTRQqp5qMPhsGjMA8KVC3q83Ly6AOjPD2eSPTjxOEX9j+QTSjXPgRruMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851163; c=relaxed/simple;
	bh=rVVffuxMBus/RcxOhFWgCU5h3PEDgUw/qcl4X5xIi1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZGZ4OFl1VRnyjODoM2FvOt6hfyYTFd7DWYPUFnWyBlW6lmSWx2XKiRDycb+8DSPbH3Q9gjBKCjthAMPFpUEYtI/AgY8PlxXIWVCh4GGPPdVuExxz5f2LKzm9OgQCJUI32T1r9ePDMxpJi9VOzGpDkPC+E80cSe8a0MpDdImKsTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Ss5YrYCf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45555e3317aso13599125e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1752851159; x=1753455959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2BNj2X+SWkqF45adh7c1im/rMt4/J2J7kU0YH53i2ZQ=;
        b=Ss5YrYCfprQIQGHSgiR7IuWOa9fukiOrBt57DH+kDo/XBM/yj45o+LmE8duuHZiKHA
         FaMCkQdSxcwk5AZ4HXfrQMpbxDF6DcIwkRTRUAWA6HLMmxkA+u7ogDQQxlyYP8wGG5fV
         uT/s6qsVj5B6FqLYPb8C4NfUCRWztuTnoMS0kBNmzT99gqFfOjaGqp4lr1YdVPdHaPAI
         Ex7WXrhD2Su+QykzT7WCAqKcU6aUQp8NsspNBoqKkS+WkItHDijGnXrDVSCdOzDxEsgp
         lKh7vXCXaow9ns2ZyhSJ0xSSLD7FA+WS023MQWGNJRf0Xej1yublh0nIFT2FmzzLW3ui
         vIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752851159; x=1753455959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2BNj2X+SWkqF45adh7c1im/rMt4/J2J7kU0YH53i2ZQ=;
        b=sxZHLR7tUVr0a+RlxOBb4XSjLhMfZEApC5G46sE9hJlPncn/N/UM0vJO/oZL3bQM7M
         KtWnQQbWLJk8SE8re5m2imS3RkHUgMHsbS2hnkKXeCtZvSavJQFAXFC5SIM8K1Bl2Ybz
         87jt0QeCIbdeSL5EipJZNfqsREl2n68FHrGWh6zMFEDjX/XrKiqmjOmBktLljbgtQMaX
         OLIZborYolvUcOUBGLcSnKvXtwtaYNwb4G7nAf11qa/xM6hdoYCvbzIPwh0cR+Lg4In8
         jJ+EDtnh16SJwE/9xl2HkNAaZ8NaJ5SzhdUmXttL9w3B1GyADyxnVrXYC4rZff7lZAmu
         a3dA==
X-Forwarded-Encrypted: i=1; AJvYcCXfWssd1h2AfQCe3lChXG5hlcEE5e3cYEzo74/jSQDd1FAppm/YTMKIXxuscuJJ+Q9Jcmv1Bru3i7Ta4Ass3Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8S9uIDRfytYUG++WqU7UIttjjRCsWxuhsTn58bXsHyfOHUKt
	XQsEYOXOeePORT3HI0hVjvllAyU7paT3ahzbLo6iW32J7ubrAZhRhePM9oAkpgWkc8L01B1EsY2
	HyzF0Ptg=
X-Gm-Gg: ASbGnctTO1qkHMn+fNt0dzE0M2y1S/3QHqva6j+Zu+mYBkqQQVgWNzcjFNqpdXEkzMH
	Ja1m7kYPFFPg2rj2ZLKnqKuf6ZuU7tsMLjzr7P/OpQEt7NHypkbtwi/qZWSAG5v/tF4VEdZqBFt
	Z+2smLINSLOAl+StqHDB0wM7COitBKPrKwQtzXEPpGMthsn3tPbNXabYqHNkN/HvN7Bg7/1k/tI
	UQrq+XvqGI+P0vihaZ3cuAVtzA6upokA3h/XcKCyqt8T/X3ZaVnUWR+Di0c5Ht4hTXsMmdSdbZs
	L62A7pb6KgBE2Ss8qj9q9pv8jdBTdppJKUydxI763naZSfpzbdebcOs0tL9pyLUMR1q8FyII1So
	tv67rSnYHXqGSuXhY2SJyxy4=
X-Google-Smtp-Source: AGHT+IEM0M+YYT1WF4Hdxs+WLk7MoZfkohvjefp7bSXR0frzr0PWDAv5nHw9Mtw87NHmCDEjkQjtyg==
X-Received: by 2002:a05:600c:6097:b0:456:26ac:517a with SMTP id 5b1f17b1804b1-4562e3914b3mr102576995e9.24.1752851158340;
        Fri, 18 Jul 2025 08:05:58 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::3df:4e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e80731bsm80684255e9.15.2025.07.18.08.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 08:05:57 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>,
	kernel-team@cloudflare.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] selftests/bpf: Add LPM trie microbenchmarks
Date: Fri, 18 Jul 2025 16:05:54 +0100
Message-Id: <20250718150554.48210-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Add benchmarks for the standard set of operations: lookup, update,
delete. Also, include a benchmark for trie_free() which is known to have
terrible performance for maps with many entries.

Benchmarks operate on tries without gaps in the key range, i.e. each
test begins with a trie with valid keys in the range [0, nr_entries).
This is intended to cause maximum branching when traversing the trie.

All measurements are recorded inside the kernel to remove syscall
overhead.

Most benchmarks run an XDP program to generate stats but free needs to
collect latencies using fentry/fexit on map_free_deferred() because it's
not possible to use fentry directly on lpm_trie.c since commit
c83508da5620 ("bpf: Avoid deadlock caused by nested kprobe and fentry
bpf programs") and there's no way to create/destroy a map from within an
XDP program.

Here is example output from an AMD EPYC 9684X 96-Core machine for each
of the benchmarks using a trie with 10K entries and a 32-bit prefix
length, e.g.

  $ ./bench lpm-trie-$op \
  	--prefix_len=32  \
	--producers=1     \
	--nr_entries=10000

  lookup: throughput    7.423 ± 0.023 M ops/s (  7.423M ops/prod), latency  134.710 ns/op
  update: throughput    2.643 ± 0.015 M ops/s (  2.643M ops/prod), latency  378.310 ns/op
  delete: throughput    0.712 ± 0.008 M ops/s (  0.712M ops/prod), latency 1405.152 ns/op
    free: throughput    0.574 ± 0.003 K ops/s (  0.574K ops/prod), latency    1.743 ms/op

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  10 +
 tools/testing/selftests/bpf/bench.h           |   1 +
 .../selftests/bpf/benchs/bench_lpm_trie_map.c | 345 ++++++++++++++++++
 .../selftests/bpf/progs/lpm_trie_bench.c      | 175 +++++++++
 .../selftests/bpf/progs/lpm_trie_map.c        |  19 +
 6 files changed, 552 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_map.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 910d8d6402ef..10a5f1d0fa41 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -815,6 +815,7 @@ $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
+$(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -836,6 +837,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
 		 $(OUTPUT)/bench_sockmap.o \
+		 $(OUTPUT)/bench_lpm_trie_map.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ddd73d06a1eb..fd15f60fd5a8 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -284,6 +284,7 @@ extern struct argp bench_htab_mem_argp;
 extern struct argp bench_trigger_batch_argp;
 extern struct argp bench_crypto_argp;
 extern struct argp bench_sockmap_argp;
+extern struct argp bench_lpm_trie_map_argp;
 
 static const struct argp_child bench_parsers[] = {
 	{ &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
@@ -299,6 +300,7 @@ static const struct argp_child bench_parsers[] = {
 	{ &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
 	{ &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
 	{ &bench_sockmap_argp, 0, "bpf sockmap benchmark", 0 },
+	{ &bench_lpm_trie_map_argp, 0, "LPM trie map benchmark", 0 },
 	{},
 };
 
@@ -558,6 +560,10 @@ extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 extern const struct bench bench_sockmap;
+extern const struct bench bench_lpm_trie_lookup;
+extern const struct bench bench_lpm_trie_update;
+extern const struct bench bench_lpm_trie_delete;
+extern const struct bench bench_lpm_trie_free;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -625,6 +631,10 @@ static const struct bench *benchs[] = {
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
 	&bench_sockmap,
+	&bench_lpm_trie_lookup,
+	&bench_lpm_trie_update,
+	&bench_lpm_trie_delete,
+	&bench_lpm_trie_free,
 };
 
 static void find_benchmark(void)
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 005c401b3e22..bea323820ffb 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -46,6 +46,7 @@ struct bench_res {
 	unsigned long gp_ns;
 	unsigned long gp_ct;
 	unsigned int stime;
+	unsigned long duration_ns;
 };
 
 struct bench {
diff --git a/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c b/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
new file mode 100644
index 000000000000..ddd7d3669e70
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Cloudflare */
+
+/*
+ * All of these benchmarks operate on tries with keys in the range
+ * [0, args.nr_entries), i.e. there are no gaps or partially filled
+ * branches of the trie for any key < args.nr_entries.
+ *
+ * This gives an idea of worst-case behaviour.
+ */
+
+#include <argp.h>
+#include <linux/time64.h>
+#include <linux/if_ether.h>
+#include "lpm_trie_bench.skel.h"
+#include "lpm_trie_map.skel.h"
+#include "bench.h"
+#include "testing_helpers.h"
+
+static struct ctx {
+	struct lpm_trie_bench *bench;
+} ctx;
+
+static struct {
+	__u32 nr_entries;
+	__u32 prefixlen;
+} args = {
+	.nr_entries = 10000,
+	.prefixlen = 32,
+};
+
+enum {
+	ARG_NR_ENTRIES = 9000,
+	ARG_PREFIX_LEN,
+};
+
+static const struct argp_option opts[] = {
+	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
+	  "Number of unique entries in the LPM trie" },
+	{ "prefix_len", ARG_PREFIX_LEN, "PREFIX_LEN", 0,
+	  "Number of prefix bits to use in the LPM trie" },
+	{},
+};
+
+static error_t lpm_parse_arg(int key, char *arg, struct argp_state *state)
+{
+	long ret;
+
+	switch (key) {
+	case ARG_NR_ENTRIES:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "Invalid nr_entries count.");
+			argp_usage(state);
+		}
+		args.nr_entries = ret;
+		break;
+	case ARG_PREFIX_LEN:
+		ret = strtol(arg, NULL, 10);
+		if (ret < 1 || ret > UINT_MAX) {
+			fprintf(stderr, "Invalid prefix_len value.");
+			argp_usage(state);
+		}
+		args.prefixlen = ret;
+		break;
+	default:
+		return ARGP_ERR_UNKNOWN;
+	}
+	return 0;
+}
+
+const struct argp bench_lpm_trie_map_argp = {
+	.options = opts,
+	.parser = lpm_parse_arg,
+};
+
+static void __lpm_validate(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer!\n");
+		exit(1);
+	}
+
+	if ((1UL << args.prefixlen) < args.nr_entries) {
+		fprintf(stderr, "prefix_len value too small for nr_entries!\n");
+		exit(1);
+	};
+}
+
+enum { OP_LOOKUP = 1, OP_UPDATE, OP_DELETE, OP_FREE };
+
+static void lpm_delete_validate(void)
+{
+	__lpm_validate();
+
+	if (env.producer_cnt != 1) {
+		fprintf(stderr,
+			"lpm-trie-delete requires a single producer!\n");
+		exit(1);
+	}
+}
+
+static void lpm_free_validate(void)
+{
+	__lpm_validate();
+
+	if (env.producer_cnt != 1) {
+		fprintf(stderr, "lpm-trie-free requires a single producer!\n");
+		exit(1);
+	}
+}
+
+static void fill_map(int map_fd)
+{
+	int i, err;
+
+	for (i = 0; i < args.nr_entries; i++) {
+		struct trie_key {
+			__u32 prefixlen;
+			__u32 data;
+		} key = { args.prefixlen, i };
+		__u32 val = 1;
+
+		err = bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXIST);
+		if (err) {
+			fprintf(stderr, "failed to add key %d to map: %d\n",
+				key.data, -err);
+			exit(1);
+		}
+	}
+}
+
+static void __lpm_setup(void)
+{
+	ctx.bench = lpm_trie_bench__open_and_load();
+	if (!ctx.bench) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	ctx.bench->bss->nr_entries = args.nr_entries;
+	ctx.bench->bss->prefixlen = args.prefixlen;
+
+	if (lpm_trie_bench__attach(ctx.bench)) {
+		fprintf(stderr, "failed to attach skeleton\n");
+		exit(1);
+	}
+}
+
+static void lpm_setup(void)
+{
+	int fd;
+
+	__lpm_setup();
+
+	fd = bpf_map__fd(ctx.bench->maps.trie_map);
+	fill_map(fd);
+}
+
+static void lpm_lookup_setup(void)
+{
+	lpm_setup();
+
+	ctx.bench->bss->op = OP_LOOKUP;
+}
+
+static void lpm_update_setup(void)
+{
+	lpm_setup();
+
+	ctx.bench->bss->op = OP_UPDATE;
+}
+
+static void lpm_delete_setup(void)
+{
+	lpm_setup();
+
+	ctx.bench->bss->op = OP_DELETE;
+}
+
+static void lpm_free_setup(void)
+{
+	__lpm_setup();
+	ctx.bench->bss->op = OP_FREE;
+}
+
+static void lpm_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.bench->bss->hits, 0);
+	res->duration_ns = atomic_swap(&ctx.bench->bss->duration_ns, 0);
+}
+
+/* For LOOKUP, UPDATE, and DELETE */
+static void *lpm_producer(void *unused __always_unused)
+{
+	int err;
+	char in[ETH_HLEN]; /* unused */
+
+	LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in = in,
+		    .data_size_in = sizeof(in), .repeat = 1, );
+
+	while (true) {
+		int fd = bpf_program__fd(ctx.bench->progs.run_bench);
+		err = bpf_prog_test_run_opts(fd, &opts);
+		if (err) {
+			fprintf(stderr, "failed to run BPF prog: %d\n", err);
+			exit(1);
+		}
+
+		if (opts.retval < 0) {
+			fprintf(stderr, "BPF prog returned error: %d\n",
+				opts.retval);
+			exit(1);
+		}
+
+		if (ctx.bench->bss->op == OP_DELETE && opts.retval == 1) {
+			/* trie_map needs to be refilled */
+			fill_map(bpf_map__fd(ctx.bench->maps.trie_map));
+		}
+	}
+
+	return NULL;
+}
+
+static void *lpm_free_producer(void *unused __always_unused)
+{
+	while (true) {
+		struct lpm_trie_map *skel;
+
+		skel = lpm_trie_map__open_and_load();
+		if (!skel) {
+			fprintf(stderr, "failed to open skeleton\n");
+			exit(1);
+		}
+
+		fill_map(bpf_map__fd(skel->maps.trie_free_map));
+		lpm_trie_map__destroy(skel);
+	}
+
+	return NULL;
+}
+
+static __always_inline double duration_ms(struct bench_res *res)
+{
+	if (!res->hits)
+		return 0.0;
+
+	return res->duration_ns / res->hits / NSEC_PER_MSEC;
+}
+
+static void free_ops_report_progress(int iter, struct bench_res *res,
+				     long delta_ns)
+{
+	double hits_per_sec, hits_per_prod;
+	double rate_divisor = 1000.0;
+	char rate = 'K';
+
+	hits_per_sec = res->hits / (res->duration_ns / (double)NSEC_PER_SEC) /
+		       rate_divisor;
+	hits_per_prod = hits_per_sec / env.producer_cnt;
+
+	printf("Iter %3d (%7.3lfus): ", iter,
+	       (delta_ns - NSEC_PER_SEC) / 1000.0);
+	printf("hits %8.3lf%c/s (%7.3lf%c/prod)\n", hits_per_sec, rate,
+	       hits_per_prod, rate);
+}
+
+static void free_ops_report_final(struct bench_res res[], int res_cnt)
+{
+	double hits_mean = 0.0, hits_stddev = 0.0;
+	double lat_divisor = 1000000.0;
+	double rate_divisor = 1000.0;
+	const char *unit = "ms";
+	double latency = 0.0;
+	char rate = 'K';
+	int i;
+
+	for (i = 0; i < res_cnt; i++) {
+		double val = res[i].hits / rate_divisor /
+			     (res[i].duration_ns / (double)NSEC_PER_SEC);
+		hits_mean += val / (0.0 + res_cnt);
+		latency += res[i].duration_ns / res[i].hits / (0.0 + res_cnt);
+	}
+
+	if (res_cnt > 1) {
+		for (i = 0; i < res_cnt; i++) {
+			double val =
+				res[i].hits / rate_divisor /
+				(res[i].duration_ns / (double)NSEC_PER_SEC);
+			hits_stddev += (hits_mean - val) * (hits_mean - val) /
+				       (res_cnt - 1.0);
+		}
+
+		hits_stddev = sqrt(hits_stddev);
+	}
+	printf("Summary: throughput %8.3lf \u00B1 %5.3lf %c ops/s (%7.3lf%c ops/prod), ",
+	       hits_mean, hits_stddev, rate, hits_mean / env.producer_cnt,
+	       rate);
+	printf("latency %8.3lf %s/op\n",
+	       latency / lat_divisor / env.producer_cnt, unit);
+}
+
+const struct bench bench_lpm_trie_lookup = {
+	.name = "lpm-trie-lookup",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = __lpm_validate,
+	.setup = lpm_lookup_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+const struct bench bench_lpm_trie_update = {
+	.name = "lpm-trie-update",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = __lpm_validate,
+	.setup = lpm_update_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+const struct bench bench_lpm_trie_delete = {
+	.name = "lpm-trie-delete",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = lpm_delete_validate,
+	.setup = lpm_delete_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+const struct bench bench_lpm_trie_free = {
+	.name = "lpm-trie-free",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = lpm_free_validate,
+	.setup = lpm_free_setup,
+	.producer_thread = lpm_free_producer,
+	.measure = lpm_measure,
+	.report_progress = free_ops_report_progress,
+	.report_final = free_ops_report_final,
+};
diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
new file mode 100644
index 000000000000..c335718cc240
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Cloudflare */
+
+#include <vmlinux.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+
+#define BPF_OBJ_NAME_LEN 16U
+#define MAX_ENTRIES 100000000
+#define NR_LOOPS 10000
+
+struct trie_key {
+	__u32 prefixlen;
+	__u32 data;
+};
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 512);
+	__type(key, struct bpf_map *);
+	__type(value, __u64);
+} latency_free_start SEC(".maps");
+
+/* Filled by userspace. See fill_map() in bench_lpm_trie_map.c */
+struct {
+	__uint(type, BPF_MAP_TYPE_LPM_TRIE);
+	__type(key, struct trie_key);
+	__type(value, __u32);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, MAX_ENTRIES);
+} trie_map SEC(".maps");
+
+long hits;
+long duration_ns;
+
+/* Configured from userspace */
+__u64 nr_entries;
+__u32 prefixlen;
+__u8 op;
+
+static __always_inline void atomic_inc(long *cnt)
+{
+	__atomic_add_fetch(cnt, 1, __ATOMIC_SEQ_CST);
+}
+
+static __always_inline long atomic_swap(long *cnt, long val)
+{
+	return __atomic_exchange_n(cnt, val, __ATOMIC_SEQ_CST);
+}
+
+SEC("fentry/bpf_map_free_deferred")
+int BPF_PROG(trie_free_entry, struct work_struct *work)
+{
+	struct bpf_map *map = container_of(work, struct bpf_map, work);
+	const char *name;
+	u32 map_type;
+	__u64 val;
+
+	map_type = BPF_CORE_READ(map, map_type);
+	if (map_type != BPF_MAP_TYPE_LPM_TRIE)
+		return 0;
+
+	/*
+	 * Ideally we'd have access to the map ID but that's already
+	 * freed before we enter trie_free().
+	 */
+	name = BPF_CORE_READ(map, name);
+	if (bpf_strncmp(name, BPF_OBJ_NAME_LEN, "trie_free_map"))
+		return 0;
+
+	val = bpf_ktime_get_ns();
+	bpf_map_update_elem(&latency_free_start, &map, &val, BPF_ANY);
+
+	return 0;
+}
+
+SEC("fexit/bpf_map_free_deferred")
+int BPF_PROG(trie_free_exit, struct work_struct *work)
+{
+	struct bpf_map *map = container_of(work, struct bpf_map, work);
+	__u64 *val;
+
+	val = bpf_map_lookup_elem(&latency_free_start, &map);
+	if (val) {
+		__sync_add_and_fetch(&duration_ns, bpf_ktime_get_ns() - *val);
+		atomic_inc(&hits);
+		bpf_map_delete_elem(&latency_free_start, &map);
+	}
+
+	return 0;
+}
+
+static void gen_random_key(struct trie_key *key)
+{
+	key->prefixlen = prefixlen;
+	key->data = bpf_get_prandom_u32() % nr_entries;
+}
+
+static int lookup(__u32 index, __u32 *unused)
+{
+	struct trie_key key;
+
+	gen_random_key(&key);
+	bpf_map_lookup_elem(&trie_map, &key);
+	return 0;
+}
+
+static int update(__u32 index, __u32 *unused)
+{
+	struct trie_key key;
+	u32 val = bpf_get_prandom_u32();
+
+	gen_random_key(&key);
+	bpf_map_update_elem(&trie_map, &key, &val, BPF_EXIST);
+	return 0;
+}
+
+long deleted_entries;
+long refill;
+
+static int delete (__u32 index, __u32 *unused)
+{
+	struct trie_key key = {
+		.data = deleted_entries,
+		.prefixlen = prefixlen,
+	};
+
+	bpf_map_delete_elem(&trie_map, &key);
+	atomic_inc(&deleted_entries);
+
+	/* Do we need to refill the map? */
+	if (deleted_entries >= nr_entries) {
+		atomic_swap(&refill, 1);
+		atomic_swap(&deleted_entries, 0);
+		return 1;
+	}
+
+	return 0;
+}
+
+SEC("xdp")
+int BPF_PROG(run_bench)
+{
+	u64 start, delta;
+	bool need_refill = false;
+
+	start = bpf_ktime_get_ns();
+
+	switch (op) {
+	case 1:
+		bpf_loop(NR_LOOPS, lookup, NULL, 0);
+		break;
+	case 2:
+		bpf_loop(NR_LOOPS, update, NULL, 0);
+		break;
+	case 3:
+		bpf_loop(NR_LOOPS, delete, NULL, 0);
+		need_refill = atomic_swap(&refill, 0);
+		break;
+	default:
+		bpf_printk("invalid benchmark operation\n");
+		return -1;
+	}
+
+	delta = bpf_ktime_get_ns() - start;
+
+	__sync_add_and_fetch(&hits, NR_LOOPS);
+	__sync_add_and_fetch(&duration_ns, delta);
+
+	return need_refill;
+}
diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_map.c b/tools/testing/selftests/bpf/progs/lpm_trie_map.c
new file mode 100644
index 000000000000..2ab43e2cd6c6
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lpm_trie_map.c
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#define MAX_ENTRIES 100000000
+
+struct trie_key {
+	__u32 prefixlen;
+	__u32 data;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_LPM_TRIE);
+	__type(key, struct trie_key);
+	__type(value, __u32);
+	__uint(map_flags, BPF_F_NO_PREALLOC);
+	__uint(max_entries, MAX_ENTRIES);
+} trie_free_map SEC(".maps");
-- 
2.34.1


