Return-Path: <linux-kselftest+bounces-36424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E24AF73CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 14:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7DB48452C
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 12:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186832EE984;
	Thu,  3 Jul 2025 12:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmturfIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0FD2EE97A;
	Thu,  3 Jul 2025 12:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545099; cv=none; b=p7qY90zYH7bF/2QS1Kd0n9iys5nsJHcRdh0HzLZYluly64+r6f4XHjWdwngQsamRTVku3R6N5K2KXVLQYGo7Rcg1crc9gNK88sOU9zfXxwUCRehqLBjo7xKDAAc0gitEFeV8V69+tAlwsUMfBM6ejVvi/l0BLhGH2gZyuZ7j+7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545099; c=relaxed/simple;
	bh=A4maR+ym1UWBIiGpvABPayxYHENx7ob0ofT6FQcgEQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ruQXeNWCEFRu+Xie4/3aWjbG6nWjemCadaG1LJt3S1n6fbfvoeuOMisR0epDUoWwTHAoYyj7C2FumzxlSTTDa7Mp5euS13Jo4Y62Hb9Y8lkYw5LyErQ822r7EscnTvn1LP34iy8DvzM4ux2qWO7KEHi9BnQofeThjSwl50t9jmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LmturfIB; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-748fe69a7baso7422517b3a.3;
        Thu, 03 Jul 2025 05:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751545097; x=1752149897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2Y/tNEM0ulgYJ7h98kqdHkd9WCaMgRog3nRAxQgWOI=;
        b=LmturfIBIldPjnr17qN2KJlib+XYI6iFy0kAvOZWp6ItNbPatFm1+1UZ2G7AAkhQuW
         DlCnS/cIT2K/6rMTWOgoyjLCTyxDDWon43O3iTElYgZmb7HhUE18kl96E1jNJnZliJzh
         vaCP3Z79fRMJbj0lukfodPtSk+GSPimZqSyplZJohaQM8eFFhGFxEKB9O0Ao5gyYNnSw
         QA69nrP7vAgYk1BJsBc/wWOFsXSxW0VdTc9WsHMfA754c99/jToi//MWbFUy/nLzeIhe
         ZsnYcLnVpLd2jQniDVnPceoleSLlRIuCDXhOqIYw78urglBveJEaBBQ8KJJM7ZtTvJcY
         gqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545097; x=1752149897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B2Y/tNEM0ulgYJ7h98kqdHkd9WCaMgRog3nRAxQgWOI=;
        b=pnJ1CyjEu6Cc1feKq2t9aaXE3K6N4RuvOv83CUCzBl1RHX2un+5U6CHbdQm09kLozl
         /Dc1TdTNQRZ/cVgHDixnxVYRjpN7IDIneK+wM/zqxIrJCe6fD0Js3Kb4ExP1CTZ9Bol5
         V5XQPkhYm639wgM7qSoDOEG0EVHwvrs1iVgHJz4RuGeZzmnuiHZwKChqizAh/DPang9j
         4vIWQdfTd1PF092B1Arn4LTlbdFa/vVReP8hOGEAmEMrSOtXP2ultV3QutSj79sFmGqY
         1XVyS718Wl+Yz/ZryNCoirZRGyOYwGXzUyCu/nw4CN/p8NTTVRy7zkAHiMay/R/DIVSc
         5wIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV/PeqddflT0+9NezB0mxWu4IpQ9kB0YIWvoypvMxn6luK5gW+ueJw0ENLnTlwaMXHwLvW/ur4S/S8LZs8Bqcn@vger.kernel.org, AJvYcCWMk7szsqD3/e1PVWoRuFkaTZ4DvU9oCelkX8M48RUH0PCN69WGSgkEjhVyD/033OzwIbEjh2vRXGOgaF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDCROl2/WBXGOgpJ6QCsW8l+V6UO8052AwTJwo+7ewr2WfjR+5
	mwr7r3nEYnPH4WKUTd2tVkUZ8Ji1kylHTLKv3DbeRfhvtzk6ocytTZDEgV2aXQXEMZPMNg==
X-Gm-Gg: ASbGnctEe3I6+t+6QbO5/TO0TnJop5ltNBRiPurBY76wpiD83nhSGrj/QEPt+W8bSF7
	MuEyh193FwUvKE9JDWqtBAC9SYSwyqSdUQMpgwQF4MQEhmsledrvU6mxUv+EjNpxHqoRKlXxenI
	CLT5jrdsm4B/3dr4I2L+1ZkIbcCEM7B5cSkVzQlyvM4oMEWTFG2Yso/q9cDe9N1pRDlHRCtpsxV
	E7eAANVlg2wYdR5o3fGK4llLHWgemkiZpXQDru5IE2fC+QzbjwQVjqqyedukh86PVsCo7Gx6pJh
	Kad8FSV+M6/HE4zNxocytQGQnLw9/ZjnDkBoTC/ChXtft/kL0NjlBM7O8T4XGeDxrV0nwd4QVqG
	Z1T0=
