Return-Path: <linux-kselftest+bounces-40390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08220B3D7DD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 05:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C207316E3D8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3CF24DD13;
	Mon,  1 Sep 2025 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkcNMnX4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33F248F68;
	Mon,  1 Sep 2025 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698199; cv=none; b=Mvwwtry3/dv3O/YPVUQ03w8Ms64cJyQbxky0NVIk7awi3WaIFUuPU4ic4UGfsSs3FJQl+gxHmNJ0k3e6isOpBGldsglltWsFX5K8IvFO7l1XhVp/F96ckerXpP4aC2MekOnzNqSs6A1db8JHq8pMn9DbX/qHobZqTbCngGKGP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698199; c=relaxed/simple;
	bh=esOjmZu1X9xiEk3qvdx7i5fY5MdwrELv0/qBSSSVvYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7AghP72pVwCrFX6i3kKMIM0OAANmxzbAWC7315V1DKcTgXCDDxPzy99Lq9exq7tH4u6F2E7N8EMVOQW8K/8sJK0ZiiqKW1rjo4jKrlYTRTClusU5lX5fcAlz/8ZDpvTuSnjANj0J/xQp48iQClfSWUjCIrrW5ko2eJPcrF1P8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkcNMnX4; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24622df0d95so29827435ad.2;
        Sun, 31 Aug 2025 20:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756698197; x=1757302997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVZ8ljKbkQ1N5TlN7zVfjsTkLHUo/u1e6cnRcFN/id4=;
        b=bkcNMnX4xVQM4zw90ujIR3h9uCi0lKS4zsCaf0WotqgoN0LeYpj6z4RTUxVlvC/th5
         L6mF1WB7In5PbWpsu1Y3rFWCnHMsK7IqcMwvf0/OyPNeZqCCWY4iV/Zz/Q8biF4TwKQ9
         CgoT+oAJ+xuTte4qK0gp/oY/1VrnrPNX0QMy0EkhKDezmG42+2eg8I5AvaeaM4qDtz6z
         3LAmMA46nwW/msONbzcVCbvpMay4G13uXby20XVqYEN5nnrAcVuqXtffHFzNyDXKsSh9
         5wBUkjcycSbKwCV8RLGrQb85PvX2/YdvwpBen+1BQEF87MdijjspQ45wY0vP4loScxnu
         AHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756698197; x=1757302997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVZ8ljKbkQ1N5TlN7zVfjsTkLHUo/u1e6cnRcFN/id4=;
        b=ZviG06IR75FTMN5Yex/Z9c5UOYXZoyA8WmHKH9q5YpW30p4A1nRFaMU52X7v5thL3g
         AZRl67OLgQxU26pDkWpzo+l7xIfjB7Eu3b06TxlMThs+CAkKs2g2xc0HclETnoUyYaQx
         ny7Os/0R3WnMvqxcuZ8sbgW5HPGZZkeTfieELIqwHD6McpZWixh6zRRnQ3YuRICv+GVe
         5l7em1SNN94f+xTmcPWhSCIODm7tV+PCPwk74q/kXd0iQuexWe8HIYvX3DONjIwondTB
         HpYBuPqpRF5CUoFn4JW97TP1YMeCEvD7juNBGwNb/6Dh6V6TzElAbnvgr6nPn3C1c67q
         gzLg==
X-Forwarded-Encrypted: i=1; AJvYcCUHYtDnS+5UX0B4q37L1EpO6kQ0A6wZAtT7/2U8FlOL7+3qM5R2H9EcGHBRLtlEXDK920MTsCpdNIGb7ww/HSpZ@vger.kernel.org, AJvYcCUwRS8UcOoOQShh8D6f3UF8NVKKxllX59JqnUSFp/2qhmSUT6bjczzCrhZKhfl4iXvS26jD/TrbslDJca5Y@vger.kernel.org, AJvYcCW+hA6/yvbgc2ihjKjNr2kMr8JuzSySr64GxjEsrpea7up+ZWbvdA80zaE33rLW/vVDgFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh1VrE8VusAef/CUIFJQcKLKSL+clF9HLFtO5aqrE+rEKXw2/6
	+KJaWzkw+wEJXTiNSlof+16E4R7pGWZN5ZMFDOamigZv2AmKSFljeQgO
X-Gm-Gg: ASbGncvjiCx0oi9iUVXbQdaHRzRdNa4txf5k3KqOTp77upRRJ3pdDL6Xs5SMJUJdriG
	rqy4K7lX32X6DRJ5SdiVQ91wiR9mO+cPJmcVhNFIE96szAjSex5695SQ5yUC4eQO6ZIPFGxpuBs
	MUfoFRPC/CBzSsrKXGfTBnhH4wq6AJ9fJMK4ZKz4jXoAzPxY58XionJfTX1yV5KEeE4pRf/Gcqq
	en+s1xiOty/RRhLkCcVNB0BJ953Reemm7vD+1TdjFigLzgG1laX2EW3N0br1m9B8VYYGGvMcsG8
	5XqZlyb8uQVBZh6yb+Dal2ewkFzC1l5L1mkR6T8VfEl714yTC0DA5euhd0tboMVVBdV/4uSQbvE
	YFv8OHnNsIsoNzz9ADUPJYtzuPwGW50eb3A==
X-Google-Smtp-Source: AGHT+IF+/P9/L3cqwGA8UKMLeIpqFj4lli0iMM4juSxXZ3/JLG3F3ElOxz5Hrm09rb9USFAzVNDnHA==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr97485105ad.18.1756698197462;
        Sun, 31 Aug 2025 20:43:17 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067de9f1sm88398265ad.151.2025.08.31.20.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 20:43:17 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org,
	olsajiri@gmail.com
