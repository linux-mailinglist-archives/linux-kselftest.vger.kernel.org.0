Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5A073A205
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 15:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjFVNkH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjFVNkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 09:40:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75C1997
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 06:40:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35D3361831
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Jun 2023 13:40:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E12FC433C0;
        Thu, 22 Jun 2023 13:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687441204;
        bh=I4NWuVbplK94yptwpSk7z+1nz1dxISccSIH9QFqpMIc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Jlg6cuqOpeQ72dq2z3kl6mrX5yOFq7owxNRCUa2c/INC4MKicRqW//hAPFQlZE/yl
         K4C0Y5aN0wU6UB8SAzcujpJ1WQdLQjjwxcoy51+tYHHQJ1dJEJQKKkUjfnP9jx9m/B
         s6D61/rnyezlgaX3nPLCXB6bCtY1nqYn7YRu0nwOzbmPnG3Ww/Ix+WU3M5VmUDU/8x
         QfZv3o+CtwyDuHJ4zi47v2WKIeD+xQc0vsjq2IqXJ2u48RYIylw6OP0OYlgo4dudco
         UPOAoAqWNYqTZ6Qg2CDyyccNVFuIKthWTVSOEV00vAytSSGVV4WzjpAc6XxR8ocTD9
         LLsXGbysZS1Bw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 22 Jun 2023 14:39:46 +0100
Subject: [PATCH v2 2/2] kselftest/arm64: Add a test case for TPIDR2 restore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-arm64-fix-tpidr2-signal-restore-v2-2-c8e8fcc10302@kernel.org>
References: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
In-Reply-To: <20230621-arm64-fix-tpidr2-signal-restore-v2-0-c8e8fcc10302@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=broonie@kernel.org;
 h=from:subject:message-id; bh=I4NWuVbplK94yptwpSk7z+1nz1dxISccSIH9QFqpMIc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBklE8oAzJLhyfqqFXIZ6KSC5CDDs//cJNa/u71raaB
 GcEjEVCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZJRPKAAKCRAk1otyXVSH0PZkB/
 9DJ0hlTEAW0a9O7uSlCy0E+iH7b41edp7KAkTbTWJ2lxc5XlBOrAD2gVWVMDsjDC6kWNOq1ClqKawt
 GZd4ZbPEKBmsxvf2BUSQLqVYDhcznqvFnI7JDmIAPEgN+EqC/60Vc9QcxZKIzWqZZ+/wWk9kAmhhqO
 +VW+jEy6PN6mJ4rUV+tqd9PU/WmfBsKWMtDA8grIH350qt7FW1fA/wo94bSXwDl2U4+oXB85j3T/ZS
 S25BFB/M5+jsjemNMnbKuUlkNWzad8uXWnTwVkXt3P0Ts5QgKAEWEv6UH92LyCCogaVpQ9h1mZYGVJ
 PfNTnmniWi7TlrTYt/gUIrF9VyYZ9R
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
 .../arm64/signal/testcases/tpidr2_restore.c        | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletion(-)

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
index 000000000000..f9a86c00c28c
--- /dev/null
+++ b/tools/testing/selftests/arm64/signal/testcases/tpidr2_restore.c
@@ -0,0 +1,86 @@
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
+	.feats_required = FEAT_SME,
+	.timeout = 3,
+	.sig_trig = SIGUSR1,
+	.init = save_tpidr2,
+	.run = modify_tpidr2,
+	.check_result = check_tpidr2,
+};

-- 
2.30.2

