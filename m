Return-Path: <linux-kselftest+bounces-43478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEA4BEC6F7
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 06:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B2219A2956
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 04:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952F6293C44;
	Sat, 18 Oct 2025 04:04:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1486020B80B;
	Sat, 18 Oct 2025 04:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760760288; cv=none; b=fC7dj6Ou0BUEH4qppyAKmXpieyrf1o8JLF3bbT/inooV36iXCHxbRTYYn2XobnZgMT/7dAzgeGKzofLbUJ5hLAcsUlDiyQ2Z2mL1kdJuMY3/RPSgHckPLuNU+4/ipFH9V1AlVKpFDGDyD/Cmw26fmK7YVAHnhsC9/ojK7KHzYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760760288; c=relaxed/simple;
	bh=s0YeU+M9ekczfZEx6RyiKeOQ8ZtpbhrwKw89w/fKXf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7RkfErStIvy7lFvG89xgdURN2qdD1FDGOUrph3Mi2e+fO1vobmX5H5xuF4Ea+tUVXaOAuIedNyKCjrBVZiaOpIbgmMr8Aq+/aP6UXxb4+qmnvi17M/E+2wZn5jCncAVGUtscWas5cqfHYXxhb2XqGEcgbcfZB0EmFBekMFe51c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cpSjf0PSqzYQtjb;
	Sat, 18 Oct 2025 12:03:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1FC261A1013;
	Sat, 18 Oct 2025 12:04:37 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP2 (Coremail) with SMTP id Syh0CgA32UHPEfNoOeb+Ag--.21556S5;
	Sat, 18 Oct 2025 12:04:36 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yhs@fb.com>,
	Song Liu <song@kernel.org>
Subject: [PATCH bpf-next v3 3/3] selftests/bpf/benchs: Add overwrite mode benchmark for BPF ring buffer
Date: Sat, 18 Oct 2025 11:57:38 +0800
Message-ID: <20251018035738.4039621-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
References: <20251018035738.4039621-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA32UHPEfNoOeb+Ag--.21556S5
X-Coremail-Antispam: 1UD129KBjvJXoW3CrWDKrWrWr4rKF47Jw1rtFb_yoWDXF1xpa
	n2kFWfCF1fA3s3WFyvk3y8ArWxursrZ3W5CF1xJa1UZw1UWw4jqryIk34UJw15G34vyw1S
	934ktry09r4Yy3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
	vfC2KfnxnUUI43ZEXa7IU8D5r7UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add --rb-overwrite option to benchmark BPF ring buffer in overwrite mode.
Since overwrite mode is not yet supported by libbpf for consumer, also add
--rb-bench-producer option to benchmark producer directly without a consumer.

Benchmarks on an x86_64 and an arm64 CPU are shown below for reference.

- AMD EPYC 9654 (x86_64)

Ringbuf, multi-producer contention in overwrite mode, no consumer
=================================================================
rb-prod nr_prod 1    32.180 ± 0.033M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 2    9.617 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 3    8.810 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 4    9.272 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 8    9.173 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 12   3.086 ± 0.032M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 16   2.945 ± 0.021M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 20   2.519 ± 0.021M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 24   2.545 ± 0.021M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 28   2.363 ± 0.024M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 32   2.357 ± 0.021M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 36   2.267 ± 0.011M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 40   2.284 ± 0.020M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 44   2.215 ± 0.025M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 48   2.193 ± 0.023M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 52   2.208 ± 0.024M/s (drops 0.000 ± 0.000M/s)

- HiSilicon Kunpeng 920 (arm64)

