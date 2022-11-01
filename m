Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261AC614CDE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiKAOkG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiKAOkE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:40:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23831C426
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:40:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FFCFB81DE7
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F9BC433D7;
        Tue,  1 Nov 2022 14:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313601;
        bh=btqd+wxNRzbHiPozkH6Ho7qEjlMM8y1Ld49FHNxQVHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ma/LREcjN+QjKpjW+WdkMph0YqUkcGyxiTYwCRnnydyMgKwxaIA1+1SHiL7JpkuLZ
         u3HgXefflixeAITHUEqc1F2d5SNUqvt9jmEs9OIn+EQRtY/cN55cH/MQsfvbn33Qzx
         jbCPqXX24gKPIOobdA9ugLr+MtSo0K8l0Ui4ast6VU1bS4AP0K36QsWMU6HzV2rOJV
         OXr42DwcFGRWz+U77aomK2AzRddamWIF6jPCv4hP3xOswnhBGlb7D98yCInZB5SFfe
         6AaJqSYxnryqN3tJVnFdMqIH1SosX32cL/lJVB1KFqJXGw3r6kY8AMq1KtocBw+zDn
         dlA+U0Daki0Gw==
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
Subject: [PATCH v2 18/21] kselftest/arm64: Add test coverage for ZT register signal frames
Date:   Tue,  1 Nov 2022 14:33:33 +0000
Message-Id: <20221101143336.254445-19-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4843; i=broonie@kernel.org; h=from:subject; bh=btqd+wxNRzbHiPozkH6Ho7qEjlMM8y1Ld49FHNxQVHA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4827wLUy8MmPY6StlaAnYEPtnbph52q+skWwFI XAVzRgeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuPAAKCRAk1otyXVSH0JIJB/ oCrWd7+8lenSLrmEPaoT/GdLM97XyJJq8VrJcdwQzPX1EIWGZh+3g8DectglpXL3rg+D0OclhkiHsj 7ii6pUapRsUOXu/VsRMHXLbsG7/oF7QQd1W0dQCS52PUPud9z+u/INXHLHUHwsiRBExYbI2P3DPF6L Ef6kc6sy+doeINvxa92qDSKx1MzAkBEdUEdujXm70CanLC7uSzlVCXDvaZseQ+uAqqL+V7luupeIhI ZXka6wgVAGayDuaLPTyXqkuQzuC02A9CWTdnXSkkFsutoJO4NdjJhCREhpfSL/f5sFsI1WbuADdILZ ix74erHYkzBOA5TCjAdaozRianVP5j
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

