Return-Path: <linux-kselftest+bounces-5569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E537986BDBB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B981C24296
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5443F38F97;
	Thu, 29 Feb 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUgVMPJY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD6338DFB;
	Thu, 29 Feb 2024 00:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168370; cv=none; b=sM2AyJXG/64njxTIA+BvKoKUDVdWdlVdO3npEgNLQY7AyfLn5njSghHSw/prfs0p8GDWybzeqxXuZ5REfY/nUlHqk/jBWU802xGBtkeTtzGJcBn/hmyEZBwnciFzrIv7w9dBRjns60t0xtaMrfUV4FW+NLpew3gROuqY1uhP5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168370; c=relaxed/simple;
	bh=MVloGXNlog3iP7Ml6839weCrZDYXR4a68tqdF53teYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1CoeV7x6dvB8DUeXJZvSe7OcRIXhuXNITKBxVM2EppRUSOL+zaLMxT5OOTT1gszf/0YU/a+kS7+tlcc8KNS8MY7dSoJ9ZikDsuQ5nc1vPhYtnSh3dhTASXP62AXsOaRDa5FovkYMQmLZP2dW9A0IHk+ce7LQYrwo7AAAA8Lxsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUgVMPJY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70608C43390;
	Thu, 29 Feb 2024 00:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168369;
	bh=MVloGXNlog3iP7Ml6839weCrZDYXR4a68tqdF53teYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUgVMPJYIF7T9z4DdE1EavlhiXX/RzU8rxJFwNBbLUQG+AuSqsjUXLkSngAULuajl
	 Fkupd3eSe1pQmFTimelUzRbfjAPtf1HhA7vUUSe0TVVXIKwPopk4Eof7RYqjGKGCE1
	 6zW/FbEP37ZgYbP9mfsKM1wi4qJTK1sYRMIxLox2zpG4/DucxWSyJYDNN44gZGaXsa
	 N3L00YqWc/BUK9jYNPweFNXnlymtqMGIxtfvGCGOY2+/csuR4BS/cbvgQzlng2kMyd
	 +6IGZ5CQtAe9kgkXhGyn3gsw8ZFBrByZdjgLfp+oQXodAsrTR+Pjz4yFbO6RGKM23A
	 ZcPLQ7/wubwRQ==
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
Subject: [PATCH v4 04/12] selftests: kselftest_harness: generate test name once
Date: Wed, 28 Feb 2024 16:59:11 -0800
Message-ID: <20240229005920.2407409-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
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
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 62ce258b0853..4a2bda6a67ed 100644
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
@@ -1107,14 +1108,18 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	char test_name[LINE_MAX];
+
 	/* reset test struct */
 	t->passed = 1;
 	t->skip = 0;
 	t->trigger = 0;
 	memset(t->results->reason, 0, sizeof(t->results->reason));
 
-	ksft_print_msg(" RUN           %s%s%s.%s ...\n",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	snprintf(test_name, sizeof(test_name), "%s%s%s.%s",
+		 f->name, variant->name[0] ? "." : "", variant->name, t->name);
+
+	ksft_print_msg(" RUN           %s ...\n", test_name);
 
 	/* Make sure output buffers are flushed before fork */
 	fflush(stdout);
@@ -1135,15 +1140,14 @@ void __run_test(struct __fixture_metadata *f,
 	} else {
 		__wait_for_test(t);
 	}
-	ksft_print_msg("         %4s  %s%s%s.%s\n", t->passed ? "OK" : "FAIL",
-	       f->name, variant->name[0] ? "." : "", variant->name, t->name);
+	ksft_print_msg("         %4s  %s\n",
+		       t->passed ? "OK" : "FAIL", test_name);
 
 	if (t->skip)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
 					t->results->reason : "unknown");
 	else
-		ksft_test_result(t->passed, "%s%s%s.%s\n",
-			f->name, variant->name[0] ? "." : "", variant->name, t->name);
+		ksft_test_result(t->passed, "%s\n", test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
-- 
2.43.2


