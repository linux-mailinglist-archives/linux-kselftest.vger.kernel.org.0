Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37DC6263E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 22:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKVwF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 16:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiKKVvo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 16:51:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFCF6B203
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 13:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7800FB82806
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Nov 2022 21:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0C9C433D6;
        Fri, 11 Nov 2022 21:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668203501;
        bh=btqd+wxNRzbHiPozkH6Ho7qEjlMM8y1Ld49FHNxQVHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCmJAVoNEad4FxehYGig3H1ejva3LOk0E9mW7KRzlu8d9LiMV7E000ym89EDJVqcJ
         25zGFkcDew5to2yGNwXeB4+RFYgGLVTgbH2D/HSyonpaQZ7bHeEg/G7b0fRHLc//ZW
         d4nG/R/bUdnPDlKMwYx6d1GzFC5fgsoLf7YSsMrbhV1f3xnhZ7/UYU2v3RKlImno8x
         AAqeWvVJC/FmOmrhU2K30K8+lcHs5kxcHSjZsxRkJh3D3fj5vrF+ilafbkmWGgoqkR
         nJ5qd2asAwjJHxnJq+VJe+3Yz8HMxfBhbT5y9+FkCf29XJyovFis0sIzbUro8i3Y7m
         ivpZW66mn8O7w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 18/21] kselftest/arm64: Add test coverage for ZT register signal frames
Date:   Fri, 11 Nov 2022 21:50:23 +0000
Message-Id: <20221111215026.813348-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221111215026.813348-1-broonie@kernel.org>
References: <20221111215026.813348-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4843; i=broonie@kernel.org; h=from:subject; bh=btqd+wxNRzbHiPozkH6Ho7qEjlMM8y1Ld49FHNxQVHA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjbsOe27wLUy8MmPY6StlaAnYEPtnbph52q+skWwFI XAVzRgeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY27DngAKCRAk1otyXVSH0PO5B/ 0ZHYdI+a/q2Z1cQ0YIeVsbHAaMLtctRio2HKI9HvJaRrbhdFZ4xGC9aeskiDpYZLpZ2G2oJul+nR0U Nv2pqsxYsgUC/GI+GMlZHp5XK3CqROpbkypqFecwgYXZ7vv5iEwqtJJYSiViUUJnR2xs0Bwl8jij1t GkgqH8l1590He3qqzIc/PvpunTdiqyzJirZftmNs+ZYv/e9jG56ymUUh/CUkhTKtmlmTxoqQbJP90+ 4yvPwIb74RxxLLjrsqi6lt9qsmU8NNoNnAK/XyCuFenozP3UDwgLJHh0QGflN4lA+SFEd29ZEGki6D Los+iXLyvWxGyREqFmJO6BKwDVoBH0
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We should have a ZT register frame with an expected size when ZA is enabled
and have no ZT frame when ZA is disabled. Since we don't load any data into
ZT we expect the data to all be zeros since the architecture guarantees it
will be set to 0 as ZA is enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../testing/selftests/arm64/signal/.gitignore |  1 +
 .../arm64/signal/testcases/zt_no_regs.c       | 51 +++++++++++
 .../arm64/signal/testcases/zt_regs.c          | 85 +++++++++++++++++++
 3 files changed, 137 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/zt_no_regs.c
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/zt_regs.c

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index e8d2b57f73ec..b7fbb65183e8 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -5,4 +5,5 @@ sme_*
 ssve_*
 sve_*
 za_*
+zt_*
 !*.[ch]
diff --git a/tools/testing/selftests/arm64/signal/testcases/zt_no_regs.c b/tools/testing/selftests/arm64/signal/testcases/zt_no_regs.c
new file mode 100644
index 000000000000..34f69bcf821e
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/zt_no_regs.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that using an instruction not supported in streaming mode
+ * traps when in streaming mode.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+
+int zt_no_regs_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+
+	/*
+	 * Get a signal context which should not have a ZT frame and
+	 * registers in it.
+	 */
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	head = get_header(head, ZT_MAGIC, GET_BUF_RESV_SIZE(context), &offset);
+	if (head) {
+		fprintf(stderr, "Got unexpected ZT context\n");
+		return 1;
+	}
+
+	td->pass = 1;
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "ZT register data not present",
+	.descr = "Validate that ZT is not present when ZA is disabled",
+	.feats_required = FEAT_SME2,
+	.timeout = 3,
+	.sanity_disabled = true,
+	.run = zt_no_regs_run,
+};
diff --git a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
new file mode 100644
index 000000000000..e1eb4d5c027a
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 ARM Limited
+ *
+ * Verify that using an instruction not supported in streaming mode
+ * traps when in streaming mode.
+ */
+
+#include <signal.h>
+#include <ucontext.h>
+#include <sys/prctl.h>
+
+#include "test_signals_utils.h"
+#include "testcases.h"
+
+static union {
+	ucontext_t uc;
+	char buf[1024 * 128];
+} context;
+
+static void enable_za(void)
+{
+	/* smstart za; real data is TODO */
+	asm volatile(".inst 0xd503457f" : : : );
+}
+
+int zt_regs_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	size_t offset;
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct zt_context *zt;
+	char *zeros;
+
+	/*
+	 * Get a signal context which should have a ZT frame and registers
+	 * in it.
+	 */
+	enable_za();
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	head = get_header(head, ZT_MAGIC, GET_BUF_RESV_SIZE(context), &offset);
+	if (!head) {
+		fprintf(stderr, "No ZT context\n");
+		return 1;
+	}
+
+	zt = (struct zt_context *)head;
+	if (zt->nregs == 0) {
+		fprintf(stderr, "Got context with no registers\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Got expected size %u for %d registers\n",
+		head->size, zt->nregs);
+
+	/* We didn't load any data into ZT so it should be all zeros */
+	zeros = malloc(ZT_SIG_REGS_SIZE(zt->nregs));
+	if (!zeros) {
+		fprintf(stderr, "Out of memory, nregs=%u\n", zt->nregs);
+		return 1;
+	}
+	memset(zeros, 0, ZT_SIG_REGS_SIZE(zt->nregs));
+
+	if (memcmp(zeros, (char *)zt + ZT_SIG_REGS_OFFSET,
+		   ZT_SIG_REGS_SIZE(zt->nregs)) != 0) {
+		fprintf(stderr, "ZT data invalid\n");
+		return 1;
+	}
+
+	free(zeros);
+
+	td->pass = 1;
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "ZT register data",
+	.descr = "Validate that ZT is present and has data when ZA is enabled",
+	.feats_required = FEAT_SME2,
+	.timeout = 3,
+	.sanity_disabled = true,
+	.run = zt_regs_run,
+};
-- 
2.30.2

