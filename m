Return-Path: <linux-kselftest+bounces-38232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05000B19A35
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 04:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD51723C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 02:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AEA218E91;
	Mon,  4 Aug 2025 02:27:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8464720127B;
	Mon,  4 Aug 2025 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754274434; cv=none; b=t1b154R4ebf4qmJSin6gzLCGDn2ViZ/6xJlIilQWuzWVfW5Cpzl600eAoGocceBalOmqCRE74W33Nvwy492YKa1XeIobgbJMf1bCkjsOBzKmPlrGu5BDPyqFiyoqppti1L+19FWQifAlMPF8sc0DUxnHjSd6+N9fhFqzbCNpbv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754274434; c=relaxed/simple;
	bh=UW1WmWLA5hqVf8AQJiB3mCG4tYSWQTkhlPbwBNCJnik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iuok66QA+f2LhF5SjZayj2h+mpq/9E+baDJ8OIk6tkgGGzTnSW1xKUEFRmRpdYLGV1WxrYvDYTQbWvAQ+y6hqbI690OFNXSJn6HRwA8bqIq/nwGGlNNPN/TMeWDYji5TpA3U/SJuaLKHq6gLXGk+poqOdEDuUku7XYMwYkurQ78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bwL6k4KDNzYQtxF;
	Mon,  4 Aug 2025 10:27:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 40CCA1A018D;
	Mon,  4 Aug 2025 10:27:09 +0800 (CST)
Received: from k-arm6401.huawei.com (unknown [7.217.19.243])
	by APP4 (Coremail) with SMTP id gCh0CgAX4BBsGpBoTUL9CQ--.242S6;
	Mon, 04 Aug 2025 10:27:08 +0800 (CST)
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
Subject: [PATCH bpf-next 4/4] selftests/bpf/benchs: Add overwrite mode bench for rb-libbpf
Date: Mon,  4 Aug 2025 10:21:00 +0800
Message-ID: <20250804022101.2171981-5-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
References: <20250804022101.2171981-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX4BBsGpBoTUL9CQ--.242S6
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw45ZrWUAr45urWDtw4xWFg_yoWxGF4fpF
	WDCFWfCw1xtr93XF1vkw48JrW7ZrnrZ3W5CFyfta17Zw1xWan0q3yxK3yUt3Z8G348C3WS
	v34ktryrGw1UJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxkIecxEwVCI4VW8JwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07jtsqXUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add overwrite mode bench for ring buffer.

For reference, below are bench numbers collected from x86_64 and arm64.

- x86_64 (AMD EPYC 9654)

  Ringbuf, multi-producer contention, overwrite mode
  ==================================================
  rb-libbpf nr_prod 1  14.970 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 2  14.064 ± 0.007M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 3  7.493 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 4  6.575 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 8  3.696 ± 0.011M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 12 2.612 ± 0.012M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 16 2.335 ± 0.005M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 20 2.079 ± 0.005M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 24 1.965 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 28 1.846 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 32 1.790 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 36 1.735 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 40 1.701 ± 0.002M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 44 1.669 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 48 1.749 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 52 1.709 ± 0.001M/s (drops 0.000 ± 0.000M/s)

- arm64 (HiSilicon Kunpeng 920)

  Ringbuf, multi-producer contention, overwrite mode
  ==================================================
  rb-libbpf nr_prod 1  10.319 ± 0.231M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 2  9.219 ± 0.006M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 3  6.699 ± 0.013M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 4  4.608 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 8  3.905 ± 0.001M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 12 3.282 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 16 3.182 ± 0.008M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 20 3.029 ± 0.006M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 24 3.116 ± 0.004M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 28 2.869 ± 0.005M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 32 3.075 ± 0.010M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 36 2.795 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 40 2.947 ± 0.005M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 44 2.748 ± 0.006M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 48 2.767 ± 0.003M/s (drops 0.000 ± 0.000M/s)
  rb-libbpf nr_prod 52 2.858 ± 0.002M/s (drops 0.000 ± 0.000M/s)

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 .../selftests/bpf/benchs/bench_ringbufs.c     | 22 ++++++++++++++++++-
 .../bpf/benchs/run_bench_ringbufs.sh          |  4 ++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
index e1ee979e6acc..6fdfc61c721b 100644
--- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
+++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
@@ -19,6 +19,7 @@ static struct {
 	int ringbuf_sz; /* per-ringbuf, in bytes */
 	bool ringbuf_use_output; /* use slower output API */
 	int perfbuf_sz; /* per-CPU size, in pages */
+	bool overwrite_mode;
 } args = {
 	.back2back = false,
 	.batch_cnt = 500,
@@ -27,6 +28,7 @@ static struct {
 	.ringbuf_sz = 512 * 1024,
 	.ringbuf_use_output = false,
 	.perfbuf_sz = 128,
+	.overwrite_mode = false,
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
+	{ "rb-overwrite", ARG_RB_OVERWRITE, NULL, 0, "overwrite mode"},
 	{},
 };
 
@@ -72,6 +76,9 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 			argp_usage(state);
 		}
 		break;
+	case ARG_RB_OVERWRITE:
+		args.overwrite_mode = true;
+		break;
 	default:
 		return ARGP_ERR_UNKNOWN;
 	}
@@ -104,6 +111,11 @@ static void bufs_validate(void)
 		fprintf(stderr, "back-to-back mode makes sense only for single-producer case!\n");
 		exit(1);
 	}
+
+	if (args.overwrite_mode && strcmp(env.bench_name, "rb-libbpf") != 0) {
+		fprintf(stderr, "rb-overwrite mode only supports rb-libbpf!\n");
+		exit(1);
+	}
 }
 
 static void *bufs_sample_producer(void *input)
@@ -134,6 +146,8 @@ static void ringbuf_libbpf_measure(struct bench_res *res)
 
 static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 {
+	__u32 flags;
+	struct bpf_map *ringbuf;
 	struct ringbuf_bench *skel;
 
 	setup_libbpf();
@@ -151,7 +165,13 @@ static struct ringbuf_bench *ringbuf_setup_skeleton(void)
 		/* record data + header take 16 bytes */
 		skel->rodata->wakeup_data_size = args.sample_rate * 16;
 
-	bpf_map__set_max_entries(skel->maps.ringbuf, args.ringbuf_sz);
+	ringbuf = skel->maps.ringbuf;
+	if (args.overwrite_mode) {
+		flags = bpf_map__map_flags(ringbuf) | BPF_F_OVERWRITE;
+		bpf_map__set_map_flags(ringbuf,  flags);
+	}
+
+	bpf_map__set_max_entries(ringbuf, args.ringbuf_sz);
 
 	if (ringbuf_bench__load(skel)) {
 		fprintf(stderr, "failed to load skeleton\n");
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
index 91e3567962ff..4e758bc52b73 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_ringbufs.sh
@@ -49,3 +49,7 @@ for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
 	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-batch-cnt 50 rb-libbpf)"
 done
 
+header "Ringbuf, multi-producer contention, overwrite mode"
+for b in 1 2 3 4 8 12 16 20 24 28 32 36 40 44 48 52; do
+	summarize "rb-libbpf nr_prod $b" "$($RUN_RB_BENCH -p$b --rb-overwrite --rb-batch-cnt 50 rb-libbpf)"
+done
-- 
2.43.0


