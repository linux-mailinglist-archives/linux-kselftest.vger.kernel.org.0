Return-Path: <linux-kselftest+bounces-40847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E34B45C35
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4D5A00E90
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 15:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAA72F7AB8;
	Fri,  5 Sep 2025 15:13:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59831B81B;
	Fri,  5 Sep 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085208; cv=none; b=kCMqvxyCXe0ldVmISj5oz1IhkcUpBqegczQeZU8dkw7/PBS0+qbx6igH8BpueGLY4nUJtBaA/aIGb2B5hIOvoIvX8pjtlWDV4r1MFx8bbDjltyIcKI6ofBgqy1vHPA3PjYdsCGsm4c58sIgQutTgeovQrGxYziqrjEhH1lHpByA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085208; c=relaxed/simple;
	bh=9BUY8LC7egcs0Sdjx0g7bGJ6SO0jrcYCrMB/R/TLrJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b01P77v+Kbe2BcZU2GvDzbz5DZMx70pqcCPverTRyFL4zMrwRYMUCeQhBiuIXbKycarAY2rv7KcrD0Q7fgGVOp6P57z6YnDdUvdGYHr0aOEq6AMjkEpxJkYkbOQAMF24YMrOTO136TaAD5CJP7q2nM2xP9Aj6+By0MrE/ZA5WKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cJKbx4htmzYQvNb;
	Fri,  5 Sep 2025 23:13:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2790D1A0F86;
	Fri,  5 Sep 2025 23:13:16 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgDnfYoF_rpoPC72BQ--.54678S5;
	Fri, 05 Sep 2025 23:13:15 +0800 (CST)
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
	Song Liu <song@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Tao Chen <chen.dylane@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf/benchs: Add producer and overwrite bench for ring buffer
Date: Fri,  5 Sep 2025 23:06:41 +0800
Message-ID: <20250905150641.2078838-4-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnfYoF_rpoPC72BQ--.54678S5
X-Coremail-Antispam: 1UD129KBjvJXoWfJw15ZF4UZw18uFW5Jw4DCFg_yoWkCw1fpa
	93KrWfCF1fAryfWFyvk3yxAry7AwnrZ3W5Cr1xJ3WUZw1UWa1jqr1Ika4jy3W5GrW0yr1S
	9a4ktry09w4YywUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxkIecxEwVCI4VW5WwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUed9N3UUUUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add rb-prod test for bpf ring buffer to bench producer performance
without counsumer thread. And add --rb-overwrite option to bench
ring buffer in overwrite mode.

For reference, below are bench numbers collected from x86_64 and
arm64 CPUs.

- AMD EPYC 9654 (x86_64)

  Ringbuf, overwrite mode with multi-producer contention, no consumer
  ===================================================================
  rb-prod nr_prod 1    32.295 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 2    9.591 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 3    8.895 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 4    9.206 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 8    9.220 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 12   4.595 ± 0.022M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 16   4.348 ± 0.016M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 20   3.957 ± 0.017M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 24   3.787 ± 0.014M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 28   3.603 ± 0.011M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 32   3.707 ± 0.011M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 36   3.562 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 40   3.616 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 44   3.598 ± 0.016M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 48   3.555 ± 0.014M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 52   3.463 ± 0.020M/s (drops 0.000 ± 0.000M/s)

- HiSilicon Kunpeng 920 (arm64)

  Ringbuf, overwrite mode with multi-producer contention, no consumer
  ===================================================================
  rb-prod nr_prod 1    14.687 ± 0.058M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 2    22.263 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 3    5.736 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 4    4.934 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 8    4.661 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 12   3.753 ± 0.013M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 16   3.706 ± 0.018M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 20   3.660 ± 0.015M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 24   3.610 ± 0.016M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 28   3.238 ± 0.010M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 32   3.270 ± 0.018M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 36   2.892 ± 0.021M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 40   2.995 ± 0.018M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 44   2.830 ± 0.019M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 48   2.877 ± 0.015M/s (drops 0.000 ± 0.000M/s)
  rb-prod nr_prod 52   2.814 ± 0.015M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/testing/selftests/bpf/bench.c           |  2 +
 .../selftests/bpf/benchs/bench_ringbufs.c     | 95 +++++++++++++++++--
 .../bpf/benchs/run_bench_ringbufs.sh          |  4 +
 .../selftests/bpf/progs/ringbuf_bench.c       | 10 ++
 4 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index bd29bb2e6cb5..a98063f6436a 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -541,6 +541,7 @@ extern const struct bench bench_trig_uretprobe_multi_nop5;
 
 extern const struct bench bench_rb_libbpf;
 extern const struct bench bench_rb_custom;
+extern const struct bench bench_rb_prod;
 extern const struct bench bench_pb_libbpf;
 extern const struct bench bench_pb_custom;
 extern const struct bench bench_bloom_lookup;
