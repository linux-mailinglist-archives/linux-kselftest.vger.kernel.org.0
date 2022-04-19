Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F85068C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Apr 2022 12:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbiDSKbQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Apr 2022 06:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350709AbiDSKbK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Apr 2022 06:31:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F822A72F
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 03:28:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C6EE611FC
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Apr 2022 10:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2733CC385A9;
        Tue, 19 Apr 2022 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650364102;
        bh=hMdi/2FK0D/IjT+fUziwBHzOtEJWdD1HREKm5mcfz5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8Fjr18WvfAu22ycGqthLM3Fa0MYWLT/jdVfD7kWymfEzhg3fO2ESE9nv9hUC4iVP
         w4MJGa/tUmoH5s67d1Ij4KhMY/VUGI9C9lZM7bjwuRd/Y+LKb/etQzqlSYLlUNp+Rr
         aHy7GYdVyGybMjoHzkkANX7uzs62jHM/TRrjE5RKqy+Q+Et6m/e/4Lz99cDkU7Y1Kt
         z/ktCg1mnK1qz+aZUcW93oKNnsoKky3o3FnItegc2N1BZv1EDeg41ObLfaHLSEFUlB
         hqOr7Y9qxdEXvF8YM1JwJTLtYMmYKbeCgWmoAIp70kdG0mJPeS+QKejirsj6ewesqX
         2PU425QBUWQ2w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        inux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 4/4] kselftest/arm64: Add simple test for MTE prctl
Date:   Tue, 19 Apr 2022 11:28:08 +0100
Message-Id: <20220419102808.24522-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220419102808.24522-1-broonie@kernel.org>
References: <20220419102808.24522-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3986; h=from:subject; bh=hMdi/2FK0D/IjT+fUziwBHzOtEJWdD1HREKm5mcfz5U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiXo61uP4PIJEfS/gV2HlOeCPq1merlrlRslXeyqjH kr4QV0SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYl6OtQAKCRAk1otyXVSH0E3rB/ 9Kg7tReR6Qlj54nXEtgtgTxahH6oC/aREh3mqqKXwbmfD1X+8iSdn3OURu+XUFSzlqRacn/LudoLQF RyNYPVOvja8XLXrEbIZQ4FM30cHVwL+THab6KwODVWlZuVVslhUkNIeEPv+006jbdLe9kr8kbZWdaK xhPsNlnvS9HUq6kUJzsdAGI6yfseXyZb80iCnDGE5PzMO+mvR04lj9eY+QNOGqN/sZuIEGtTdTcmYG TmDBRy9/Z+SvBQqjcclhuRz1dgryoQkL6YcKJ5iXBDsoSXUj41p42pnp02lrjtyNybuQmYacICtKyX xiibZvkUHK3KBaOyXXf5+P5+mHknVf
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current tests use the prctls for various things but there's no
coverage of the edges of the interface so add some basics. This isn't
hugely useful as it is (it originally had some coverage for the
combinations with asymmetric mode but we removed the prctl() for that)
but it might be a helpful starting point for future work, for example
covering error handling.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/mte/.gitignore  |   1 +
 .../testing/selftests/arm64/mte/check_prctl.c | 119 ++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_prctl.c

diff --git a/tools/testing/selftests/arm64/mte/.gitignore b/tools/testing/selftests/arm64/mte/.gitignore
index d1fe4ddf1669..052d0f9f92b3 100644
--- a/tools/testing/selftests/arm64/mte/.gitignore
+++ b/tools/testing/selftests/arm64/mte/.gitignore
@@ -3,5 +3,6 @@ check_gcr_el1_cswitch
 check_tags_inclusion
 check_child_memory
 check_mmap_options
+check_prctl
 check_ksm_options
 check_user_mem
diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
new file mode 100644
index 000000000000..f139a33a43ef
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_prctl.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 ARM Limited
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+
+#include <asm/hwcap.h>
+
+#include "kselftest.h"
+
+static int set_tagged_addr_ctrl(int val)
+{
+	int ret;
+
+	ret = prctl(PR_SET_TAGGED_ADDR_CTRL, val, 0, 0, 0);
+	if (ret < 0)
+		ksft_print_msg("PR_SET_TAGGED_ADDR_CTRL: failed %d %d (%s)\n",
+			       ret, errno, strerror(errno));
+	return ret;
+}
+
+static int get_tagged_addr_ctrl(void)
+{
+	int ret;
+
+	ret = prctl(PR_GET_TAGGED_ADDR_CTRL, 0, 0, 0, 0);
+	if (ret < 0)
+		ksft_print_msg("PR_GET_TAGGED_ADDR_CTRL failed: %d %d (%s)\n",
+			       ret, errno, strerror(errno));
+	return ret;
+}
+
+/*
+ * Read the current mode without having done any configuration, should
+ * run first.
+ */
+void check_basic_read(void)
+{
+	int ret;
+
+	ret = get_tagged_addr_ctrl();
+	if (ret < 0) {
+		ksft_test_result_fail("check_basic_read\n");
+		return;
+	}
+
+	if (ret & PR_MTE_TCF_SYNC)
+		ksft_print_msg("SYNC enabled\n");
+	if (ret & PR_MTE_TCF_ASYNC)
+		ksft_print_msg("ASYNC enabled\n");
+
+	/* Any configuration is valid */
+	ksft_test_result_pass("check_basic_read\n");
+}
+
+/*
+ * Attempt to set a specified combination of modes.
+ */
+void set_mode_test(const char *name, int hwcap2, int mask)
+{
+	int ret;
+
+	if ((getauxval(AT_HWCAP2) & hwcap2) != hwcap2) {
+		ksft_test_result_skip("%s\n", name);
+		return;
+	}
+
+	ret = set_tagged_addr_ctrl(mask);
+	if (ret < 0) {
+		ksft_test_result_fail("%s\n", name);
+		return;
+	}
+
+	ret = get_tagged_addr_ctrl();
+	if (ret < 0) {
+		ksft_test_result_fail("%s\n", name);
+		return;
+	}
+
+	if ((ret & PR_MTE_TCF_MASK) == mask) {
+		ksft_test_result_pass("%s\n", name);
+	} else {
+		ksft_print_msg("Got %x, expected %x\n",
+			       (ret & PR_MTE_TCF_MASK), mask);
+		ksft_test_result_fail("%s\n", name);
+	}
+}
+
+struct mte_mode {
+	int mask;
+	int hwcap2;
+	const char *name;
+} mte_modes[] = {
+	{ PR_MTE_TCF_NONE,  0,          "NONE"  },
+	{ PR_MTE_TCF_SYNC,  HWCAP2_MTE, "SYNC"  },
+	{ PR_MTE_TCF_ASYNC, HWCAP2_MTE, "ASYNC" },
+	{ PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC,  HWCAP2_MTE, "SYNC+ASYNC"  },
+};
+
+int main(void)
+{
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	check_basic_read();
+	for (i = 0; i < ARRAY_SIZE(mte_modes); i++)
+		set_mode_test(mte_modes[i].name, mte_modes[i].hwcap2,
+			      mte_modes[i].mask);
+
+	ksft_print_cnts();
+
+	return 0;
+}
-- 
2.30.2

