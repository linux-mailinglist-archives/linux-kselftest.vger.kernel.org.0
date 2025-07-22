Return-Path: <linux-kselftest+bounces-37847-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D099BB0E0A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 17:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86F3E1C821DE
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF20279354;
	Tue, 22 Jul 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lGlIGhXR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709B327932D
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Jul 2025 15:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198555; cv=none; b=eOxarUDGf4P6UPktfbJ6FXfJyIsS8k8tVD/NsKEPP6MDw0vRqbXOVaxob7QRrM50OUJtLcF/P0BGOLNB8BGQ3Nvu6cY1S9VKOPBUf11KvgaKU8C7zs65V9ltqBG7H/6YOf7/TtSeyKd3T8pO4ujYecRQRfzpO4pAua568Rl5j7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198555; c=relaxed/simple;
	bh=mCBqL8xjfR57vJvMp9lpkKBV0ktGg7kwsgafi+ri44o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0pvj4WFGvUVgZxR8qEfNTTITWELgcC4twQJZlLhuTn77owCQ6KoV2jdgpeKTD7AO/ROG9ULzM3UOYKdZ9HRc3pO57kfPgEOLt2JvpN3GlcX3hfmk6Edr5M54gO1tmahMa9sU8Dodc8H/UaHzb33vun8xQGoXu1zUydR6Hp+e0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lGlIGhXR; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753198551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I8bpiq7NXE+7ykTDyyrt/AdiHWnh4KywpW8frQH5Gv0=;
	b=lGlIGhXRq+W2dOq48FTPdLjh7u8bFYIMW5z/rMgW8PB8mmSZYuhxxvNoeWO0ROAQKid6RK
	xh8i/G/nOGGsAND9EzuZvUdA4tQ2hKsevfV6yVJGIAZQ9okZelPSTm7rwAi3k7NBW4HFEG
	sPWAnF2X8IDk0m3pOdU0xbMthCttqbQ=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	kafai.wan@linux.dev,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon.hwang@linux.dev
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Migrate fexit_noreturns case into tracing_failure test suite
Date: Tue, 22 Jul 2025 23:34:34 +0800
Message-ID: <20250722153434.20571-5-kafai.wan@linux.dev>
In-Reply-To: <20250722153434.20571-1-kafai.wan@linux.dev>
References: <20250722153434.20571-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Delete fexit_noreturns.c files and migrate the cases into
tracing_failure.c files.

The result:

 $ tools/testing/selftests/bpf/test_progs -t tracing_failure/fexit_noreturns
 #467/4   tracing_failure/fexit_noreturns:OK
 #467     tracing_failure:OK
 Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
 .../bpf/prog_tests/fexit_noreturns.c          |  9 ----
 .../bpf/prog_tests/tracing_failure.c          | 47 +++++++++++++------
 .../selftests/bpf/progs/fexit_noreturns.c     | 15 ------
 .../selftests/bpf/progs/tracing_failure.c     |  6 +++
 4 files changed, 39 insertions(+), 38 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 delete mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
deleted file mode 100644
index 568d3aa48a78..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <test_progs.h>
-#include "fexit_noreturns.skel.h"
-
-void test_fexit_noreturns(void)
-{
-	RUN_TESTS(fexit_noreturns);
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 140fb0d175cf..01c1997b705f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -28,37 +28,54 @@ static void test_bpf_spin_lock(bool is_spin_lock)
 	tracing_failure__destroy(skel);
 }
 
-static void test_tracing_deny(void)
+static void test_tracing_fail_prog(const char *prog_name, const char *exp_msg)
 {
 	struct tracing_failure *skel;
+	struct bpf_program *prog;
 	char log_buf[256];
-	int btf_id, err;
-
-	/* migrate_disable depends on CONFIG_SMP */
-	btf_id = libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY);
-	if (btf_id <= 0) {
-		test__skip();
-		return;
-	}
+	int err;
 
 	skel = tracing_failure__open();
 	if (!ASSERT_OK_PTR(skel, "tracing_failure__open"))
 		return;
 
-	bpf_program__set_autoload(skel->progs.tracing_deny, true);
-	bpf_program__set_log_buf(skel->progs.tracing_deny, log_buf, sizeof(log_buf));
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto out;
+
+	bpf_program__set_autoload(prog, true);
+	bpf_program__set_log_buf(prog, log_buf, sizeof(log_buf));
 
 	err = tracing_failure__load(skel);
 	if (!ASSERT_ERR(err, "tracing_failure__load"))
 		goto out;
 
-	ASSERT_HAS_SUBSTR(log_buf,
-			  "Attaching tracing programs to function 'migrate_disable' is rejected.",
-			  "log_buf");
+	ASSERT_HAS_SUBSTR(log_buf, exp_msg, "log_buf");
 out:
 	tracing_failure__destroy(skel);
 }
 
+static void test_tracing_deny(void)
+{
+	int btf_id;
+
+	/* migrate_disable depends on CONFIG_SMP */
+	btf_id = libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTRY);
+	if (btf_id <= 0) {
+		test__skip();
+		return;
+	}
+
+	test_tracing_fail_prog("tracing_deny",
+			       "Attaching tracing programs to function 'migrate_disable' is rejected.");
+}
+
+static void test_fexit_noreturns(void)
+{
+	test_tracing_fail_prog("fexit_noreturns",
+			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+}
+
 void test_tracing_failure(void)
 {
 	if (test__start_subtest("bpf_spin_lock"))
@@ -67,4 +84,6 @@ void test_tracing_failure(void)
 		test_bpf_spin_lock(false);
 	if (test__start_subtest("tracing_deny"))
 		test_tracing_deny();
+	if (test__start_subtest("fexit_noreturns"))
+		test_fexit_noreturns();
 }
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
deleted file mode 100644
index b1c33d958ae2..000000000000
--- a/tools/testing/selftests/bpf/progs/fexit_noreturns.c
+++ /dev/null
@@ -1,15 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_tracing.h>
-#include "bpf_misc.h"
-
-char _license[] SEC("license") = "GPL";
-
-SEC("fexit/do_exit")
-__failure __msg("Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.")
-int BPF_PROG(noreturns)
-{
-	return 0;
-}
diff --git a/tools/testing/selftests/bpf/progs/tracing_failure.c b/tools/testing/selftests/bpf/progs/tracing_failure.c
index dfa152e8194e..70a123e8fe9c 100644
--- a/tools/testing/selftests/bpf/progs/tracing_failure.c
+++ b/tools/testing/selftests/bpf/progs/tracing_failure.c
@@ -24,3 +24,9 @@ int BPF_PROG(tracing_deny)
 {
 	return 0;
 }
+
+SEC("?fexit/do_exit")
+int BPF_PROG(fexit_noreturns)
+{
+	return 0;
+}
-- 
2.43.0


