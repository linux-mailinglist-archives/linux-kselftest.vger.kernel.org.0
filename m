Return-Path: <linux-kselftest+bounces-5064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5685C4A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCD4E1C21264
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E535214D440;
	Tue, 20 Feb 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F43OqDMN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98CC14D435;
	Tue, 20 Feb 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456969; cv=none; b=ivhyFpuw5Ykbu27TH3skF2hZJOesyjE73YtZR/lya6adFqsAf7oOSxCSFvhjpNO/QVnjg/itDz+1ZWV/Jz6CpLfMVeljvp2TaxcbfaN6tyYJnAm69CgtCkWAB5cEIGkhPB7PNAdtFSVDRmNxxu3ozaMTYPN3Syr1kclFuJPq+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456969; c=relaxed/simple;
	bh=yQO677NdufTEtYEpl+ewTAnUbcerKSpLBt1eERj1/SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+zMWLokMk713Or0j2H63sIgQqU76yRbLaOPtTL5xuxSKSRWJKtQW3++qxGhd3EXEuxsfqxPxIufjbA5N4tSxvp1ktPsllKolkoD0e0YE9kdYNpUDyau1BT7awlb5KyFwTHotNMxVOVwE4Fro4R62KAGtkR7r8w2sh02cO6+VUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F43OqDMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41B2C43399;
	Tue, 20 Feb 2024 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456969;
	bh=yQO677NdufTEtYEpl+ewTAnUbcerKSpLBt1eERj1/SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F43OqDMNXUy78B8/sXZBH+lBUw2CKY4zXUZL3Mvu1zbeFsYzB8jU84XpxKdKThfJI
	 gAni/U3xQPSMXVXbBvXeYwcus4/eDsW8BDRMZvUPUTZV7DH+T/VsYhpy4opEMh0N/P
	 l9LLdV1DS+BBEfYGu77fM7OKpCPy02jut2qLV3fbNcb2mkvzLyELcBF2SAtQGRFG65
	 kOou316kcnD06WlQs3wcH450VTkIfK+wqD9vYNWnK3Cc9aAAwzW8UApjH2DHL3E4jF
	 QGPKU9RdKVdr8QFuZLG3oc27sGOSPOD5qgzLiKYcsRJ+XPswKkCb2nMZ4iPu3dN8An
	 2P/ylWITiYEOw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 05/11] selftests: kselftest_harness: use exit code to store skip
Date: Tue, 20 Feb 2024 11:22:29 -0800
Message-ID: <20240220192235.2953484-6-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We always use skip in combination with exit_code being 0
(KSFT_PASS). This are basic KSFT / KTAP semantics.
Store the right KSFT_* code in exit_code directly.

This makes it easier to support tests reporting other
extended KSFT_* codes like XFAIL / XPASS.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 20 +++++---------------
 tools/testing/selftests/landlock/common.h   |  5 +----
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index bbb339642a72..42ec3ca29c4b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -136,8 +136,7 @@
 		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->exit_code = KSFT_PASS; \
-	_metadata->skip = 1; \
+	_metadata->exit_code = KSFT_SKIP; \
 	_metadata->trigger = 0; \
 	statement; \
 } while (0)
@@ -389,7 +388,7 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-			if (!__test_passed(_metadata) || _metadata->skip) \
+			if (_metadata->exit_code) \
 				return; \
 			_metadata->setup_completed = true; \
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
@@ -834,7 +833,6 @@ struct __test_metadata {
 	struct __fixture_metadata *fixture;
 	int termsig;
 	int exit_code;
-	int skip;	/* did SKIP get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
 	bool timed_out;	/* did this test timeout instead of exiting? */
@@ -945,9 +943,7 @@ void __wait_for_test(struct __test_metadata *t)
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == KSFT_SKIP) {
-			/* SKIP */
-			t->exit_code = KSFT_PASS;
-			t->skip = 1;
+			t->exit_code = WEXITSTATUS(status);
 		} else if (t->termsig != -1) {
 			t->exit_code = KSFT_FAIL;
 			fprintf(TH_LOG_STREAM,
@@ -1120,7 +1116,6 @@ void __run_test(struct __fixture_metadata *f,
 
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
-	t->skip = 0;
 	t->trigger = 0;
 	t->no_print = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
@@ -1142,19 +1137,14 @@ void __run_test(struct __fixture_metadata *f,
 	} else if (t->pid == 0) {
 		setpgrp();
 		t->fn(t, variant);
-		if (t->skip)
-			_exit(KSFT_SKIP);
-		if (__test_passed(t))
-			_exit(KSFT_PASS);
-		/* Something else happened. */
-		_exit(KSFT_FAIL);
+		_exit(t->exit_code);
 	} else {
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s\n",
 		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
-	if (t->skip)
+	if (t->exit_code == KSFT_SKIP)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
 					t->results->reason : "unknown");
 	else
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index 89f8183bd8f5..56c5b5c5676a 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -57,11 +57,8 @@
 		} \
 		switch (WEXITSTATUS(status)) { \
 		case KSFT_PASS: \
-			_metadata->exit_code = KSFT_PASS; \
-			break; \
 		case KSFT_SKIP: \
-			_metadata->exit_code = KSFT_PASS; \
-			_metadata->skip = 1; \
+			_metadata->exit_code = WEXITSTATUS(status); \
 			break; \
 		default: \
 			_metadata->exit_code = KSFT_FAIL; \
-- 
2.43.0


