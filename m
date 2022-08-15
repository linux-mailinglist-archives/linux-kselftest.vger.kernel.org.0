Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94884592FD9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiHONZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242180AbiHONZ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:25:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF79BC1D
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:25:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E63F60DF8
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F0BC433D6;
        Mon, 15 Aug 2022 13:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660569924;
        bh=Hi7WKFd/xsD8XK6zunaWUoMNEhnf57gWLZyHyBg85p4=;
        h=From:To:Cc:Subject:Date:From;
        b=jzeAflkfkmJYfWRpI5fhPh9vs2xB3IE5MqX92ctAiKbtENsXYZxNTE+PuKYZ+7MPt
         YLBQEHAOiHgIxefjav3ru/xu8O1H4S48quuj04Jix1tNwU8T0bAjBAV8es+45wllO+
         gyzjqnLgPWc3r+lorfM+S+tzqfTCLWtsiZRJ6QplOUuqeSeeaf0uLdiqQHRs74Jmjt
         nPa7oW7Fjhx94ThP3RWHDwnEwb7aqCSvENb8A4UO7D6g2XIDCgnQfj1bAVqOfXjNp1
         8W6rT84jJbdVj1CAW7DVDIwouot4Hku9kpnKrZnRH8R+/PnDfA+xJhn90Cgi7s1m/j
         bL9hg5Q+of3/w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] kselftest/arm64: Add simple hwcap validation
Date:   Mon, 15 Aug 2022 14:23:10 +0100
Message-Id: <20220815132310.218604-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6478; i=broonie@kernel.org; h=from:subject; bh=Hi7WKFd/xsD8XK6zunaWUoMNEhnf57gWLZyHyBg85p4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+ki9SX49YQfvhmhnl3mWo2sNkUrW/sG8ctg0k2vm 242c1B2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpIvQAKCRAk1otyXVSH0K2WB/ 4lb2dgU/fzbqpXNs4dHgoPo2skNcR8SYdUi1ycuaZ/xXXCQjj0ytG7lMfXZ+5RhuAZzFkrkVQTSbk4 53ggc3BGjEUGKckWdWCvHQH58XOQRTGw4sTs4RLOb4NruZQiziRerxH56prg+qTGn4vMItJBnBpaVm 9CM87AProbSgU4dgYOf1LqoD5d9ZvvaCkcLGIntW+z3klH3n3TncMJ57mh3oJK9N60NIjb4xPxLIRs yGwaYHUP4ZkM0iMXMBPNwlgAo5Sf/5oRLpEm4yxKxFgcv5jDmFq++0fF9aaQveJLwSqqqm0Eq8GP3j WmQawwHAVVNeNaz5mjiB00q0dPCFt8
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

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.30.2

