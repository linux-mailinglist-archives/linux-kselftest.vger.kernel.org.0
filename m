Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B8B66C5FF
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjAPQNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbjAPQM0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:12:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1547E2B0A3;
        Mon, 16 Jan 2023 08:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4AA7B81060;
        Mon, 16 Jan 2023 16:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C5FC433F0;
        Mon, 16 Jan 2023 16:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885261;
        bh=hPgmSCQ/Mf/iJwYZPL6yzUIBxj4vmjVTGW5er+S6amw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=oypXQJ9z80Th7EvgZi3fR1iFJRuGmb1FTl7VEp25Ysm3IMrdK0nCBmeQmIyEcglQ0
         6ncm5ZgEpAvMsBBW8WXrXYtktZ6nST7IHaMP2taAV5k0Unet/5g134XQyLdol6DpS9
         gMO7Iz614HqNbJKMpsKzh6/cW6WULQ/QSLinWyNIsKApAnJJAOEKHOHnXgLsy0Lqbb
         fx9tSl26gp3sWlkK9gGyKgQgHHeMuXjFn/TivSUQxkFQmhn2LC3lCqpn1vbIjBE5Ww
         j8s0obRNhLuLotgKuj99FGHBBi/Go+13jfIQ4CHpzRZNICqFfI6UfkskQZMRPlQWke
         ojW79Dw5p6Q/w==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:53 +0000
Subject: [PATCH v4 18/21] kselftest/arm64: Add test coverage for ZT
 register signal frames
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-18-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=4706; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hPgmSCQ/Mf/iJwYZPL6yzUIBxj4vmjVTGW5er+S6amw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWvIhOPlmKxWfonU3La3t9M/vnOV/Wdz7+vloqu
 AkZYLbaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1rwAKCRAk1otyXVSH0Or0B/
 4xVybg4FabQSm8MiO1j6osiYEjbVCAbauH3HTO0zltkKAo4vS2RIkybgbG4xe3GjK3AEl2pEHeQohg
 Le5oMnO1uTl+4cwOSMAGLEavwQjuVsDnTXDu+RFLiCmV9OTSQOMuw8RCeJP16Bo0yCn+MVS1gM7y3S
 TUqul+MmNlHCHSFSe3NEH16pMpueCW9ORD5OxIoJRLZr37ZnWPqJGdfCii2Sx8bVwPqMMezfJNrLyi
 UJt+ISp+S6WX6F9H3pz28YkxGbgwsISxGRv2EicDZMhZmN3r/zjn3OyodPkoER7EeWbk87z79C+p7X
 Ww0cy9q7FDBW/TuGkMDzvpBGB18427
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

We should have a ZT register frame with an expected size when ZA is enabled
and have no ZT frame when ZA is disabled. Since we don't load any data into
ZT we expect the data to all be zeros since the architecture guarantees it
will be set to 0 as ZA is enabled.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  1 +
 .../selftests/arm64/signal/testcases/zt_no_regs.c  | 51 +++++++++++++
 .../selftests/arm64/signal/testcases/zt_regs.c     | 85 ++++++++++++++++++++++
 3 files changed, 137 insertions(+)

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
2.34.1