@@ -617,6 +618,7 @@ static const struct bench *benchs[] = {
 	/* ringbuf/perfbuf benchmarks */
 	&bench_rb_libbpf,
 	&bench_rb_custom,
+	&bench_rb_prod,
 	&bench_pb_libbpf,
 	&bench_pb_custom,
 	&bench_bloom_lookup,
diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index e1ee979e6acc..6d58479fac91 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -19,6 +19,7 @@ static struct {
 	int ringbuf_sz; /* per-ringbuf, in bytes */
 	bool ringbuf_use_output; /* use slower output API */
 	int perfbuf_sz; /* per-CPU size, in pages */
+	bool overwrite;
 } args = {
 	.back2back = false,
 	.batch_cnt = 500,
@@ -27,6 +28,7 @@ static struct {
 	.ringbuf_sz = 512 * 1024,
 	.ringbuf_use_output = false,
 	.perfbuf_sz = 128,
+	.overwrite = false,
 };
 
 enum {
@@ -35,6 +37,7 @@ enum {
 	ARG_RB_BATCH_CNT = 2002,
 	ARG_RB_SAMPLED = 2003,
 	ARG_RB_SAMPLE_RATE = 2004,
+	ARG_RB_OVERWRITE = 2005,
 };
 
 static const struct argp_option opts[] = {
@@ -43,6 +46,7 @@ static const struct argp_option opts[] = {
 	{ "rb-batch-cnt", ARG_RB_BATCH_CNT, "CNT", 0, "Set BPF-side record batch count"},
 	{ "rb-sampled", ARG_RB_SAMPLED, NULL, 0, "Notification sampling"},
 	{ "rb-sample-rate", ARG_RB_SAMPLE_RATE, "RATE", 0, "Notification sample rate"},
+	{ "rb-overwrite", ARG_RB_OVERWRITE, NULL, 0, "Overwrite mode"},
 	{},
 };
 
@@ -72,6 +76,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			argp_usage(state);
 		}
 		break;
+	case ARG_RB_OVERWRITE:
+		args.overwrite = true;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -95,8 +102,30 @@ static inline void bufs_trigger_batch(void)
 
 static void bufs_validate(void)
 {
-	if (env.consumer_cnt != 1) {
-		fprintf(stderr, "rb-libbpf benchmark needs one consumer!\n");
+	bool bench_prod = !strcmp(env.bench_name, "rb-prod");
+
+	if (args.overwrite && !bench_prod) {
+		fprintf(stderr, "overwite mode only works with benchmakr rb-prod!\n");
+		exit(1);
+	}
+
+	if (bench_prod && env.consumer_cnt != 0) {
+		fprintf(stderr, "rb-prod benchmark does not need consumer!\n");
+		exit(1);
+	}
+
+	if (bench_prod && args.back2back) {
+		fprintf(stderr, "back-to-back mode makes no sense for rb-prod!\n");
+		exit(1);
+	}
+
+	if (bench_prod && args.sampled) {
+		fprintf(stderr, "sampling mode makes no sense for rb-prod!\n");
+		exit(1);
+	}
+
+	if (!bench_prod && env.consumer_cnt != 1) {
+		fprintf(stderr, "benchmarks excluding rb-prod need one consumer!\n");
 		exit(1);
 	}
 
@@ -132,8 +161,10 @@ static void ringbuf_libbpf_measure(struct bench_res *res)
 	res->drops = atomic_swap(&ctx->skel->bss->dropped, 0);
 }
 
-static struct ringbuf_bench *ringbuf_setup_skeleton(void)
+static struct ringbuf_bench *ringbuf_setup_skeleton(int bench_prod)
 {
+	__u32 flags;
+	struct bpf_map *ringbuf;
 	struct ringbuf_bench *skel;
 
 	setup_libbpf();
@@ -146,12 +177,19 @@ static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 
 	skel->rodata->batch_cnt = args.batch_cnt;
 	skel->rodata->use_output = args.ringbuf_use_output ? 1 : 0;
+	skel->rodata->bench_prod = bench_prod;
 
 	if (args.sampled)
 		/* record data + header take 16 bytes */
 		skel->rodata->wakeup_data_size = args.sample_rate * 16;
 
-	bpf_map__set_max_entries(skel->maps.ringbuf, args.ringbuf_sz);
+	ringbuf = skel->maps.ringbuf;
+	if (args.overwrite) {
+		flags = bpf_map__map_flags(ringbuf) | BPF_F_OVERWRITE;
+		bpf_map__set_map_flags(ringbuf, flags);
+	}
+
+	bpf_map__set_max_entries(ringbuf, args.ringbuf_sz);
 
 	if (ringbuf_bench__load(skel)) {
 		fprintf(stderr, "failed to load skeleton\n");
@@ -171,10 +209,13 @@ static void ringbuf_libbpf_setup(void)
 {
 	struct ringbuf_libbpf_ctx *ctx = &ringbuf_libbpf_ctx;
 	struct bpf_link *link;
+	int map_fd;
 
-	ctx->skel = ringbuf_setup_skeleton();
-	ctx->ringbuf = ring_buffer__new(bpf_map__fd(ctx->skel->maps.ringbuf),
-					buf_process_sample, NULL, NULL);
+	ctx->skel = ringbuf_setup_skeleton(0);
+
+	map_fd = bpf_map__fd(ctx->skel->maps.ringbuf);
+	ctx->ringbuf = ring_buffer__new(map_fd, buf_process_sample,
+					NULL, NULL);
 	if (!ctx->ringbuf) {
 		fprintf(stderr, "failed to create ringbuf\n");
 		exit(1);
@@ -232,7 +273,7 @@ static void ringbuf_custom_setup(void)
 	void *tmp;
 	int err;
 
-	ctx->skel = ringbuf_setup_skeleton();
+	ctx->skel = ringbuf_setup_skeleton(0);
 
 	ctx->epoll_fd = epoll_create1(EPOLL_CLOEXEC);
 	if (ctx->epoll_fd < 0) {
@@ -277,6 +318,33 @@ static void ringbuf_custom_setup(void)
 	}
 }
 
+/* RINGBUF-PRODUCER benchmark */
+static struct ringbuf_prod_ctx {
+	struct ringbuf_bench *skel;
+} ringbuf_prod_ctx;
+
+static void ringbuf_prod_measure(struct bench_res *res)
+{
+	struct ringbuf_prod_ctx *ctx = &ringbuf_prod_ctx;
+
+	res->hits = atomic_swap(&ctx->skel->bss->hits, 0);
+	res->drops = atomic_swap(&ctx->skel->bss->dropped, 0);
+}
+
+static void ringbuf_prod_setup(void)
+{
+	struct ringbuf_prod_ctx *ctx = &ringbuf_prod_ctx;
+	struct bpf_link *link;
+
+	ctx->skel = ringbuf_setup_skeleton(1);
+
+	link = bpf_program__attach(ctx->skel->progs.bench_ringbuf);
+	if (!link) {
+		fprintf(stderr, "failed to attach program!\n");
+		exit(1);
+	}
+}
+
 #define RINGBUF_BUSY_BIT (1 << 31)
 #define RINGBUF_DISCARD_BIT (1 << 30)
 #define RINGBUF_META_LEN 8
@@ -540,6 +608,17 @@ const struct bench bench_rb_custom = {
 	.report_final = hits_drops_report_final,
 };
 
+const struct bench bench_rb_prod = {
+	.name = "rb-prod",
+	.argp = &bench_ringbufs_argp,
+	.validate = bufs_validate,
+	.setup = ringbuf_prod_setup,
+	.producer_thread = bufs_sample_producer,
+	.measure = ringbuf_prod_measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
 const struct bench bench_pb_libbpf = {
 	.name = "pb-libbpf",
 	.argp = &bench_ringbufs_argp,
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index 91e3567962ff..84ae66beb0ec 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -49,3 +49,7 @@ for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
 	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
 done
 
+header "Ringbuf, overwrite mode with multi-producer contention, no consumer"
+for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
+	summarize "rb-prod nr_prod $b" "$($RUN_BENCH -p$b --rb-batch-cnt 50 --rb-overwrite rb-prod)"
+done
diff --git a/tools/testing/selftests/bpf/progs/ringbuf_bench.c b/tools/testing/selftests/bpf/progs/ringbuf_bench.c
index 6a468496f539..c55282ba4038 100644
--- a/tools/testing/selftests/bpf/progs/ringbuf_bench.c
+++ b/tools/testing/selftests/bpf/progs/ringbuf_bench.c
@@ -14,9 +14,11 @@ struct {
 
 const volatile int batch_cnt = 0;
 const volatile long use_output = 0;
+const volatile long bench_prod = 0;
 
 long sample_val = 42;
 long dropped __attribute__((aligned(128))) = 0;
+long hits __attribute__((aligned(128))) = 0;
 
 const volatile long wakeup_data_size = 0;
 
@@ -24,6 +26,9 @@ static __always_inline long get_flags()
 {
 	long sz;
 
+	if (bench_prod)
+		return BPF_RB_NO_WAKEUP;
+
 	if (!wakeup_data_size)
 		return 0;
 
@@ -47,6 +52,8 @@ int bench_ringbuf(void *ctx)
 				*sample = sample_val;
 				flags = get_flags();
 				bpf_ringbuf_submit(sample, flags);
+				if (bench_prod)
+					__sync_add_and_fetch(&hits, 1);
 			}
 		}
 	} else {
@@ -55,6 +62,9 @@ int bench_ringbuf(void *ctx)
 			if (bpf_ringbuf_output(&ringbuf, &sample_val,
 					       sizeof(sample_val), flags))
 				__sync_add_and_fetch(&dropped, 1);
+			else if (bench_prod)
+				__sync_add_and_fetch(&hits, 1);
+
 		}
 	}
 	return 0;
-- 
2.43.0


