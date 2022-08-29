Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BAD5A5072
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiH2Pqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiH2Pqt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:46:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833586892
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA92EB81101
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D7CC433B5;
        Mon, 29 Aug 2022 15:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788004;
        bh=VECdJO+0n+ndS0guBWqDx9b7Eiz+afsJreVpJ6xfPxg=;
        h=From:To:Cc:Subject:Date:From;
        b=DkkR6WQ22jLnkxbEefBmyU3O0w5tcRzxB2NUK55wvqxhpQRktnK4VRqszFQyWzZSJ
         7+R0vYiHM5WnN6MTVZSInnxJnmqqGW5Pl6egKuvzC7wwh+Lu2xfW35Eo3cDM2y66hG
         az0IhDAp/rNm1M1CThhq7L+XCL+KVrHPMIR3JQctzIFQhtZ5PaCff29kp2VVvIoBZK
         J+IRrT7A+tMl89uLqzxKejRa9DKtGmQ9FiPvLYXFx7qLBdpy5XRCc2ZrfHoSdwfRZe
         1EA3IWgx6cYGwZ7lZHZrxpVFoUls+FWakjOXa9AGcQTl9IrbNUfhmNdN/SVpbxoSqP
         X5pcPqb3aRBpA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] kselftest/arm64: Add simple hwcap validation
Date:   Mon, 29 Aug 2022 16:46:02 +0100
Message-Id: <20220829154602.827275-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6478; i=broonie@kernel.org; h=from:subject; bh=VECdJO+0n+ndS0guBWqDx9b7Eiz+afsJreVpJ6xfPxg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN84bA4qJntJO2JrghOrWHze/T8LWMU81yMQ2Ldq hVGb3yWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzfOAAKCRAk1otyXVSH0N8wB/ 4/mvURBnYqcU1SRzleAzM+RX7Ih0gb1Sq/9NooLQJXN5+bH3J+JLOPbWLwIKVf3EvmHWOUpN6+np1s kqi/77BahbCt+CQpiUeG+xjGZW0BB/kozSR/us92P4nY06D8iLfr+97L7SiiEYF5uvpjjagiNlGRPB /DKEA+apbc4VytyOPLC1ELROdj+3zrGWPdT38bQ+VrSSSly9INeRPCjYoyHFEwVs2wpJ27DmAC+3zm ZHO51XHlT6YFXOHkuw49r3Xqyd/mjryYQOHgUrjJ8sAsjnWsB7zualqCo28FuIZLMnmU3Sz/JFN4y7 AQStEMm9gq2Vjjh7Hv9+cGmHwZNxfM
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some trivial hwcap validation which checks that /proc/cpuinfo and
AT_HWCAP agree with each other and can verify that for extensions that can
generate a SIGILL due to adding new instructions one appears or doesn't
appear as expected. I've added SVE and SME, other capabilities can be
added later if this gets merged.

This isn't super exciting but on the other hand took very little time to
write and should be handy when verifying that you wired up AT_HWCAP
properly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/.gitignore |   1 +
 tools/testing/selftests/arm64/abi/Makefile   |   2 +-
 tools/testing/selftests/arm64/abi/hwcap.c    | 188 +++++++++++++++++++
 3 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/abi/hwcap.c

diff --git a/tools/testing/selftests/arm64/abi/.gitignore b/tools/testing/selftests/arm64/abi/.gitignore
index b9e54417250d..c31d34d48a30 100644
--- a/tools/testing/selftests/arm64/abi/.gitignore
+++ b/tools/testing/selftests/arm64/abi/.gitignore
@@ -1,2 +1,3 @@
+hwcap
 syscall-abi
 tpidr2
diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
index c8d7f2495eb2..e60752eb8334 100644
--- a/tools/testing/selftests/arm64/abi/Makefile
+++ b/tools/testing/selftests/arm64/abi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2021 ARM Limited
 
