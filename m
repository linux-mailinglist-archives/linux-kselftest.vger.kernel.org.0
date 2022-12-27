Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCDD656BAD
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 15:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiL0OVd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 09:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiL0OVP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 09:21:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFFC64DD
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 06:21:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7575061174
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Dec 2022 14:21:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DA1C433F2;
        Tue, 27 Dec 2022 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672150871;
        bh=w/aM5yPMx4Ph/CwKI7rsdx9fo77jVtrew5tIYC4hKYE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VflBJVrcIOo9fCmtHe0hVJnjXLjPjHtEg0Siumz/4G/xM3V4Hm708EinGWZGbylTB
         USP5d7b6TsLjMMEeoI5kSX2gkF202Y0djjvhwWqbxetG1B5b5DwoBNmC8M+f1Pu+Ik
         SGBly3Hw004gYu+0j9wRb39G/1vu6mfCPhcqgwB4gfJ0oS3kuFTsDP05CEta92phYm
         nSzUgSmaQeQhEbO6Fd+mZ2OdgF/hg6yKkdG/geLMlS94cHbcgyCEMO7zxBns1ale8p
         R9/9bImXv7rkqW6Xye2RLo/zXcdodz61dZUw3FoAsi7X5097pYo31hq4+rH5t1nzPP
         AVEBAFVxYsCnA==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 14:20:43 +0000
Subject: [PATCH v3 4/4] kselftest/arm64: Add test case for TPIDR2 signal frame records
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-tpidr2-sig-v3-4-c77c6c8775f4@kernel.org>
References: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
In-Reply-To: <20221208-arm64-tpidr2-sig-v3-0-c77c6c8775f4@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3397; i=broonie@kernel.org;
 h=from:subject:message-id; bh=w/aM5yPMx4Ph/CwKI7rsdx9fo77jVtrew5tIYC4hKYE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqv9LOIFLTpBoh67/8PwNpZJ4mGT+7slfjlnYY/DV
 ySFM/oiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6r/SwAKCRAk1otyXVSH0LsJB/
 0d7HryVSGW5pUlLtSB49mdsP20JUWUC+1SK8H9J/dsOYNqfL2guG22c5g1pUguyeVHiWWfBBYblB8l
 wEO7xtx8ebOF+zOvUEzNPvtirfXbv7DZakHJIuRTj58bgi/ac3CBUu59h/Yj/L+STSDDopqnjnAji8
 +UAJVpiGB7HJxVVsgXcU5VBlQJWAKI24hpBKhKKTqCH0B7cuSPbiDtXBYxrbgeUv9+3aA0K43a9vLY
 jrLsusZdOh7BizkdQLA9117ZSWT9Y5V66MmnHf7RPcDvHBgbVAXURx/w55dJ8SXTLYDbmBlDa7W3fT
 Nc8Z17nCPkKNLP4ko6qj+qNtQKnU4h
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

Ensure that we get signal context for TPIDR2 if and only if SME is present
on the system. Since TPIDR2 is owned by libc we merely validate that the
value is whatever it was set to, this isn't ideal since it's likely to
just be the default of 0 with current systems but it avoids future false
positives.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../arm64/signal/testcases/tpidr2_siginfo.c        | 90 ++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index e8d2b57f73ec..e1b6c4d961b5 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -4,5 +4,6 @@ fake_sigreturn_*
 sme_*
 ssve_*
 sve_*
+tpidr2_siginfo
 za_*
 !*.[ch]
diff --git a/tools/testing/selftests/arm64/signal/testcases/tpidr2_siginfo.c b/tools/testing/selftests/arm64/signal/testcases/tpidr2_siginfo.c
new file mode 100644
index 000000000000..6a2c82bf7ead
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/tpidr2_siginfo.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 ARM Limited
+ *
+ * Verify that the TPIDR2 register context in signal frames is set up as
+ * expected.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <asm/sigcontext.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+
+#define SYS_TPIDR2 "S3_3_C13_C0_5"
+
+static uint64_t get_tpidr2(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, " SYS_TPIDR2 "\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
+
+int tpidr2_present(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct tpidr2_context *tpidr2_ctx;
+	size_t offset;
+	bool in_sigframe;
+	bool have_sme;
+	__u64 orig_tpidr2;
+
+	have_sme = getauxval(AT_HWCAP2) & HWCAP2_SME;
+	if (have_sme)
+		orig_tpidr2 = get_tpidr2();
+
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	tpidr2_ctx = (struct tpidr2_context *)
+		get_header(head, TPIDR2_MAGIC, td->live_sz, &offset);
+
+	in_sigframe = tpidr2_ctx != NULL;
+
+	fprintf(stderr, "TPIDR2 sigframe %s on system %s SME\n",
+		in_sigframe ? "present" : "absent",
+		have_sme ? "with" : "without");
+
+	td->pass = (in_sigframe == have_sme);
+
+	/*
+	 * Check that the value we read back was the one present at
+	 * the time that the signal was triggered.  TPIDR2 is owned by
+	 * libc so we can't safely choose the value and it is possible
+	 * that we may need to revisit this in future if something
+	 * starts deciding to set a new TPIDR2 between us reading and
+	 * the signal.
+	 */
+	if (have_sme && tpidr2_ctx) {
+		if (tpidr2_ctx->tpidr2 != orig_tpidr2) {
+			fprintf(stderr, "TPIDR2 in frame is %llx, was %llx\n",
+				tpidr2_ctx->tpidr2, orig_tpidr2);
+			td->pass = false;
+		}
+	}
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "TPIDR2",
+	.descr = "Validate that TPIDR2 is present as expected",
+	.timeout = 3,
+	.run = tpidr2_present,
+};

-- 
2.30.2
