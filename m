Return-Path: <linux-kselftest+bounces-40056-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2EEB38448
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 16:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4AC363AE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386F35209F;
	Wed, 27 Aug 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="B6wMRXUq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197051DFD96
	for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303317; cv=none; b=rCPJzexd8wsrUr9PW65kyuYTq29Yx6DHOd3okkvVQeM5l+pV0RaeF7BJTRjWmbY4eQWHVXtV9Ke9rwbZWW982cmgZoemFUJ9+I9/F1B/vORKh6MTF8p8NfrXL8w1SOK9+8QKTCHGw6oHP8lsAbh72exJ31RBkAZ7g5kEPrkszJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303317; c=relaxed/simple;
	bh=g+0J+mNFv1MeQDECn7G/Tnx2FI3UVDMWdvusMKNukZg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aC4NCBB2nuxMgIB1OwWIxJH3NbEU0pSEK7/3OFy7aXVG6++N6j18mav+g3tzpksuDENdN8MnwLVJxFAw8re9/aZF3fI4SLLvUii2OqATV0kTc+B/t6wLvDzBuEYRhlQzYUO3LQEmoA+6gOcuP8EuC5w4ElLnjFaZG1GTPnhd96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=B6wMRXUq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c68ac7e238so2452664f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Aug 2025 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1756303313; x=1756908113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KomuSFt9BbcHPTeKol1T7iF1W1yz+1/6+/Vo+hol5XM=;
        b=B6wMRXUqJrsF41f2u6bI2MvU7HR1oZ3LKwJVYYQXAj5uhCFKQxAP5R+Jm9cf3+/2x5
         f8SQwL5BVpZsOzYg79tPglMGVleekbYIp1+hkSDAy+wBlWrs9h3hfD/7Jg2I42G3kQY4
         xGIjqRH8sMnHq2lcbbDLG2cL28eQgvYOAO1xsQ1FUWEuqSSGp7ayxeX6nx18RUa0tKso
         m/agOeS9QdRc4whj0urvFfw2Na2ugyy3ZOzNMnykEnnhWefJ5K+jmZH/EspYFG1nskIl
         HiU09Bsjz+tLNw/e9b1DxYmF3r/mgELGNOmxboeCbVm79Gw4KllTNsZtBf6LgOyqlWLP
         8gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303313; x=1756908113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KomuSFt9BbcHPTeKol1T7iF1W1yz+1/6+/Vo+hol5XM=;
        b=f4tm/WH3HqYWtO5brAwOsI7tBjEgC3V/TucoFkHGjdEYvGnaZv2ntzi4Ra3l+6FBZl
         xpK7+0NJQ7fFWN9C5vkj5lKgMfyUjYCanOTnhye1eyBqcYHM9a2UdgQuTJ4uYN9j4lzY
         w7KFX2omfkxsnGisiAOAGg1/IIZ+Pu6ZPqAlJ3PZwVNxfiDXYrK0Le7g0En06WNMwvcG
         badn9/JtKIgu+SpassNGBC6rA2Y9zLlEfhEm6V6BAu7M6aZVxX1y4I0ftESWnJEDxs5h
         tzt/RSp0XiYdQ0CgPZWFBxufp6DTdCbEMBiYMmMobJ2hZNkvMUFXZBtn2+JTg/4XCGex
         W/mg==
X-Forwarded-Encrypted: i=1; AJvYcCWhIIVN1DjYBPfKUhVwxLf/VNIOM6TyvhQVm/LhSPJy1EeqOG9Xin1yepOYbRgIzFRbmZ7MWhPfBkrDSFxpyoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZAsK8oQ8oqj7ydeixjry6OcV5i+yLMvGpbEHHgw8IDb7buDwl
	nBAA3cf+XTketqTK+pymytTpYSBdJLxLztbCt/OvZ+kDCGZafO/kgVDomVhkvqlL0XQ=
