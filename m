Return-Path: <linux-kselftest+bounces-15136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B2594E405
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 02:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD921C20AA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Aug 2024 00:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF446B8;
	Mon, 12 Aug 2024 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geCOkfC7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A3847A;
	Mon, 12 Aug 2024 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723423521; cv=none; b=rodNJMXcIHfTZidiTCnBxnWa4P6Fn1X1+ooiElmD2acBsaoS92wYSFt7cBqIZ3O9naixUZUgCCIQppqyVPmcqBDIhn+fvhuPsFRiQDzsFkiBYUjSdWBgCSLYKyyxHXC6tbfkNUCk6uVjXu5U90J+iEoUdb021mUClnTFUwnmPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723423521; c=relaxed/simple;
	bh=V7jX/1i9OHxj8xQD2qtHGYnTC6/VAgxs06wKQDBW9SI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7EVa3EUljH4pUlB5GcJKmzLDMgX/u16Urx3siLgcIjJofYElqxA+u2i3EMYLA29e0FCrYf2T13/xitnhz2p6yjyMmiUB2KvT/jqQH3fDoZJyo/TyizVQQwTGbilP+C+p1ta8ck/LTWkhKdGhEzWdJQ1j4bAi1StgyXR0/LxcFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geCOkfC7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710dc3015bfso1432751b3a.0;
        Sun, 11 Aug 2024 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723423519; x=1724028319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex3NXVlQdvYn2/E6Cqcjr0USpx9g8G9ALFgNX3EqEWQ=;
        b=geCOkfC7OySl2rsP5HucciVh3yzavUwHbVs5rRa/pV18t6XvFshE6Dc7+6YoPc9+oy
         53i5UMeM4eCGdqpI7l48bT0A1A0xlj7oSPOsENcGApRJ56AIY3VC3foQbhK0Oh+zjiM2
         5mWOnOK/XJi4g2trsNhW/p3awb88CCK1JUxUpEGGtPca3AjTbNTNzE7cNXURS4Kc+yfn
         BXRu6ywKtTn0C/NrC8AajYYaUoiPhk6XINyPBR2db3MIjeAQg3U0Nfno+m+q/HoIF0HM
         WWBPrtfNpbYcCfvRw864sFDxLFLmKuzsazrZiyNggYjPWqmE6tcLOxhXWfNSlWZPPZRM
         nG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723423519; x=1724028319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ex3NXVlQdvYn2/E6Cqcjr0USpx9g8G9ALFgNX3EqEWQ=;
        b=ch65vvOHd4p1WBWCdIkNpt1vxpFFhGD7A/wYsIcNn7eCavMSPHH5djwCPubKFL6WJo
         +iV4b2IeyRtSMPcw0MIKVZSMAGPkarjSczcbCQwLTsmMSgfk/QLWkqrFlqMFctj81o8N
         anKO+1StTpdns9v/LrJy/ChxMSCHxxYnFP5lexoeAIsbz2rhFT/RjTuUr3X5aiyEz3gB
         uJnAC2Co+CXfvDRPG78NeCOf+Ee2QQUNoxa8aUaWwgV4NJU9JPOcFgw/NXgkEFPTAp1G
         4hzisKU+pFv9QfvZuSq67ed2vHJdim0zGvvJmRCwxrAkK82zm86Xv3RTcK7EunecbZC2
         dYTg==
X-Forwarded-Encrypted: i=1; AJvYcCUw2WNMz9R1UVS/Uo2P4M/sZmbjuXPxkb7KNCu37rKrvfsOg8PfVFjx8NgVIGGwsYwek2GdWdNlYtdd8KRe9x/jWwVbEO9OAYsvZuTbNtteT6vn/Q7z1vgJ7H4L6y2EsvWiXWzfY4QEwp56bxXo3aDjtLhjPslHlNLXGwy+
X-Gm-Message-State: AOJu0YxtK7Q659OxAmnn4NTcDMOP57v2jgqDTKnxTLK41CjC03ZPwjDf
	gEKblY0PcWeH1d2UsZZQtBltKezDzIGOLdtFcjD4wRnZGLvIXLg=