Cc: eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yikai.lin@vivo.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Mon,  1 Sep 2025 11:42:52 +0800
Message-ID: <20250901034252.26121-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901034252.26121-1-dongml2@chinatelecom.cn>
References: <20250901034252.26121-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, the benchmark for kprobe-multi is single, which means there is
only 1 function is hooked during testing. Add the testing
"kprobe-multi-all", which will hook all the kernel functions during
the benchmark. And the "kretprobe-multi-all" is added too.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- add some comment to attach_ksyms_all, which note that don't run the
  testing on a debug kernel

v2:
- use fprintf() instead of printf()
---
 tools/testing/selftests/bpf/bench.c           |  4 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 61 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  4 +-
 .../selftests/bpf/progs/trigger_bench.c       | 12 ++++
 tools/testing/selftests/bpf/trace_helpers.c   |  1 +
 5 files changed, 80 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ddd73d06a1eb..29dbf937818a 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -510,6 +510,8 @@ extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
+extern const struct bench bench_trig_kprobe_multi_all;
+extern const struct bench bench_trig_kretprobe_multi_all;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_tp;
@@ -578,6 +580,8 @@ static const struct bench *benchs[] = {
 	&bench_trig_kprobe_multi,
 	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
+	&bench_trig_kprobe_multi_all,
+	&bench_trig_kretprobe_multi_all,
 	&bench_trig_fexit,
 	&bench_trig_fmodret,
 	&bench_trig_tp,
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 82327657846e..1e2aff007c2a 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -226,6 +226,65 @@ static void trigger_fentry_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	/* Some recursive functions will be skipped in
+	 * bpf_get_ksyms -> skip_entry, as they can introduce sufficient
+	 * overhead. However, it's difficut to skip all the recursive
+	 * functions for a debug kernel.
+	 *
+	 * So, don't run the kprobe-multi-all and kretprobe-multi-all on
+	 * a debug kernel.
+	 */
+	if (bpf_get_ksyms(&syms, &cnt, true)) {
+		fprintf(stderr, "failed to get ksyms\n");
+		exit(1);
+	}
+
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.retprobe = kretprobe;
+	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
+	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
+		fprintf(stderr, "failed to attach bpf_program__attach_kprobe_multi_opts to all\n");
+		exit(1);
+	}
+}
+
+static void trigger_kprobe_multi_all_setup(void)
+{
+	struct bpf_program *prog, *empty;
+
+	setup_ctx();
+	empty = ctx.skel->progs.bench_kprobe_multi_empty;
+	prog = ctx.skel->progs.bench_trigger_kprobe_multi;
+	bpf_program__set_autoload(empty, true);
+	bpf_program__set_autoload(prog, true);
+	load_ctx();
+
+	attach_ksyms_all(empty, false);
+	attach_bpf(prog);
+}
+
+static void trigger_kretprobe_multi_all_setup(void)
+{
+	struct bpf_program *prog, *empty;
+
+	setup_ctx();
+	empty = ctx.skel->progs.bench_kretprobe_multi_empty;
+	prog = ctx.skel->progs.bench_trigger_kretprobe_multi;
+	bpf_program__set_autoload(empty, true);
+	bpf_program__set_autoload(prog, true);
+	load_ctx();
+
+	attach_ksyms_all(empty, true);
+	attach_bpf(prog);
+}
+
 static void trigger_fexit_setup(void)
 {
 	setup_ctx();
@@ -512,6 +571,8 @@ BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
 BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
 BENCH_TRIG_KERNEL(kretprobe_multi, "kretprobe-multi");
 BENCH_TRIG_KERNEL(fentry, "fentry");
+BENCH_TRIG_KERNEL(kprobe_multi_all, "kprobe-multi-all");
+BENCH_TRIG_KERNEL(kretprobe_multi_all, "kretprobe-multi-all");
 BENCH_TRIG_KERNEL(fexit, "fexit");
 BENCH_TRIG_KERNEL(fmodret, "fmodret");
 BENCH_TRIG_KERNEL(tp, "tp");
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index a690f5a68b6b..f7573708a0c3 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -6,8 +6,8 @@ def_tests=( \
 	usermode-count kernel-count syscall-count \
 	fentry fexit fmodret \
 	rawtp tp \
-	kprobe kprobe-multi \
-	kretprobe kretprobe-multi \
+	kprobe kprobe-multi kprobe-multi-all \
+	kretprobe kretprobe-multi kretprobe-multi-all \
 )
 
 tests=("$@")
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 044a6d78923e..3d5f30c29ae3 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -97,6 +97,12 @@ int bench_trigger_kprobe_multi(void *ctx)
 	return 0;
 }
 
+SEC("?kprobe.multi/bpf_get_numa_node_id")
+int bench_kprobe_multi_empty(void *ctx)
+{
+	return 0;
+}
+
 SEC("?kretprobe.multi/bpf_get_numa_node_id")
 int bench_trigger_kretprobe_multi(void *ctx)
 {
@@ -104,6 +110,12 @@ int bench_trigger_kretprobe_multi(void *ctx)
 	return 0;
 }
 
+SEC("?kretprobe.multi/bpf_get_numa_node_id")
+int bench_kretprobe_multi_empty(void *ctx)
+{
+	return 0;
+}
+
 SEC("?fentry/bpf_get_numa_node_id")
 int bench_trigger_fentry(void *ctx)
 {
diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index 9577979bd84d..171987627f3a 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -549,6 +549,7 @@ static const char * const trace_blacklist[] = {
 	"preempt_count_sub",
 	"__rcu_read_lock",
 	"__rcu_read_unlock",
+	"bpf_get_numa_node_id",
 };
 
 static bool skip_entry(char *name)
-- 
2.51.0