X-Google-Smtp-Source: AGHT+IEJ/xANJXHVQ1ORXK8DAYjINsVZ3TBgS7WVSrfSzxWAZNAP+BDf5vO1EFMY3uxQr2+HmULR0A==
X-Received: by 2002:a05:6a00:92a9:b0:748:f406:b09 with SMTP id d2e1a72fcca58-74b512c1b0amr8849811b3a.23.1751545096776;
        Thu, 03 Jul 2025 05:18:16 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5575895sm18591081b3a.94.2025.07.03.05.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 05:18:16 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	Mykola Lysenko <mykolal@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 18/18] selftests/bpf: add bench tests for tracing_multi
Date: Thu,  3 Jul 2025 20:15:21 +0800
Message-Id: <20250703121521.1874196-19-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bench testcase for fentry_multi, fexit_multi and fmodret_multi in
bench_trigger.c.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use the existing bpf bench framework instead of introducing new one
---
 tools/testing/selftests/bpf/bench.c           |  8 +++
 .../selftests/bpf/benchs/bench_trigger.c      | 72 +++++++++++++++++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |  1 +
 .../selftests/bpf/progs/trigger_bench.c       | 22 ++++++
 4 files changed, 103 insertions(+)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index ddd73d06a1eb..32f1e2e936c0 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -510,8 +510,12 @@ extern const struct bench bench_trig_kretprobe;
 extern const struct bench bench_trig_kprobe_multi;
 extern const struct bench bench_trig_kretprobe_multi;
 extern const struct bench bench_trig_fentry;
+extern const struct bench bench_trig_fentry_multi;
+extern const struct bench bench_trig_fentry_multi_all;
 extern const struct bench bench_trig_fexit;
+extern const struct bench bench_trig_fexit_multi;
 extern const struct bench bench_trig_fmodret;
+extern const struct bench bench_trig_fmodret_multi;
 extern const struct bench bench_trig_tp;
 extern const struct bench bench_trig_rawtp;
 
@@ -578,8 +582,12 @@ static const struct bench *benchs[] = {
 	&bench_trig_kprobe_multi,
 	&bench_trig_kretprobe_multi,
 	&bench_trig_fentry,
+	&bench_trig_fentry_multi,
+	&bench_trig_fentry_multi_all,
 	&bench_trig_fexit,
+	&bench_trig_fexit_multi,
 	&bench_trig_fmodret,
+	&bench_trig_fmodret_multi,
 	&bench_trig_tp,
 	&bench_trig_rawtp,
 	/* uprobes */
diff --git a/tools/testing/selftests/bpf/benchs/bench_trigger.c b/tools/testing/selftests/bpf/benchs/bench_trigger.c
index 82327657846e..a1844ee358f1 100644
--- a/tools/testing/selftests/bpf/benchs/bench_trigger.c
+++ b/tools/testing/selftests/bpf/benchs/bench_trigger.c
@@ -226,6 +226,54 @@ static void trigger_fentry_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fentry);
 }
 
+static void trigger_fentry_multi_setup(void)
+{
+	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_fentry_multi, true);
+	load_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fentry_multi);
+}
+
+static void trigger_fentry_multi_all_setup(void)
+{
+	LIBBPF_OPTS(bpf_trace_multi_opts, opts);
+	struct bpf_program *prog;
+	struct bpf_link *link;
+	char **syms = NULL;
+	size_t cnt = 0;
+	int i;
+
+	setup_ctx();
+	prog = ctx.skel->progs.bench_trigger_fentry_multi;
+	bpf_program__set_autoload(prog, true);
+	load_ctx();
+
+	if (bpf_get_ksyms(&syms, &cnt, true)) {
+		printf("failed to get ksyms\n");
+		exit(1);
+	}
+
+	for (i = 0; i < cnt; i++) {
+		if (strcmp(syms[i], "bpf_get_numa_node_id") == 0)
+			break;
+	}
+	if (i == cnt) {
+		printf("bpf_get_numa_node_id not found in ksyms\n");
+		exit(1);
+	}
+
+	printf("found %zu ksyms\n", cnt);
+	opts.syms = (const char **) syms;
+	opts.cnt = cnt;
+	opts.skip_invalid = true;
+	link = bpf_program__attach_trace_multi_opts(prog, &opts);
+	if (!link) {
+		printf("failed to attach bench_trigger_fentry_multi to all\n");
+		exit(1);
+	}
+	ctx.skel->links.bench_trigger_fentry_multi = link;
+}
+
 static void trigger_fexit_setup(void)
 {
 	setup_ctx();
@@ -234,6 +282,14 @@ static void trigger_fexit_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fexit);
 }
 