X-Google-Smtp-Source: AGHT+IEgbAfUy0VQGei2/DRoJwWPNuULj0hM54lzoGNFRQ1Vl6hIFTtEbbWTJvW4xfCHCS1rYxngbQ==
X-Received: by 2002:a05:6a00:91d9:b0:70e:cf2a:4503 with SMTP id d2e1a72fcca58-710cc90d97bmr20016948b3a.11.1723423519426;
        Sun, 11 Aug 2024 17:45:19 -0700 (PDT)
Received: from vagrant.. ([114.71.48.94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58ade4fsm2891966b3a.51.2024.08.11.17.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:45:18 -0700 (PDT)
From: "Daniel T. Lee" <danieltimlee@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Shuah Khan <shuah@kernel.org>,
	Yipeng Zou <zouyipeng@huawei.com>,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [bpf-next 2/3] selftests/bpf: add rename tracepoint bench test
Date: Mon, 12 Aug 2024 00:45:02 +0000
Message-ID: <20240812004503.43206-3-danieltimlee@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812004503.43206-1-danieltimlee@gmail.com>
References: <20240812004503.43206-1-danieltimlee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In addition to migrating the tracepoint overhead test from sample/bpf
to selftest/bpf, this commit extends benchmarking test with rename
task.

Since previous commit migrated tracepoint based on rename task, this
commit updates the benchmarking program to utilize the newly added
'rename-tp'.

Signed-off-by: Daniel T. Lee <danieltimlee@gmail.com>
---
 tools/testing/selftests/bpf/bench.c              |  2 ++
 .../testing/selftests/bpf/benchs/bench_rename.c  | 16 ++++++++++++++++
 .../selftests/bpf/benchs/run_bench_rename.sh     |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 627b74ae041b..e3d17b9b78cc 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -495,6 +495,7 @@ extern const struct bench bench_rename_kretprobe;
 extern const struct bench bench_rename_rawtp;
 extern const struct bench bench_rename_fentry;
 extern const struct bench bench_rename_fexit;
+extern const struct bench bench_rename_tp;
 
 /* pure counting benchmarks to establish theoretical lmits */
 extern const struct bench bench_trig_usermode_count;
@@ -552,6 +553,7 @@ static const struct bench *benchs[] = {
 	&bench_rename_rawtp,
 	&bench_rename_fentry,
 	&bench_rename_fexit,
+	&bench_rename_tp,
 	/* pure counting benchmarks for establishing theoretical limits */
 	&bench_trig_usermode_count,
 	&bench_trig_kernel_count,
diff --git a/tools/testing/selftests/bpf/benchs/bench_rename.c b/tools/testing/selftests/bpf/benchs/bench_rename.c
index bf66893c7a33..48cd9556ddf8 100644
--- a/tools/testing/selftests/bpf/benchs/bench_rename.c
+++ b/tools/testing/selftests/bpf/benchs/bench_rename.c
@@ -106,6 +106,12 @@ static void setup_fexit(void)
 	attach_bpf(ctx.skel->progs.prog5);
 }
 
+static void setup_tp(void)
+{
+	setup_ctx();
+	attach_bpf(ctx.skel->progs.prog6);
+}
+
 const struct bench bench_rename_base = {
 	.name = "rename-base",
 	.validate = validate,
@@ -136,6 +142,16 @@ const struct bench bench_rename_kretprobe = {
 	.report_final = hits_drops_report_final,
 };
 
+const struct bench bench_rename_tp = {
+	.name = "rename-tp",
+	.validate = validate,
+	.setup = setup_tp,
+	.producer_thread = producer,
+	.measure = measure,
+	.report_progress = hits_drops_report_progress,
+	.report_final = hits_drops_report_final,
+};
+
 const struct bench bench_rename_rawtp = {
 	.name = "rename-rawtp",
 	.validate = validate,
diff --git a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
index 7b281dbe4165..131e5e6ea8ec 100755
--- a/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
+++ b/tools/testing/selftests/bpf/benchs/run_bench_rename.sh
@@ -2,7 +2,7 @@
 
 set -eufo pipefail
 
-for i in base kprobe kretprobe rawtp fentry fexit
+for i in base kprobe kretprobe rawtp fentry fexit tp
 do
 	summary=$(sudo ./bench -w2 -d5 -a rename-$i | tail -n1 | cut -d'(' -f1 | cut -d' ' -f3-)
 	printf "%-10s: %s\n" $i "$summary"
-- 
2.43.0