Ringbuf, multi-producer contention in overwrite mode, no consumer
=================================================================
rb-prod nr_prod 1    14.478 ± 0.006M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 2    21.787 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 3    6.045 ± 0.001M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 4    5.352 ± 0.003M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 8    4.850 ± 0.002M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 12   3.542 ± 0.016M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 16   3.509 ± 0.021M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 20   3.171 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 24   3.154 ± 0.014M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 28   2.974 ± 0.015M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 32   3.167 ± 0.014M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 36   2.903 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 40   2.866 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 44   2.914 ± 0.010M/s (drops 0.000 ± 0.000M/s)
rb-prod nr_prod 48   2.806 ± 0.012M/s (drops 0.000 ± 0.000M/s)
Rb-prod nr_prod 52   2.840 ± 0.012M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/benchs/bench_ringbufs.c     | 66 +++++++++++++++++--
 .../bpf/benchs/run_bench_ringbufs.sh          |  4 ++
 .../selftests/bpf/progs/ringbuf_bench.c       | 11 ++++
 3 files changed, 75 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index e1ee979e6acc..212859fb2961 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -19,6 +19,8 @@ static struct {
 	int ringbuf_sz; /* per-ringbuf, in bytes */
 	bool ringbuf_use_output; /* use slower output API */
 	int perfbuf_sz; /* per-CPU size, in pages */
+	bool overwrite;
+	bool bench_producer;
 } args = {
 	.back2back = false,
 	.batch_cnt = 500,
@@ -27,6 +29,8 @@ static struct {
 	.ringbuf_sz = 512 * 1024,
 	.ringbuf_use_output = false,
 	.perfbuf_sz = 128,
+	.overwrite = false,
+	.bench_producer = false,
 };
 
 enum {
@@ -35,6 +39,8 @@ enum {
 	ARG_RB_BATCH_CNT = 2002,
 	ARG_RB_SAMPLED = 2003,
 	ARG_RB_SAMPLE_RATE = 2004,
+	ARG_RB_OVERWRITE = 2005,
+	ARG_RB_BENCH_PRODUCER = 2006,
 };
 
 static const struct argp_option opts[] = {
@@ -43,6 +49,8 @@ static const struct argp_option opts[] = {
 	{ "rb-batch-cnt", ARG_RB_BATCH_CNT, "CNT", 0, "Set BPF-side record batch count"},
 	{ "rb-sampled", ARG_RB_SAMPLED, NULL, 0, "Notification sampling"},
 	{ "rb-sample-rate", ARG_RB_SAMPLE_RATE, "RATE", 0, "Notification sample rate"},
+	{ "rb-overwrite", ARG_RB_OVERWRITE, NULL, 0, "Overwrite mode"},
+	{ "rb-bench-producer", ARG_RB_BENCH_PRODUCER, NULL, 0, "Benchmark producer"},
 	{},
 };
 
@@ -72,6 +80,12 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			argp_usage(state);
 		}
 		break;
+	case ARG_RB_OVERWRITE:
+		args.overwrite = true;
+		break;
+	case ARG_RB_BENCH_PRODUCER:
+		args.bench_producer = true;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -95,8 +109,33 @@ static inline void bufs_trigger_batch(void)
 
 static void bufs_validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "rb-libbpf benchmark needs one consumer!\n");
+	if (args.bench_producer && strcmp(env.bench_name, "rb-libbpf")) {
+		fprintf(stderr, "--rb-bench-producer only works with rb-libbpf!\n");
+		exit(1);
+	}
+
+	if (args.overwrite && !args.bench_producer) {
+		fprintf(stderr, "overwrite mode only works with --rb-bench-producer for now!\n");
+		exit(1);
+	}
+
+	if (args.bench_producer && env.consumer_cnt != 0) {
+		fprintf(stderr, "no consumer is needed for --rb-bench-producer!\n");
+		exit(1);
+	}
+
+	if (args.bench_producer && args.back2back) {
+		fprintf(stderr, "back-to-back mode makes no sense for --rb-bench-producer!\n");
+		exit(1);
+	}
+
+	if (args.bench_producer && args.sampled) {
+		fprintf(stderr, "sampling mode makes no sense for --rb-bench-producer!\n");
+		exit(1);
+	}
+
+	if (!args.bench_producer && env.consumer_cnt != 1) {
+		fprintf(stderr, "benchmarks without --rb-bench-producer require exactly one consumer!\n");
 		exit(1);
 	}
 
@@ -128,12 +167,17 @@ static void ringbuf_libbpf_measure(struct bench_res *res)
 {
 	struct ringbuf_libbpf_ctx *ctx = &ringbuf_libbpf_ctx;
 
-	res->hits = atomic_swap(&buf_hits.value, 0);
+	if (args.bench_producer)
+		res->hits = atomic_swap(&ctx->skel->bss->hits, 0);
+	else
+		res->hits = atomic_swap(&buf_hits.value, 0);
 	res->drops = atomic_swap(&ctx->skel->bss->dropped, 0);
 }
 
 static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 {
+	__u32 flags;
+	struct bpf_map *ringbuf;
 	struct ringbuf_bench *skel;
 
 	setup_libbpf();
@@ -146,12 +190,19 @@ static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 
 	skel->rodata->batch_cnt = args.batch_cnt;
 	skel->rodata->use_output = args.ringbuf_use_output ? 1 : 0;
+	skel->rodata->bench_producer = args.bench_producer;
 
 	if (args.sampled)
 		/* record data + header take 16 bytes */
 		skel->rodata->wakeup_data_size = args.sample_rate * 16;
 
-	bpf_map__set_max_entries(skel->maps.ringbuf, args.ringbuf_sz);
+	ringbuf = skel->maps.ringbuf;
+	if (args.overwrite) {
+		flags = bpf_map__map_flags(ringbuf) | BPF_F_RB_OVERWRITE;
+		bpf_map__set_map_flags(ringbuf, flags);
+	}
+
+	bpf_map__set_max_entries(ringbuf, args.ringbuf_sz);
 
 	if (ringbuf_bench__load(skel)) {
 		fprintf(stderr, "failed to load skeleton\n");
@@ -171,10 +222,13 @@ static void ringbuf_libbpf_setup(void)
 {
 	struct ringbuf_libbpf_ctx *ctx = &ringbuf_libbpf_ctx;
 	struct bpf_link *link;
+	int map_fd;
 
 	ctx->skel = ringbuf_setup_skeleton();
-	ctx->ringbuf = ring_buffer__new(bpf_map__fd(ctx->skel->maps.ringbuf),
-					buf_process_sample, NULL, NULL);
+
+	map_fd = bpf_map__fd(ctx->skel->maps.ringbuf);
+	ctx->ringbuf = ring_buffer__new(map_fd, buf_process_sample,
+			NULL, NULL);
 	if (!ctx->ringbuf) {
 		fprintf(stderr, "failed to create ringbuf\n");
 		exit(1);
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index 91e3567962ff..83e05e837871 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -49,3 +49,7 @@ for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
 	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
 done
 
+header "Ringbuf, multi-producer contention in overwrite mode, no consumer"
+for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
+	summarize "rb-prod nr_prod $b" "$($RUN_BENCH -p$b --rb-batch-cnt 50 --rb-overwrite --rb-bench-producer rb-libbpf)"
+done
diff --git a/tools/testing/selftests/bpf/progs/ringbuf_bench.c b/tools/testing/selftests/bpf/progs/ringbuf_bench.c
index 6a468496f539..d96c7d1e8fc2 100644
--- a/tools/testing/selftests/bpf/progs/ringbuf_bench.c
+++ b/tools/testing/selftests/bpf/progs/ringbuf_bench.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2020 Facebook
 
+#include <stdbool.h>
 #include <linux/bpf.h>
 #include <stdint.h>
 #include <bpf/bpf_helpers.h>
@@ -14,9 +15,11 @@ struct {
 
 const volatile int batch_cnt = 0;
 const volatile long use_output = 0;
+const volatile bool bench_producer = false;
 
 long sample_val = 42;
 long dropped __attribute__((aligned(128))) = 0;
+long hits __attribute__((aligned(128))) = 0;
 
 const volatile long wakeup_data_size = 0;
 
@@ -24,6 +27,9 @@ static __always_inline long get_flags()
 {
 	long sz;
 
+	if (bench_producer)
+		return BPF_RB_NO_WAKEUP;
+
 	if (!wakeup_data_size)
 		return 0;
 
@@ -47,6 +53,8 @@ int bench_ringbuf(void *ctx)
 				*sample = sample_val;
 				flags = get_flags();
 				bpf_ringbuf_submit(sample, flags);
+				if (bench_producer)
+					__sync_add_and_fetch(&hits, 1);
 			}
 		}
 	} else {
@@ -55,6 +63,9 @@ int bench_ringbuf(void *ctx)
 			if (bpf_ringbuf_output(&ringbuf, &sample_val,
 					       sizeof(sample_val), flags))
 				__sync_add_and_fetch(&dropped, 1);
+			else if (bench_producer)
+				__sync_add_and_fetch(&hits, 1);
+
 		}
 	}
 	return 0;
-- 
2.43.0