+static void trigger_fexit_multi_setup(void)
+{
+	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_fexit_multi, true);
+	load_ctx();
+	attach_bpf(ctx.skel->progs.bench_trigger_fexit_multi);
+}
+
 static void trigger_fmodret_setup(void)
 {
 	setup_ctx();
@@ -246,6 +302,18 @@ static void trigger_fmodret_setup(void)
 	attach_bpf(ctx.skel->progs.bench_trigger_fmodret);
 }
 
+static void trigger_fmodret_multi_setup(void)
+{
+	setup_ctx();
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver, false);
+	bpf_program__set_autoload(ctx.skel->progs.trigger_driver_kfunc, true);
+	bpf_program__set_autoload(ctx.skel->progs.bench_trigger_fmodret_multi, true);
+	load_ctx();
+	/* override driver program */
+	ctx.driver_prog_fd = bpf_program__fd(ctx.skel->progs.trigger_driver_kfunc);
+	attach_bpf(ctx.skel->progs.bench_trigger_fmodret_multi);
+}
+
 static void trigger_tp_setup(void)
 {
 	setup_ctx();
@@ -512,8 +580,12 @@ BENCH_TRIG_KERNEL(kretprobe, "kretprobe");
 BENCH_TRIG_KERNEL(kprobe_multi, "kprobe-multi");
 BENCH_TRIG_KERNEL(kretprobe_multi, "kretprobe-multi");
 BENCH_TRIG_KERNEL(fentry, "fentry");
+BENCH_TRIG_KERNEL(fentry_multi, "fentry-multi");
+BENCH_TRIG_KERNEL(fentry_multi_all, "fentry-multi-all");
 BENCH_TRIG_KERNEL(fexit, "fexit");
+BENCH_TRIG_KERNEL(fexit_multi, "fexit-multi");
 BENCH_TRIG_KERNEL(fmodret, "fmodret");
+BENCH_TRIG_KERNEL(fmodret_multi, "fmodret-multi");
 BENCH_TRIG_KERNEL(tp, "tp");
 BENCH_TRIG_KERNEL(rawtp, "rawtp");
 
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
index a690f5a68b6b..48a7f809d053 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
@@ -5,6 +5,7 @@ set -eufo pipefail
 def_tests=( \
 	usermode-count kernel-count syscall-count \
 	fentry fexit fmodret \
+	fentry-multi fentry-multi-all fexit-multi fmodret-multi \
 	rawtp tp \
 	kprobe kprobe-multi \
 	kretprobe kretprobe-multi \
diff --git a/tools/testing/selftests/bpf/progs/trigger_bench.c b/tools/testing/selftests/bpf/progs/trigger_bench.c
index 044a6d78923e..2ff1a7568080 100644
--- a/tools/testing/selftests/bpf/progs/trigger_bench.c
+++ b/tools/testing/selftests/bpf/progs/trigger_bench.c
@@ -111,6 +111,13 @@ int bench_trigger_fentry(void *ctx)
 	return 0;
 }
 
+SEC("?fentry.multi/bpf_get_numa_node_id")
+int bench_trigger_fentry_multi(void *ctx)
+{
+	inc_counter();
+	return 0;
+}
+
 SEC("?fexit/bpf_get_numa_node_id")
 int bench_trigger_fexit(void *ctx)
 {
@@ -118,6 +125,14 @@ int bench_trigger_fexit(void *ctx)
 	return 0;
 }
 
+SEC("?fexit.multi/bpf_get_numa_node_id")
+int bench_trigger_fexit_multi(void *ctx)
+{
+	inc_counter();
+
+	return 0;
+}
+
 SEC("?fmod_ret/bpf_modify_return_test_tp")
 int bench_trigger_fmodret(void *ctx)
 {
@@ -125,6 +140,13 @@ int bench_trigger_fmodret(void *ctx)
 	return -22;
 }
 
+SEC("?fmod_ret.multi/bpf_modify_return_test_tp")
+int bench_trigger_fmodret_multi(void *ctx)
+{
+	inc_counter();
+	return -22;
+}
+
 SEC("?tp/bpf_test_run/bpf_trigger_tp")
 int bench_trigger_tp(void *ctx)
 {
-- 
2.39.5