X-Gm-Gg: ASbGnct3gXBTyg8ef7ll87aXSfM09Uu7a25mRrkWYBEj0jMX8ActBhdmVV3LJNridUJ
	IBDkBoU/WQ+H0bhKfMTE5i9G3VFRYOvD/7o0KopBaW+eWO+5VNgb2J7SK3XWzhW3+Ecftn8A6+u
	zsjrvbJuGOX65d8bqQ2RTPU+mnaEAsb8mCTCgBkoItt8Ej2OsG+PT2PBCDtjGtKIdbZwNW88DbU
	tNDZxMcOxtI0VXoTDnxQIzDClgpz1GC+c9XZG9PIA3wHN1WehYZKnAiukcQh1STXQFTQNapvhkz
	0R4uq1ExYo46oovxm59NUkSdM7rUdM80uYxlwKyq7fnJMFLPo4jU0sz90YGFbx4DBBmNwKupxk8
	sDm5yNo9m5pDeGmQ3TdTJ0oc=
X-Google-Smtp-Source: AGHT+IHfZUolqi1ONluO/BnIn6I+D5kCdc4wUj+lXgkygAgsv1KTkuNBiqmifBei7E4/rWMLXbP1nQ==
X-Received: by 2002:a05:6000:4025:b0:3cc:faaa:ec96 with SMTP id ffacd0b85a97d-3ccfaaaf496mr1460880f8f.0.1756303313009;
        Wed, 27 Aug 2025 07:01:53 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::3de:4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c88901520asm16084671f8f.19.2025.08.27.07.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 07:01:51 -0700 (PDT)
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
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	netdev@vger.kernel.org,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH bpf-next v5] selftests/bpf: Add LPM trie microbenchmarks
Date: Wed, 27 Aug 2025 15:01:49 +0100
Message-Id: <20250827140149.1001557-1-matt@readmodwrite.com>
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

Add benchmarks for the standard set of operations: LOOKUP, INSERT,
UPDATE, DELETE. Also include benchmarks to measure the overhead of the
bench framework itself (NOOP) as well as the overhead of generating keys
(BASELINE). Lastly, this includes a benchmark for FREE (trie_free())
which is known to have terrible performance for maps with many entries.

Benchmarks operate on tries without gaps in the key range, i.e. each
test begins or ends with a trie with valid keys in the range [0,
nr_entries). This is intended to cause maximum branching when traversing
the trie.

LOOKUP, UPDATE, DELETE, and FREE fill a BPF LPM trie from userspace
using bpf_map_update_batch() and run the corresponding benchmark
operation via bpf_loop(). INSERT starts with an empty map and fills it
kernel-side from bpf_loop(). FREE records the time to free a filled LPM
trie by attaching and destroying a BPF prog. NOOP measures the overhead
of the test harness by running an empty function with bpf_loop().
BASELINE is similar to NOOP except that the function generates a key.

Each operation runs 10,000 times using bpf_loop(). Note that this value
is intentionally independent of the number of entries in the LPM trie so
that the stability of the results isn't affected by the number of
entries.

For those benchmarks that need to reset the LPM trie once it's full
(INSERT) or empty (DELETE), throughput and latency results are scaled by
the fraction of a second the operation actually ran to ignore any time
spent reinitialising the trie.

By default, benchmarks run using sequential keys in the range [0,
nr_entries). BASELINE, LOOKUP, and UPDATE can use random keys via the
--random parameter but beware there is a runtime cost involved in
generating random keys. Other benchmarks are prohibited from using
random keys because it can skew the results, e.g. when inserting an
existing key or deleting a missing one.

