Return-Path: <linux-kselftest+bounces-39926-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB876B35659
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 10:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F12B682042
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BA62F83C1;
	Tue, 26 Aug 2025 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4HwOVcs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A14A2853FA;
	Tue, 26 Aug 2025 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756195500; cv=none; b=nj0vzpjKDttKTIWAI7D16FIqJYFaKfg8btRYeSIzSES8rc1DcnoWJHt7t7Z8nONldlsYij8PQ0UyoocCAYMhYBrWFwH/yV8MxlGzk4NcaMA7UGVoBS2Bp4mAW+nLMFwh1HQkmJsoNjz2aTCWBuAOf6hUC1QpZb9ypFTSxMNZqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756195500; c=relaxed/simple;
	bh=mc4HjBQoj+cY0K8gVaUwo6cJ18WjLYLy5NvRmtEby7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdUhEaKCM9wkPUGCCh8UcfTXXrblOVmmzOFibIL8pOF4XsXq7wzK/yfUe5ly8DZeYwm2ct8WVncwZ5hjsW83rgwZNYLg/7coMCWP4fiZr62wsKBbO+9MLh93/NtTinF3G1mZWKCuuoBjy+nbQ3Co5jpU1efvGK6eBc0b+rgveTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4HwOVcs; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-24687a76debso23092885ad.0;
        Tue, 26 Aug 2025 01:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756195498; x=1756800298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANo5cUf5hg9N0r5c+hXAraC/9ocQ00QIvjoPiGNkd94=;
        b=Q4HwOVcs/A5NLavNVwzY1aOAIeBqBiivVxGwf+/uGABDByfdfNp7PJxkS3A+5vBjL9
         azBM105KVRIBBEuE4iQnUL7F35sy4vJ2W3ygRBi9V7HDTotMN7jExSYWCf+PMLlVzb4I
         bYgVUuBVuZyX2Rp36kEKZiEaUuzrYTFC7p3Xb28rYLpajAjmgHmdFEMJe6UXNe7rdyA4
         spi43yquuQghdMzL0XOg0r2mHWtCK8dubKPGxgnjGq4YiKOeR6ts4LiTc5kVQXqprpjq
         Y7lmD6YGkOPWL0elFHeuXckYXF+LDwysmgbVmxjQ4ZOEdjAG0AU2Dxti2/YX1+BxTvZJ
         BPzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756195498; x=1756800298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANo5cUf5hg9N0r5c+hXAraC/9ocQ00QIvjoPiGNkd94=;
        b=hn9GJIndgDeulcFPLzCQhNda5uqFsB6pLYcUOMlt2Jr5/9U30Xib7T+EQYEsKjyj1y
         6GE0Kad4CjG0nRAIJRl0ZeKjzV5PWQXs7A9WmM9s4ah11gwRh0SjzUsNKV3xUZDmhGCz
         SGDL3nEQaBEuofZ0gHWfB+zFwDWYBpfdpn4raIkzRHaeRlKFaWk10actIZxkWXk0Y44n
         P3G9G+nvzVxNamELzgOXkMIHN4/SXrmG9tpgRODbXBrb2WUrEXQSpSIeer13Vt/FMNJz
         ihQQyA1VXzh114asJur5JzxDrKaujV1jkUxCnI0M6nQCOprMQxfcBtl7HeGm9MEjEXCi
         W9ig==
X-Forwarded-Encrypted: i=1; AJvYcCVG3jNmOE1ZEr3aUsEkuUUO/1kJ0ha32Ln3IEzDbbS7Z3BhREhIyy5G10tsKF/suqpOMCU=@vger.kernel.org, AJvYcCVHY/ef9J3cp3cdCz8a1aF6Bb0ue97yraNhIT+BxZde1WRhW1ZfDpOw17XerOu/9T3XQav/i50RheUCP9em@vger.kernel.org, AJvYcCWKALxbRwV3Z2qg1bQw9S/jNYy7M8drsJyRhgDqJ7YSdVbscKgUetR0IuPIqPwPQT2lrii4l7Hd/oNzEh0EW4GM@vger.kernel.org
X-Gm-Message-State: AOJu0YxIuTofss3/3SaHkLMruh9ujM6iy94Ku3MdSiRvUlkeYn6pPEk+
	lHJPGG8aaQiaCYhYDJtbptKAHy8WbNTd4X4jl1ps4GR85PgDSk0aR0R0
X-Gm-Gg: ASbGnctbbrARjooUlO9FgWV6fM/EJrGi6VUP6KxZFcayKopa7ORQtjp+QtN0gZrWqzP
	59JyvHq8KmZeJZfnbEJwEZD82OmafhEt/38cja/l7CMHv4wQgDLIvwA78yXuO6LXTUZlbRuHGoR
	2OzfJEIPIW6K7lObiayUelWyd8epfY2M5ly6R5LLysVr1eo1BcfhOSdBUmXPZjlYnYt1gFmflD3
	OwMk4Uwll4pwpfVCoHtbdGErfWjoPqMSTCb2TpsfQt0+OZrqbaei/tF4C+Q3E9x/6aUGj2bV6qz
	rpEWIOBWzUKgeKiQ5nHpci4MdAXY30mh1Cgk9t9pfyS2jiTuXU/u0sN6vZiT9SVfRS6pU6VzHYn
	MH1N75VZR34hBGkDoBbBwD50sw2xtPh6nEA==
X-Google-Smtp-Source: AGHT+IHLWEMFd/v9ow3xzQkAWja8OQHfuqE+Z3SsxYR3vrdyWDSIGD1g1wUGWFc0myCS2X1LrXQOTg==
X-Received: by 2002:a17:902:e54c:b0:215:6c5f:d142 with SMTP id d9443c01a7336-248753a271amr6505305ad.20.1756195497679;
        Tue, 26 Aug 2025 01:04:57 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466888037fsm88829485ad.125.2025.08.26.01.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 01:04:56 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: andrii@kernel.org
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
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Tue, 26 Aug 2025 16:04:30 +0800
Message-ID: <20250826080430.79043-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250826080430.79043-1-dongml2@chinatelecom.cn>
References: <20250826080430.79043-1-dongml2@chinatelecom.cn>
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
v2:
- use fprintf() instead of printf()
---
 tools/testing/selftests/bpf/bench.c           |  4 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 53 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  4 +-
 .../selftests/bpf/progs/trigger_bench.c       | 12 +++++
 tools/testing/selftests/bpf/trace_helpers.c   |  1 +
 5 files changed, 72 insertions(+), 2 deletions(-)

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
index 82327657846e..b483c6f64444 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -226,6 +226,57 @@ static void trigger_fentry_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	char **syms = NULL;
+	size_t cnt = 0;
+
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
@@ -512,6 +563,8 @@ BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
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


