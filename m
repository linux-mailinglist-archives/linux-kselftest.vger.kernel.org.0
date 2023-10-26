Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BA37D831B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345162AbjJZMsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345078AbjJZMrq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 08:47:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C365ED6C;
        Thu, 26 Oct 2023 05:47:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D365C433D9;
        Thu, 26 Oct 2023 12:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698324452;
        bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=q7eesor6jinYv1yB55Uk+bcBdg+AJLhjm5ZLF6zBH8KhRoRygSwflSE11ZnmIg8LT
         HKgn7xLfkovVka3xpV/ctbXpN/RqI2ol9gjPb0kBwz3XVC1FIHCWKNiVhapdKa34JS
         0ty5Qt0NdqywOb9aQY0Du0PEo2JuVTUQSpnX0+BMB4gpRcL2n0CcGpZnuKZZGPvJu6
         p80vrWDCMXegTUBI59EhRRZoxo/TfWSW27te7L516UJ018JMK5SR3hFQ89f/G3lyHb
         VDhbqciu58fMVdlwI+c7Uajrj4SIAXfHE0oal89MKEUUwwWRIgg1i/OoQcNaT0//oI
         Mu54FxoYuiSUg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 26 Oct 2023 13:44:32 +0100
Subject: [PATCH 18/21] kselftest/arm64: Add basic FPMR test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231026-arm64-2023-dpisa-v1-18-8470dd989bb2@kernel.org>
References: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
In-Reply-To: <20231026-arm64-2023-dpisa-v1-0-8470dd989bb2@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2813; i=broonie@kernel.org;
 h=from:subject:message-id; bh=irtBwegYB+DXpSWW34B5isPMLTYQBsVR3AqcPDPAR5U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlOl+iCJdeV2fsyrb2Goi5LFUKDp5cDy2hkYV1hTmP
 NxdgV+qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZTpfogAKCRAk1otyXVSH0G9uB/
 9Uk6ue6AiOXc9U24n6Z1wmQoT6SRGNy0Sw6uyrZBwn8z/osMnkYzrq6zTxCgXlkcFeK9A+saCjA+qf
 Yo8GH1Hzhm8Ca1Jry/vNstZVkyQ2MYQtn4fc6B4zxYyeJ/G9BiQnctdjJYMLxfl4cIUr+t0KghbqIB
 ya59WP3L0gCeBnXe2PGC2uWZoOUJl8+krxUeDaWmvOjgSqbGkIk6VWrqk/rm/scVjAc+gFTn+e/KdC
 xCPNkJa/ttYorYFaFnjCtRQ91ww7BShiiCxRZqFiaSVhm7jUMsUxz2BZORzA0e5WeFBosKyVtYogmU
 JLQrK2cV9JJoSpjaqeMFfmBEH40Fpc
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Verify that a FPMR frame is generated on systems that support FPMR and not
generated otherwise.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../arm64/signal/testcases/fpmr_siginfo.c          | 82 ++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 839e3a252629..1ce5b5eac386 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 mangle_*
 fake_sigreturn_*
+fpmr_*
 sme_*
 ssve_*
 sve_*
diff --git a/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
new file mode 100644
index 000000000000..e9d24685e741
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/fpmr_siginfo.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ *
+ * Verify that the FPMR register context in signal frames is set up as
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
+#define SYS_FPMR "S3_3_C4_C4_2"
+
+static uint64_t get_fpmr(void)
+{
+	uint64_t val;
+
+	asm volatile (
+		"mrs	%0, " SYS_FPMR "\n"
+		: "=r"(val)
+		:
+		: "cc");
+
+	return val;
+}
+
+int fpmr_present(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	struct _aarch64_ctx *head = GET_BUF_RESV_HEAD(context);
+	struct fpmr_context *fpmr_ctx;
+	size_t offset;
+	bool in_sigframe;
+	bool have_fpmr;
+	__u64 orig_fpmr;
+
+	have_fpmr = getauxval(AT_HWCAP2) & HWCAP2_FPMR;
+	if (have_fpmr)
+		orig_fpmr = get_fpmr();
+
+	if (!get_current_context(td, &context.uc, sizeof(context)))
+		return 1;
+
+	fpmr_ctx = (struct fpmr_context *)
+		get_header(head, FPMR_MAGIC, td->live_sz, &offset);
+
+	in_sigframe = fpmr_ctx != NULL;
+
+	fprintf(stderr, "FPMR sigframe %s on system %s FPMR\n",
+		in_sigframe ? "present" : "absent",
+		have_fpmr ? "with" : "without");
+
+	td->pass = (in_sigframe == have_fpmr);
+
+	if (have_fpmr && fpmr_ctx) {
+		if (fpmr_ctx->fpmr != orig_fpmr) {
+			fprintf(stderr, "FPMR in frame is %llx, was %llx\n",
+				fpmr_ctx->fpmr, orig_fpmr);
+			td->pass = false;
+		}
+	}
+
+	return 0;
+}
+
+struct tdescr tde = {
+	.name = "FPMR",
+	.descr = "Validate that FPMR is present as expected",
+	.timeout = 3,
+	.run = fpmr_present,
+};

-- 
2.30.2