-TEST_GEN_PROGS := syscall-abi tpidr2
+TEST_GEN_PROGS := hwcap syscall-abi tpidr2
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
new file mode 100644
index 000000000000..8b5c646cea63
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ARM Limited.
+ */
+
+#include <errno.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <asm/hwcap.h>
+#include <asm/sigcontext.h>
+#include <asm/unistd.h>
+
+#include "../../kselftest.h"
+
+#define TESTS_PER_HWCAP 2
+
+/*
+ * Function expected to generate SIGILL when the feature is not
+ * supported and return when it is supported. If SIGILL is generated
+ * then the handler must be able to skip over the instruction safely.
+ *
+ * Note that it is expected that for many architecture extensions
+ * there are no specific traps due to no architecture state being
+ * added so we may not fault if running on a kernel which doesn't know
+ * to add the hwcap.
+ */
+typedef void (*sigill_fn)(void);
+
+static void sme_sigill(void)
+{
+	/* RDSVL x0, #0 */
+	asm volatile(".inst 0x04bf5800" : : : "x0");
+}
+
+static void sve_sigill(void)
+{
+	/* RDVL x0, #0 */
+	asm volatile(".inst 0x04bf5000" : : : "x0");
+}
+
+static const struct hwcap_data {
+	const char *name;
+	unsigned long at_hwcap;
+	unsigned long hwcap_bit;
+	const char *cpuinfo;
+	sigill_fn sigill_fn;
+	bool sigill_reliable;
+} hwcaps[] = {
+	{
+		.name = "SME",
+		.at_hwcap = AT_HWCAP2,
+		.hwcap_bit = HWCAP2_SME,
+		.cpuinfo = "sme",
+		.sigill_fn = sme_sigill,
+		.sigill_reliable = true,
+	},
+	{
+		.name = "SVE",
+		.at_hwcap = AT_HWCAP,
+		.hwcap_bit = HWCAP_SVE,
+		.cpuinfo = "sve",
+		.sigill_fn = sve_sigill,
+		.sigill_reliable = true,
+	},
+};
+
+static bool seen_sigill;
+
+static void handle_sigill(int sig, siginfo_t *info, void *context)
+{
+	ucontext_t *uc = context;
+
+	seen_sigill = true;
+
+	/* Skip over the offending instruction */
+	uc->uc_mcontext.pc += 4;
+}
+
+bool cpuinfo_present(const char *name)
+{
+	FILE *f;
+	char buf[2048], name_space[30], name_newline[30];
+	char *s;
+
+	/*
+	 * The feature should appear with a leading space and either a
+	 * trailing space or a newline.
+	 */
+	snprintf(name_space, sizeof(name_space), " %s ", name);
+	snprintf(name_newline, sizeof(name_newline), " %s\n", name);
+
+	f = fopen("/proc/cpuinfo", "r");
+	if (!f) {
+		ksft_print_msg("Failed to open /proc/cpuinfo\n");
+		return false;
+	}
+
+	while (fgets(buf, sizeof(buf), f)) {
+		/* Features: line? */
+		if (strncmp(buf, "Features\t:", strlen("Features\t:")) != 0)
+			continue;
+
+		/* All CPUs should be symmetric, don't read any more */
+		fclose(f);
+
+		s = strstr(buf, name_space);
+		if (s)
+			return true;
+		s = strstr(buf, name_newline);
+		if (s)
+			return true;
+
+		return false;
+	}
+
+	ksft_print_msg("Failed to find Features in /proc/cpuinfo\n");
+	fclose(f);
+	return false;
+}
+
+int main(void)
+{
+	const struct hwcap_data *hwcap;
+	int i, ret;
+	bool have_cpuinfo, have_hwcap;
+	struct sigaction sa;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(hwcaps) * TESTS_PER_HWCAP);
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handle_sigill;
+	sa.sa_flags = SA_RESTART | SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	ret = sigaction(SIGILL, &sa, NULL);
+	if (ret < 0)
+		ksft_exit_fail_msg("Failed to install SIGILL handler: %s (%d)\n",
+				   strerror(errno), errno);
+
+	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
+		hwcap = &hwcaps[i];
+
+		have_hwcap = getauxval(hwcaps->at_hwcap) & hwcap->hwcap_bit;
+		have_cpuinfo = cpuinfo_present(hwcap->cpuinfo);
+
+		if (have_hwcap)
+			ksft_print_msg("%s present", hwcap->name);
+
+		ksft_test_result(have_hwcap == have_cpuinfo,
+				 "cpuinfo_match_%s\n", hwcap->name);
+
+		if (hwcap->sigill_fn) {
+			seen_sigill = false;
+			hwcap->sigill_fn();
+
+			if (have_hwcap) {
+				/* Should be able to use the extension */
+				ksft_test_result(!seen_sigill, "sigill_%s\n",
+						 hwcap->name);
+			} else if (hwcap->sigill_reliable) {
+				/* Guaranteed a SIGILL */
+				ksft_test_result(seen_sigill, "sigill_%s\n",
+						 hwcap->name);
+			} else {
+				/* Missing SIGILL might be fine */
+				ksft_print_msg("SIGILL %sreported for %s\n",
+					       seen_sigill ? "" : "not ",
+					       hwcap->name);
+				ksft_test_result_skip("sigill_%s\n",
+						      hwcap->name);
+			}
+		} else {
+			ksft_test_result_skip("sigill_%s\n",
+					      hwcap->name);
+		}
+	}
+
+	ksft_print_cnts();
+
+	return 0;
+}

base-commit: b90cb1053190353cc30f0fef0ef1f378ccc063c5
-- 
2.30.2

