Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6768D664DAB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjAJUuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 15:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbjAJUuW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 15:50:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2794FCD9;
        Tue, 10 Jan 2023 12:50:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 322B8B819AB;
        Tue, 10 Jan 2023 20:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC9AC433F2;
        Tue, 10 Jan 2023 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673383818;
        bh=zpskF82GlvP6q9N/uHitfd7FqiyA6XCzda+aKDgjBYc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hb54APO+K9WbX/BdIw4GDaiPOyDr0OcRzivljwo17zEe+3ttdQNKDCLN67ALMCEal
         WTLorB3d/LE4FivSC6n89VOraxGS6/SqRtQX7qVfzg3AtWrmCcVdLmJalCodu6yhdk
         /oPwnPUcfylkSJdRNMbx544zYMTjQvQ4QAQwXe0C+y8RugRfOKWxzMw/8++BvAZsa9
         LtEDNSMhreGLVH/qkB2sSc/I48qV2pfNEgwxZsw/1oeMPd2C1hYXlCq6T7iiKVYkYc
         ZtQgidAzjzpf0nVmVWHz8GXGUHyM8hO0iqwG/UnWF4QGe6iTgzDfmo4ec7n+XzGGIQ
         oLAWvpdTmIg+A==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 10 Jan 2023 20:49:59 +0000
Subject: [PATCH 2/2] kselftest/arm64: Run BTI selftests on systems without BTI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230110-arm64-bti-selftest-skip-v1-2-143ecdc84567@kernel.org>
References: <20230110-arm64-bti-selftest-skip-v1-0-143ecdc84567@kernel.org>
In-Reply-To: <20230110-arm64-bti-selftest-skip-v1-0-143ecdc84567@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2624; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zpskF82GlvP6q9N/uHitfd7FqiyA6XCzda+aKDgjBYc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjvc+EUDvIqXxdIbhWzGNXJ4wcNqEmVAzaeulaw/jE
 B4/RyJeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY73PhAAKCRAk1otyXVSH0GXoB/
 4o8z+LWKUApVvMNZQMp+Tm4K5r/2Cm27joa2VNd7mO7OolJOzXBJ0w3ZSVs/nvY2Z3natfFkWmpkM3
 doNsnF4kLmhpxFbFaE/IIwArNNxI9TpYgHX/lOahltklCwo3R/6AM8Zlkcip+hNtjA9HJOn9cZcqRl
 zIdY3Jcm/R8FicEk+2g12VWxHwxJy/WKnxtpGim6ipiybRXUgWUQIzZTQV7qvjaVet7C6Roim1+qbQ
 Eth3zbmhbrNFm23rIfAmQNY/VBQHPrStG9ghBfCM1s6XqqtJcSyoybzBIN3uGreGa5fIkpQWZGBE4y
 H652S4TqlYOXmx9CJQeS9riyCsxyQO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The BTI selftests are built both with and without BTI support, validating
both the generation of BTI signals as expected for binaries without BTI
support. Both versions of the binary currently skip all their tests when
the system does not support BTI, however this is excessive since we do have
a defined ABI for how the programs should function in this case (especially
for the non-BTI binary). Update the test program to run all the tests
unconditionally, adding a runtime adjustment of the expected results on
systems that don't support BTI where we currently handle the build time
case.

The tests all use HINT space instructions, BTI itself is a HINT as is
are the PAC instructions that function as landing pads, so nothing in the
tests depends on support for BTI in the kernel or hardware.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/bti/test.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/arm64/bti/test.c b/tools/testing/selftests/arm64/bti/test.c
index 4b6dda987c58..2cd8dcee5aec 100644
--- a/tools/testing/selftests/arm64/bti/test.c
+++ b/tools/testing/selftests/arm64/bti/test.c
@@ -6,6 +6,7 @@
 
 #include "system.h"
 
+#include <stdbool.h>
 #include <stddef.h>
 #include <linux/errno.h>
 #include <linux/auxvec.h>
@@ -101,7 +102,8 @@ static void handler(int n, siginfo_t *si __always_unused,
 	uc->uc_mcontext.pstate &= ~PSR_BTYPE_MASK;
 }
 
-static int skip_all;
+/* Does the system have BTI? */
+static bool have_bti;
 
 static void __do_test(void (*trampoline)(void (*)(void)),
 		      void (*fn)(void),
@@ -109,19 +111,11 @@ static void __do_test(void (*trampoline)(void (*)(void)),
 		      const char *name,
 		      int expect_sigill)
 {
-	if (skip_all) {
-		test_skipped++;
-		putstr("ok ");
-		putnum(test_num++);
-		putstr(" ");
-		puttestname(name, trampoline_name);
-		putstr(" # SKIP\n");
-
-		return;
-	}
-
-	/* Branch Target exceptions should only happen in BTI binaries: */
-	if (!BTI)
+	/*
+	 * Branch Target exceptions should only happen for BTI
+	 * binaries running on a system with BTI:
+	 */
+	if (!BTI || !have_bti)
 		expect_sigill = 0;
 
 	sigill_expected = expect_sigill;
@@ -199,9 +193,10 @@ void start(int *argcp)
 		putstr("# HWCAP2_BTI present\n");
 		if (!(hwcap & HWCAP_PACA))
 			putstr("# Bad hardware?  Expect problems.\n");
+		have_bti = true;
 	} else {
 		putstr("# HWCAP2_BTI not present\n");
-		skip_all = 1;
+		have_bti = false;
 	}
 
 	putstr("# Test binary");

-- 
2.30.2
