Return-Path: <linux-kselftest+bounces-5062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 389E985C49F
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9051F244C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26E314C5AB;
	Tue, 20 Feb 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYfzcEMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF014A4E2;
	Tue, 20 Feb 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456968; cv=none; b=KD2ELl8PHHPx0J+WciF9FQb3qJgBD3v2XTuFslcCnhFmIUr0HooejL5ubDip61hWTuBbqBv9zLjF9pBd6Xp7peMQwFM9lK11xkPkh16Gz1zN0D6g1SHun0l/+U+XUZ7Muq+coA0uwH/CdO7qyS1GMy8o2ZEEJMWMoXsdNfjiHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456968; c=relaxed/simple;
	bh=i7OQ0CBPUvcZuB1M/xw7S8wpiJMS1dvOsrgRmQy3mEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TehmCCE+8Vqw92y7I0s7j+XZzcK/GUPFuBC04x9V3iBmnBZ0dlgym3tddORzb7azNB6QJUcaFIR4BTpK7Kamvrhk0JHujpJcCaxV9hOeyB2NlxKGK15IVz8mrEp89yTDguPON/ta6k1Z6nyzvyH4lXRk/oTUjRLOALtBh5D9mOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYfzcEMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A88ACC43390;
	Tue, 20 Feb 2024 19:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456968;
	bh=i7OQ0CBPUvcZuB1M/xw7S8wpiJMS1dvOsrgRmQy3mEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XYfzcEMDSxpyolsXWnaoC/5SujI3JSi38UCTNU5oQRkSW3yEEe/x5uoW9lpvadSAN
	 mnnFwC+uQwDPQuyNV+FcdLMZqyEli6BVFXfSFud8Tdy1TjVAaFxgmysKkUj6xRKDhR
	 7LAHYhD+ULh7CMcQFjQK+PkBBXDLsvm69TVf0n+V7wZGbr+SOkfuxu7pQCd7I2il03
	 NVAZ9dbdp0eUZMQGyBkyctd5bF65dkBQc6PjERuN8avXCGoPKS7jIM/Q4JaT8JK8e2
	 c6N301DF6Sv62OJvBhf0XEzZu3IAi95O2qjuVyla/WOCgML40ZaekDXfcLgPcEwoS6
	 mYlQ+HX7YpZ5A==
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
Subject: [PATCH net-next v3 03/11] selftests: kselftest_harness: generate test name once
Date: Tue, 20 Feb 2024 11:22:27 -0800
Message-ID: <20240220192235.2953484-4-kuba@kernel.org>
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
index 618b41eac749..8fc24a728240 100644
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
@@ -1109,6 +1110,8 @@ void __run_test(struct __fixture_metadata *f,
 		struct __fixture_variant_metadata *variant,
 		struct __test_metadata *t)
 {
+	char test_name[LINE_MAX];
+
 	/* reset test struct */
 	t->passed = 1;
 	t->skip = 0;
@@ -1117,8 +1120,10 @@ void __run_test(struct __fixture_metadata *f,
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
@@ -1140,15 +1145,14 @@ void __run_test(struct __fixture_metadata *f,
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
2.43.0


