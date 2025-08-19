Return-Path: <linux-kselftest+bounces-39279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A8AB2B7D5
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 05:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A36B21BA2C29
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 03:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C212D3EEE;
	Tue, 19 Aug 2025 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7Ym0pmI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9412D2494;
	Tue, 19 Aug 2025 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574825; cv=none; b=Dnm30I0SjszOsQ+R7PrHl1jGmlUSaG8sRv5WrpWpHzqFsujQUq7g5ffs00muZ9P05TOUECZQK2ILd5CVy/Qmi47lyILbuub3i8otAOkOJ4kfjSFvlzTN6oRnNRLcDPGN94kvUl9xXA/lgd+bP36l9JTSawdiAA01878olrBv8Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574825; c=relaxed/simple;
	bh=Yju8yrfKAYNHODJEA8h/x80ZTVJoAlrlqoDz+HFiBUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjTHTa5LMo/+20C04Khg3kSsB8rujhJ34LBCcpHGdG+xS2FSzXopXMTWX9ELxLVazV5bxSdv6oeetVnx7SZnc1ZpjqhEDJ/SS9pGgqMZnitOAmPUJo3oRW6TU+9fewmH5HtNLOMaUUgNO41Vuu75gvmMoFM0c1qasTS+cw33ytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7Ym0pmI; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b471aaa085aso2764270a12.0;
        Mon, 18 Aug 2025 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755574823; x=1756179623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up9OuXnclQEyapPLpqQTS4r+NCar6InDzt6ZL5WdOUY=;
        b=N7Ym0pmI0ujXu/mLkT+8MlqfF733Nrdb7CfddbEc6rGgD4dOw0cCrl/a3SL6ZKl1Pf
         gq2Nl5nBpiXLMSEeOw6ManMF/wb6qwM5dptywRs2OJI9iyrOOo+38GWbjMcPtxAnwi+P
         2+zRu0E2k+5iIhE1T/trztRNDQP1l1J9GMSOcY0TvDffmC209wPTmXrIpU9TXD6cUOve
         N9ON2Dt/AZPK2NZuZ5QX2n/CLIbLR4+rDJaSPI7HEGQoFOFkdNoWj1eZsqZThmMO+JNg
         s8uhiinhke4KhHEpp79EL0sXJnoq/HXbhU0ONH0hAK4SmIFedYhO1c8KVJnyNhbHgFfH
         XwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574823; x=1756179623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=up9OuXnclQEyapPLpqQTS4r+NCar6InDzt6ZL5WdOUY=;
        b=vkO0aATlMv3NkIBQyh6EOOAP18G4gkgNUNKfoSPvdYWCORGjuo2slgn/1wEkggqRrT
         ahdVQMQlptrgqA4b/D64eYggLo8UNtXGQ0OpJxG7t+lDAuYqnj3lbSWYOxuYI2kN8t8q
         zP6KogEK/26NJk8qhJx+CGE3QZXLZ7GJlbSjbI0t6hE1Pj+Q2rz6AX0zzitqH+n5oXP7
         Poy2Jb42CnLAw4pByXbinDvQ2rfLQjy2bXj8xEFjZN2E84hYXjtVcysxhAeTCN4Nfiqd
         7xcHalAtHVTZsiYldbwr0dW1maYqbxqKmVkZD50R3eQhEzpZ+wzUzUAPD9Dfgy4BdTZT
         gD/A==
X-Forwarded-Encrypted: i=1; AJvYcCU/fQsv/YYxjdVBHqXUzUlUVLDWsMNzQ0PNiy7Zu6LV9fRYp6IGiK5nwdFn6h8yIGF9zeQ=@vger.kernel.org, AJvYcCU0tRVl9zI53hg79dEw/3IVxmubJ/fyKa/0gRGZ8vxURMRJZgFc4Nhvt/5ceKgB73JIXZxFeCxYR1Sq+wa/@vger.kernel.org, AJvYcCUY+dg+dJCVh2Eg8t2dWNlkYYs7LRe2Ttz2oopm8WTZ46kE6sc7N5BJlyjhxwBAqzzR5eaAqSEl@vger.kernel.org, AJvYcCV6moY+Gn6AXa/NXuA2si8yebVMLEJF01TFxIxVBCZIdZCHZdwABv4aIsPH670fvkLhNHdu23y3wLbEMFa1Iv70@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFt4jVFOKJuzKlai/9XRwO1NyeHTi3qKwo7owmj1HPceDdboR
	hSNME1GbUkikGL7E9pk2NqSJNHX24UumT0oayITC3NtScIzCQwVhgWpV
