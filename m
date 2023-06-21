Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73FF73913C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 23:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjFUVBZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 17:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjFUVBY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 17:01:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5EB19C
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 14:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13D19616DB
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Jun 2023 21:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1002DC433C0;
        Wed, 21 Jun 2023 21:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687381282;
        bh=0Otr1gGFLIbmZ8hW9P3ig3nqrlBtVGxAbSaBQQaDgYA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=skgLlztnDvomOw/rgIEU6ujzcipJIoKacTRUQfgKoYDksgqQCdGE37MjSTiT2hBoV
         +/BOD9xOH6T+S3WvfC5TrbsXdXl5und1qv7cgOGLTsGr+YJ5Jx9ERsfeXxwABAlOqd
         dd6JD/En3jRfnAl2ahnBZV0snh1n6rIA7Hc7uUUPTNQ9SQ3CKCKEBEpZuFNwo6sQwr
         3mUx4npQpGcyOc7N5W7el6lYmrR0hxloqgIgIgwo6M/LmUVaeS5LQGMgVsinD3Jehc
         mUvMr1nKdvQvykj1OnJKlnhbaI0SNCYJhJ8auiOnJXc0bT0YjD9j3e48dPTjq/a4Cp
         QRqE3LvT6z08A==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 21 Jun 2023 22:00:51 +0100
Subject: [PATCH 2/2] kselftest/arm64: Add a test case for TPIDR2 restore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-arm64-fix-tpidr2-signal-restore-v1-2-b6d9e584d2ee@kernel.org>
References: <20230621-arm64-fix-tpidr2-signal-restore-v1-0-b6d9e584d2ee@kernel.org>
In-Reply-To: <20230621-arm64-fix-tpidr2-signal-restore-v1-0-b6d9e584d2ee@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=3063; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0Otr1gGFLIbmZ8hW9P3ig3nqrlBtVGxAbSaBQQaDgYA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkk2UbdLcf5wQjFOxU9upjX8rHFyxptm5JQjM5C+dw
 5qod0TaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJNlGwAKCRAk1otyXVSH0IwxB/
 91+aGd7wZPnKphcbFssxji/rPLXVi3hwFV8O6khOQbkftrx1kAP48+6YPH8+mE2V9gXLfW5Q/nqEda
 9Rl3xbOikVV2mSuxU2VPU4Z+25Fo9LPW+fLzauNCrWSvVqfoyDlOmDE1QkcVCdzCbSaMNpV1Q5AkkM
 TP5oDELlIwSPmfju2S2NGcDUAaA2+rnGYiO81abDNe/E0QL4RUHP4M76ipdlkuOdTEl0qwkgsczFKT
 ThqNqSXXUy1oXYUUDITb3fhwCHL36tYdLcN+majux+qQkg489WqlXLt7ygWUMybEIpZtGUNt2XhaZU
 ZBxsmcMe8+EjpBPJMZWu5MbTkCLmGj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to the fact that TPIDR2 is intended to be managed by libc we don't
currently test modifying it via the signal context since that might
disrupt libc's usage of it and cause instability. We can however test the
opposite case with less risk, modifying TPIDR2 in a signal handler and
making sure that the original value is restored after returning from the
signal handler. Add a test which does this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/.gitignore    |  2 +-
 .../arm64/signal/testcases/tpidr2_restore.c        | 85 ++++++++++++++++++++++
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/.gitignore b/tools/testing/selftests/arm64/signal/.gitignore
index 8ab4c86837fd..839e3a252629 100644
--- a/tools/testing/selftests/arm64/signal/.gitignore
+++ b/tools/testing/selftests/arm64/signal/.gitignore
@@ -4,7 +4,7 @@ fake_sigreturn_*
 sme_*
 ssve_*
 sve_*
-tpidr2_siginfo
+tpidr2_*
 za_*
 zt_*
 !*.[ch]
diff --git a/tools/testing/selftests/arm64/signal/testcases/tpidr2_restore.c b/tools/testing/selftests/arm64/signal/testcases/tpidr2_restore.c
new file mode 100644
index 000000000000..c01db4d56eb9
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/tpidr2_restore.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 ARM Limited
+ *
+ * Verify that the TPIDR2 register context in signal frames is restored.
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
+static void set_tpidr2(uint64_t val)
+{
+	asm volatile (
+		"msr	" SYS_TPIDR2 ", %0\n"
+		:
+		: "r"(val)
+		: "cc");
+}
+
+
+static uint64_t initial_tpidr2;
+
+static bool save_tpidr2(struct tdescr *td)
+{
+	initial_tpidr2 = get_tpidr2();
+	fprintf(stderr, "Initial TPIDR2: %lx\n", initial_tpidr2);
+
+	return true;
+}
+
+static int modify_tpidr2(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
+{
+	uint64_t my_tpidr2 = get_tpidr2();
+
+	my_tpidr2++;
+	fprintf(stderr, "Setting TPIDR2 to %lx\n", my_tpidr2);
+	set_tpidr2(my_tpidr2);
+
+	return 0;
+}
+
+static void check_tpidr2(struct tdescr *td)
+{
+	uint64_t tpidr2 = get_tpidr2();
+
+	td->pass = tpidr2 == initial_tpidr2;
+
+	if (td->pass)
+		fprintf(stderr, "TPIDR2 restored\n");
+	else
+		fprintf(stderr, "TPIDR2 was %lx but is now %lx\n",
+			initial_tpidr2, tpidr2);
+}
+
+struct tdescr tde = {
+	.name = "TPIDR2 restore",
+	.descr = "Validate that TPIDR2 is restored from the sigframe",
+	.timeout = 3,
+	.sig_trig = SIGUSR1,
+	.init = save_tpidr2,
+	.run = modify_tpidr2,
+	.check_result = check_tpidr2,
+};

-- 
2.30.2

