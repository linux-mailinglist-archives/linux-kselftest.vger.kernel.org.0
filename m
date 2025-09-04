Return-Path: <linux-kselftest+bounces-40724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F4B42F7C
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 04:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3D91BC87F6
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 02:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B4D2586CE;
	Thu,  4 Sep 2025 02:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXay5f9X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC7324728B;
	Thu,  4 Sep 2025 02:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756951840; cv=none; b=p3US38S3Hlxr8v+vJE3f+JCqZFgUeIvXhV1SHxBMTqxFz20D//c10UgAREHsmG6G6OWVuTu5PjuEibyuB/2h3YpJTaBb5Lq562NkHfBSdz85OOiWkrgwhRz27u8z8VcwRfntug7WLkl7Okg0SyQgqcq+rmFKuJG7T634QaIDc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756951840; c=relaxed/simple;
	bh=JtnLU1lOlEO7kOGweXbOv45YArumQDIRPeP+yy1NpFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgOe5mZRrNJvzF5BNquvNgwc6myZXvQ1npHVEYroRqIix9q1w/1azhWjkms+tpJBoqNq4qBxMpOvXy+YRp5tzytjh0Yej6dx1BrpU5w0hYtNF3SnCSQA9fNAJMDoQMiEkQCiQfHgRHl6AJqcYJ8e1DFn4ornCs36SKWBQFEagpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXay5f9X; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so579940a91.2;
        Wed, 03 Sep 2025 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756951838; x=1757556638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3dvQ7K9NTYyh1ugFrnxU2Kn4PBNqUnkJfMhvkxOxik=;
        b=IXay5f9XK/J9qnhTv3Fm4zmHqyW4P3kEWyrBZeur8d2AojawypcAHftIMpkmF3SZKQ
         Kuj+nPxf8iw6SUsq7T9udlm6C8tstfnqwPrNKcFqwX79svEReUpyUsnhoqd9roz48hp9
         UZeuV75301MUOutvc4rGUPgnlSnCxW9NOTIwqlQhxjcVrMwvN+3m4jbiyFT5WGKnNDKm
         SibO/q8nzt4N6z9lr7KVzFEbD24DSioJw1HlmVQ5iYarDiY4UCMfY0qrA4AQ4WW01vO6
         F9N3uw7wpMV0UTlN9iQQ2Iyd1RuW6V0D8fd/acDgVGWgHpBfkBbgCuZxpyt90MWwJv4U
         C/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756951838; x=1757556638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3dvQ7K9NTYyh1ugFrnxU2Kn4PBNqUnkJfMhvkxOxik=;
        b=QSth7Qrh7rz7QEZm1cZVrb9jPN+WCLffonvDDjYKsbQxN3ELeANzzgzWHUZ32I4Z7O
         9kX+/Kvp09M/bJdWS2GGcSmlVALrhWhcQF3eX0M1ig2fqKkwQHpCiZNGpaH4w0AflygE
         +iZmZfwAvA0SzuIwcShYTPKY+tjpcDWhpkc1otJkZ5a41BTwpFe7tD+pylILQN/0pX64
         IdEroIRbH/zopFBAEV+1HD4ts4CmJG1MnULsqjsblGoY/R5kdNeK2OPxYvMP891Rdr+y
         wOiiv+HggoZpdgKdgI8OZvR4Vbf/T4QFGxhgvX7a9FH6sI4bRpiGlUMyGuVH0T1PtL09
         2HCg==
X-Forwarded-Encrypted: i=1; AJvYcCU9TLSETLEUfYkXS2oxQYrlg3cetGoqamI7hVsafnAeUTLNoW9NGxi9br8fdSiE2dvNTdA7BEuQhI82FFB5@vger.kernel.org, AJvYcCVLJsrNBuSbXNiE0bmUoCiZpOAE0M9P10ALkSPVqmMKerOmrSAb3O11mbjd2+BRhigQX9mzTGFJOgVo4FCQ6nQD@vger.kernel.org, AJvYcCXCKJgLUH+cAfMTDhkG01DwBOTW/quh8dJy4dGdbYXadgoC5Vms6MvxxOP1nQtdJZEhMD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Hxd/0rbl8bukAmArj/qv+z6rkT2yvp3+QfjVe7EL7U9NqFck
	9Q0j2k98I0Nptr4r3RuKXg2vvMmojnFAXDj49Dxqe82xCgpNkt5qOFKp
X-Gm-Gg: ASbGncvGQJPGI1T1IC/XP7fkK2fFEyofvYN+brj9ejvfc1LvbR7iX4P1D1iswYn2VYf
	kVAw2DPounppp9x6Ejw7DDH1d9cT9yl1v/CyZKZmGJTLwVFqJgFFrj+ZZKlG/wUUYgrdClOUcQQ
	A1xMS+EP2lOivisR5Ak90ggAVJZhy5CBLowKwAjutXuMmgF871MfzNz15XpvfQ+BKzvFywqrc0Z
	WVYBtD1Y3S5k03qOuU3etZ8u/G4Rx+jUK7eFWa+FAkiNYVAMKY28g02PfB4h9e9Bw7cSEF/JjSE
	CXaAR0KZCHCoQHl0sFtdrRQL4Ba3uHUZTWRTVJ2uG0/yEg1/xgbZywcMoeq0YowZOS9Ep929PIi
	B7FvKC/8NNgNkIyRMBumhmgg=
X-Google-Smtp-Source: AGHT+IHv871LldnjZ5vEAPGq0te4x2Jr9f9NB0EUSvNM4YX4zjwy7/kqLXCaYBRlZmQyPu22EPqVww==
X-Received: by 2002:a17:90b:384d:b0:327:50b2:8007 with SMTP id 98e67ed59e1d1-328156f75f6mr21540854a91.32.1756951838152;
        Wed, 03 Sep 2025 19:10:38 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727822817asm5143014b3a.98.2025.09.03.19.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 19:10:37 -0700 (PDT)
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
Subject: [PATCH RESEND bpf-next v3 3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Thu,  4 Sep 2025 10:10:11 +0800
Message-ID: <20250904021011.14069-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904021011.14069-1-dongml2@chinatelecom.cn>
References: <20250904021011.14069-1-dongml2@chinatelecom.cn>
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
index df4489ac14a0..bd29bb2e6cb5 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -512,6 +512,8 @@ extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
+extern const struct bench bench_trig_kprobe_multi_all;
+extern const struct bench bench_trig_kretprobe_multi_all;
 extern const struct bench bench_trig_fexit;
 extern const struct bench bench_trig_fmodret;
 extern const struct bench bench_trig_tp;
@@ -587,6 +589,8 @@ static const struct bench *benchs[] = {
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


