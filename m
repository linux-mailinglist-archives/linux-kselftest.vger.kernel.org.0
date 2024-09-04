Return-Path: <linux-kselftest+bounces-17201-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9DC96CD9A
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 06:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABAF1F27228
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 04:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723F014E2E6;
	Thu,  5 Sep 2024 04:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YRJ7zJbr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309F114D2B3;
	Thu,  5 Sep 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509459; cv=none; b=axbCwiNStifE/jq/Rwh1wEdK3E4BODPPE4y6A3xI2fZnI1DAnMocbUCksHhIzxMZk6+6Z2dkzOJO7eqcxJTJ0PC2X1doZG41GYf1P1v731JjXUudsYLr4m1y3QFWOc7l4vMRleuUIHwbHXllc4SanalbXdR7Y4rjpZOd0ycLWtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509459; c=relaxed/simple;
	bh=u2Ch/o77PjLYGsReQcy05n4gCCnOgS0nHgy/Suw9PLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TIQj6f82HVBaXL/+FPO2d74lSCfk1ATuV+454bixcN3U4Xn3Qd6om9EaF0pLY1pjBHBN1Li1H4k+dDeMiNU47zl31DFjs1qCLPMu5+BiaW/sx3FF1liTaPHJ979jO7jE20zElaVGzIYRI55sHAk9ZNGduKX7gZHYOZrFpF+NjZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YRJ7zJbr; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=OtwjK
	TXld+LD+C/gFLMawKusKdxWF5oA5AVNnQP/lMo=; b=YRJ7zJbrOOE4aETAAnDUe
	FFOwZr0jXMknJ0I/5eY07zf//uwICXm+4i7Mzu6itHVyDLmwEh0O4PWZd6JyaCs3
	yI3CJogpvjo5F7JmyA6E+5gHLKYfzmJLSFuikd1QciVIsn6iCx4mvaEWOT/IenSI
	qDDPGfyKpaT0DP/7hXaXbo=
Received: from localhost.localdomain (unknown [120.227.22.125])
	by gzga-smtp-mta-g2-5 (Coremail) with SMTP id _____wBXnqEsL9lm2Ud+Fg--.54591S2;
	Thu, 05 Sep 2024 12:10:21 +0800 (CST)
From: Yuan Chen <chenyuan_fl@163.com>
To: andrii@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/bpf: Add valid flag to bpf_cookie selftest's res
Date: Wed,  4 Sep 2024 19:55:10 +0800
Message-ID: <20240904115510.67480-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXnqEsL9lm2Ud+Fg--.54591S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF13Gr4kKF1ktry8trW8Zwb_yoW5Cr47p3
	y8X34ayFZ3JF17XF4xGr4UWF4FvF40vFW3ZF4rt3yrZrn7Xr92qr1xKF42qF9xWrWFvw1f
	Zw4DKFZ8Cw1xZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jq1v3UUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiNxJRvWXAnFjYFAAAsk

From: Yuan Chen <chenyuan@kylinos.cn>

This patch identifies whether a test item is valid by adding a valid flag to res.

When we test the bpf_cookies/perf_event sub-test item of test_progs, there is a
probability failure of the test item. In fact, this is not a problem, because
the corresponding perf event is not collected. This should not output the test
failure, and it is more reasonable to output SKIP. Therefore, add a valid
identifier to res to distinguish whether the test item is valid, and skip the
test item if it is invalid.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../testing/selftests/bpf/prog_tests/bpf_cookie.c | 15 +++++++++++++++
 .../testing/selftests/bpf/progs/test_bpf_cookie.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
index 070c52c312e5..e5bf4b385501 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
@@ -456,6 +456,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	if (!ASSERT_GE(pfd, 0, "perf_fd"))
 		goto cleanup;
 
+	skel->bss->res_valid = false;
 	opts.bpf_cookie = 0x100000;
 	link = bpf_program__attach_perf_event_opts(skel->progs.handle_pe, pfd, &opts);
 	if (!ASSERT_OK_PTR(link, "link1"))
@@ -463,6 +464,12 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 
 	burn_cpu(); /* trigger BPF prog */
 
+	if (!skel->bss->res_valid) {
+		printf("%s:SKIP:the corresponding perf event was not sampled.\n",
+		        __func__);
+		test__skip();
+		goto cleanup;
+	}
 	ASSERT_EQ(skel->bss->pe_res, 0x100000, "pe_res1");
 
 	/* prevent bpf_link__destroy() closing pfd itself */
@@ -474,6 +481,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 	link = NULL;
 	kern_sync_rcu();
 	skel->bss->pe_res = 0;
+	skel->bss->res_valid = false;
 
 	opts.bpf_cookie = 0x200000;
 	link = bpf_program__attach_perf_event_opts(skel->progs.handle_pe, pfd, &opts);
@@ -482,6 +490,13 @@ static void pe_subtest(struct test_bpf_cookie *skel)
 
 	burn_cpu(); /* trigger BPF prog */
 
+	if (!skel->bss->res_valid) {
+		printf("%s:SKIP:the corresponding perf event was not sampled.\n",
+		        __func__);
+		test__skip();
+		goto cleanup;
+	}
+
 	ASSERT_EQ(skel->bss->pe_res, 0x200000, "pe_res2");
 
 cleanup:
diff --git a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
index c83142b55f47..28d0ae6810d9 100644
--- a/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
+++ b/tools/testing/selftests/bpf/progs/test_bpf_cookie.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 
 int my_tid;
+bool res_valid;
 
 __u64 kprobe_res;
 __u64 kprobe_multi_res;
@@ -27,6 +28,7 @@ static void update(void *ctx, __u64 *res)
 	if (my_tid != (u32)bpf_get_current_pid_tgid())
 		return;
 
+	res_valid = true;
 	*res |= bpf_get_attach_cookie(ctx);
 }
 
-- 
2.46.0


