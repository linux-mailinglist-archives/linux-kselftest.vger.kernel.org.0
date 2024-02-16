Return-Path: <linux-kselftest+bounces-4828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B38572AB
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC241F24D0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4445382;
	Fri, 16 Feb 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDo+juwK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857163D76;
	Fri, 16 Feb 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044089; cv=none; b=o64Arl79oGZfsKl5EgeIG8TlKvLH4vnE+/I22dRp1KEwReumOgakqFFhZ5Ir1gnsVMF2sT/x+lGuhDbAB/7jYLyKUfKGwOEi+mzG1/NjX2peR8Bar+1mJhcSesIIK1Hx60lHmacpLvGgQLYukc0ZfeMkjX+rR/h/HU2nVL1uSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044089; c=relaxed/simple;
	bh=jVsyFrRWGb6c8tPeoYyanRLN2VhvxjxD+uPfcRjaW9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdFX75pmP0nmfQIEcdWu5cydJHTK3k3lEVlPPHvu07zqOlKBV1iF+WVIXg8wTD1pkvCnzhasEo4VsJv7Vb05rRs465LVVoeq45fJu0mHc4Mvcy2ycq46wS1FT067YMOghHOrju9LobJJmkHCLYXzXF9f1v+SPFR7s1+QN1gn69I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDo+juwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB627C43390;
	Fri, 16 Feb 2024 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044089;
	bh=jVsyFrRWGb6c8tPeoYyanRLN2VhvxjxD+uPfcRjaW9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDo+juwKtPXmC9zH3YlU1jWHYJFY5hpgIMNZ7v2ZA0SRx1pkgzX5fQhHyxFQZV108
	 CvWPSWfn2Whu2YcT26T9xLxLxnTj8zFuZgaOrG6EXGedcJyNDKFNY+/Wi48ubMb5GB
	 46BhDUCNoKT67yjr6IAf70Y2Cu/rbmcr3wOrQQA81kNjVf9zMOhdEWD12xpOhOohS8
	 CkXoL9xWgaHygeBPnBmhhiTqb+2DqY/eE62MwYM08xxVmDbLsFtlSiQxjigkKYuqGp
	 8mXsqX/b+USWcDUpNna7BxSyRkgg5Xnm/MrSwCvG2BSsUHhdeKKT5cuR1R4v5bDuRt
	 tKEArd9xJ3j4w==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 1/7] selftests: kselftest_harness: generate test name once
Date: Thu, 15 Feb 2024 16:41:16 -0800
Message-ID: <20240216004122.2004689-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we added variant support generating full test case
name takes 4 string arguments. We're about to need it
in another two places. Stop the duplication and print
once into a temporary buffer.

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 04177813930b..b271cb721b81 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -56,6 +56,7 @@
 #include <asm/types.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -1140,6 +1141,8 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	char test_name[LINE_MAX];
+
 	/* reset test struct */
 	t->passed = 1;
 	t->skip = 0;
@@ -1149,8 +1152,10 @@ void __run_test(struct __fixture_metadata *f,
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 	t->results->step = 1;
 
-	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
+		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	ksft_print_msg(" RUN           %s ...\n", test_name);
 
 	/* Make sure output buffers are flushed before fork */
 	fflush(stdout);
@@ -1174,8 +1179,8 @@ void __run_test(struct __fixture_metadata *f,
 	} else {
 		__wait_for_test(t);
 	}
-	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	ksft_print_msg("         %4s  %s\n",
+		       t->passed ? "OK" : "FAIL", test_name);
 
 	if (t->skip)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
@@ -1184,8 +1189,7 @@ void __run_test(struct __fixture_metadata *f,
 		ksft_test_result_xfail("%s\n", t->results->reason[0] ?
 				       t->results->reason : "unknown");
 	else
-		ksft_test_result(t->passed, "%s%s%s.%s\n",
-			f->name, variant->name[0] ? "." : "", variant->name, t->name);
+		ksft_test_result(t->passed, "%s\n", test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
-- 
2.43.0