All measurements are recorded from within the kernel to eliminate
syscall overhead. Most benchmarks run an XDP program to generate stats
but FREE needs to collect latencies using fentry/fexit on
map_free_deferred() because it's not possible to use fentry directly on
lpm_trie.c since commit c83508da5620 ("bpf: Avoid deadlock caused by
nested kprobe and fentry bpf programs") and there's no way to
create/destroy a map from within an XDP program.

Here is example output from an AMD EPYC 9684X 96-Core machine for each
of the benchmarks using a trie with 10K entries and a 32-bit prefix
length, e.g.

  $ ./bench lpm-trie-$op \
  	--prefix_len=32  \
	--producers=1     \
	--nr_entries=10000

     noop: throughput   74.417 ± 0.032 M ops/s ( 74.417M ops/prod), latency   13.438 ns/op
 baseline: throughput   70.107 ± 0.171 M ops/s ( 70.107M ops/prod), latency   14.264 ns/op
   lookup: throughput    8.467 ± 0.047 M ops/s (  8.467M ops/prod), latency  118.109 ns/op
   insert: throughput    2.440 ± 0.015 M ops/s (  2.440M ops/prod), latency  409.290 ns/op
   update: throughput    2.806 ± 0.042 M ops/s (  2.806M ops/prod), latency  356.322 ns/op
   delete: throughput    4.625 ± 0.011 M ops/s (  4.625M ops/prod), latency  215.613 ns/op
     free: throughput    0.578 ± 0.006 K ops/s (  0.578K ops/prod), latency    1.730 ms/op

And the same benchmarks using random keys:

  $ ./bench lpm-trie-$op \
  	--prefix_len=32  \
	--producers=1     \
	--nr_entries=10000 \
	--random

     noop: throughput   74.259 ± 0.335 M ops/s ( 74.259M ops/prod), latency   13.466 ns/op
 baseline: throughput   35.150 ± 0.144 M ops/s ( 35.150M ops/prod), latency   28.450 ns/op
   lookup: throughput    7.119 ± 0.048 M ops/s (  7.119M ops/prod), latency  140.469 ns/op
   insert: N/A
   update: throughput    2.736 ± 0.012 M ops/s (  2.736M ops/prod), latency  365.523 ns/op
   delete: N/A
     free: N/A

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---

Changes in v5:

 - Fix uninitialised read of blackbox variable to avoid gcc-bpf CI
   failure

Changes in v4:

 - Incorporate Jesper's NOOP and BASELINE benchmarks
 - Remove use of double underscore naming
 - Add --random parameter to use random keys (linear by default)
 - Fractional second reporting to make delete op times accurate
 - Check return value of bpf_map_update_elem()
 - Make latency_free_start a global var and remove hashmap

Changes in v3:

 - Replace BPF_CORE_READ() with BPF_CORE_READ_STR_INTO() to avoid
   gcc-bpf CI build failure

Changes in v2:

 - Add Jesper's Tested-by and Revewied-by tags
 - Remove use of atomic_*() in favour of __sync_add_and_fetch()
 - Use a file-local 'deleted_entries' in the DELETE op benchmark and add
   a comment explaining why non-atomic accesses are safe.
 - Bump 'hits' with the number of bpf_loop() loops actually executed

 tools/testing/selftests/bpf/Makefile          |   2 +
 tools/testing/selftests/bpf/bench.c           |  16 +
 tools/testing/selftests/bpf/bench.h           |   1 +
 .../selftests/bpf/benchs/bench_lpm_trie_map.c | 555 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/lpm_trie.h  |  30 +
 .../selftests/bpf/progs/lpm_trie_bench.c      | 230 ++++++++
 .../selftests/bpf/progs/lpm_trie_map.c        |  19 +
 7 files changed, 853 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie.h
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_map.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..c6555497372f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -816,6 +816,7 @@ $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_hashmap_lookup.skel.h
 $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
 $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
 $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
+$(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT)/lpm_trie_map.skel.h
 $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
 $(OUTPUT)/bench: LDLIBS += -lm
 $(OUTPUT)/bench: $(OUTPUT)/bench.o \
@@ -837,6 +838,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 		 $(OUTPUT)/bench_htab_mem.o \
 		 $(OUTPUT)/bench_bpf_crypto.o \
 		 $(OUTPUT)/bench_sockmap.o \
+		 $(OUTPUT)/bench_lpm_trie_map.o \
 		 #
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ddd73d06a1eb..23ed6feee0d9 100644
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
 
@@ -558,6 +560,13 @@ extern const struct bench bench_htab_mem;
 extern const struct bench bench_crypto_encrypt;
 extern const struct bench bench_crypto_decrypt;
 extern const struct bench bench_sockmap;
+extern const struct bench bench_lpm_trie_noop;
+extern const struct bench bench_lpm_trie_baseline;
+extern const struct bench bench_lpm_trie_lookup;
+extern const struct bench bench_lpm_trie_insert;
+extern const struct bench bench_lpm_trie_update;
+extern const struct bench bench_lpm_trie_delete;
+extern const struct bench bench_lpm_trie_free;
 
 static const struct bench *benchs[] = {
 	&bench_count_global,
@@ -625,6 +634,13 @@ static const struct bench *benchs[] = {
 	&bench_crypto_encrypt,
 	&bench_crypto_decrypt,
 	&bench_sockmap,
+	&bench_lpm_trie_noop,
+	&bench_lpm_trie_baseline,
+	&bench_lpm_trie_lookup,
+	&bench_lpm_trie_insert,
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
index 000000000000..246f6cb3387d
--- /dev/null
+++ b/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
@@ -0,0 +1,555 @@
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
+#include "progs/lpm_trie.h"
+
+static struct ctx {
+	struct lpm_trie_bench *bench;
+} ctx;
+
+static struct {
+	__u32 nr_entries;
+	__u32 prefixlen;
+	bool random;
+} args = {
+	.nr_entries = 0,
+	.prefixlen = 32,
+	.random = false,
+};
+
+enum {
+	ARG_NR_ENTRIES = 9000,
+	ARG_PREFIX_LEN,
+	ARG_RANDOM,
+};
+
+static const struct argp_option opts[] = {
+	{ "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
+	  "Number of unique entries in the LPM trie" },
+	{ "prefix_len", ARG_PREFIX_LEN, "PREFIX_LEN", 0,
+	  "Number of prefix bits to use in the LPM trie" },
+	{ "random", ARG_RANDOM, NULL, 0, "Access random keys during op" },
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
+	case ARG_RANDOM:
+		args.random = true;
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
+static void validate_common(void)
+{
+	if (env.consumer_cnt != 0) {
+		fprintf(stderr, "benchmark doesn't support consumer\n");
+		exit(1);
+	}
+
+	if (args.nr_entries == 0) {
+		fprintf(stderr, "Missing --nr_entries parameter\n");
+		exit(1);
+	}
+
+	if ((1UL << args.prefixlen) < args.nr_entries) {
+		fprintf(stderr, "prefix_len value too small for nr_entries\n");
+		exit(1);
+	}
+}
+
+static void lpm_insert_validate(void)
+{
+	validate_common();
+
+	if (env.producer_cnt != 1) {
+		fprintf(stderr, "lpm-trie-insert requires a single producer\n");
+		exit(1);
+	}
+
+	if (args.random) {
+		fprintf(stderr, "lpm-trie-insert does not support --random\n");
+		exit(1);
+	}
+}
+
+static void lpm_delete_validate(void)
+{
+	validate_common();
+
+	if (env.producer_cnt != 1) {
+		fprintf(stderr, "lpm-trie-delete requires a single producer\n");
+		exit(1);
+	}
+
+	if (args.random) {
+		fprintf(stderr, "lpm-trie-delete does not support --random\n");
+		exit(1);
+	}
+}
+
+static void lpm_free_validate(void)
+{
+	validate_common();
+
+	if (env.producer_cnt != 1) {
+		fprintf(stderr, "lpm-trie-free requires a single producer\n");
+		exit(1);
+	}
+
+	if (args.random) {
+		fprintf(stderr, "lpm-trie-free does not support --random\n");
+		exit(1);
+	}
+}
+
+static struct trie_key *keys;
+static __u32 *vals;
+
+static void fill_map(int map_fd)
+{
+	int err;
+
+	DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
+		.elem_flags = 0,
+		.flags = 0,
+	);
+
+	err = bpf_map_update_batch(map_fd, keys, vals, &args.nr_entries, &opts);
+	if (err) {
+		fprintf(stderr, "failed to batch update keys to map: %d\n",
+			-err);
+		exit(1);
+	}
+}
+
+static void empty_map(int map_fd)
+{
+	int err;
+
+	DECLARE_LIBBPF_OPTS(bpf_map_batch_opts, opts,
+		.elem_flags = 0,
+		.flags = 0,
+	);
+
+	err = bpf_map_delete_batch(map_fd, keys, &args.nr_entries, &opts);
+	if (err) {
+		fprintf(stderr, "failed to batch delete keys for map: %d\n",
+			-err);
+		exit(1);
+	}
+}
+
+static void attach_prog(void)
+{
+	int i;
+
+	ctx.bench = lpm_trie_bench__open_and_load();
+	if (!ctx.bench) {
+		fprintf(stderr, "failed to open skeleton\n");
+		exit(1);
+	}
+
+	ctx.bench->bss->nr_entries = args.nr_entries;
+	ctx.bench->bss->prefixlen = args.prefixlen;
+	ctx.bench->bss->random = args.random;
+
+	if (lpm_trie_bench__attach(ctx.bench)) {
+		fprintf(stderr, "failed to attach skeleton\n");
+		exit(1);
+	}
+
+	keys = calloc(args.nr_entries, sizeof(*keys));
+	vals = calloc(args.nr_entries, sizeof(*vals));
+
+	for (i = 0; i < args.nr_entries; i++) {
+		struct trie_key *k = &keys[i];
+		__u32 *v = &vals[i];
+
+		k->prefixlen = args.prefixlen;
+		k->data = i;
+		*v = 1;
+	}
+}
+
+static void attach_prog_and_fill_map(void)
+{
+	int fd;
+
+	attach_prog();
+
+	fd = bpf_map__fd(ctx.bench->maps.trie_map);
+	fill_map(fd);
+}
+
+static void lpm_noop_setup(void)
+{
+	attach_prog();
+	ctx.bench->bss->op = LPM_OP_NOOP;
+}
+
+static void lpm_baseline_setup(void)
+{
+	attach_prog();
+	ctx.bench->bss->op = LPM_OP_BASELINE;
+}
+
+static void lpm_lookup_setup(void)
+{
+	attach_prog_and_fill_map();
+	ctx.bench->bss->op = LPM_OP_LOOKUP;
+}
+
+static void lpm_insert_setup(void)
+{
+	attach_prog();
+	ctx.bench->bss->op = LPM_OP_INSERT;
+}
+
+static void lpm_update_setup(void)
+{
+	attach_prog_and_fill_map();
+	ctx.bench->bss->op = LPM_OP_UPDATE;
+}
+
+static void lpm_delete_setup(void)
+{
+	attach_prog_and_fill_map();
+	ctx.bench->bss->op = LPM_OP_DELETE;
+}
+
+static void lpm_free_setup(void)
+{
+	attach_prog();
+	ctx.bench->bss->op = LPM_OP_FREE;
+}
+
+static void lpm_measure(struct bench_res *res)
+{
+	res->hits = atomic_swap(&ctx.bench->bss->hits, 0);
+	res->duration_ns = atomic_swap(&ctx.bench->bss->duration_ns, 0);
+}
+
+static void bench_reinit_map(void)
+{
+	int fd = bpf_map__fd(ctx.bench->maps.trie_map);
+
+	switch (ctx.bench->bss->op) {
+	case LPM_OP_INSERT:
+		/* trie_map needs to be emptied */
+		empty_map(fd);
+		break;
+	case LPM_OP_DELETE:
+		/* trie_map needs to be refilled */
+		fill_map(fd);
+		break;
+	default:
+		fprintf(stderr, "Unexpected REINIT return code for op %d\n",
+				ctx.bench->bss->op);
+		exit(1);
+	}
+}
+
+/* For NOOP, BASELINE, LOOKUP, INSERT, UPDATE, and DELETE */
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
+		/* Check for kernel error code */
+		if ((int)opts.retval < 0) {
+			fprintf(stderr, "BPF prog returned error: %d\n",
+				opts.retval);
+			exit(1);
+		}
+
+		switch (opts.retval) {
+		case LPM_BENCH_SUCCESS:
+			break;
+		case LPM_BENCH_REINIT_MAP:
+			bench_reinit_map();
+			break;
+		default:
+			fprintf(stderr, "Unexpected BPF prog return code %d for op %d\n",
+					opts.retval, ctx.bench->bss->op);
+			exit(1);
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
+/*
+ * The standard bench op_report_*() functions assume measurements are
+ * taken over a 1-second interval but operations that modify the map
+ * (INSERT, DELETE, and FREE) cannot run indefinitely without
+ * "resetting" the map to the initial state. Depending on the size of
+ * the map, this likely needs to happen before the 1-second timer fires.
+ *
+ * Calculate the fraction of a second over which the op measurement was
+ * taken (to ignore any time spent doing the reset) and report the
+ * throughput results per second.
+ */
+static void frac_second_report_progress(int iter, struct bench_res *res,
+					long delta_ns, double rate_divisor,
+					char rate)
+{
+	double hits_per_sec, hits_per_prod;
+
+	hits_per_sec = res->hits / rate_divisor /
+		(res->duration_ns / (double)NSEC_PER_SEC);
+	hits_per_prod = hits_per_sec / env.producer_cnt;
+
+	printf("Iter %3d (%7.3lfus): ", iter,
+	       (delta_ns - NSEC_PER_SEC) / 1000.0);
+	printf("hits %8.3lf%c/s (%7.3lf%c/prod)\n", hits_per_sec, rate,
+	       hits_per_prod, rate);
+}
+
+static void frac_second_report_final(struct bench_res res[], int res_cnt,
+				     double lat_divisor, double rate_divisor,
+				     char rate, const char *unit)
+{
+	double hits_mean = 0.0, hits_stddev = 0.0;
+	double latency = 0.0;
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
+static void insert_ops_report_progress(int iter, struct bench_res *res,
+				       long delta_ns)
+{
+	double rate_divisor = 1000000.0;
+	char rate = 'M';
+
+	frac_second_report_progress(iter, res, delta_ns, rate_divisor, rate);
+}
+
+static void delete_ops_report_progress(int iter, struct bench_res *res,
+				       long delta_ns)
+{
+	double rate_divisor = 1000000.0;
+	char rate = 'M';
+
+	frac_second_report_progress(iter, res, delta_ns, rate_divisor, rate);
+}
+
+static void free_ops_report_progress(int iter, struct bench_res *res,
+				     long delta_ns)
+{
+	double rate_divisor = 1000.0;
+	char rate = 'K';
+
+	frac_second_report_progress(iter, res, delta_ns, rate_divisor, rate);
+}
+
+static void insert_ops_report_final(struct bench_res res[], int res_cnt)
+{
+	double lat_divisor = 1.0;
+	double rate_divisor = 1000000.0;
+	const char *unit = "ns";
+	char rate = 'M';
+
+	frac_second_report_final(res, res_cnt, lat_divisor, rate_divisor, rate,
+				 unit);
+}
+
+static void delete_ops_report_final(struct bench_res res[], int res_cnt)
+{
+	double lat_divisor = 1.0;
+	double rate_divisor = 1000000.0;
+	const char *unit = "ns";
+	char rate = 'M';
+
+	frac_second_report_final(res, res_cnt, lat_divisor, rate_divisor, rate,
+				 unit);
+}
+
+static void free_ops_report_final(struct bench_res res[], int res_cnt)
+{
+	double lat_divisor = 1000000.0;
+	double rate_divisor = 1000.0;
+	const char *unit = "ms";
+	char rate = 'K';
+
+	frac_second_report_final(res, res_cnt, lat_divisor, rate_divisor, rate,
+				 unit);
+}
+
+/* noop bench measures harness-overhead */
+const struct bench bench_lpm_trie_noop = {
+	.name = "lpm-trie-noop",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = validate_common,
+	.setup = lpm_noop_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+/* baseline overhead for lookup and update */
+const struct bench bench_lpm_trie_baseline = {
+	.name = "lpm-trie-baseline",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = validate_common,
+	.setup = lpm_baseline_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+/* measure cost of doing a lookup on existing entries in a full trie */
+const struct bench bench_lpm_trie_lookup = {
+	.name = "lpm-trie-lookup",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = validate_common,
+	.setup = lpm_lookup_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+/* measure cost of inserting new entries into an empty trie */
+const struct bench bench_lpm_trie_insert = {
+	.name = "lpm-trie-insert",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = lpm_insert_validate,
+	.setup = lpm_insert_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = insert_ops_report_progress,
+	.report_final = insert_ops_report_final,
+};
+
+/* measure cost of updating existing entries in a full trie */
+const struct bench bench_lpm_trie_update = {
+	.name = "lpm-trie-update",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = validate_common,
+	.setup = lpm_update_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = ops_report_progress,
+	.report_final = ops_report_final,
+};
+
+/* measure cost of deleting existing entries from a full trie */
+const struct bench bench_lpm_trie_delete = {
+	.name = "lpm-trie-delete",
+	.argp = &bench_lpm_trie_map_argp,
+	.validate = lpm_delete_validate,
+	.setup = lpm_delete_setup,
+	.producer_thread = lpm_producer,
+	.measure = lpm_measure,
+	.report_progress = delete_ops_report_progress,
+	.report_final = delete_ops_report_final,
+};
+
+/* measure cost of freeing a full trie */
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
diff --git a/tools/testing/selftests/bpf/progs/lpm_trie.h b/tools/testing/selftests/bpf/progs/lpm_trie.h
new file mode 100644
index 000000000000..76aa5821807f
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lpm_trie.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __PROGS_LPM_TRIE_H
+#define __PROGS_LPM_TRIE_H
+
+struct trie_key {
+	__u32 prefixlen;
+	__u32 data;
+};
+
+/* Benchmark operations */
+enum {
+	LPM_OP_NOOP = 0,
+	LPM_OP_BASELINE,
+	LPM_OP_LOOKUP,
+	LPM_OP_INSERT,
+	LPM_OP_UPDATE,
+	LPM_OP_DELETE,
+	LPM_OP_FREE
+};
+
+/*
+ * Return values from run_bench.
+ *
+ * Negative values are also allowed and represent kernel error codes.
+ */
+#define LPM_BENCH_SUCCESS	0
+#define LPM_BENCH_REINIT_MAP 	1	/* Reset trie to initial state for current op */
+
+#endif
diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
new file mode 100644
index 000000000000..1b48c67b02ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Cloudflare */
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+#include "bpf_misc.h"
+#include "bpf_atomic.h"
+#include "progs/lpm_trie.h"
+
+#define BPF_OBJ_NAME_LEN 16U
+#define MAX_ENTRIES 100000000
+#define NR_LOOPS 10000
+
+char _license[] SEC("license") = "GPL";
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
+__u32 nr_entries;
+__u32 prefixlen;
+bool random;
+__u8 op;
+
+static __u64 latency_free_start;
+
+SEC("fentry/bpf_map_free_deferred")
+int BPF_PROG(trie_free_entry, struct work_struct *work)
+{
+	struct bpf_map *map = container_of(work, struct bpf_map, work);
+	char name[BPF_OBJ_NAME_LEN];
+	u32 map_type;
+
+	map_type = BPF_CORE_READ(map, map_type);
+	if (map_type != BPF_MAP_TYPE_LPM_TRIE)
+		return 0;
+
+	/*
+	 * Ideally we'd have access to the map ID but that's already
+	 * freed before we enter trie_free().
+	 */
+	BPF_CORE_READ_STR_INTO(&name, map, name);
+	if (bpf_strncmp(name, BPF_OBJ_NAME_LEN, "trie_free_map"))
+		return 0;
+
+	latency_free_start = bpf_ktime_get_ns();
+
+	return 0;
+}
+
+SEC("fexit/bpf_map_free_deferred")
+int BPF_PROG(trie_free_exit, struct work_struct *work)
+{
+	__u64 val;
+
+	if (!latency_free_start)
+		return 0;
+
+	val = bpf_ktime_get_ns() - latency_free_start;
+	latency_free_start = 0;
+
+	__sync_add_and_fetch(&duration_ns, val);
+	__sync_add_and_fetch(&hits, 1);
+
+	return 0;
+}
+
+static __u32 cur_key;
+
+static __always_inline void generate_key(struct trie_key *key)
+{
+	key->prefixlen = prefixlen;
+
+	if (random)
+		key->data = bpf_get_prandom_u32() % nr_entries;
+	else
+		key->data = cur_key++ % nr_entries;
+}
+
+static int noop(__u32 index, __u32 *unused)
+{
+	return 0;
+}
+
+static int baseline(__u32 index, __u32 *unused)
+{
+	struct trie_key key;
+	__u32 blackbox = 0;
+
+	generate_key(&key);
+	/* Avoid compiler optimizing out the modulo */
+	barrier_var(blackbox);
+	blackbox = READ_ONCE(key.data);
+
+	return 0;
+}
+
+static int lookup(__u32 index, int *retval)
+{
+	struct trie_key key;
+
+	generate_key(&key);
+	if (!bpf_map_lookup_elem(&trie_map, &key)) {
+		*retval = -ENOENT;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int insert(__u32 index, int *retval)
+{
+	struct trie_key key;
+	u32 val = 1;
+	int err;
+
+	generate_key(&key);
+	err = bpf_map_update_elem(&trie_map, &key, &val, BPF_NOEXIST);
+	if (err) {
+		*retval = err;
+		return 1;
+	}
+
+	/* Is this the last entry? */
+	if (key.data == nr_entries - 1) {
+		/* For atomicity concerns, see the comment in delete() */
+		*retval = LPM_BENCH_REINIT_MAP;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int update(__u32 index, int *retval)
+{
+	struct trie_key key;
+	u32 val = 1;
+	int err;
+
+	generate_key(&key);
+	err = bpf_map_update_elem(&trie_map, &key, &val, BPF_EXIST);
+	if (err) {
+		*retval = err;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int delete(__u32 index, int *retval)
+{
+	struct trie_key key;
+	int err;
+
+	generate_key(&key);
+	err = bpf_map_delete_elem(&trie_map, &key);
+	if (err) {
+		*retval = err;
+		return 1;
+	}
+
+	/* Do we need to refill the map? */
+	if (key.data == nr_entries - 1) {
+		/*
+		 * Atomicity isn't required because DELETE only supports
+		 * one producer running concurrently. What we need is a
+		 * way to track how many entries have been deleted from
+		 * the trie between consecutive invocations of the BPF
+		 * prog because a single bpf_loop() call might not
+		 * delete all entries, e.g. when NR_LOOPS < nr_entries.
+		 */
+		*retval = LPM_BENCH_REINIT_MAP;
+		return 1;
+	}
+
+	return 0;
+}
+
+SEC("xdp")
+int BPF_PROG(run_bench)
+{
+	int err = LPM_BENCH_SUCCESS;
+	u64 start, delta;
+	int loops;
+
+	start = bpf_ktime_get_ns();
+
+	switch (op) {
+	case LPM_OP_NOOP:
+		loops = bpf_loop(NR_LOOPS, noop, NULL, 0);
+		break;
+	case LPM_OP_BASELINE:
+		loops = bpf_loop(NR_LOOPS, baseline, NULL, 0);
+		break;
+	case LPM_OP_LOOKUP:
+		loops = bpf_loop(NR_LOOPS, lookup, &err, 0);
+		break;
+	case LPM_OP_INSERT:
+		loops = bpf_loop(NR_LOOPS, insert, &err, 0);
+		break;
+	case LPM_OP_UPDATE:
+		loops = bpf_loop(NR_LOOPS, update, &err, 0);
+		break;
+	case LPM_OP_DELETE:
+		loops = bpf_loop(NR_LOOPS, delete, &err, 0);
+		break;
+	default:
+		bpf_printk("invalid benchmark operation\n");
+		return -1;
+	}
+
+	delta = bpf_ktime_get_ns() - start;
+
+	__sync_add_and_fetch(&duration_ns, delta);
+	__sync_add_and_fetch(&hits, loops);
+
+	return err;
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