X-Gm-Gg: ASbGncvRNv6y72PGhUagcQaM0KaxoHQe9xeHFFOkRgsg0nlexqqH86w/LrlVzG710jM
	SyyY8VLtozz1koDpdG+N5B6LswjUkfWiMt36+lEJuVHU6hAd7lzgCh7Ff/hVR7IIKr8R3Qs7aB6
	VCqW0QriPPzqtHzlVqiuQ6q/hNlOh+clMHD1jr1AAeYZOeDVqmkd2j3yAd/g0TjT0RbezvwnBsC
	ZD27csiJSpWWx7O/rL8LHt6n0bOBxQL45dl8T8CMaF82DtfnykGH9qBaLEZb4Aw3mp/acmPtJhV
	28xu5NhhZrmNveoceJRQHytlDhTMnzf/IQzULTnw/4Rmo2Z5DUcArIAziyV8BAkTalIOL9EGTSO
	WkLVCF0yv/vlDXMJc+J0=
X-Google-Smtp-Source: AGHT+IEC3G8q3IJdu+w6frUU7ChD8y/Lec4gtNmIDyApvzgod1kIF0UO4U1ayRLvDnDouBsTCoY4Yw==
X-Received: by 2002:a17:902:e5cb:b0:240:3f43:260 with SMTP id d9443c01a7336-245e09cfaefmr12686785ad.17.1755574823362;
        Mon, 18 Aug 2025 20:40:23 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d22b8sm1109804b3a.4.2025.08.18.20.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 20:40:22 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH bpf-next 3/3] selftests/bpf: add benchmark testing for kprobe-multi-all
Date: Tue, 19 Aug 2025 11:39:56 +0800
Message-ID: <20250819033956.59164-4-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819033956.59164-1-dongml2@chinatelecom.cn>
References: <20250819033956.59164-1-dongml2@chinatelecom.cn>
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
 tools/testing/selftests/bpf/bench.c           |  4 ++
 .../selftests/bpf/benchs/bench_trigger.c      | 54 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  4 +-
 .../selftests/bpf/progs/trigger_bench.c       | 12 +++++
 tools/testing/selftests/bpf/trace_helpers.c   |  3 ++
 5 files changed, 75 insertions(+), 2 deletions(-)

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
index 82327657846e..c6634a64a7c0 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -226,6 +226,58 @@ static void trigger_fentry_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void attach_ksyms_all(struct bpf_program *empty, bool kretprobe)
+{
+	LIBBPF_OPTS(bpf_kprobe_multi_opts, opts);
+	char **syms = NULL;
+	size_t cnt = 0;
+
+	if (bpf_get_ksyms(&syms, &cnt, true)) {
+		printf("failed to get ksyms\n");
+		exit(1);
+	}
+
+	printf("found %zu ksyms\n", cnt);
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.retprobe = kretprobe;
+	/* attach empty to all the kernel functions except bpf_get_numa_node_id. */
+	if (!bpf_program__attach_kprobe_multi_opts(empty, NULL, &opts)) {
+		printf("failed to attach bpf_program__attach_kprobe_multi_opts to all\n");
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
@@ -512,6 +564,8 @@ BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
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
index 9da9da51b132..78cf1aab09d8 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -575,6 +575,9 @@ static bool skip_entry(char *name)
 	if (!strcmp(name, "__rcu_read_unlock"))
 		return true;
 
+	if (!strcmp(name, "bpf_get_numa_node_id"))
+		return true;
+
 	return false;
 }
 
-- 
2.50.1


